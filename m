Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC081C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5941C2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 23:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps4jQr2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5941C2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbeJKGhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbeJKGhm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:37:42 -0400
Received: from lerouge.suse.de (LFbn-NCY-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E402098A;
        Wed, 10 Oct 2018 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539213200;
        bh=28A1LPdReVg/VHoRZ45U5Y4FgbfDvx0W3uFVWepFBOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ps4jQr2AzW/RevTta0ROACClgDcllUNu/DwJjLPJQKiONH/GnyKXTOpGF/ojsK7Uo
         AwkvZ6DBLHURcN7hoxJUQXj6GRlIcq6VLDNyAhV6MJxxnmvnASQEihSnoRo3t0eBd6
         uHPvPaxAM0sXG08PjxaAo9gtZnH4zV92IgAtIUaI=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Subject: [RFC PATCH 16/30] net: Prepare nf_log_buf_open() for handling softirq mask
Date:   Thu, 11 Oct 2018 01:12:03 +0200
Message-Id: <1539213137-13953-17-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539213137-13953-1-git-send-email-frederic@kernel.org>
References: <1539213137-13953-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This pair of function is implemented on top of local_bh_disable() that
is going to handle a softirq mask in order to apply finegrained vector
disablement. The lock function is going to return the previous vectors
enabled mask prior to the last call to local_bh_disable(), following a
similar model to that of local_irq_save/restore. Subsequent calls to
local_bh_disable() and friends can then stack up:

	bh = local_bh_disable(vec_mask);
		nf_log_buf_open(&bh2) {
			*bh2 = local_bh_disable(...)
		}
		...
		nf_log_buf_close(bh2) {
			local_bh_enable(bh2);
		}
	local_bh_enable(bh);

To prepare for that, make nf_log_buf_open() able to return a saved vector
enabled mask and pass it back to nf_log_buf_close(). We'll plug it to
local_bh_disable() in a subsequent patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/net/netfilter/nf_log.h   | 4 ++--
 net/ipv4/netfilter/nf_log_arp.c  | 5 +++--
 net/ipv4/netfilter/nf_log_ipv4.c | 5 +++--
 net/ipv6/netfilter/nf_log_ipv6.c | 5 +++--
 net/netfilter/nf_log.c           | 4 ++--
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/netfilter/nf_log.h b/include/net/netfilter/nf_log.h
index 0d39208..ab55ff9 100644
--- a/include/net/netfilter/nf_log.h
+++ b/include/net/netfilter/nf_log.h
@@ -96,9 +96,9 @@ void nf_log_trace(struct net *net,
 
 struct nf_log_buf;
 
-struct nf_log_buf *nf_log_buf_open(void);
+struct nf_log_buf *nf_log_buf_open(unsigned int *bh);
 __printf(2, 3) int nf_log_buf_add(struct nf_log_buf *m, const char *f, ...);
-void nf_log_buf_close(struct nf_log_buf *m);
+void nf_log_buf_close(struct nf_log_buf *m, unsigned int bh);
 
 /* common logging functions */
 int nf_log_dump_udp_header(struct nf_log_buf *m, const struct sk_buff *skb,
diff --git a/net/ipv4/netfilter/nf_log_arp.c b/net/ipv4/netfilter/nf_log_arp.c
index df5c2a2..3696911 100644
--- a/net/ipv4/netfilter/nf_log_arp.c
+++ b/net/ipv4/netfilter/nf_log_arp.c
@@ -85,12 +85,13 @@ static void nf_log_arp_packet(struct net *net, u_int8_t pf,
 			      const char *prefix)
 {
 	struct nf_log_buf *m;
+	unsigned int bh;
 
 	/* FIXME: Disabled from containers until syslog ns is supported */
 	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
 		return;
 
-	m = nf_log_buf_open();
+	m = nf_log_buf_open(&bh);
 
 	if (!loginfo)
 		loginfo = &default_loginfo;
@@ -99,7 +100,7 @@ static void nf_log_arp_packet(struct net *net, u_int8_t pf,
 				  prefix);
 	dump_arp_packet(m, loginfo, skb, 0);
 
-	nf_log_buf_close(m);
+	nf_log_buf_close(m, bh);
 }
 
 static struct nf_logger nf_arp_logger __read_mostly = {
diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
index 1e6f28c..996f386 100644
--- a/net/ipv4/netfilter/nf_log_ipv4.c
+++ b/net/ipv4/netfilter/nf_log_ipv4.c
@@ -317,12 +317,13 @@ static void nf_log_ip_packet(struct net *net, u_int8_t pf,
 			     const char *prefix)
 {
 	struct nf_log_buf *m;
+	unsigned int bh;
 
 	/* FIXME: Disabled from containers until syslog ns is supported */
 	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
 		return;
 
-	m = nf_log_buf_open();
+	m = nf_log_buf_open(&bh);
 
 	if (!loginfo)
 		loginfo = &default_loginfo;
@@ -335,7 +336,7 @@ static void nf_log_ip_packet(struct net *net, u_int8_t pf,
 
 	dump_ipv4_packet(net, m, loginfo, skb, 0);
 
-	nf_log_buf_close(m);
+	nf_log_buf_close(m, bh);
 }
 
 static struct nf_logger nf_ip_logger __read_mostly = {
diff --git a/net/ipv6/netfilter/nf_log_ipv6.c b/net/ipv6/netfilter/nf_log_ipv6.c
index c6bf580..62bff78 100644
--- a/net/ipv6/netfilter/nf_log_ipv6.c
+++ b/net/ipv6/netfilter/nf_log_ipv6.c
@@ -349,12 +349,13 @@ static void nf_log_ip6_packet(struct net *net, u_int8_t pf,
 			      const char *prefix)
 {
 	struct nf_log_buf *m;
+	unsigned int bh;
 
 	/* FIXME: Disabled from containers until syslog ns is supported */
 	if (!net_eq(net, &init_net) && !sysctl_nf_log_all_netns)
 		return;
 
-	m = nf_log_buf_open();
+	m = nf_log_buf_open(&bh);
 
 	if (!loginfo)
 		loginfo = &default_loginfo;
@@ -367,7 +368,7 @@ static void nf_log_ip6_packet(struct net *net, u_int8_t pf,
 
 	dump_ipv6_packet(net, m, loginfo, skb, skb_network_offset(skb), 1);
 
-	nf_log_buf_close(m);
+	nf_log_buf_close(m, bh);
 }
 
 static struct nf_logger nf_ip6_logger __read_mostly = {
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index a61d6df..06ded8a31 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -292,7 +292,7 @@ __printf(2, 3) int nf_log_buf_add(struct nf_log_buf *m, const char *f, ...)
 }
 EXPORT_SYMBOL_GPL(nf_log_buf_add);
 
-struct nf_log_buf *nf_log_buf_open(void)
+struct nf_log_buf *nf_log_buf_open(unsigned int *bh)
 {
 	struct nf_log_buf *m = kmalloc(sizeof(*m), GFP_ATOMIC);
 
@@ -307,7 +307,7 @@ struct nf_log_buf *nf_log_buf_open(void)
 }
 EXPORT_SYMBOL_GPL(nf_log_buf_open);
 
-void nf_log_buf_close(struct nf_log_buf *m)
+void nf_log_buf_close(struct nf_log_buf *m, unsigned int bh)
 {
 	m->buf[m->count] = 0;
 	printk("%s\n", m->buf);
-- 
2.7.4

