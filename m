Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CACC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558D02082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PgKTOdvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558D02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbeKCDrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbeKCDq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:59 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8D82081B;
        Fri,  2 Nov 2018 18:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183928;
        bh=7/RRwS/6dMPAFolNl8QKKISx1OVJaTIoGco0JmOsCog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PgKTOdvpxwsOrRFp1uptgn1aiVB6B774eXJWgzoXNUcoQShBC1NH5Fh5TEQ74KglJ
         kRZqRIbh9TsPefHRk0xtnPBQJ3K1qn8eSPYJgAmvxIJVU1mgXaM7bN+/lCUT5DPoi8
         pJlW9fMnoRKeSAzWkPtVFOEf8sP5U7JVc/+pOt4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Copeland <bobcopeland@fb.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 007/150] mac80211: fix pending queue hang due to TX_DROP
Date:   Fri,  2 Nov 2018 19:32:49 +0100
Message-Id: <20181102182902.989850676@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

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



