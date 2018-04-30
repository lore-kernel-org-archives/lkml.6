Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AB8JxZp6qqdXaG2fWm6o/O7xRQeH7bMD5VcMRg1bF6FUaJINCp5g7W0lM8cGNOvHYE83uxkRf1JA
ARC-Seal: i=1; a=rsa-sha256; t=1525081371; cv=none;
        d=google.com; s=arc-20160816;
        b=Z65tqTJfr0NjCBE6ZoY3CF2AUuzV0hm11UwmaWCAEIb9Jw2hRzt5mmKIg2vPGW4Zt+
         Z0GvH+i4zwJikQvYwRhEQIUj/yyHGJZ0HZCcwqTHawHkFQiGxbfUbEzZXNGKj+4B5h3d
         4poGPcCmlQNlAa4CHe67xF/9Ox8fGYYKYyJm6s3+N3nJHspK1qUs1CV2U+NSc6pJ73+v
         ATZF84dL2OQym4hUEWiZimsC9oEbzog0XcyR3xOoZl44LuTyKhoPwuv7GjoEhRYKXCf+
         vKGIRD3MWlkbV0GnJ/rCisnOHgI15pMuGtfEKHfrRUoxF5mqN6qYbFxpgagAPQwTyr9o
         90Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vI1G9VZx6NLsaFmPzM0/LJ2r6OYZNVPY4e/GoJIqA18=;
        b=Hqymn3m2y7VU8MLCEmn4uZY6/0Z4MY9HUDRibSnbeNuzBo3h0U/EuhcmA4g+59Sn7t
         Rdnl9jEBjjFZJphdX2sxu4lWoP3/2GzMXOalETcBQQYbO8wPaLXNyRV2PdhfWVenS0K8
         kfoAh4wWtF7dHV9/0j6joeHqrYnthvYFpbUPIm8f0+lLlWYYZ8yl3E6Ual25xEkBHR1D
         Q1F3OGKrsQgt/Vg35usEBdtGTO7xOp48m3dz3j4od9/R74+GdJJIbWQpTGmqz7VloRg2
         fZnIN5Wkl/VR50re3Yr180c/Pv+eHr/2ixpx28H8H2hRaIku/F7PeR4uVlExoSF24gjJ
         1PRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH RCFv2 3/7] mm/memory_hotplug: limit offline_pages() to sizes we can actually handle
Date: Mon, 30 Apr 2018 11:42:32 +0200
Message-Id: <20180430094236.29056-4-david@redhat.com>
In-Reply-To: <20180430094236.29056-1-david@redhat.com>
References: <20180430094236.29056-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599163724475007158?=
X-GMAIL-MSGID: =?utf-8?q?1599163724475007158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

We have to take care of MAX_ORDER. Page blocks might contain references
to the next page block. So sometimes a page block cannot be offlined
independently. E.g. on x86: page block size is 2MB, MAX_ORDER -1 (10)
allows 4MB allocations.

E.g. a buddy page could either overlap at the beginning or the end of the
range to offline. While the end case could be handled easily (shrink the
buddy page), overlaps at the beginning are hard to handle (unknown page
order).

Let document offline_pages() while at it.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/memory_hotplug.h |  6 ++++++
 mm/memory_hotplug.c            | 22 ++++++++++++++++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e0e49b5b1ee1..d71829d54360 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -294,6 +294,12 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #endif /* !(CONFIG_MEMORY_HOTPLUG || CONFIG_DEFERRED_STRUCT_PAGE_INIT) */
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
+/*
+ * Isolation and offlining code cannot deal with pages (e.g. buddy)
+ * overlapping with the range to be offlined yet.
+ */
+#define offline_nr_pages	max((unsigned long)pageblock_nr_pages, \
+				    (unsigned long)MAX_ORDER_NR_PAGES)
 
 extern bool is_mem_section_removable(unsigned long pfn, unsigned long nr_pages);
 extern void try_offline_node(int nid);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7f7bd2acb55b..c971295a1100 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1599,10 +1599,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	struct zone *zone;
 	struct memory_notify arg;
 
-	/* at least, alignment against pageblock is necessary */
-	if (!IS_ALIGNED(start_pfn, pageblock_nr_pages))
+	if (!IS_ALIGNED(start_pfn, offline_nr_pages))
 		return -EINVAL;
-	if (!IS_ALIGNED(end_pfn, pageblock_nr_pages))
+	if (!IS_ALIGNED(end_pfn, offline_nr_pages))
 		return -EINVAL;
 	/* This makes hotplug much easier...and readable.
 	   we assume this for now. .*/
@@ -1700,7 +1699,22 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	return ret;
 }
 
-/* Must be protected by mem_hotplug_begin() or a device_lock */
+/**
+ * offline_pages - offline pages in a given range (that are currently online)
+ * @start_pfn: start pfn of the memory range
+ * @nr_pages: the number of pages
+ *
+ * This function tries to offline the given pages. The alignment/size that
+ * can be used is given by offline_nr_pages.
+ *
+ * Returns 0 if sucessful, -EBUSY if the pages cannot be offlined and
+ * -EINVAL if start_pfn/nr_pages is not properly aligned or not in a zone.
+ * -EINTR is returned if interrupted by a signal.
+ *
+ * Bad things will happen if pages in the range are already offline.
+ *
+ * Must be protected by mem_hotplug_begin() or a device_lock
+ */
 int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
 	return __offline_pages(start_pfn, start_pfn + nr_pages);
-- 
2.14.3
