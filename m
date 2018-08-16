Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936F8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5754A2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 10:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5754A2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbeHPNEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 09:04:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55788 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728018AbeHPNEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 09:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B7E20401C090;
        Thu, 16 Aug 2018 10:06:39 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-94.ams2.redhat.com [10.36.116.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD02210F1C1D;
        Thu, 16 Aug 2018 10:06:36 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v1 1/5] mm/memory_hotplug: drop intermediate __offline_pages
Date:   Thu, 16 Aug 2018 12:06:24 +0200
Message-Id: <20180816100628.26428-2-david@redhat.com>
In-Reply-To: <20180816100628.26428-1-david@redhat.com>
References: <20180816100628.26428-1-david@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 10:06:39 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 16 Aug 2018 10:06:39 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's avoid this indirection and just call the function offline_pages().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6a2726920ed2..090cf474de87 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1589,10 +1589,10 @@ static void node_states_clear_node(int node, struct memory_notify *arg)
 		node_clear_state(node, N_MEMORY);
 }
 
-static int __ref __offline_pages(unsigned long start_pfn,
-		  unsigned long end_pfn)
+/* Must be protected by mem_hotplug_begin() or a device_lock */
+int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
-	unsigned long pfn, nr_pages;
+	unsigned long pfn, end_pfn = start_pfn + nr_pages;
 	long offlined_pages;
 	int ret, node;
 	unsigned long flags;
@@ -1612,7 +1612,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 
 	zone = page_zone(pfn_to_page(valid_start));
 	node = zone_to_nid(zone);
-	nr_pages = end_pfn - start_pfn;
 
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
@@ -1700,12 +1699,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	return ret;
 }
-
-/* Must be protected by mem_hotplug_begin() or a device_lock */
-int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
-{
-	return __offline_pages(start_pfn, start_pfn + nr_pages);
-}
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 /**
-- 
2.17.1

