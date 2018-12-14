Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFAF0C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A04BF20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A04BF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeLNKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:52:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60816 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729693AbeLNKw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:52:27 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 160FB306429A;
        Fri, 14 Dec 2018 10:52:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.32.181.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04C326FA9;
        Fri, 14 Dec 2018 10:52:25 +0000 (UTC)
From:   Paolo Abeni <pabeni@redhat.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Paul Turner <pjt@google.com>, linux-kernel@vger.kernel.org,
        Edward Cree <ecree@solarflare.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH net-next v3 4/4] udp: use indirect call wrappers for GRO socket lookup
Date:   Fri, 14 Dec 2018 11:52:00 +0100
Message-Id: <c9ed62fbef796117aef08cb946d8b25d211f2710.1544784419.git.pabeni@redhat.com>
In-Reply-To: <cover.1544784419.git.pabeni@redhat.com>
References: <cover.1544784419.git.pabeni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 14 Dec 2018 10:52:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This avoids another indirect call for UDP GRO. Again, the test
for the IPv6 variant is performed first.

v1 -> v2:
 - adapted to INDIRECT_CALL_ changes

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/udp_offload.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 9a141a6cf1a0..64f9715173ac 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -392,6 +392,8 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	return NULL;
 }
 
+INDIRECT_CALLABLE_DECLARE(struct sock *udp6_lib_lookup_skb(struct sk_buff *skb,
+						   __be16 sport, __be16 dport));
 struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 				struct udphdr *uh, udp_lookup_t lookup)
 {
@@ -403,7 +405,8 @@ struct sk_buff *udp_gro_receive(struct list_head *head, struct sk_buff *skb,
 	struct sock *sk;
 
 	rcu_read_lock();
-	sk = (*lookup)(skb, uh->source, uh->dest);
+	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
+				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
 	if (!sk)
 		goto out_unlock;
 
@@ -503,7 +506,8 @@ int udp_gro_complete(struct sk_buff *skb, int nhoff,
 	uh->len = newlen;
 
 	rcu_read_lock();
-	sk = (*lookup)(skb, uh->source, uh->dest);
+	sk = INDIRECT_CALL_INET(lookup, udp6_lib_lookup_skb,
+				udp4_lib_lookup_skb, skb, uh->source, uh->dest);
 	if (sk && udp_sk(sk)->gro_enabled) {
 		err = udp_gro_complete_segment(skb);
 	} else if (sk && udp_sk(sk)->gro_complete) {
-- 
2.19.2

