Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904C2C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACFF2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACFF2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeKQVsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:48:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbeKQVsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:48:17 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE3F48553D;
        Sat, 17 Nov 2018 11:31:53 +0000 (UTC)
Received: from localhost (ovpn-200-47.brq.redhat.com [10.40.200.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E88A19742;
        Sat, 17 Nov 2018 11:31:50 +0000 (UTC)
Date:   Sat, 17 Nov 2018 12:31:46 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Joe Perches <joe@perches.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] geneve: Use empty braces for addr6
 initializer
Message-ID: <20181117123110.4caca757@redhat.com>
In-Reply-To: <138f1c15387c47fe65f4a0448f35afdd9db81933.camel@perches.com>
References: <20181112221248.11477-1-natechancellor@gmail.com>
        <20181113061146.12182-1-natechancellor@gmail.com>
        <20181116150432.2408a075@redhat.com>
        <20181116153701.GA16184@flashbox>
        <138f1c15387c47fe65f4a0448f35afdd9db81933.camel@perches.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sat, 17 Nov 2018 11:31:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Nov 2018 18:33:40 -0800
Joe Perches <joe@perches.com> wrote:

> If this is really an issue, I don't know why the other uses
> haven't been reported.

It causes warnings with some older gcc versions and clang, I don't see
it as an issue, but others might.

> Perhaps change the rest of them too?

But then look, we already have a delicious strict C89 initialiser in
include/linux/in6.h, and we can do this:

 drivers/net/geneve.c        |    4 ++--
 include/net/ip6_fib.h       |    9 +++------
 include/trace/events/fib6.h |    4 +---
 net/6lowpan/iphc.c          |   12 ++++++------
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 7c53e06b31c3..96588adc294c 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -191,7 +191,7 @@ static struct geneve_dev *geneve_lookup_skb(struct geneve_sock *gs,
                return geneve_lookup(gs, addr, vni);
 #if IS_ENABLED(CONFIG_IPV6)
        } else if (geneve_get_sk_family(gs) == AF_INET6) {
-               static struct in6_addr zero_addr6;
+               struct in6_addr zero_addr6 = IN6ADDR_ANY_INIT;
                struct ipv6hdr *ip6h;
                struct in6_addr addr6;
 
@@ -424,8 +424,8 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 
 #if IS_ENABLED(CONFIG_IPV6)
        if (geneve_get_sk_family(gs) == AF_INET6) {
+               struct in6_addr addr6 = IN6ADDR_ANY_INIT;
                struct ipv6hdr *ip6h = ipv6_hdr(skb);
-               struct in6_addr addr6 = { 0 };
 
                if (!gs->collect_md) {
                        vni = geneve_hdr(skb)->vni;
diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
index 84097010237c..24543caf5a9f 100644
--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -427,13 +427,10 @@ void rt6_get_prefsrc(const struct rt6_info *rt, struct in6_addr *addr)
        rcu_read_lock();
 
        from = rcu_dereference(rt->from);
-       if (from) {
+       if (from)
                *addr = from->fib6_prefsrc.addr;
-       } else {
-               struct in6_addr in6_zero = {};
-
-               *addr = in6_zero;
-       }
+       else
+               *addr = in6addr_any;
 
        rcu_read_unlock();
 }
diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index b088b54d699c..6496ca1594ac 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -68,10 +68,8 @@ TRACE_EVENT(fib6_table_lookup,
                        __assign_str(name, "-");
                }
                if (f6i == net->ipv6.fib6_null_entry) {
-                       struct in6_addr in6_zero = {};
-
                        in6 = (struct in6_addr *)__entry->gw;
-                       *in6 = in6_zero;
+                       *in6 = in6addr_any;
 
                } else if (f6i) {
                        in6 = (struct in6_addr *)__entry->gw;
diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index 52fad5dad9f7..f0e0bac91e71 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -246,8 +246,8 @@ lowpan_iphc_ctx_get_by_mcast_addr(const struct net_device *dev,
                                  const struct in6_addr *addr)
 {
        struct lowpan_iphc_ctx *table = lowpan_dev(dev)->ctx.table;
+       struct in6_addr addr_mcast, network_pfx = IN6ADDR_ANY_INIT;
        struct lowpan_iphc_ctx *ret = NULL;
-       struct in6_addr addr_mcast, network_pfx = {};
        int i;
 
        /* init mcast address with  */
@@ -481,7 +481,7 @@ static int lowpan_uncompress_multicast_ctx_daddr(struct sk_buff *skb,
                                                 struct in6_addr *ipaddr,
                                                 u8 address_mode)
 {
-       struct in6_addr network_pfx = {};
+       struct in6_addr network_pfx = IN6ADDR_ANY_INIT;
        bool fail;
 
        ipaddr->s6_addr[0] = 0xFF;
@@ -794,8 +794,8 @@ lowpan_iphc_compress_ctx_802154_lladdr(const struct in6_addr *ipaddr,
 {
        const struct ieee802154_addr *addr = lladdr;
        unsigned char extended_addr[EUI64_ADDR_LEN];
+       struct in6_addr tmp = IN6ADDR_ANY_INIT;
        bool lladdr_compress = false;
-       struct in6_addr tmp = {};
 
        switch (addr->mode) {
        case IEEE802154_ADDR_LONG:
@@ -833,7 +833,7 @@ static bool lowpan_iphc_addr_equal(const struct net_device *dev,
                                   const struct in6_addr *ipaddr,
                                   const void *lladdr)
 {
-       struct in6_addr tmp = {};
+       struct in6_addr tmp = IN6ADDR_ANY_INIT;
 
        lowpan_iphc_uncompress_lladdr(dev, &tmp, lladdr);
 
@@ -848,7 +848,7 @@ static u8 lowpan_compress_ctx_addr(u8 **hc_ptr, const struct net_device *dev,
                                   const struct lowpan_iphc_ctx *ctx,
                                   const unsigned char *lladdr, bool sam)
 {
-       struct in6_addr tmp = {};
+       struct in6_addr tmp = IN6ADDR_ANY_INIT;
        u8 dam;
 
        switch (lowpan_dev(dev)->lltype) {
@@ -907,8 +907,8 @@ lowpan_iphc_compress_802154_lladdr(const struct in6_addr *ipaddr,
 {
        const struct ieee802154_addr *addr = lladdr;
        unsigned char extended_addr[EUI64_ADDR_LEN];
+       struct in6_addr tmp = IN6ADDR_ANY_INIT;
        bool lladdr_compress = false;
-       struct in6_addr tmp = {};
 
        switch (addr->mode) {
        case IEEE802154_ADDR_LONG:

-- 
Stefano
