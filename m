Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B194CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8237120882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548761835;
	bh=ILjrkFsg19HOFzpdco6mMN5PKGitEWwz4KB6fQHYT9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yxLOrsuOQg9UyvpbMlmhoN+AgjwebsJKpnfSw8YBUtao1HtxjfHCUGdyaUptbx8C8
	 UQIw/245Rk14zyk5Kgl7WnbdZsplbVGtHhxqwLNiYcG1vnSvfcygQINjIB4FM0G+1v
	 8PztnBG83BX51b5IDn408bTs7y63qVo/QezbaOYQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfA2LhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:37:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:53834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728745AbfA2LhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:37:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BE9E20882;
        Tue, 29 Jan 2019 11:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548761830;
        bh=ILjrkFsg19HOFzpdco6mMN5PKGitEWwz4KB6fQHYT9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YUDWS0NRv/ke8ny8OWsD+F1BiUhZ8fBsLx/PmsxYJf3AHbQRCPJZGjPgBZFwz7fVj
         b6+l8pozDZcL90v6XLaLGQ0F8KzuYynTArmJ/KyJi1n3MCQrdAqdzSWfT3ZhelMZ32
         d4b1Hr6M5sZcCsR+JxT0QEhH52vMl5lGXJG/xTNE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 016/117] udp: with udp_segment release on error path
Date:   Tue, 29 Jan 2019 12:34:27 +0100
Message-Id: <20190129113208.435949540@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113207.477505932@linuxfoundation.org>
References: <20190129113207.477505932@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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


