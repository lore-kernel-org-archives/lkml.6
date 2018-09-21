Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74456ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6F62154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6F62154E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbeIUTPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:15:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37194 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390100AbeIUTPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:15:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id n11-v6so3270626wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o52x8tjPTmNioW0bBVA6BC8kUEvUd+5T8EUKIIECF/I=;
        b=pHRJ9HSp97MpKi5tVCar/D7uzpRpj5oZYpsxd1oFIFfjuGKoGMC+P4IEc6dDX7t2cp
         p9HdTOWlroDT9XwfzY4H0sPpDmqF33Q9JeLXdL+Tm5DT6XEyGS8Grt/7Aod1JieAN/2L
         cDrOi/80Nl5Vfq9n65esXzg4/UDSAu9JBHtD44ZJ8LmKZJ/rHuIu+MN2FzIcK+AJRcRM
         fafnXtUni+NRg9hzsm9M56hd8iCtyek8o+QE4kgmavLaNI3GC3n5+1/+jX/fJzwZta/I
         dtlVZ5OT/vFuYppL9iNjhyb5WDuQ8vE4rn8HfdvGsSwSpV11uU7SXGU7TFprrW8p8b26
         dvPQ==
X-Gm-Message-State: ABuFfogrgUsVP8EpI86i5rZF585enYQTylVRkvNAnmQX44R+GUHOUAOo
        CIPPHwCi627b43VjUu0Lg4k=
X-Google-Smtp-Source: ACcGV60CN8yYgQgtMyKP5pJBF54wt/SEU1TVEMerZNaayS+2J2mGov6d4qsltfjXR0n9cwwo49tWAw==
X-Received: by 2002:a1c:501:: with SMTP id 1-v6mr7033567wmf.140.1537536403982;
        Fri, 21 Sep 2018 06:26:43 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id u1-v6sm19805759wrt.59.2018.09.21.06.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:26:42 -0700 (PDT)
Received: from d104.suse.de (nat.nue.novell.com [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 0C50E125344;
        Fri, 21 Sep 2018 15:26:41 +0200 (CEST)
From:   Oscar Salvador <osalvador@techadventures.net>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com, david@redhat.com,
        Pavel.Tatashin@microsoft.com, Jonathan.Cameron@huawei.com,
        yasu.isimatu@gmail.com, malat@debian.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v2 4/4] mm/memory_hotplug: Clean up node_states_check_changes_offline
Date:   Fri, 21 Sep 2018 15:26:34 +0200
Message-Id: <20180921132634.10103-5-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180921132634.10103-1-osalvador@techadventures.net>
References: <20180921132634.10103-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch, as the previous one, gets rid of the wrong if statements.
While at it, I realized that the comments are sometimes very confusing,
to say the least, and wrong.
For example:

___
zone_last = ZONE_MOVABLE;

/*
 * check whether node_states[N_HIGH_MEMORY] will be changed
 * If we try to offline the last present @nr_pages from the node,
 * we can determind we will need to clear the node from
 * node_states[N_HIGH_MEMORY].
 */

for (; zt <= zone_last; zt++)
        present_pages += pgdat->node_zones[zt].present_pages;
if (nr_pages >= present_pages)
        arg->status_change_nid = zone_to_nid(zone);
else
        arg->status_change_nid = -1;
___

In case the node gets empry, it must be removed from N_MEMORY.
We already check N_HIGH_MEMORY a bit above within the CONFIG_HIGHMEM
ifdef code.
Not to say that status_change_nid is for N_MEMORY, and not for
N_HIGH_MEMORY.

So I re-wrote some of the comments to what I think is better.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Pavel Tatashin <pavel.tatashin@microsoft.com>
---
 mm/memory_hotplug.c | 80 +++++++++++++++++++----------------------------------
 1 file changed, 29 insertions(+), 51 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index eadd149eb7bc..f19b63f024c9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1463,75 +1463,53 @@ static void node_states_check_changes_offline(unsigned long nr_pages,
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
 	unsigned long present_pages = 0;
-	enum zone_type zt, zone_last = ZONE_NORMAL;
+	enum zone_type zt;
 
-	/*
-	 * If we have HIGHMEM or movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_NORMAL,
-	 * set zone_last to ZONE_NORMAL.
-	 *
-	 * If we don't have HIGHMEM nor movable node,
-	 * node_states[N_NORMAL_MEMORY] contains nodes which have zones of
-	 * 0...ZONE_MOVABLE, set zone_last to ZONE_MOVABLE.
-	 */
-	if (N_MEMORY == N_NORMAL_MEMORY)
-		zone_last = ZONE_MOVABLE;
+	arg->status_change_nid = -1;	
+	arg->status_change_nid_normal = -1;
+	arg->status_change_nid_high = -1;
 
 	/*
-	 * check whether node_states[N_NORMAL_MEMORY] will be changed.
-	 * If the memory to be offline is in a zone of 0...zone_last,
-	 * and it is the last present memory, 0...zone_last will
-	 * become empty after offline , thus we can determind we will
-	 * need to clear the node from node_states[N_NORMAL_MEMORY].
+	 * Check whether node_states[N_NORMAL_MEMORY] will be changed.
+	 * If the memory to be offline is within the range
+	 * [0..ZONE_NORMAL], and it is the last present memory there,
+	 * the zones in that range will become empty after the offlining,
+	 * thus we can determine that we need to clear the node from
+	 * node_states[N_NORMAL_MEMORY].
 	 */
-	for (zt = 0; zt <= zone_last; zt++)
+	for (zt = 0; zt <= ZONE_NORMAL; zt++)
 		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= zone_last && nr_pages >= present_pages)
+	if (zone_idx(zone) <= ZONE_NORMAL && nr_pages >= present_pages)
 		arg->status_change_nid_normal = zone_to_nid(zone);
-	else
-		arg->status_change_nid_normal = -1;
 
 #ifdef CONFIG_HIGHMEM
 	/*
-	 * If we have movable node, node_states[N_HIGH_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_HIGHMEM,
-	 * set zone_last to ZONE_HIGHMEM.
-	 *
-	 * If we don't have movable node, node_states[N_NORMAL_MEMORY]
-	 * contains nodes which have zones of 0...ZONE_MOVABLE,
-	 * set zone_last to ZONE_MOVABLE.
+	 * node_states[N_HIGH_MEMORY] contains nodes which
+	 * have normal memory or high memory.
+	 * Here we add the present_pages belonging to ZONE_HIGHMEM.
+	 * If the zone is within the range of [0..ZONE_HIGHMEM), and
+	 * we determine that the zones in that range become empty,
+	 * we need to clear the node for N_HIGH_MEMORY.
 	 */
-	zone_last = ZONE_HIGHMEM;
-	if (N_MEMORY == N_HIGH_MEMORY)
-		zone_last = ZONE_MOVABLE;
-
-	for (; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
-	if (zone_idx(zone) <= zone_last && nr_pages >= present_pages)
+	present_pages += pgdat->node_zones[ZONE_HIGHMEM].present_pages;
+	if (zone_idx(zone) <= ZONE_HIGHMEM && nr_pages >= present_pages)
 		arg->status_change_nid_high = zone_to_nid(zone);
-	else
-		arg->status_change_nid_high = -1;
-#else
-	arg->status_change_nid_high = arg->status_change_nid_normal;
 #endif
 
 	/*
-	 * node_states[N_HIGH_MEMORY] contains nodes which have 0...ZONE_MOVABLE
+	 * We have accounted the pages from [0..ZONE_NORMAL), and
+	 * in case of CONFIG_HIGHMEM the pages from ZONE_HIGHMEM
+	 * as well.
+	 * Here we count the possible pages from ZONE_MOVABLE.
+	 * If after having accounted all the pages, we see that the nr_pages
+	 * to be offlined is over or equal to the accounted pages,
+	 * we know that the node will become empty, and so, we can clear
+	 * it for N_MEMORY as well.
 	 */
-	zone_last = ZONE_MOVABLE;
+	present_pages += pgdat->node_zones[ZONE_MOVABLE].present_pages;
 
-	/*
-	 * check whether node_states[N_HIGH_MEMORY] will be changed
-	 * If we try to offline the last present @nr_pages from the node,
-	 * we can determind we will need to clear the node from
-	 * node_states[N_HIGH_MEMORY].
-	 */
-	for (; zt <= zone_last; zt++)
-		present_pages += pgdat->node_zones[zt].present_pages;
 	if (nr_pages >= present_pages)
 		arg->status_change_nid = zone_to_nid(zone);
-	else
-		arg->status_change_nid = -1;
 }
 
 static void node_states_clear_node(int node, struct memory_notify *arg)
-- 
2.13.6

