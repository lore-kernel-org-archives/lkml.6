Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E76C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A73214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864769;
	bh=8vMR+yx+nUF3zVs9FziAzgXN75/JIfgQv0/0HQHuMFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=llcFBO1Ga2bsdxwojmvki8osBnkrOUbDiKzIi8uqW9j+pLGXxbF39BH/xsYHRS3o/
	 3lw0zZ35lBTt3/EJtHgyn4CJ/Ato7FVxAz17xkZX8UPA5ThyFtc0SkzMNv3piekOsR
	 SknxUBnH5sdaqZZvi6BLVLJi9FSyY8sl5+gNVIh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbeLZWwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeLZWg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:57 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5406F218FE;
        Wed, 26 Dec 2018 22:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863817;
        bh=8vMR+yx+nUF3zVs9FziAzgXN75/JIfgQv0/0HQHuMFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1MtOA64Nc75PGc6rk0XiJLni7ExDDktuF66L2xua5FqsVV72lSVBJaqQiySR6E7R
         lryd3saRhAXdtQ21owazSSPjljuqQJc/N78C4UJm6oOMDn3tWmIAuH8Vto+MgLOcaA
         dQToGrwZvgrRSWo8dNFrXpIsOr/14Mk1myv8fXtE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 36/97] netfilter: nat: can't use dst_hold on noref dst
Date:   Wed, 26 Dec 2018 17:34:56 -0500
Message-Id: <20181226223557.149329-36-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

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

