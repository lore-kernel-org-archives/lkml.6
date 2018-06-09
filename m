Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Mw+dObfyG1v4XwAAmS7hNA
	; Sat, 09 Jun 2018 15:31:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 940B9608C8; Sat,  9 Jun 2018 15:31:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zjyGG9rH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF9DD602FC;
	Sat,  9 Jun 2018 15:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF9DD602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeFIPbf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 11:31:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753595AbeFIPb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 11:31:29 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D545204EC;
        Sat,  9 Jun 2018 15:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528558288;
        bh=Cm624tGaLYrWOhrebg0eHvYOKyB80Uh4x1uvMlh21JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zjyGG9rHpjkFWiUYasCAfINraOKjYuZ8R3GZ5kwaXsy3CYWdYHgf+bilKKJ4hoIPq
         X+3YlxSkgKzWFsMQbmBOYiPaamJiS+7iX1l8MLuDJ+inJB6hFHIgVzRQqXnnFYqnDE
         jbMktVU/cMP088bd70HQ++18SaeRxUE9gcJtS22w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 14/15] ipmr: fix error path when ipmr_new_table fails
Date: Sat,  9 Jun 2018 17:29:49 +0200
Message-Id: <20180609150001.459043011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180609150000.746833461@linuxfoundation.org>
References: <20180609150000.746833461@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit e783bb00ad86d9d1f01d9d3a750713070036358e ]

commit 0bbbf0e7d0e7 ("ipmr, ip6mr: Unite creation of new mr_table")
refactored ipmr_new_table, so that it now returns NULL when
mr_table_alloc fails. Unfortunately, all callers of ipmr_new_table
expect an ERR_PTR.

This can result in NULL deref, for example when ipmr_rules_exit calls
ipmr_free_table with NULL net->ipv4.mrt in the
!CONFIG_IP_MROUTE_MULTIPLE_TABLES version.

This patch makes mr_table_alloc return errors, and changes
ip6mr_new_table and its callers to return/expect error pointers as
well. It also removes the version of mr_table_alloc defined under
!CONFIG_IP_MROUTE_COMMON, since it is never used.

Fixes: 0bbbf0e7d0e7 ("ipmr, ip6mr: Unite creation of new mr_table")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/mroute_base.h |   10 ----------
 net/ipv4/ipmr_base.c        |    8 +++++---
 net/ipv6/ip6mr.c            |   18 ++++++++++++------
 3 files changed, 17 insertions(+), 19 deletions(-)

--- a/include/linux/mroute_base.h
+++ b/include/linux/mroute_base.h
@@ -307,16 +307,6 @@ static inline void vif_device_init(struc
 {
 }
 
-static inline void *
-mr_table_alloc(struct net *net, u32 id,
-	       struct mr_table_ops *ops,
-	       void (*expire_func)(struct timer_list *t),
-	       void (*table_set)(struct mr_table *mrt,
-				 struct net *net))
-{
-	return NULL;
-}
-
 static inline void *mr_mfc_find_parent(struct mr_table *mrt,
 				       void *hasharg, int parent)
 {
--- a/net/ipv4/ipmr_base.c
+++ b/net/ipv4/ipmr_base.c
@@ -35,17 +35,19 @@ mr_table_alloc(struct net *net, u32 id,
 				 struct net *net))
 {
 	struct mr_table *mrt;
+	int err;
 
 	mrt = kzalloc(sizeof(*mrt), GFP_KERNEL);
 	if (!mrt)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	mrt->id = id;
 	write_pnet(&mrt->net, net);
 
 	mrt->ops = *ops;
-	if (rhltable_init(&mrt->mfc_hash, mrt->ops.rht_params)) {
+	err = rhltable_init(&mrt->mfc_hash, mrt->ops.rht_params);
+	if (err) {
 		kfree(mrt);
-		return NULL;
+		return ERR_PTR(err);
 	}
 	INIT_LIST_HEAD(&mrt->mfc_cache_list);
 	INIT_LIST_HEAD(&mrt->mfc_unres_queue);
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -227,8 +227,8 @@ static int __net_init ip6mr_rules_init(s
 	INIT_LIST_HEAD(&net->ipv6.mr6_tables);
 
 	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
-	if (!mrt) {
-		err = -ENOMEM;
+	if (IS_ERR(mrt)) {
+		err = PTR_ERR(mrt);
 		goto err1;
 	}
 
@@ -301,8 +301,13 @@ static int ip6mr_fib_lookup(struct net *
 
 static int __net_init ip6mr_rules_init(struct net *net)
 {
-	net->ipv6.mrt6 = ip6mr_new_table(net, RT6_TABLE_DFLT);
-	return net->ipv6.mrt6 ? 0 : -ENOMEM;
+	struct mr_table *mrt;
+
+	mrt = ip6mr_new_table(net, RT6_TABLE_DFLT);
+	if (IS_ERR(mrt))
+		return PTR_ERR(mrt);
+	net->ipv6.mrt6 = mrt;
+	return 0;
 }
 
 static void __net_exit ip6mr_rules_exit(struct net *net)
@@ -1757,8 +1762,9 @@ int ip6_mroute_setsockopt(struct sock *s
 
 		rtnl_lock();
 		ret = 0;
-		if (!ip6mr_new_table(net, v))
-			ret = -ENOMEM;
+		mrt = ip6mr_new_table(net, v);
+		if (IS_ERR(mrt))
+			ret = PTR_ERR(mrt);
 		else
 			raw6_sk(sk)->ip6mr_table = v;
 		rtnl_unlock();
