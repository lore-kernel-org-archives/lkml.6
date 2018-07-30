Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DBCFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F020893
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 10:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4F020893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeG3LwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:52:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33974 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbeG3LwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:52:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so12237003wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 03:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r3FUumIztPDwO6lIdEH4/NlXhd3R05jzu97rMbjyVnY=;
        b=o+XXZdmlbDGs8QtRCIVsDQF+miilFdf4cHYNFF5uZBzalHW2c5d9vqNwckpLQXu1NQ
         x13+KYHxdTM1JVp6B2lhKIfSq/X0UoSVYLGzlU1hPOlTCC/Ktltw2UYILtm0vmYCXQmk
         H3/ucxey6+hshpVhNK6LL02vEUhgDt9aoczIjh4Qw3+4JZnj2lZWg2E0xKF2ljYiBH+3
         wXryPPk6I4ZHyfLQAf8vl+QRcLKD1zmS14vUe7eUWChUamrCq6xg45QECC+zL2qUSe5B
         M2kHe5vYHiQV1G3pwV0RMv0BbQJtrxlrLdBKxpu8402m1ON8hbVUicFGr3oeucdLYRkn
         Xm4Q==
X-Gm-Message-State: AOUpUlGyUN47ct7ntPDbRrDHDvF24a7ldMhXKSa2AUdypmbNjiDwRX2S
        X1PjT3OXnYlMNoKtALP7FUS699fedXo=
X-Google-Smtp-Source: AAOMgpeb/ufzCmRAGJBr8drTHWXEcEBSU0Cmhe26IKPgkTdbW/5tDU5cQh9YjkkJjep00KeupCYLaQ==
X-Received: by 2002:a5d:514d:: with SMTP id u13-v6mr17321645wrt.162.1532945884826;
        Mon, 30 Jul 2018 03:18:04 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id h7-v6sm11009845wmb.48.2018.07.30.03.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 03:18:03 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 0004F124447;
        Mon, 30 Jul 2018 12:18:02 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, pasha.tatashin@oracle.com,
        mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        david@redhat.com, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v5 2/4] mm: access zone->node via zone_to_nid() and zone_set_nid()
Date:   Mon, 30 Jul 2018 12:17:55 +0200
Message-Id: <20180730101757.28058-3-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180730101757.28058-1-osalvador@techadventures.net>
References: <20180730101757.28058-1-osalvador@techadventures.net>
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
Acked-by: Michal Hocko <mhocko@suse.com>
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

