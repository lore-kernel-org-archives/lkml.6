Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 8a/qOKzyG1tRXgAAmS7hNA
	; Sat, 09 Jun 2018 15:30:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C6839608C1; Sat,  9 Jun 2018 15:30:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOcy6eJ0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 45CDD608B8;
	Sat,  9 Jun 2018 15:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45CDD608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753373AbeFIPau (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:33350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753194AbeFIPas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:30:48 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B1B204EC;
        Sat,  9 Jun 2018 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558247;
        bh=wKbIf9/eeHhcLcsjKVtsHJYz8hTPj2nNb+pVi6i9JQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOcy6eJ0nlqozh8MSZmvl8tQ/5i61bRyLLSKLe7/ViM2reKXUwtVtqNR0bhFPGjyW
         t3bpflCJd+RNbyWJO/dCgcOyrh8lVGupjMBgYENHdMYkhaUv1oBE4VPqeCI99V0upR
         GYAIWSrXpk/6y1WWuSfFBmZrFxHKZrbVPRpQDPWU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.17 01/15] netfilter: nf_flow_table: attach dst to skbs
Date: Sat,  9 Jun 2018 17:29:36 +0200
Message-Id: <20180609150000.817480937@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason A. Donenfeld <Jason@zx2c4.com>

commit 2a79fd3908acd88e6cb0e620c314d7b1fee56a02 upstream.

Some drivers, such as vxlan and wireguard, use the skb's dst in order to
determine things like PMTU. They therefore loose functionality when flow
offloading is enabled. So, we ensure the skb has it before xmit'ing it
in the offloading path.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 net/ipv4/netfilter/nf_flow_table_ipv4.c |    5 +++--
 net/ipv6/netfilter/nf_flow_table_ipv6.c |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

--- a/net/ipv4/netfilter/nf_flow_table_ipv4.c
+++ b/net/ipv4/netfilter/nf_flow_table_ipv4.c
@@ -213,7 +213,7 @@ nf_flow_offload_ip_hook(void *priv, stru
 	enum flow_offload_tuple_dir dir;
 	struct flow_offload *flow;
 	struct net_device *outdev;
-	const struct rtable *rt;
+	struct rtable *rt;
 	struct iphdr *iph;
 	__be32 nexthop;
 
@@ -234,7 +234,7 @@ nf_flow_offload_ip_hook(void *priv, stru
 	dir = tuplehash->tuple.dir;
 	flow = container_of(tuplehash, struct flow_offload, tuplehash[dir]);
 
-	rt = (const struct rtable *)flow->tuplehash[dir].tuple.dst_cache;
+	rt = (struct rtable *)flow->tuplehash[dir].tuple.dst_cache;
 	if (unlikely(nf_flow_exceeds_mtu(skb, rt)))
 		return NF_ACCEPT;
 
@@ -251,6 +251,7 @@ nf_flow_offload_ip_hook(void *priv, stru
 
 	skb->dev = outdev;
 	nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
+	skb_dst_set_noref(skb, &rt->dst);
 	neigh_xmit(NEIGH_ARP_TABLE, outdev, &nexthop, skb);
 
 	return NF_STOLEN;
--- a/net/ipv6/netfilter/nf_flow_table_ipv6.c
+++ b/net/ipv6/netfilter/nf_flow_table_ipv6.c
@@ -243,6 +243,7 @@ nf_flow_offload_ipv6_hook(void *priv, st
 
 	skb->dev = outdev;
 	nexthop = rt6_nexthop(rt, &flow->tuplehash[!dir].tuple.src_v6);
+	skb_dst_set_noref(skb, &rt->dst);
 	neigh_xmit(NEIGH_ND_TABLE, outdev, nexthop, skb);
 
 	return NF_STOLEN;
