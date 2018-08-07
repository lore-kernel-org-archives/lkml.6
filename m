Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099F1C46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFDD217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFDD217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbeHGPwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:52:49 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51763 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbeHGPws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:52:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so17499417wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 06:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UGHDYi1fGTGsyDr5+uGpoPTBhMkqCLpSGvH1cSTmmy8=;
        b=PQTHGyooSxCkC2iR55IqP8POPEV3AtgvPzckHOK1o6X2/X23YrPSUAFU0Ob3rHjZQx
         U2aI4exYh+B08gsLUalstfxQDYgX47bE6nNQlehkI06rbxllDsNsGmv2+prbvOowVYZo
         DNfgxUJ7v39YBTYmfc/XpeUVB6hDwnQz0Xa3bhDjMQurzv7IZkmZAmFA5g30PUnz+DpY
         7zM43Dz5Knf4WdM6+7QV7s4mU7Xhy3Zcesx4Hb0a8dj3oKo/+zIpiHacUuLhpw+89rqf
         liPT8m1QxQHFMNZVGqhiw1KKgRtu3QmSmYAEhgoG8UNCx41oJkRhqBUgY4si62AonUAP
         BZJg==
X-Gm-Message-State: AOUpUlFh2OY5XrVdQ0cdsWfIwc0nAZ/bsM5Sk2jm56jFQgE4QVZdT5sr
        qR3JISz7eybOYBE5NZp62yM=
X-Google-Smtp-Source: AA+uWPwnROE4sZZPs3TVKL+ZZ0tZRrl+xz1jyG/Gf6Z16dml6uomWbV2cXWSY5kTkoPCwGLdcvPGeA==
X-Received: by 2002:a1c:c95:: with SMTP id 143-v6mr1878759wmm.50.1533649102756;
        Tue, 07 Aug 2018 06:38:22 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y128-v6sm2564657wmy.26.2018.08.07.06.38.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 06:38:21 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 71CE91246FD;
        Tue,  7 Aug 2018 15:38:20 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, dan.j.williams@intel.com,
        pasha.tatashin@oracle.com, jglisse@redhat.com, david@redhat.com,
        yasu.isimatu@gmail.com, logang@deltatee.com, dave.jiang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 3/3] mm/memory_hotplug: Refactor shrink_zone/pgdat_span
Date:   Tue,  7 Aug 2018 15:37:57 +0200
Message-Id: <20180807133757.18352-4-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180807133757.18352-1-osalvador@techadventures.net>
References: <20180807133757.18352-1-osalvador@techadventures.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

This patch refactors shrink_zone_span and shrink_pgdat_span functions.

In case that find_smallest/biggest_section do not return any pfn,
it means that the zone/pgdat has no online sections left, so we can
set the respective values to 0:

   zone case:
        zone->zone_start_pfn = 0;
        zone->spanned_pages = 0;

   pgdat case:
        pgdat->node_start_pfn = 0;
        pgdat->node_spanned_pages = 0;

Also, the check that loops over all sections to see if we have something left
is moved to an own function, and so the code can be shared by shrink_zone_span
and shrink_pgdat_span.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 mm/memory_hotplug.c | 127 +++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 62 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e33555651e46..ccac36eaac05 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -365,6 +365,29 @@ static unsigned long find_biggest_section_pfn(int nid, struct zone *zone,
 	return 0;
 }
 
+static bool has_only_holes(struct zone *zone, int nid, unsigned long zone_start_pfn,
+							unsigned long zone_end_pfn)
+{
+	unsigned long pfn;
+
+	pfn = zone_start_pfn;
+	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
+		struct mem_section *ms = __pfn_to_section(pfn);
+
+		if (unlikely(!online_section(ms)))
+			continue;
+		if (zone && page_zone(pfn_to_page(pfn)) != zone)
+			continue;
+
+		if (pfn_to_nid(pfn) != nid)
+			continue;
+
+		return false;
+	}
+
+	return true;
+}
+
 static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 			     unsigned long end_pfn)
 {
@@ -372,7 +395,6 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 	unsigned long z = zone_end_pfn(zone); /* zone_end_pfn namespace clash */
 	unsigned long zone_end_pfn = z;
 	unsigned long pfn;
-	struct mem_section *ms;
 	int nid = zone_to_nid(zone);
 
 	zone_span_writelock(zone);
@@ -385,10 +407,11 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 */
 		pfn = find_smallest_section_pfn(nid, zone, end_pfn,
 						zone_end_pfn);
-		if (pfn) {
-			zone->zone_start_pfn = pfn;
-			zone->spanned_pages = zone_end_pfn - pfn;
-		}
+		if (!pfn)
+			goto only_holes;
+
+		zone->zone_start_pfn = pfn;
+		zone->spanned_pages = zone_end_pfn - pfn;
 	} else if (zone_end_pfn == end_pfn) {
 		/*
 		 * If the section is biggest section in the zone, it need
@@ -398,38 +421,28 @@ static void shrink_zone_span(struct zone *zone, unsigned long start_pfn,
 		 */
 		pfn = find_biggest_section_pfn(nid, zone, zone_start_pfn,
 					       start_pfn);
-		if (pfn)
-			zone->spanned_pages = pfn - zone_start_pfn + 1;
-	}
-
-	/*
-	 * The section is not biggest or smallest mem_section in the zone, it
-	 * only creates a hole in the zone. So in this case, we need not
-	 * change the zone. But perhaps, the zone has only hole data. Thus
-	 * it check the zone has only hole or not.
-	 */
-	pfn = zone_start_pfn;
-	for (; pfn < zone_end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-
-		if (unlikely(!online_section(ms)))
-			continue;
+		if (!pfn)
+			goto only_holes;
 
-		if (page_zone(pfn_to_page(pfn)) != zone)
-			continue;
-
-		 /* If the section is current section, it continues the loop */
-		if (start_pfn == pfn)
-			continue;
-
-		/* If we find valid section, we have nothing to do */
-		zone_span_writeunlock(zone);
-		return;
+		zone->spanned_pages = pfn - zone_start_pfn + 1;
+	} else {
+		/*
+		 * The section is not biggest or smallest mem_section in the zone, it
+		 * only creates a hole in the zone. So in this case, we need not
+		 * change the zone. But perhaps, the zone has only hole data. Thus
+		 * it check the zone has only hole or not.
+		 */
+		if (has_only_holes(zone, nid, zone_start_pfn, zone_end_pfn))
+			goto only_holes;
 	}
 
+	goto out;
+
+only_holes:
 	/* The zone has no valid section */
 	zone->zone_start_pfn = 0;
 	zone->spanned_pages = 0;
+out:
 	zone_span_writeunlock(zone);
 }
 
@@ -440,7 +453,6 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 	unsigned long p = pgdat_end_pfn(pgdat); /* pgdat_end_pfn namespace clash */
 	unsigned long pgdat_end_pfn = p;
 	unsigned long pfn;
-	struct mem_section *ms;
 	int nid = pgdat->node_id;
 
 	if (pgdat_start_pfn == start_pfn) {
@@ -452,10 +464,11 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 		 */
 		pfn = find_smallest_section_pfn(nid, NULL, end_pfn,
 						pgdat_end_pfn);
-		if (pfn) {
-			pgdat->node_start_pfn = pfn;
-			pgdat->node_spanned_pages = pgdat_end_pfn - pfn;
-		}
+		if (!pfn)
+			goto only_holes;
+
+		pgdat->node_start_pfn = pfn;
+		pgdat->node_spanned_pages = pgdat_end_pfn - pfn;
 	} else if (pgdat_end_pfn == end_pfn) {
 		/*
 		 * If the section is biggest section in the pgdat, it need
@@ -465,35 +478,25 @@ static void shrink_pgdat_span(struct pglist_data *pgdat,
 		 */
 		pfn = find_biggest_section_pfn(nid, NULL, pgdat_start_pfn,
 					       start_pfn);
-		if (pfn)
-			pgdat->node_spanned_pages = pfn - pgdat_start_pfn + 1;
-	}
-
-	/*
-	 * If the section is not biggest or smallest mem_section in the pgdat,
-	 * it only creates a hole in the pgdat. So in this case, we need not
-	 * change the pgdat.
-	 * But perhaps, the pgdat has only hole data. Thus it check the pgdat
-	 * has only hole or not.
-	 */
-	pfn = pgdat_start_pfn;
-	for (; pfn < pgdat_end_pfn; pfn += PAGES_PER_SECTION) {
-		ms = __pfn_to_section(pfn);
-
-		if (unlikely(!online_section(ms)))
-			continue;
-
-		if (pfn_to_nid(pfn) != nid)
-			continue;
+		if (!pfn)
+			goto only_holes;
 
-		 /* If the section is current section, it continues the loop */
-		if (start_pfn == pfn)
-			continue;
-
-		/* If we find valid section, we have nothing to do */
-		return;
+		pgdat->node_spanned_pages = pfn - pgdat_start_pfn + 1;
+	} else {
+		/*
+		 * If the section is not biggest or smallest mem_section in the pgdat,
+		 * it only creates a hole in the pgdat. So in this case, we need not
+		 * change the pgdat.
+		 * But perhaps, the pgdat has only hole data. Thus it check the pgdat
+		 * has only hole or not.
+		 */
+		if (has_only_holes(NULL, nid, pgdat_start_pfn, pgdat_end_pfn))
+			goto only_holes;
 	}
 
+	return;
+
+only_holes:
 	/* The pgdat has no valid section */
 	pgdat->node_start_pfn = 0;
 	pgdat->node_spanned_pages = 0;
-- 
2.13.6

