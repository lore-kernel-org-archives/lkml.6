Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173D8ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E0A20868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP3LLcNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E0A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeJYWvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:32826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbeJYWvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:12 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3882020848;
        Thu, 25 Oct 2018 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477095;
        bh=32OOa1IVKao5cw9RQCEy0IZwy/20WNKhrbx3/X48N3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oP3LLcNF/RwBxXCp2s/KJK+9gXtxIzMwwaYWEQ276gbnVi8bdUg6eI4gCk9pc/BVj
         k8TT7EAKqUNS4IXHoB40A+t6aUQQD/3ZC7W5VVCe/nALRnML07lgI7xqUFcyA3/s0k
         sGD/0+H+TFmZm6XRgZ0NzX0TbiWVwmFzvol0TOu8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alexander Duyck <aduyck@mirantis.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 43/65] gro: Allow tunnel stacking in the case of FOU/GUE
Date:   Thu, 25 Oct 2018 10:16:43 -0400
Message-Id: <20181025141705.213937-43-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Duyck <aduyck@mirantis.com>

[ Upstream commit c3483384ee511ee2af40b4076366cd82a6a47b86 ]

This patch should fix the issues seen with a recent fix to prevent
tunnel-in-tunnel frames from being generated with GRO.  The fix itself is
correct for now as long as we do not add any devices that support
NETIF_F_GSO_GRE_CSUM.  When such a device is added it could have the
potential to mess things up due to the fact that the outer transport header
points to the outer UDP header and not the GRE header as would be expected.

Fixes: fac8e0f579695 ("tunnels: Don't apply GRO to multiple layers of encapsulation.")
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fou.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/ipv4/fou.c b/net/ipv4/fou.c
index 08d8ee124538..d83888bc33d3 100644
--- a/net/ipv4/fou.c
+++ b/net/ipv4/fou.c
@@ -195,6 +195,14 @@ static struct sk_buff **fou_gro_receive(struct sk_buff **head,
 	u8 proto = NAPI_GRO_CB(skb)->proto;
 	const struct net_offload **offloads;
 
+	/* We can clear the encap_mark for FOU as we are essentially doing
+	 * one of two possible things.  We are either adding an L4 tunnel
+	 * header to the outer L3 tunnel header, or we are are simply
+	 * treating the GRE tunnel header as though it is a UDP protocol
+	 * specific header such as VXLAN or GENEVE.
+	 */
+	NAPI_GRO_CB(skb)->encap_mark = 0;
+
 	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[proto]);
@@ -354,6 +362,14 @@ static struct sk_buff **gue_gro_receive(struct sk_buff **head,
 		}
 	}
 
+	/* We can clear the encap_mark for GUE as we are essentially doing
+	 * one of two possible things.  We are either adding an L4 tunnel
+	 * header to the outer L3 tunnel header, or we are are simply
+	 * treating the GRE tunnel header as though it is a UDP protocol
+	 * specific header such as VXLAN or GENEVE.
+	 */
+	NAPI_GRO_CB(skb)->encap_mark = 0;
+
 	rcu_read_lock();
 	offloads = NAPI_GRO_CB(skb)->is_ipv6 ? inet6_offloads : inet_offloads;
 	ops = rcu_dereference(offloads[guehdr->proto_ctype]);
-- 
2.17.1

