Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD89A214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864323;
	bh=I0xcQ/GWJT8C7oiI2zSRLugBmbW3kymcjZfqcpX6gfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OR1RHySQLlx3LN38OtoRigN4ZQKXTF2ceDJNshzKZClNBrJbpxa2oL8ga2gYDlhC+
	 kasfWDL2qLute3moXsJ1Vy0pSqcC2PZoF9je2dwGcaRFOLkjxapKynfNaV6ygodYzp
	 ZFLKF/FcsApoGdlt5/Eb4mvEWnq9VLWbBP/NdSgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbeLZWkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729072AbeLZWke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A624221741;
        Wed, 26 Dec 2018 22:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864033;
        bh=I0xcQ/GWJT8C7oiI2zSRLugBmbW3kymcjZfqcpX6gfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAqq2SB4GnauXtpfxaULqzpZzaW9p0A4CSQ0zOsK3Piiso+SIh+/bu7gG5DY6bARk
         0CmuYrjBFCI+TYiBtQkGK6Tilh5Jlpsn8oFHvadXFNdwsqjLVR1JgiWhAW8eHb5rv7
         SW86y3cVv+cwIqENarU80mQ+pyAhduX+gs/qzTOA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 23/59] netfilter: nat: can't use dst_hold on noref dst
Date:   Wed, 26 Dec 2018 17:38:03 -0500
Message-Id: <20181226223839.150262-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
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

