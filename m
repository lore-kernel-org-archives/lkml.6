Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A00C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB24821848
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217179;
	bh=E7ZcDDKDHT6syj1/76ZeFa69lf/szMedwlwkFKCAeLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0KLbgo6uiN2RFOiW4cKwPJSNBthXQSFBLcXn2XD8hCjPLAHCb0mLh5nv9Nkmok6z0
	 jBsXZe7tPyxdHbLLvTJNwFLjAIw5A06kKQzOm++F0UuO9QYJW7z1jtGvu8A7UEGf7s
	 BgIZQVyJ7cA1jW2AZU99FH1R99/K+JIyVVMHRVEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389559AbfAKOc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:32:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387920AbfAKOc5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:32:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E38C82133F;
        Fri, 11 Jan 2019 14:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217176;
        bh=E7ZcDDKDHT6syj1/76ZeFa69lf/szMedwlwkFKCAeLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjREyh1h+2ChD8N6GEcdpltEPd134vAFQGoJwuewnJ2aW8O37ZsvHbL1bpdcRWqNr
         O9L3zCi235vZZXvNycbSSuj/eXQMk9QG3uB5B8pQATnOVsKYidBpZglH5VtOfthG8s
         pVH46yAFySJq2qYP68Ohd6Nk/v873L4J2igqvVrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Zaharinov <micron10@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 022/105] netfilter: nat: cant use dst_hold on noref dst
Date:   Fri, 11 Jan 2019 15:13:53 +0100
Message-Id: <20190111131105.165943651@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index af8345fc4fbd..ed0ea64b8d04 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -97,7 +97,8 @@ int nf_xfrm_me_harder(struct net *net, struct sk_buff *skb, unsigned int family)
 	dst = skb_dst(skb);
 	if (dst->xfrm)
 		dst = ((struct xfrm_dst *)dst)->route;
-	dst_hold(dst);
+	if (!dst_hold_safe(dst))
+		return -EHOSTUNREACH;
 
 	dst = xfrm_lookup(net, dst, &fl, skb->sk, 0);
 	if (IS_ERR(dst))
-- 
2.19.1



