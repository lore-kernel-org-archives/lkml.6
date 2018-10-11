Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A3C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4EC21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHhKEFrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A4EC21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbeJKXKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:05 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF6D213A2;
        Thu, 11 Oct 2018 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272541;
        bh=seJyfT3S1vRBoUxBARbPjinUttrwwoH/BQZgH3Y6PK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHhKEFrfd9oyacLRnfyu8s2zz3AWuQOEa/bAf8HuI8bP2SbJBbXYyZ06fEUNlZOny
         AhgMrSXMtoulUnkrI7U1fJ7uaITxEdKfdxOVnIAXoxRYB/rxNqOD/6lYGnK/QxT4Uw
         0UlNyfq8aNc+z/ZbZbVnaQimTFCIHkSnCD4EWJ7A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 25/27] tcp: add tcp_ooo_try_coalesce() helper
Date:   Thu, 11 Oct 2018 17:35:12 +0200
Message-Id: <20181011152535.243990354@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 58152ecbbcc6a0ce7fddd5bf5f6ee535834ece0c ]

In case skb in out_or_order_queue is the result of
multiple skbs coalescing, we would like to get a proper gso_segs
counter tracking, so that future tcp_drop() can report an accurate
number.

I chose to not implement this tracking for skbs in receive queue,
since they are not dropped, unless socket is disconnected.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4296,6 +4296,23 @@ static bool tcp_try_coalesce(struct sock
 	return true;
 }
 
+static bool tcp_ooo_try_coalesce(struct sock *sk,
+			     struct sk_buff *to,
+			     struct sk_buff *from,
+			     bool *fragstolen)
+{
+	bool res = tcp_try_coalesce(sk, to, from, fragstolen);
+
+	/* In case tcp_drop() is called later, update to->gso_segs */
+	if (res) {
+		u32 gso_segs = max_t(u16, 1, skb_shinfo(to)->gso_segs) +
+			       max_t(u16, 1, skb_shinfo(from)->gso_segs);
+
+		skb_shinfo(to)->gso_segs = min_t(u32, gso_segs, 0xFFFF);
+	}
+	return res;
+}
+
 static void tcp_drop(struct sock *sk, struct sk_buff *skb)
 {
 	sk_drops_add(sk, skb);
@@ -4422,7 +4439,8 @@ static void tcp_data_queue_ofo(struct so
 	/* In the typical case, we are adding an skb to the end of the list.
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (tcp_try_coalesce(sk, tp->ooo_last_skb, skb, &fragstolen)) {
+	if (tcp_ooo_try_coalesce(sk, tp->ooo_last_skb,
+				 skb, &fragstolen)) {
 coalesce_done:
 		tcp_grow_window(sk, skb);
 		kfree_skb_partial(skb, fragstolen);
@@ -4467,7 +4485,8 @@ coalesce_done:
 				tcp_drop(sk, skb1);
 				goto merge_right;
 			}
-		} else if (tcp_try_coalesce(sk, skb1, skb, &fragstolen)) {
+		} else if (tcp_ooo_try_coalesce(sk, skb1,
+						skb, &fragstolen)) {
 			goto coalesce_done;
 		}
 		p = &parent->rb_right;


