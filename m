Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9883C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FC92083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTJnBeU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FC92083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731773AbeGZQcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:32:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54488 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZQcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:32:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QFE7b2123535;
        Thu, 26 Jul 2018 15:14:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=y/H8FPreZBSLCnLe7vFBU7dCmnXQdu6XyERtv4gNPyw=;
 b=RTJnBeU+mLKC9+Wj3sOI/EhRQE2FR9pfo3HoO4X7C3Iva/3sWVD1uG+L9Z9vRS5CRfNf
 zaBGq7dhq6uRxP3lOSH9c9ynLzYANV4wgdwkqhADBYEzkq3X2EwTCLkU9fnwezLOm3JM
 ig4VEUvlRYISFJ2ibWd0zPAS1BwFdwPqddJtykROuSvs+WZ8QmbRsk+d/zGbd7Bx5/Wb
 mEbU4BhPTrAgvdmnAleqY8fFzZYt3J6CPmoLTC1uqexfMo+ZHp1S7XyRhY87kee3jadW
 YGKrWHgm9iNlV3iTGAssRex3ptxHFT0ctzGYXco0CmoZZW+hKS2+tAg9MH6AyIGjn4Ib Hw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2kbwfq3gvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 15:14:28 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFEPco021610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 15:14:25 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QFEN6c018519;
        Thu, 26 Jul 2018 15:14:23 GMT
Received: from xakep.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 08:14:22 -0700
Date:   Thu, 26 Jul 2018 11:14:20 -0400
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        vbabka@suse.cz, mgorman@techsingularity.net, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
Message-ID: <20180726151420.uigttpoclcka6h4h@xakep.localdomain>
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net>
 <20180726080500.GX28386@dhcp22.suse.cz>
 <20180726081215.GC22028@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726081215.GC22028@techadventures.net>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

Below is updated patch, with comment about OpenGrok and Acked-by Michal added.

Thank you,
Pavel

From cca1b083d78d0ff99cce6dfaf12f6380d76390c7 Mon Sep 17 00:00:00 2001
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 26 Jul 2018 00:01:41 +0200
Subject: [PATCH] mm: access zone->node via zone_to_nid() and zone_set_nid()

zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
have inline functions to access this field in order to avoid ifdef's in
c files.

OpenGrok was used to find places where zone->node is accessed. A public one
is available here: http://src.illumos.org/source/

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
index fc14a4bec36d..446fc3e6a85b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -942,15 +942,6 @@ static inline int page_zone_id(struct page *page)
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
index 83b1d11e90eb..805b990b27ab 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -841,6 +841,25 @@ static inline bool populated_zone(struct zone *zone)
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
@@ -956,12 +975,7 @@ static inline int zonelist_zone_idx(struct zoneref *zoneref)
 
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
index 2dec8056a091..1e6c377ef7d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2908,10 +2908,10 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z)
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
@@ -5277,7 +5277,7 @@ int local_memory_node(int node)
 	z = first_zones_zonelist(node_zonelist(node, GFP_KERNEL),
 				   gfp_zone(GFP_KERNEL),
 				   NULL);
-	return z->zone->node;
+	return zone_to_nid(z->zone);
 }
 #endif
 
@@ -6277,9 +6277,7 @@ static void __paginginit free_area_init_core(struct pglist_data *pgdat)
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
2.18.0

