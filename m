Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25592145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4ePXMzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25592145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbeKOI1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:34392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727099AbeKOI1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:14 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4594B2250F;
        Wed, 14 Nov 2018 22:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234131;
        bh=RYhWnVqHC3Gb9VSlNOvcS74z8kzSHDHn8ijT4HCuA3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M4ePXMzM0eOy4Uuqg9NxNAoKBP6Ffhv32AfFifLKcv+TOQFuXrv9kRQv1fFTuB30r
         nKMo7J3R/9xfUZs1ieVfgjSrv0/0G10PhDCxQXfGpx9wsa5o5jpha3u0SkgCxCddqn
         S5gdBGeCJwGBSQumBsdsA598EAFb+JRRyqoFuJ+M=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 12/73] netfilter: ipset: fix ip_set_list allocation failure
Date:   Wed, 14 Nov 2018 17:21:06 -0500
Message-Id: <20181114222207.98701-12-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Ryabinin <aryabinin@virtuozzo.com>

[ Upstream commit ed956f3947a01ff9875cd908d7c1ef1fe7f47bf0 ]

ip_set_create() and ip_set_net_init() attempt to allocate physically
contiguous memory for ip_set_list. If memory is fragmented, the
allocations could easily fail:

        vzctl: page allocation failure: order:7, mode:0xc0d0

        Call Trace:
         dump_stack+0x19/0x1b
         warn_alloc_failed+0x110/0x180
         __alloc_pages_nodemask+0x7bf/0xc60
         alloc_pages_current+0x98/0x110
         kmalloc_order+0x18/0x40
         kmalloc_order_trace+0x26/0xa0
         __kmalloc+0x279/0x290
         ip_set_net_init+0x4b/0x90 [ip_set]
         ops_init+0x3b/0xb0
         setup_net+0xbb/0x170
         copy_net_ns+0xf1/0x1c0
         create_new_namespaces+0xf9/0x180
         copy_namespaces+0x8e/0xd0
         copy_process+0xb61/0x1a00
         do_fork+0x91/0x320

Use kvcalloc() to fallback to 0-order allocations if high order
page isn't available.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Signed-off-by: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/ipset/ip_set_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/ipset/ip_set_core.c b/net/netfilter/ipset/ip_set_core.c
index fa15a831aeee..68db946df151 100644
--- a/net/netfilter/ipset/ip_set_core.c
+++ b/net/netfilter/ipset/ip_set_core.c
@@ -960,7 +960,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 			/* Wraparound */
 			goto cleanup;
 
-		list = kcalloc(i, sizeof(struct ip_set *), GFP_KERNEL);
+		list = kvcalloc(i, sizeof(struct ip_set *), GFP_KERNEL);
 		if (!list)
 			goto cleanup;
 		/* nfnl mutex is held, both lists are valid */
@@ -972,7 +972,7 @@ static int ip_set_create(struct net *net, struct sock *ctnl,
 		/* Use new list */
 		index = inst->ip_set_max;
 		inst->ip_set_max = i;
-		kfree(tmp);
+		kvfree(tmp);
 		ret = 0;
 	} else if (ret) {
 		goto cleanup;
@@ -2058,7 +2058,7 @@ ip_set_net_init(struct net *net)
 	if (inst->ip_set_max >= IPSET_INVALID_ID)
 		inst->ip_set_max = IPSET_INVALID_ID - 1;
 
-	list = kcalloc(inst->ip_set_max, sizeof(struct ip_set *), GFP_KERNEL);
+	list = kvcalloc(inst->ip_set_max, sizeof(struct ip_set *), GFP_KERNEL);
 	if (!list)
 		return -ENOMEM;
 	inst->is_deleted = false;
@@ -2086,7 +2086,7 @@ ip_set_net_exit(struct net *net)
 		}
 	}
 	nfnl_unlock(NFNL_SUBSYS_IPSET);
-	kfree(rcu_dereference_protected(inst->ip_set_list, 1));
+	kvfree(rcu_dereference_protected(inst->ip_set_list, 1));
 }
 
 static struct pernet_operations ip_set_net_ops = {
-- 
2.17.1

