Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B8D5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A712177A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A712177A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389556AbeHDLMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:12:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388557AbeHDLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:12:54 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8A0B589C;
        Sat,  4 Aug 2018 09:12:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 109/124] tcp: do not force quickack when receiving out-of-order packets
Date:   Sat,  4 Aug 2018 11:01:38 +0200
Message-Id: <20180804082706.540650534@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082702.434482435@linuxfoundation.org>
References: <20180804082702.434482435@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit a3893637e1eb0ef5eb1bbc52b3a8d2dfa317a35d ]

As explained in commit 9f9843a751d0 ("tcp: properly handle stretch
acks in slow start"), TCP stacks have to consider how many packets
are acknowledged in one single ACK, because of GRO, but also
because of ACK compression or losses.

We plan to add SACK compression in the following patch, we
must therefore not call tcp_enter_quickack_mode()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    2 --
 1 file changed, 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4649,8 +4649,6 @@ drop:
 	if (!before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt + tcp_receive_window(tp)))
 		goto out_of_window;
 
-	tcp_enter_quickack_mode(sk);
-
 	if (before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
 		/* Partial packet, seq < rcv_next < end_seq */
 		SOCK_DEBUG(sk, "partial packet: rcv_next %X seq %X - %X\n",


