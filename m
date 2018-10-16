Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6089C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9FF21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB/auELL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9FF21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbeJPMAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:00:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726990AbeJPMAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F39D2145D;
        Tue, 16 Oct 2018 04:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663152;
        bh=nI+P1fuBXnftX47VwxljHnZOSXpsSGJqIvfDF+fIbBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sB/auELL87s/OhM7VfNu60ihA3lGyyAuwqbcZyC9jSlVh8ePsXtgzbUxgMRq9riyB
         Q9JndTykVHfujVn/ULJe8jLi7uZh4VK4JKbP5c2ZPlAOlNqIPwUBIHhFz8QOAEMxMn
         AaUC5i+O1BUK+4PCEETALfcvwwlao8okNqKISHQg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Bob Copeland <bobcopeland@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 007/100] mac80211: fix pending queue hang due to TX_DROP
Date:   Tue, 16 Oct 2018 00:10:48 -0400
Message-Id: <20181016041221.135528-7-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
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
index 9b3b069e418a..361f2f6cc839 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1886,7 +1886,7 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 			sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	if (invoke_tx_handlers_early(&tx))
-		return false;
+		return true;
 
 	if (ieee80211_queue_skb(local, sdata, tx.sta, tx.skb))
 		return true;
-- 
2.17.1

