Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0D8C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9C7217C6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 09:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9C7217C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732886AbeHDLFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 07:05:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48726 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728340AbeHDLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 07:05:16 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A3667BB3;
        Sat,  4 Aug 2018 09:05:17 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Neal Cardwell <ncardwell@google.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 15/32] tcp: add one more quick ack after after ECN events
Date:   Sat,  4 Aug 2018 11:01:05 +0200
Message-Id: <20180804082650.727986379@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180804082649.908295462@linuxfoundation.org>
References: <20180804082649.908295462@linuxfoundation.org>
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

[ Upstream commit 15ecbe94a45ef88491ca459b26efdd02f91edb6d ]

Larry Brakmo proposal ( https://patchwork.ozlabs.org/patch/935233/
tcp: force cwnd at least 2 in tcp_cwnd_reduction) made us rethink
about our recent patch removing ~16 quick acks after ECN events.

tcp_enter_quickack_mode(sk, 1) makes sure one immediate ack is sent,
but in the case the sender cwnd was lowered to 1, we do not want
to have a delayed ack for the next packet we will receive.

Fixes: 522040ea5fdd ("tcp: do not aggressively quick ack after ECN events")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Neal Cardwell <ncardwell@google.com>
Cc: Lawrence Brakmo <brakmo@fb.com>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -261,7 +261,7 @@ static void __tcp_ecn_check_ce(struct so
 		 * it is probably a retransmit.
 		 */
 		if (tp->ecn_flags & TCP_ECN_SEEN)
-			tcp_enter_quickack_mode(sk, 1);
+			tcp_enter_quickack_mode(sk, 2);
 		break;
 	case INET_ECN_CE:
 		if (tcp_ca_needs_ecn(sk))
@@ -269,7 +269,7 @@ static void __tcp_ecn_check_ce(struct so
 
 		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
 			/* Better not delay acks, sender can have a very low cwnd */
-			tcp_enter_quickack_mode(sk, 1);
+			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
 		tp->ecn_flags |= TCP_ECN_SEEN;


