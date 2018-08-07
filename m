Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AEDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BE482174D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BE482174D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404720AbeHGVQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:16:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404680AbeHGVQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:16:08 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F93874;
        Tue,  7 Aug 2018 19:00:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 70/85] tcp: do not aggressively quick ack after ECN events
Date:   Tue,  7 Aug 2018 20:52:12 +0200
Message-Id: <20180807172359.957708787@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807172357.357252052@linuxfoundation.org>
References: <20180807172357.357252052@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 522040ea5fdd1c33bbf75e1d7c7c0422b96a94ef ]

ECN signals currently forces TCP to enter quickack mode for
up to 16 (TCP_MAX_QUICKACKS) following incoming packets.

We believe this is not needed, and only sending one immediate ack
for the current packet should be enough.

This should reduce the extra load noticed in DCTCP environments,
after congestion events.

This is part 2 of our effort to reduce pure ACK packets.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -230,7 +230,7 @@ static void __tcp_ecn_check_ce(struct tc
 		 * it is probably a retransmit.
 		 */
 		if (tp->ecn_flags & TCP_ECN_SEEN)
-			tcp_enter_quickack_mode((struct sock *)tp, TCP_MAX_QUICKACKS);
+			tcp_enter_quickack_mode((struct sock *)tp, 1);
 		break;
 	case INET_ECN_CE:
 		if (tcp_ca_needs_ecn((struct sock *)tp))
@@ -238,7 +238,7 @@ static void __tcp_ecn_check_ce(struct tc
 
 		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
 			/* Better not delay acks, sender can have a very low cwnd */
-			tcp_enter_quickack_mode((struct sock *)tp, TCP_MAX_QUICKACKS);
+			tcp_enter_quickack_mode((struct sock *)tp, 1);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
 		tp->ecn_flags |= TCP_ECN_SEEN;


