Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCE5C21104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JaqRSMSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE5C21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbeKZV62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:58:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729291AbeKZV61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:58:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58F9320672;
        Mon, 26 Nov 2018 11:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230281;
        bh=7Q3p1KvAQ9dGgtgyJbJ0g5zJLKolD4id1qXkC+dPNA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JaqRSMSPL/8QuxkRkMHenOCPermgMu34P2CBkv37v60T2SnTUuTelPdBc7q6e/oRX
         +5bBoGT8/31ocoma+3AXFErWS6Fp/i2HBv7VCrVSeSXFWXqukBayePUNs8sUQVsJOq
         vLsmmvcVHozYHI+TqTtv1wdZwO07RJWKLFcH1xJM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 043/118] netfilter: ipset: fix ip_set_list allocation failure
Date:   Mon, 26 Nov 2018 11:50:37 +0100
Message-Id: <20181126105102.519467886@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



