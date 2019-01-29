Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F9AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0EA9214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762177;
	bh=IhAd2Hv82kPxEDSGdtkjuwFi46TKfeoTrPMt+pmIGdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GH9fkwKB8V2T0jTvKdEpppw2DRKv01hUcn+O1eqmiGLQZULdao1hAGFXkWlb9RouN
	 mCWJJmI/Ufig3c6Papp1IGgiHMbiOHW1XulCrvhB8v/meXWWi6QP6x/Yf5eX5EJQCE
	 b9UOEy9ZE2FZLTB16gsMyTF5HmGvAIWq3uFqWZ60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730176AbfA2Lmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:42:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbfA2Lmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:42:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE27D20857;
        Tue, 29 Jan 2019 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762172;
        bh=IhAd2Hv82kPxEDSGdtkjuwFi46TKfeoTrPMt+pmIGdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKXw5DWWJhjfSvu0NMXaCJTRUwQvRQBTAjjx1QLtHzxr5Kx5gS0U61NKkhUlerDYA
         Kflz4j0CtzBsY2+RBdIjpnY2sUFQDSMt2I/SwRe/cibRohGMqniOSyfNpM2JVmvVA1
         2IWJUCahuJBOt86XfSnPlYmSak1nx8t6XvHw5fNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 016/103] udp: with udp_segment release on error path
Date:   Tue, 29 Jan 2019 12:34:53 +0100
Message-Id: <20190129113200.511447606@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
References: <20190129113159.567154026@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 0f149c9fec3cd720628ecde83bfc6f64c1e7dcb6 ]

Failure __ip_append_data triggers udp_flush_pending_frames, but these
tests happen later. The skb must be freed directly.

Fixes: bec1f6f697362 ("udp: generate gso with UDP_SEGMENT")
Reported-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/udp.c |   16 ++++++++++++----
 net/ipv6/udp.c |   16 ++++++++++++----
 2 files changed, 24 insertions(+), 8 deletions(-)

--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -785,15 +785,23 @@ static int udp_send_skb(struct sk_buff *
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize)
+		if (hlen + cork->gso_size > cork->fragsize) {
+			kfree_skb(skb);
 			return -EINVAL;
-		if (skb->len > cork->gso_size * UDP_MAX_SEGMENTS)
+		}
+		if (skb->len > cork->gso_size * UDP_MAX_SEGMENTS) {
+			kfree_skb(skb);
 			return -EINVAL;
-		if (sk->sk_no_check_tx)
+		}
+		if (sk->sk_no_check_tx) {
+			kfree_skb(skb);
 			return -EINVAL;
+		}
 		if (skb->ip_summed != CHECKSUM_PARTIAL || is_udplite ||
-		    dst_xfrm(skb_dst(skb)))
+		    dst_xfrm(skb_dst(skb))) {
+			kfree_skb(skb);
 			return -EIO;
+		}
 
 		skb_shinfo(skb)->gso_size = cork->gso_size;
 		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1056,15 +1056,23 @@ static int udp_v6_send_skb(struct sk_buf
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize)
+		if (hlen + cork->gso_size > cork->fragsize) {
+			kfree_skb(skb);
 			return -EINVAL;
-		if (skb->len > cork->gso_size * UDP_MAX_SEGMENTS)
+		}
+		if (skb->len > cork->gso_size * UDP_MAX_SEGMENTS) {
+			kfree_skb(skb);
 			return -EINVAL;
-		if (udp_sk(sk)->no_check6_tx)
+		}
+		if (udp_sk(sk)->no_check6_tx) {
+			kfree_skb(skb);
 			return -EINVAL;
+		}
 		if (skb->ip_summed != CHECKSUM_PARTIAL || is_udplite ||
-		    dst_xfrm(skb_dst(skb)))
+		    dst_xfrm(skb_dst(skb))) {
+			kfree_skb(skb);
 			return -EIO;
+		}
 
 		skb_shinfo(skb)->gso_size = cork->gso_size;
 		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;


