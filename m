Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3189FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCA021477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xgyFC8VE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCA021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbeJPMCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeJPMCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5248A2145D;
        Tue, 16 Oct 2018 04:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663252;
        bh=Y98iIiO1wAlEtxNwfUJ8zgC3F5gaGoNm9OFUFxpFsQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xgyFC8VExvz08MXT3WdwusG9Of+IY0vQUNvsDW52L+B/i6+CaFJPuc9BCC6Ux4kCG
         I2AdezUMt1VjmwC+QuHbIs7V5ARBuQfyNDL4BcRFlE6Es1C08ouriuMJPYYOmrGFcn
         7lgi20b9MuHcEMf/z/48eDJGW73S1Gok/Ac2eGKo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Bob Copeland <bobcopeland@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 07/61] mac80211: fix pending queue hang due to TX_DROP
Date:   Tue, 16 Oct 2018 00:13:09 -0400
Message-Id: <20181016041403.135678-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bob Copeland <me@bobcopeland.com>

[ Upstream commit 6eae4a6c2be387fec41b0d2782c4fffb57159498 ]

In our environment running lots of mesh nodes, we are seeing the
pending queue hang periodically, with the debugfs queues file showing
lines such as:

    00: 0x00000000/348

i.e. there are a large number of frames but no stop reason set.

One way this could happen is if queue processing from the pending
tasklet exited early without processing all frames, and without having
some future event (incoming frame, stop reason flag, ...) to reschedule
it.

Exactly this can occur today if ieee80211_tx() returns false due to
packet drops or power-save buffering in the tx handlers.  In the
past, this function would return true in such cases, and the change
to false doesn't seem to be intentional.  Fix this case by reverting
to the previous behavior.

Fixes: bb42f2d13ffc ("mac80211: Move reorder-sensitive TX handlers to after TXQ dequeue")
Signed-off-by: Bob Copeland <bobcopeland@fb.com>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d8fddd88bf46..a17a56032a21 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1837,7 +1837,7 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 			sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	if (invoke_tx_handlers_early(&tx))
-		return false;
+		return true;
 
 	if (ieee80211_queue_skb(local, sdata, tx.sta, tx.skb))
 		return true;
-- 
2.17.1

