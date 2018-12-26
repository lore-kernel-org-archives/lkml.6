Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EA1C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7989F214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864641;
	bh=jhI76KwFmn3v6XOZX500r6l65k+h5ii8u18nBbB2dSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hbc6J+U/TptM6r6axG/5InJfBsGLfhGDf/bayIALBJ0pUQXoovm4serrvBKZ+frgs
	 REL3O5qQ/egEcUIwi/oZrPWExO/4rghdpKaH4cvzpDizuYLoZUN6ytEg2vIrOSIoZc
	 8RFw4EC9KMu/NDQulXfZ0gU4A8ValUwql5HX/BUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbeLZWuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:50:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbeLZWhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:37:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40EC62054F;
        Wed, 26 Dec 2018 22:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863838;
        bh=jhI76KwFmn3v6XOZX500r6l65k+h5ii8u18nBbB2dSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NfyP6oiaEgUmb30wGvrhtxq47te6UinEVNb22YOPpAQMfWVCysLnE4p4Z7YD8Fp7A
         tHbP86Neb9WjBX/5fRHqyWYXrjUWvj5KRZjrYq4GzduL0UH23IRC6dlYJSUWmLGHFp
         qJ4e/R7b2L1jkxr8BG7MukmmRvpCbjM2lxgGWhrc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 53/97] net: clear skb->tstamp in forwarding paths
Date:   Wed, 26 Dec 2018 17:35:13 -0500
Message-Id: <20181226223557.149329-53-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8203e2d844d34af247a151d8ebd68553a6e91785 ]

Sergey reported that forwarding was no longer working
if fq packet scheduler was used.

This is caused by the recent switch to EDT model, since incoming
packets might have been timestamped by __net_timestamp()

__net_timestamp() uses ktime_get_real(), while fq expects packets
using CLOCK_MONOTONIC base.

The fix is to clear skb->tstamp in forwarding paths.

Fixes: 80b14dee2bea ("net: Add a new socket option for a future transmit time.")
Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Sergey Matyukevich <geomatsi@gmail.com>
Tested-by: Sergey Matyukevich <geomatsi@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ip_forward.c | 1 +
 net/ipv6/ip6_output.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/ipv4/ip_forward.c b/net/ipv4/ip_forward.c
index 32662e9e5d21..d5984d31ab93 100644
--- a/net/ipv4/ip_forward.c
+++ b/net/ipv4/ip_forward.c
@@ -72,6 +72,7 @@ static int ip_forward_finish(struct net *net, struct sock *sk, struct sk_buff *s
 	if (unlikely(opt->optlen))
 		ip_forward_options(skb);
 
+	skb->tstamp = 0;
 	return dst_output(net, sk, skb);
 }
 
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2694def1e72c..0bb87f3a10c7 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -378,6 +378,7 @@ static inline int ip6_forward_finish(struct net *net, struct sock *sk,
 	__IP6_INC_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTFORWDATAGRAMS);
 	__IP6_ADD_STATS(net, ip6_dst_idev(dst), IPSTATS_MIB_OUTOCTETS, skb->len);
 
+	skb->tstamp = 0;
 	return dst_output(net, sk, skb);
 }
 
-- 
2.19.1

