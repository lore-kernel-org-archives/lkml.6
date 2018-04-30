Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753354AbeD3Jm7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:42:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51568 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753003AbeD3Jm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:42:56 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RCFv2 5/7] mm/memory_hotplug: print only with DEBUG_VM in offline_pages()
Date: Mon, 30 Apr 2018 11:42:34 +0200
Message-Id: <20180430094236.29056-6-david@redhat.com>
In-Reply-To: <20180430094236.29056-1-david@redhat.com>
References: <20180430094236.29056-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's try to minimze the noise.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4c7e0efff079..d8f127754c2e 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1685,7 +1685,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	offlined_pages = check_pages_isolated(start_pfn, end_pfn);
 	if (offlined_pages < 0)
 		goto repeat;
+#ifdef CONFIG_DEBUG_VM
 	pr_info("Offlined Pages %ld\n", offlined_pages);
+#endif
 	/* Ok, all of our target is isolated.
 	   We cannot do rollback at this point. */
 	offline_isolated_pages(start_pfn, end_pfn);
@@ -1720,9 +1722,11 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	return 0;
 
 failed_removal:
+#ifdef CONFIG_DEBUG_VM
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
 		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
+#endif
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
 	/* pushback to free area */
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
-- 
2.14.3
