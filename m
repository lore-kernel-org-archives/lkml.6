Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CC713F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91E2920870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91E2920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeG3PMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:12:36 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37982 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726693AbeG3PMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:12:36 -0400
Received: by mail-wm0-f66.google.com with SMTP id t25-v6so13770812wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fkCL6JOtZhrngp0JXekbTmOa1tN3kWSPglBG2L6jMLs=;
        b=euQMJhLaB66fEVnZSE47kk/vI4p7NpjgUTRP0tx0CFOWGRDR8XoEqgR20t/CMbNlbw
         KQmGKRdg7ty0UHu7jmXpt8YN1NX5xpxNGixqmZIololVvjTgm+JYA50FPmv0XSKzQsya
         fhQLRssA3cHzY8vA9uBgqk9hDwhdY1VtYz02ceq27uVrudn+bh2dEt/8e3HwqQDppWya
         EJ1NRpIgjzC1F9/ISXm/z7AJ5JqQaULTcUlaoxDWOJtVg0XmuqK81+JZkkCyD+UxEo6l
         YNtu9bCxzb+iYezsa34AsccuAl59r8K1lYVbpT6HhZwXnGwo0iV8OtqJKMX1CA8xfrhV
         XfVw==
X-Gm-Message-State: AOUpUlGwF9dMQD1wfQT6N4PAvO5sElxFMQKr+lTReLEAnKnr24V1bDML
        hsJP9RUHqsGZflL1JmZwenI=
X-Google-Smtp-Source: AAOMgpePZ8qLBEX5z+bGz6RB3lKwyyYcDglnY32XamC3REtuAWK+g3gndyxSXvatmgTjz1VyaLamPg==
X-Received: by 2002:a1c:93d3:: with SMTP id v202-v6mr15507084wmd.57.1532957852659;
        Mon, 30 Jul 2018 06:37:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id v130-v6sm15047532wme.13.2018.07.30.06.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:37:32 -0700 (PDT)
Received: from d104.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by techadventures.net (Postfix) with ESMTPA id 35CB112440E;
        Mon, 30 Jul 2018 15:37:31 +0200 (CEST)
From:   osalvador@techadventures.net
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, vbabka@suse.cz, sfr@canb.auug.org.au,
        rientjes@google.com, pasha.tatashin@oracle.com,
        kemi.wang@intel.com, jia.he@hxt-semitech.com, ptesarik@suse.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, dan.j.williams@intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm: Remove zone_id() and make use of zone_idx() in is_dev_zone()
Date:   Mon, 30 Jul 2018 15:37:18 +0200
Message-Id: <20180730133718.28683-1-osalvador@techadventures.net>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oscar Salvador <osalvador@suse.de>

is_dev_zone() is using zone_id() to check if the zone is ZONE_DEVICE.
zone_id() looks pretty much the same as zone_idx(), and while the use of
zone_idx() is quite spread in the kernel, zone_id() is only being
used by is_dev_zone().

This patch removes zone_id() and makes is_dev_zone() use zone_idx()
to check the zone, so we do not have two things with the same
functionality around.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 include/linux/mmzone.h | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 83b1d11e90eb..dbe7635c33dd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -755,25 +755,6 @@ static inline bool pgdat_is_empty(pg_data_t *pgdat)
 	return !pgdat->node_start_pfn && !pgdat->node_spanned_pages;
 }
 
-static inline int zone_id(const struct zone *zone)
-{
-	struct pglist_data *pgdat = zone->zone_pgdat;
-
-	return zone - pgdat->node_zones;
-}
-
-#ifdef CONFIG_ZONE_DEVICE
-static inline bool is_dev_zone(const struct zone *zone)
-{
-	return zone_id(zone) == ZONE_DEVICE;
-}
-#else
-static inline bool is_dev_zone(const struct zone *zone)
-{
-	return false;
-}
-#endif
-
 #include <linux/memory_hotplug.h>
 
 void build_all_zonelists(pg_data_t *pgdat);
@@ -824,6 +805,18 @@ static inline int local_memory_node(int node_id) { return node_id; };
  */
 #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
 
+#ifdef CONFIG_ZONE_DEVICE
+static inline bool is_dev_zone(const struct zone *zone)
+{
+	return zone_idx(zone) == ZONE_DEVICE;
+}
+#else
+static inline bool is_dev_zone(const struct zone *zone)
+{
+	return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
-- 
2.13.6

