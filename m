Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919E2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F6720684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45F6720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731853AbeGSOLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:11:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33588 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeGSOK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:10:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id z6-v6so1777088wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 06:27:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=77A9+rW8amb86L2JkMZP3auBwcWTGSGmGoibnY+fYSg=;
        b=gBCL8a83cSNt0lLGfczWEyseET9knQQ5/ZWk0IRub7J+YPsnJO7Cf7x00JoPvfeAqP
         vrjK1aSJuWp4z677NWhUePGb+uGTmVnQgPi1QRzDKslO/1s8iW/IN7MubGx3i36t8gKY
         taEcRf/fwxmdPPGRKgzZ/4wn5NexdQWmelkVrKKGhJkkoZP/Nqzdhk99lN+uVHSAcLn2
         jGDldxCdUF0m0aOFgH2T65WlmdQV96FsIGJKvqpk8ZWB6G0/S1/7xb44lcWLGPnLnlX4
         CmSPyGPhQtimLEMdK+ZH7xODxuPuK1NXGy+BuOKhUpqLbftPdA0z2jdaFT/NZoPgAPaA
         7jxA==
X-Gm-Message-State: AOUpUlFXcwAo5HnewTUs24mmw74qrC3ceiKA6B16R8QB50gdwoOATiKx
        Ws84cxR4NLanWK6QSoz0pdN/2rkrPH8=
X-Google-Smtp-Source: AAOMgpcZ7oJCoMV/6JyMP9CIhb0YB9uawLWf2egkgpMds/G6tTtM55DoWd8xj8tovXUvTiHasRx9Rw==
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr3996383wme.135.1532006867138;
        Thu, 19 Jul 2018 06:27:47 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id q70-v6sm9199417wmd.45.2018.07.19.06.27.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 06:27:45 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id E5385124173;
        Thu, 19 Jul 2018 15:27:44 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     pasha.tatashin@oracle.com, mhocko@suse.com, vbabka@suse.cz,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 2/5] mm: access zone->node via zone_to_nid() and zone_set_nid()
Date:   Thu, 19 Jul 2018 15:27:37 +0200
Message-Id: <20180719132740.32743-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180719132740.32743-1-osalvador@techadventures.net>
References: <20180719132740.32743-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>

zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
have inline functions to access this field in order to avoid ifdef's in
c files.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mm.h     |  9 ---------
 include/linux/mmzone.h | 26 ++++++++++++++++++++------
 mm/mempolicy.c         |  4 ++--
 mm/mm_init.c           |  9 ++-------
 mm/page_alloc.c        | 10 ++++------
 5 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 726e71475144..6954ad183159 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -940,15 +940,6 @@ static inline int page_zone_id(struct page *page)
 	return (page->flags >> ZONEID_PGSHIFT) & ZONEID_MASK;
 }
 
-static inline int zone_to_nid(struct zone *zone)
-{
-#ifdef CONFIG_NUMA
-	return zone->node;
-#else
-	return 0;
-#endif
-}
-
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 extern int page_to_nid(const struct page *page);
 #else
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae1a034c3e2c..17fdff3bfb41 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -842,6 +842,25 @@ static inline bool populated_zone(struct zone *zone)
 	return zone->present_pages;
 }
 
+#ifdef CONFIG_NUMA
+static inline int zone_to_nid(struct zone *zone)
+{
+	return zone->node;
+}
+
+static inline void zone_set_nid(struct zone *zone, int nid)
+{
+	zone->node = nid;
+}
+#else
+static inline int zone_to_nid(struct zone *zone)
+{
+	return 0;
+}
+
+static inline void zone_set_nid(struct zone *zone, int nid) {}
+#endif
+
 extern int movable_zone;
 
 #ifdef CONFIG_HIGHMEM
@@ -957,12 +976,7 @@ static inline int zonelist_zone_idx(struct zoneref *zoneref)
 
 static inline int zonelist_node_idx(struct zoneref *zoneref)
 {
-#ifdef CONFIG_NUMA
-	/* zone_to_nid not available in this context */
-	return zoneref->zone->node;
-#else
-	return 0;
-#endif /* CONFIG_NUMA */
+	return zone_to_nid(zoneref->zone);
 }
 
 struct zoneref *__next_zones_zonelist(struct zoneref *z,
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f0fcf70bcec7..8c1c09b3852a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1784,7 +1784,7 @@ unsigned int mempolicy_slab_node(void)
 		zonelist = &NODE_DATA(node)->node_zonelists[ZONELIST_FALLBACK];
 		z = first_zones_zonelist(zonelist, highest_zoneidx,
 							&policy->v.nodes);
-		return z->zone ? z->zone->node : node;
+		return z->zone ? zone_to_nid(z->zone) : node;
 	}
 
 	default:
@@ -2326,7 +2326,7 @@ int mpol_misplaced(struct page *page, struct vm_area_struct *vma, unsigned long
 				node_zonelist(numa_node_id(), GFP_HIGHUSER),
 				gfp_zone(GFP_HIGHUSER),
 				&pol->v.nodes);
-		polnid = z->zone->node;
+		polnid = zone_to_nid(z->zone);
 		break;
 
 	default:
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 5b72266b4b03..6838a530789b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -53,13 +53,8 @@ void __init mminit_verify_zonelist(void)
 				zone->name);
 
 			/* Iterate the zonelist */
-			for_each_zone_zonelist(zone, z, zonelist, zoneid) {
-#ifdef CONFIG_NUMA
-				pr_cont("%d:%s ", zone->node, zone->name);
-#else
-				pr_cont("0:%s ", zone->name);
-#endif /* CONFIG_NUMA */
-			}
+			for_each_zone_zonelist(zone, z, zonelist, zoneid)
+				pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
 			pr_cont("\n");
 		}
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8a73305f7c55..10b754fba5fa 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2909,10 +2909,10 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
 	if (!static_branch_likely(&vm_numa_stat_key))
 		return;
 
-	if (z->node != numa_node_id())
+	if (zone_to_nid(z) != numa_node_id())
 		local_stat = NUMA_OTHER;
 
-	if (z->node == preferred_zone->node)
+	if (zone_to_nid(z) == zone_to_nid(preferred_zone))
 		__inc_numa_state(z, NUMA_HIT);
 	else {
 		__inc_numa_state(z, NUMA_MISS);
@@ -5287,7 +5287,7 @@ int local_memory_node(int node)
 	z = first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
 				   gfp_zone(GFP_KERNEL),
 				   NULL);
-	return z->zone->node;
+	return zone_to_nid(z->zone);
 }
 #endif
 
@@ -6311,9 +6311,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
 		 * And all highmem pages will be managed by the buddy system.
 		 */
 		zone->managed_pages = freesize;
-#ifdef CONFIG_NUMA
-		zone->node = nid;
-#endif
+		zone_set_nid(zone, nid);
 		zone->name = zone_names[j];
 		zone->zone_pgdat = pgdat;
 		spin_lock_init(&zone->lock);
-- 
2.13.6

