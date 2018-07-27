Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB00C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CB42089E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CB42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388775AbeG0Lb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:31:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36494 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:31:24 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 539B1CB6;
        Fri, 27 Jul 2018 10:10:12 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 20/33] tcp: call tcp_drop() from tcp_data_queue_ofo()
Date:   Fri, 27 Jul 2018 12:09:01 +0200
Message-Id: <20180727100828.429780690@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 8541b21e781a22dce52a74fef0b9bed00404a1cd ]

In order to be able to give better diagnostics and detect
malicious traffic, we need to have better sk->sk_drops tracking.

Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4517,7 +4517,7 @@ coalesce_done:
 				/* All the bits are present. Drop. */
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPOFOMERGE);
-				__kfree_skb(skb);
+				tcp_drop(sk, skb);
 				skb = NULL;
 				tcp_dsack_set(sk, seq, end_seq);
 				goto add_sack;
@@ -4536,7 +4536,7 @@ coalesce_done:
 						 TCP_SKB_CB(skb1)->end_seq);
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPOFOMERGE);
-				__kfree_skb(skb1);
+				tcp_drop(sk, skb1);
 				goto merge_right;
 			}
 		} else if (tcp_try_coalesce(sk, skb1, skb, &fragstolen)) {


