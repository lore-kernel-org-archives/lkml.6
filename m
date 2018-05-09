Return-Path: <mathieu.malaterre@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525892411; cv=none;
        d=google.com; s=arc-20160816;
        b=xMFs0zd+qqllH4AvoQP/FNG9kvaijMDJVE3KMBh79vMe/inWyPCUd90N+ZDu1LFLVh
         aCIXg1/jY5QJ1wOoN7zxhVedvaXjJzeEeDrlhhkAwztZh55LfRMhp7wjpeeoYyioAX2B
         t2lu2U4jcndwnbxR+B6C6qMMYWuBAAAylPqIJkVfzgmrFKrgF7KLkfzxgV4hB4Z8qj7N
         pX/iDZmlNkmdXrzOV3gb9zvlUx79pd/YwQPYMe1LroKPzirX81CeyWWTy+dGsDO3XdMz
         c5PmFjYBFIIS6uAae20Xd9RhqIt4pJAdxsgIdAN/4Vh9sK+qt8n/jyFMX7+7ofONKU5r
         O9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:dkim-signature
         :arc-authentication-results;
        bh=fAo588UllvcubBjP5YkspmAW/29hWWAs9nuDqTT8omA=;
        b=F8mNP60RBg3OsMUryTjZ9G0xK8LWiv80nyGZS5jqVA6maCnQJHVLNRVB/guH7XEMX2
         bviDKWBvDL8A7vY3x6eRrHgCKPOZNilaBT50AhuO/Pvj/z+rbNrwupCEwhztCkHdJPsY
         TqgLxnm8/9GG5+3eb1OQHjLWzVyf5/2zOPEBhB+pscub9kIrIMrC3scdCWBKcmV/y0tn
         bn1OvyjFBWV4MbZSirpvA+WbdC8mPxI2/mboofM5WNJtTH62O9cOXTaBVPfe2HQPM+j3
         Vvgj300TjpuI/+688qUpSfr18RU14QXSTf5apV/SKXrF5yCzwQoS4RYTqSL47XbTAh0k
         JIkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b6Hwnl6I;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=b6Hwnl6I;
       spf=pass (google.com: domain of mathieu.malaterre@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mathieu.malaterre@gmail.com
X-Google-Smtp-Source: AB8JxZqknKJ33u/SG39PfFPMNo0cB0d8Qbe5BXNWGfBeKJJ/8BLjz7U4n7grRufwha54VhYAP574XQ==
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Dan Williams <dan.j.williams@intel.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Reza Arbab <arbab@linux.vnet.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mel Gorman <mgorman@techsingularity.net>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] =?UTF-8?q?mm:=20move=20function=20=E2=80=98is=5Fpagebl?= =?UTF-8?q?ock=5Fremovable=5Fnolock=E2=80=99=20to=20mm/memory=5Fhotplug.c?=
Date: Wed,  9 May 2018 20:59:57 +0200
Message-Id: <20180509190001.24789-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180505201107.21070-1-malat@debian.org>
References: <20180505201107.21070-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600014160898520786?=
X-GMAIL-MSGID: =?utf-8?q?1600014160898520786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Function ‘is_pageblock_removable_nolock’ is not used outside of
mm/memory_hotplug.c. Move it next to unique caller:
‘is_mem_section_removable’ and make it static.
Remove prototype in <linux/memory_hotplug.h>. Silence gcc warning (W=1):

  mm/page_alloc.c:7704:6: warning: no previous prototype for ‘is_pageblock_removable_nolock’ [-Wmissing-prototypes]

Suggested-by: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
v2: this function can be made static, make it so

 include/linux/memory_hotplug.h |  1 -
 mm/memory_hotplug.c            | 23 +++++++++++++++++++++++
 mm/page_alloc.c                | 23 -----------------------
 3 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index e0e49b5b1ee1..9566d551a41b 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -107,7 +107,6 @@ static inline bool movable_node_is_enabled(void)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-extern bool is_pageblock_removable_nolock(struct page *page);
 extern int arch_remove_memory(u64 start, u64 size,
 		struct vmem_altmap *altmap);
 extern int __remove_pages(struct zone *zone, unsigned long start_pfn,
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f74826cdceea..9342e120518a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1237,6 +1237,29 @@ static struct page *next_active_pageblock(struct page *page)
 	return page + pageblock_nr_pages;
 }
 
+static bool is_pageblock_removable_nolock(struct page *page)
+{
+	struct zone *zone;
+	unsigned long pfn;
+
+	/*
+	 * We have to be careful here because we are iterating over memory
+	 * sections which are not zone aware so we might end up outside of
+	 * the zone but still within the section.
+	 * We have to take care about the node as well. If the node is offline
+	 * its NODE_DATA will be NULL - see page_zone.
+	 */
+	if (!node_online(page_to_nid(page)))
+		return false;
+
+	zone = page_zone(page);
+	pfn = page_to_pfn(page);
+	if (!zone_spans_pfn(zone, pfn))
+		return false;
+
+	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
+}
+
 /* Checks if this range of memory is likely to be hot-removable. */
 bool is_mem_section_removable(unsigned long start_pfn, unsigned long nr_pages)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 905db9d7962f..52731601ca5a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7701,29 +7701,6 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int count,
 	return false;
 }
 
-bool is_pageblock_removable_nolock(struct page *page)
-{
-	struct zone *zone;
-	unsigned long pfn;
-
-	/*
-	 * We have to be careful here because we are iterating over memory
-	 * sections which are not zone aware so we might end up outside of
-	 * the zone but still within the section.
-	 * We have to take care about the node as well. If the node is offline
-	 * its NODE_DATA will be NULL - see page_zone.
-	 */
-	if (!node_online(page_to_nid(page)))
-		return false;
-
-	zone = page_zone(page);
-	pfn = page_to_pfn(page);
-	if (!zone_spans_pfn(zone, pfn))
-		return false;
-
-	return !has_unmovable_pages(zone, page, 0, MIGRATE_MOVABLE, true);
-}
-
 #if (defined(CONFIG_MEMORY_ISOLATION) && defined(CONFIG_COMPACTION)) || defined(CONFIG_CMA)
 
 static unsigned long pfn_max_align_down(unsigned long pfn)
-- 
2.11.0
