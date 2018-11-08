Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011EC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB69620818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dST5E+N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB69620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbeKIIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:05:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731004AbeKIHjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:39:37 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABF0521479;
        Thu,  8 Nov 2018 22:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714527;
        bh=pwJ3ynuhfSoL7+6bVUuep2PUaiVhS0EGku1oL4rtqh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dST5E+N52j4rGIDVlcBpHEYPoxJCHuXWcTyKkxlTAv9DfHModNl9q8ycLkJ23FAV2
         TbFoJjszlPysXnjITqSpe+ifapfaQxT8lGm8KQCAsBMvYOiMBU8fXt+AunKZLWLin7
         jJZF8HFc2gtL7jltNfGtjX94kTYHOjsIRCczBqZ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Copeland <bobcopeland@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 005/171] mac80211: fix pending queue hang due to TX_DROP
Date:   Thu,  8 Nov 2018 13:49:35 -0800
Message-Id: <20181108215127.583789452@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 84582998f65f..58fba4e569e6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1833,7 +1833,7 @@ static bool ieee80211_tx(struct ieee80211_sub_if_data *sdata,
 			sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	if (invoke_tx_handlers_early(&tx))
-		return false;
+		return true;
 
 	if (ieee80211_queue_skb(local, sdata, tx.sta, tx.skb))
 		return true;
-- 
2.17.1



