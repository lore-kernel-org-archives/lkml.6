Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEE8C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED872098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrQ/TJyv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED872098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeJPMCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbeJPMCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6E9B21477;
        Tue, 16 Oct 2018 04:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663248;
        bh=GnsTQ/PQ9o/zGSeEKkoqajfe+LFhzKyI3tyow/uoiWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rrQ/TJyvTZsFl/8LySDG7Ggwd6dyrlhIRk0KPT4N4vaWn5kzSuW4g5apENvh6iohv
         CzcefonOjrtnfxAasPMRgn3vkbnAyNJ1kAmczfEcbrNJVdvSnZwhInhGaGWwsfb7me
         INOEqCUEh8NC+57gS8cW/mQ9BCPqe7e6d4RLC7+s=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sowmini Varadhan <sowmini.varadhan@oracle.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 03/61] xfrm: reset transport header back to network header after all input transforms ahave been applied
Date:   Tue, 16 Oct 2018 00:13:05 -0400
Message-Id: <20181016041403.135678-3-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>

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

