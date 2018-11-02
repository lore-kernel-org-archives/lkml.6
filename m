Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86381C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5747620847
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdGCpChE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5747620847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeKCDvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbeKCDvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:51:36 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F24CF20847;
        Fri,  2 Nov 2018 18:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184203;
        bh=SCWD+HAQxy1i03z8Sgw91ivvLmuJLUSarS938PYECUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YdGCpChEWWL8sdtYEjvYkR9kbtRiSS8z0cg9xH5g2aaJPzifaO2H2CP36ESVuBou+
         FnZXID7U8LjIwPZ06nFdgRvV1ThMfJ2+awknKTOy7tAG5WQSEuvUzunfr6quKIkvwE
         p6xwPH9UnlgQ+2tUk9SZN40jkh0fs5Q4Y5A+l4dg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 106/150] ipv6: rate-limit probes for neighbourless routes
Date:   Fri,  2 Nov 2018 19:34:28 +0100
Message-Id: <20181102182910.664214711@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit f547fac624be53ad8b07e9ebca7654a7827ba61b ]

When commit 270972554c91 ("[IPV6]: ROUTE: Add Router Reachability
Probing (RFC4191).") introduced router probing, the rt6_probe() function
required that a neighbour entry existed. This neighbour entry is used to
record the timestamp of the last probe via the ->updated field.

Later, commit 2152caea7196 ("ipv6: Do not depend on rt->n in rt6_probe().")
removed the requirement for a neighbour entry. Neighbourless routes skip
the interval check and are not rate-limited.

This patch adds rate-limiting for neighbourless routes, by recording the
timestamp of the last probe in the fib6_info itself.

Fixes: 2152caea7196 ("ipv6: Do not depend on rt->n in rt6_probe().")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/ip6_fib.h |    4 ++++
 net/ipv6/route.c      |   12 ++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

--- a/include/net/ip6_fib.h
+++ b/include/net/ip6_fib.h
@@ -159,6 +159,10 @@ struct fib6_info {
 	struct rt6_info * __percpu	*rt6i_pcpu;
 	struct rt6_exception_bucket __rcu *rt6i_exception_bucket;
 
+#ifdef CONFIG_IPV6_ROUTER_PREF
+	unsigned long			last_probe;
+#endif
+
 	u32				fib6_metric;
 	u8				fib6_protocol;
 	u8				fib6_type;
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -517,10 +517,11 @@ static void rt6_probe_deferred(struct wo
 
 static void rt6_probe(struct fib6_info *rt)
 {
-	struct __rt6_probe_work *work;
+	struct __rt6_probe_work *work = NULL;
 	const struct in6_addr *nh_gw;
 	struct neighbour *neigh;
 	struct net_device *dev;
+	struct inet6_dev *idev;
 
 	/*
 	 * Okay, this does not seem to be appropriate
@@ -536,15 +537,12 @@ static void rt6_probe(struct fib6_info *
 	nh_gw = &rt->fib6_nh.nh_gw;
 	dev = rt->fib6_nh.nh_dev;
 	rcu_read_lock_bh();
+	idev = __in6_dev_get(dev);
 	neigh = __ipv6_neigh_lookup_noref(dev, nh_gw);
 	if (neigh) {
-		struct inet6_dev *idev;
-
 		if (neigh->nud_state & NUD_VALID)
 			goto out;
 
-		idev = __in6_dev_get(dev);
-		work = NULL;
 		write_lock(&neigh->lock);
 		if (!(neigh->nud_state & NUD_VALID) &&
 		    time_after(jiffies,
@@ -554,11 +552,13 @@ static void rt6_probe(struct fib6_info *
 				__neigh_set_probe_once(neigh);
 		}
 		write_unlock(&neigh->lock);
-	} else {
+	} else if (time_after(jiffies, rt->last_probe +
+				       idev->cnf.rtr_probe_interval)) {
 		work = kmalloc(sizeof(*work), GFP_ATOMIC);
 	}
 
 	if (work) {
+		rt->last_probe = jiffies;
 		INIT_WORK(&work->work, rt6_probe_deferred);
 		work->target = *nh_gw;
 		dev_hold(dev);


