Return-Path: <david@redhat.com>
X-Google-Smtp-Source: AIpwx4+GySoVgGGi5t35xCYBrUJtbu4QYxtLldTgqOH8Yoy5sjCsS6ZmdNXCRJnfv51prcRpJfrl
ARC-Seal: i=1; a=rsa-sha256; t=1523626393; cv=none;
        d=google.com; s=arc-20160816;
        b=IPjCwyLBI5Wku1sUQSeeoaWnx+oU9QOxcSvA/Pss9NPaJgTx2EMBzXUmOrK8ylo/dn
         WQr3tMIiDz2Qwv2U+dhRu0YKiHEKMVJ7fwfHcIrBPGauFDQ3W3NPq5oQC7mtYHTR4L7S
         tBwMQSSuSdxtzJ7p4M0leCInXm/WTn2kN2q0pmyc75lu13Inc7ddgPiKzajQ0jvfUK6n
         yZLYBBgEp04F/+YD5Q15fJ7GEGW6w3kSVayja3JANcXJrPTjPWvN8FVyl2r+EdhcckRo
         7jQ70tuhUCjZ3f/XdCw8yZxDMhuafKJULQIzIQHEV9tzKn3Hx+n2wJOFRh0i/Wf1ZuPE
         Zebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=lTgCbwgwA5ObPfQaoIiZYCgpLaLvefKrD3XfoOm0+9w=;
        b=pdAJQCbct6cbaoG/64AKF5CK8beKvTukmWotIomQD7I8qHl742LlK2SxpLc7zKOobz
         DP6wLmcYxdb35uLujmayQCzwOUHJxOdXMLqBJlzuquXphpHXcnXUC5Vdgz9ZzID/OEKb
         Jg4nUGnyebi9MCV8cN8DrIad+5zoW+Gb6F8iPAgroZ59BJyuArR4kknplYX29prGA8po
         Axf/4+qzSpV/sj40Oa3FlqeBBDnzl2TyueQkwTvOT8gU1lXYuCEOjV5JMK4kFEI3VlGE
         h18s8PhhlACSCTGDDzvYxTNcQsWSq/PAecK6eo2+pA2Nhc8ducyOsBazAIBnZe8BKy+b
         wEZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of david@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=david@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: David Hildenbrand <david@redhat.com>
To: linux-mm@kvack.org
Cc: David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Rientjes <rientjes@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC 5/8] mm: only mark section offline when all pages are offline
Date: Fri, 13 Apr 2018 15:33:06 +0200
Message-Id: <20180413133309.3501-1-david@redhat.com>
In-Reply-To: <20180413131632.1413-1-david@redhat.com>
References: <20180413131632.1413-1-david@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597638069055964388?=
X-GMAIL-MSGID: =?utf-8?q?1597638069055964388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

If any page is still online, the section should stay online.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c |  2 +-
 mm/sparse.c     | 25 ++++++++++++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e5dcfdb0908..ae9023da2ca2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8013,7 +8013,6 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 			break;
 	if (pfn == end_pfn)
 		return;
-	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
 	spin_lock_irqsave(&zone->lock, flags);
 	pfn = start_pfn;
@@ -8051,6 +8050,7 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		pfn += (1 << order);
 	}
 	spin_unlock_irqrestore(&zone->lock, flags);
+	offline_mem_sections(start_pfn, end_pfn);
 }
 #endif
 
diff --git a/mm/sparse.c b/mm/sparse.c
index 58cab483e81b..44978cb18fed 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -623,7 +623,27 @@ void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 }
 
 #ifdef CONFIG_MEMORY_HOTREMOVE
-/* Mark all memory sections within the pfn range as online */
+static bool all_pages_in_section_offline(unsigned long section_nr)
+{
+	unsigned long pfn = section_nr_to_pfn(section_nr);
+	struct page *page;
+	int i;
+
+	for (i = 0; i < PAGES_PER_SECTION; i++, pfn++) {
+		if (!pfn_valid(pfn))
+			continue;
+
+		page = pfn_to_page(pfn);
+		if (!PageOffline(page))
+			return false;
+	}
+	return true;
+}
+
+/*
+ * Mark all memory sections within the pfn range as offline (if all pages
+ * of a memory section are already offline)
+ */
 void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 {
 	unsigned long pfn;
@@ -639,6 +659,9 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 		if (WARN_ON(!valid_section_nr(section_nr)))
 			continue;
 
+		if (!all_pages_in_section_offline(section_nr))
+			continue;
+
 		ms = __nr_to_section(section_nr);
 		ms->section_mem_map &= ~SECTION_IS_ONLINE;
 	}
-- 
2.14.3
