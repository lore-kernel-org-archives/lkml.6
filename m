Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827A7216E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 09:59:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827A7216E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeHOMua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 08:50:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:51310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbeHOMua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 08:50:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64468AD4D;
        Wed, 15 Aug 2018 09:58:59 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Jiri Bohac <jbohac@suse.cz>
Subject: [PATCH 4.4.y] tcp: Fix missing range_truesize enlargement in the backport
Date:   Wed, 15 Aug 2018 11:58:46 +0200
Message-Id: <20180815095846.7734-1-tiwai@suse.de>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 4.4.y stable backport dc6ae4dffd65 for the upstream commit
3d4bf93ac120 ("tcp: detect malicious patterns in
tcp_collapse_ofo_queue()") missed a line that enlarges the
range_truesize value, which broke the whole check.

Fixes: dc6ae4dffd65 ("tcp: detect malicious patterns in tcp_collapse_ofo_queue()")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---

Greg, this is a fix-up specific to 4.4.y stable backport that had a
slightly different form from upstream fix.  I haven't looked at the
older trees, but 4.9.y and later took the upstream fix as is, so this
patch isn't needed for them.

The patch hasn't been tested with the real test case, though; let me
know if the current code is intended.  Thanks!


 net/ipv4/tcp_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 4a261e078082..9c4c6cd0316e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4835,6 +4835,7 @@ static void tcp_collapse_ofo_queue(struct sock *sk)
 			end = TCP_SKB_CB(skb)->end_seq;
 			range_truesize = skb->truesize;
 		} else {
+			range_truesize += skb->truesize;
 			if (before(TCP_SKB_CB(skb)->seq, start))
 				start = TCP_SKB_CB(skb)->seq;
 			if (after(TCP_SKB_CB(skb)->end_seq, end))
-- 
2.18.0

