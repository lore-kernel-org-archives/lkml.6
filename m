Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA21C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248EE20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS7TfYhn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248EE20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeKIIKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:10:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbeKIHh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:29 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90F3320818;
        Thu,  8 Nov 2018 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714400;
        bh=S0CNCWfSjsRdsBymq8tpcGU1DcMCmeY34XOBZhtfV+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZS7TfYhn0Or24XWWKHFEtPezeAfv38Yi44TacsECgAS81/L/nje01zguk9LfQ9NjM
         sbVk2z4Ua+/GkDQymbiXlaDmpFlliuPs//doQPyhEkhmakOOW/E2V/wDEXRn1p1xgM
         pVb82uCrmE8rZAluvc7tBHnf1QjZvzzPJHqyKi0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Duyck <aduyck@mirantis.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 061/114] gro: Allow tunnel stacking in the case of FOU/GUE
Date:   Thu,  8 Nov 2018 13:51:16 -0800
Message-Id: <20181108215106.615048628@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



