Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933652AbeEWPPG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:15:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933425AbeEWPMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:12:12 -0400
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@techadventures.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1 02/10] mm/page_ext.c: support online/offline of memory < section size
Date: Wed, 23 May 2018 17:11:43 +0200
Message-Id: <20180523151151.6730-3-david@redhat.com>
In-Reply-To: <20180523151151.6730-1-david@redhat.com>
References: <20180523151151.6730-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, we would free the extended page data if parts of a section
are offlined or if onlining is aborted, although still some pages are
online.

We can simply check if the section is online to see if we are allowed to
free. init_section_page_ext() already takes care of the allocation part
for sub sections.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@techadventures.net>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Jaewon Kim <jaewon31.kim@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/page_ext.c b/mm/page_ext.c
index 5295ef331165..71a025128dac 100644
--- a/mm/page_ext.c
+++ b/mm/page_ext.c
@@ -320,7 +320,9 @@ static int __meminit online_page_ext(unsigned long start_pfn,
 
 	/* rollback */
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
-		__free_page_ext(pfn);
+		/* still online? nothing to do then */
+		if (!online_section_nr(pfn_to_section_nr(pfn)))
+			__free_page_ext(pfn);
 
 	return -ENOMEM;
 }
@@ -334,7 +336,10 @@ static int __meminit offline_page_ext(unsigned long start_pfn,
 	end = SECTION_ALIGN_UP(start_pfn + nr_pages);
 
 	for (pfn = start; pfn < end; pfn += PAGES_PER_SECTION)
-		__free_page_ext(pfn);
+		/* still online? nothing to do then */
+		if (!online_section_nr(pfn_to_section_nr(pfn)))
+			__free_page_ext(pfn);
+
 	return 0;
 
 }
-- 
2.17.0
