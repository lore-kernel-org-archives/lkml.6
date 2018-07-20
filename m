Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58010ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A62B20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A62B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbeGTNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:31:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389610AbeGTNbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:24 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8B201BBD;
        Fri, 20 Jul 2018 12:36:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lou Berger <lberger@labn.net>,
        Renato Westphal <renato@opensourcerouting.org>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 032/101] net/tcp: Fix socket lookups with SO_BINDTODEVICE
Date:   Fri, 20 Jul 2018 14:13:38 +0200
Message-Id: <20180720121424.316292960@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 8c43bd1706885ba1acfa88da02bc60a2ec16f68c ]

Similar to 69678bcd4d2d ("udp: fix SO_BINDTODEVICE"), TCP socket lookups
need to fail if dev_match is not true. Currently, a packet to a given port
can match a socket bound to device when it should not. In the VRF case,
this causes the lookup to hit a VRF socket and not a global socket
resulting in a response trying to go through the VRF when it should not.

Fixes: 3fa6f616a7a4d ("net: ipv4: add second dif to inet socket lookups")
Fixes: 4297a0ef08572 ("net: ipv6: add second dif to inet6 socket lookups")
Reported-by: Lou Berger <lberger@labn.net>
Diagnosed-by: Renato Westphal <renato@opensourcerouting.org>
Tested-by: Renato Westphal <renato@opensourcerouting.org>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_hashtables.c  |    4 ++--
 net/ipv6/inet6_hashtables.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -243,9 +243,9 @@ static inline int compute_score(struct s
 			bool dev_match = (sk->sk_bound_dev_if == dif ||
 					  sk->sk_bound_dev_if == sdif);
 
-			if (exact_dif && !dev_match)
+			if (!dev_match)
 				return -1;
-			if (sk->sk_bound_dev_if && dev_match)
+			if (sk->sk_bound_dev_if)
 				score += 4;
 		}
 		if (sk->sk_incoming_cpu == raw_smp_processor_id())
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -113,9 +113,9 @@ static inline int compute_score(struct s
 			bool dev_match = (sk->sk_bound_dev_if == dif ||
 					  sk->sk_bound_dev_if == sdif);
 
-			if (exact_dif && !dev_match)
+			if (!dev_match)
 				return -1;
-			if (sk->sk_bound_dev_if && dev_match)
+			if (sk->sk_bound_dev_if)
 				score++;
 		}
 		if (sk->sk_incoming_cpu == raw_smp_processor_id())


