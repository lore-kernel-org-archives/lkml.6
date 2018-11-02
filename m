Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78BDC6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E152082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKYKGam3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E152082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbeKCDqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbeKCDqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:46:21 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6EEE2082E;
        Fri,  2 Nov 2018 18:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183890;
        bh=CBSrLHLrzUwE096Q+dLnUxbxm3dOJD4FCnFKIPbe4XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DKYKGam3GULfnJOVfc2UaDIRtWF3E9V9ZZo51ajf1+RZO7ed5P0R6VCOja7EM6Yxz
         esB9OB79zJqMChUgB78XVxulrBVYuyrbMPfMuAcyJ4ZMg0p4E7HU8+Fkqg55aYHmyL
         ScnwSpWwS0hdd7xxfIAFAV/n13QlSdKiw6uWUb6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 003/150] xfrm: reset transport header back to network header after all input transforms ahave been applied
Date:   Fri,  2 Nov 2018 19:32:45 +0100
Message-Id: <20181102182902.587937047@linuxfoundation.org>
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

[ Upstream commit bfc0698bebcb16d19ecfc89574ad4d696955e5d3 ]

A policy may have been set up with multiple transforms (e.g., ESP
and ipcomp). In this situation, the ingress IPsec processing
iterates in xfrm_input() and applies each transform in turn,
processing the nexthdr to find any additional xfrm that may apply.

This patch resets the transport header back to network header
only after the last transformation so that subsequent xfrms
can find the correct transport header.

Fixes: 7785bba299a8 ("esp: Add a software GRO codepath")
Suggested-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/xfrm4_input.c          | 1 +
 net/ipv4/xfrm4_mode_transport.c | 4 +---
 net/ipv6/xfrm6_input.c          | 1 +
 net/ipv6/xfrm6_mode_transport.c | 4 +---
 4 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index bcfc00e88756..f8de2482a529 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -67,6 +67,7 @@ int xfrm4_transport_finish(struct sk_buff *skb, int async)
 
 	if (xo && (xo->flags & XFRM_GRO)) {
 		skb_mac_header_rebuild(skb);
+		skb_reset_transport_header(skb);
 		return 0;
 	}
 
diff --git a/net/ipv4/xfrm4_mode_transport.c b/net/ipv4/xfrm4_mode_transport.c
index 3d36644890bb..1ad2c2c4e250 100644
--- a/net/ipv4/xfrm4_mode_transport.c
+++ b/net/ipv4/xfrm4_mode_transport.c
@@ -46,7 +46,6 @@ static int xfrm4_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int ihl = skb->data - skb_transport_header(skb);
-	struct xfrm_offload *xo = xfrm_offload(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
@@ -54,8 +53,7 @@ static int xfrm4_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 		skb->network_header = skb->transport_header;
 	}
 	ip_hdr(skb)->tot_len = htons(skb->len + ihl);
-	if (!xo || !(xo->flags & XFRM_GRO))
-		skb_reset_transport_header(skb);
+	skb_reset_transport_header(skb);
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 841f4a07438e..9ef490dddcea 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -59,6 +59,7 @@ int xfrm6_transport_finish(struct sk_buff *skb, int async)
 
 	if (xo && (xo->flags & XFRM_GRO)) {
 		skb_mac_header_rebuild(skb);
+		skb_reset_transport_header(skb);
 		return -1;
 	}
 
diff --git a/net/ipv6/xfrm6_mode_transport.c b/net/ipv6/xfrm6_mode_transport.c
index 9ad07a91708e..3c29da5defe6 100644
--- a/net/ipv6/xfrm6_mode_transport.c
+++ b/net/ipv6/xfrm6_mode_transport.c
@@ -51,7 +51,6 @@ static int xfrm6_transport_output(struct xfrm_state *x, struct sk_buff *skb)
 static int xfrm6_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 {
 	int ihl = skb->data - skb_transport_header(skb);
-	struct xfrm_offload *xo = xfrm_offload(skb);
 
 	if (skb->transport_header != skb->network_header) {
 		memmove(skb_transport_header(skb),
@@ -60,8 +59,7 @@ static int xfrm6_transport_input(struct xfrm_state *x, struct sk_buff *skb)
 	}
 	ipv6_hdr(skb)->payload_len = htons(skb->len + ihl -
 					   sizeof(struct ipv6hdr));
-	if (!xo || !(xo->flags & XFRM_GRO))
-		skb_reset_transport_header(skb);
+	skb_reset_transport_header(skb);
 	return 0;
 }
 
-- 
2.17.1



