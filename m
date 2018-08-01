Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF65DC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C7A208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C7A208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbeHAVvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:51:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbeHAVvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:51:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0AC1596;
        Wed,  1 Aug 2018 13:04:23 -0700 (PDT)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9717D3F5BA;
        Wed,  1 Aug 2018 13:04:22 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-mm@kvack.org
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, mhocko@suse.com,
        vbabka@suse.cz, Punit.Agrawal@arm.com, Lorenzo.Pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 2/2] mm: harden alloc_pages code paths against bogus nodes
Date:   Wed,  1 Aug 2018 15:04:18 -0500
Message-Id: <20180801200418.1325826-3-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180801200418.1325826-1-jeremy.linton@arm.com>
References: <20180801200418.1325826-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its possible to crash __alloc_pages_nodemask by passing it
bogus node ids. This is caused by NODE_DATA() returning null
(hopefully) when the requested node is offline. We can
harded against the basic case of a mostly valid node, that
isn't online by checking for null and failing prepare_alloc_pages.

But this then suggests we should also harden NODE_DATA() like this

#define NODE_DATA(nid)         ( (nid) < MAX_NUMNODES ? node_data[(nid)] : NULL)

eventually this starts to add a bunch of generally uneeded checks
in some code paths that are called quite frequently.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 include/linux/gfp.h | 2 ++
 mm/page_alloc.c     | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index a6afcec53795..17d70271c42e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -436,6 +436,8 @@ static inline int gfp_zonelist(gfp_t flags)
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
+	if (unlikely(!NODE_DATA(nid))) //VM_WARN_ON?
+		return NULL;
 	return NODE_DATA(nid)->node_zonelists + gfp_zonelist(flags);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a790ef4be74e..3a3d9ac2662a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4306,6 +4306,8 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 {
 	ac->high_zoneidx = gfp_zone(gfp_mask);
 	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
+	if (!ac->zonelist)
+		return false;
 	ac->nodemask = nodemask;
 	ac->migratetype = gfpflags_to_migratetype(gfp_mask);
 
-- 
2.14.3

