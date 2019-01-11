Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10355C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB362133F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217366;
	bh=ceNKCBEx/bTuRfTe5vR6gQwrWfrHc1rL0mvbIbeGsx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PhdRzIJoYvTrjXVGtf2ycSuCBbvLLFkB/UpM2P7QkMWiV5xIMcYniPQReIHF3MEoj
	 7IzlyXOZkusRHgJRaIzG1mlSErvsSaFQkMl2ai3PG/mtSP4nJNeFU7nGPxYIeUDHJQ
	 Vuvw4Q5pyoVZJeyleSgY0w+U3ZYvFTltGtD29bNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbfAKOgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390276AbfAKOgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEA462063F;
        Fri, 11 Jan 2019 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217362;
        bh=ceNKCBEx/bTuRfTe5vR6gQwrWfrHc1rL0mvbIbeGsx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFzH728khb6NSL8kVS4YD7rAVqZE3tgRR6OcapHaJBT1UYHbtH0V8KGdjZkYTWtL6
         RQLztpBMEg7bW7UjGefZmCHvnTzyOTTjg3a/4O8W+2in/QO0ap7M0deiBjdaerFQG4
         6YnAO44cHKfWxo5obMQzPIFYtghoFcHAhgtj7dfM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Zaharinov <micron10@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 034/148] netfilter: nat: cant use dst_hold on noref dst
Date:   Fri, 11 Jan 2019 15:13:32 +0100
Message-Id: <20190111131115.660596561@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 542fbda0f08f1cbbc250f9e59f7537649651d0c8 ]

The dst entry might already have a zero refcount, waiting on rcu list
to be free'd.  Using dst_hold() transitions its reference count to 1, and
next dst release will try to free it again -- resulting in a double free:

  WARNING: CPU: 1 PID: 0 at include/net/dst.h:239 nf_xfrm_me_harder+0xe7/0x130 [nf_nat]
  RIP: 0010:nf_xfrm_me_harder+0xe7/0x130 [nf_nat]
  Code: 48 8b 5c 24 60 65 48 33 1c 25 28 00 00 00 75 53 48 83 c4 68 5b 5d 41 5c c3 85 c0 74 0d 8d 48 01 f0 0f b1 0a 74 86 85 c0 75 f3 <0f> 0b e9 7b ff ff ff 29 c6 31 d2 b9 20 00 48 00 4c 89 e7 e8 31 27
  Call Trace:
  nf_nat_ipv4_out+0x78/0x90 [nf_nat_ipv4]
  nf_hook_slow+0x36/0xd0
  ip_output+0x9f/0xd0
  ip_forward+0x328/0x440
  ip_rcv+0x8a/0xb0

Use dst_hold_safe instead and bail out if we cannot take a reference.

Fixes: a4c2fd7f7891 ("net: remove DST_NOCACHE flag")
Reported-by: Martin Zaharinov <micron10@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_nat_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index e2b196054dfc..2268b10a9dcf 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -117,7 +117,8 @@ int nf_xfrm_me_harder(struct net *net, struct sk_buff *skb, unsigned int family)
 	dst = skb_dst(skb);
 	if (dst->xfrm)
 		dst = ((struct xfrm_dst *)dst)->route;
-	dst_hold(dst);
+	if (!dst_hold_safe(dst))
+		return -EHOSTUNREACH;
 
 	if (sk && !net_eq(net, sock_net(sk)))
 		sk = NULL;
-- 
2.19.1



