Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266D3208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266D3208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbeHAVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:51:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48666 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729647AbeHAVvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:51:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE2EDED1;
        Wed,  1 Aug 2018 13:04:21 -0700 (PDT)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B0143F5BA;
        Wed,  1 Aug 2018 13:04:21 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 1/2] slub: Avoid trying to allocate memory on offline nodes
Date:   Wed,  1 Aug 2018 15:04:17 -0500
Message-Id: <20180801200418.1325826-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180801200418.1325826-1-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a user calls the *alloc_node() functions with an invalid node
its possible to crash in alloc_pages_nodemask because NODE_DATA()
returns a bad node, which propogates into the node zonelist in
prepare_alloc_pages. This avoids that by not trying to allocate
new slabs against offline nodes.

(example backtrace)

  __alloc_pages_nodemask+0x128/0xf48
  allocate_slab+0x94/0x528
  new_slab+0x68/0xc8
  ___slab_alloc+0x44c/0x520
  __slab_alloc+0x50/0x68
  kmem_cache_alloc_node_trace+0xe0/0x230

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 51258eff4178..e03719bac1e2 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2519,6 +2519,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(!node_match(page, searchnode))) {
 			stat(s, ALLOC_NODE_MISMATCH);
 			deactivate_slab(s, page, c->freelist, c);
+			if (!node_online(searchnode))
+				node = NUMA_NO_NODE;
 			goto new_slab;
 		}
 	}
-- 
2.14.3

