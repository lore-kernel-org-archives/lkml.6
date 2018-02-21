Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225EOKKc9OeMBclSF3fc7/a8Io6OmY5Nw7n7lcsw2e2PhNqVciNaqkP/BmO1bjAE8SEcowBo
ARC-Seal: i=1; a=rsa-sha256; t=1519218438; cv=none;
        d=google.com; s=arc-20160816;
        b=lXErkecvNgKBGDOCtCZk4/pOZ6FvMzt17BbC++9hkJA21KZ6//hzRm5QCbpYyQz1xh
         cvL+iQTJI898vS8dqjIVEVWiKWfSrDE8ISWipm/W4Jz8P0p5hxlS+TnnMfz2q+38+wOh
         hEvwbf6BijD5XVEVFsx+Mvpdd6faOqRESkRhCD5SYQsKoEZx9FJI1yUxhjY1+I+dkd1p
         xjzeErajy8tKJuxQjodZDGx6aAV4n67n1O6S7GR50yS3beVv+mrmmwNwu8GIdic7u45/
         nUr/1qRH4nt0QWj8SIYwelmJrAEpFUI230KIq9ybs7973kspT4LwMRWeOUUOLv1G6dGs
         FE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=kIH3ReyZiQdXRmXYYY1TXJ6QkhjSRfghrbonsGK+lTM=;
        b=ZINZXH7lV1xzcXa7UCzY3cwWoPhhrtEJmMF9bBXWFb1SrFiNihc/6vHQ5fHEo7D01Y
         4N3Ua1hozucK5jcFpMIY+tjFhhkJGzin8v5UVp6s5sZ4KnUkxzQrbMKcZt1C26jlbpMT
         Dam+XYQwf0PxX9Uuc2vRJMZFhKsHVe0urVtehz897AjOJeVHf0ousJqrqjWaaLw8j4fi
         4GhnEWvpQO0V97JHDwI/phD3bHsos/62KZliS8fSl/02QJAx2ZwoB/LyHLWY4xzCM2LH
         V5Atxe0qG8omZZNaEqAuJ3xEAcqDeeHYmm8+YpzcGRzaqKTqt7kWgLsIvDD6tcuR/nM8
         F2oQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michal Hocko <mhocko@suse.com>,
	Bharata B Rao <bharata@linux.vnet.ibm.com>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Bob Picco <bob.picco@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 039/163] mm, memory_hotplug: fix memmap initialization
Date: Wed, 21 Feb 2018 13:47:48 +0100
Message-Id: <20180221124532.485499209@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015994058369800?=
X-GMAIL-MSGID: =?utf-8?q?1593015994058369800?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Hocko <mhocko@suse.com>

commit 9bb5a391f9a5707e04763cf14298fc4cc29bfecd upstream.

Bharata has noticed that onlining a newly added memory doesn't increase
the total memory, pointing to commit f7f99100d8d9 ("mm: stop zeroing
memory during allocation in vmemmap") as a culprit.  This commit has
changed the way how the memory for memmaps is initialized and moves it
from the allocation time to the initialization time.  This works
properly for the early memmap init path.

It doesn't work for the memory hotplug though because we need to mark
page as reserved when the sparsemem section is created and later
initialize it completely during onlining.  memmap_init_zone is called in
the early stage of onlining.  With the current code it calls
__init_single_page and as such it clears up the whole stage and
therefore online_pages_range skips those pages.

Fix this by skipping mm_zero_struct_page in __init_single_page for
memory hotplug path.  This is quite uggly but unifying both early init
and memory hotplug init paths is a large project.  Make sure we plug the
regression at least.

Link: http://lkml.kernel.org/r/20180130101141.GW21609@dhcp22.suse.cz
Fixes: f7f99100d8d9 ("mm: stop zeroing memory during allocation in vmemmap")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Reported-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Tested-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Bob Picco <bob.picco@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1177,9 +1177,10 @@ static void free_one_page(struct zone *z
 }
 
 static void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid)
+				unsigned long zone, int nid, bool zero)
 {
-	mm_zero_struct_page(page);
+	if (zero)
+		mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
 	init_page_count(page);
 	page_mapcount_reset(page);
@@ -1194,9 +1195,9 @@ static void __meminit __init_single_page
 }
 
 static void __meminit __init_single_pfn(unsigned long pfn, unsigned long zone,
-					int nid)
+					int nid, bool zero)
 {
-	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid);
+	return __init_single_page(pfn_to_page(pfn), pfn, zone, nid, zero);
 }
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
@@ -1217,7 +1218,7 @@ static void __meminit init_reserved_page
 		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
 			break;
 	}
-	__init_single_pfn(pfn, zid, nid);
+	__init_single_pfn(pfn, zid, nid, true);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -1514,7 +1515,7 @@ static unsigned long __init deferred_ini
 					page++;
 				else
 					page = pfn_to_page(pfn);
-				__init_single_page(page, pfn, zid, nid);
+				__init_single_page(page, pfn, zid, nid, true);
 				cond_resched();
 			}
 		}
@@ -5393,15 +5394,20 @@ not_early:
 		 * can be created for invalid pages (for alignment)
 		 * check here not to call set_pageblock_migratetype() against
 		 * pfn out of zone.
+		 *
+		 * Please note that MEMMAP_HOTPLUG path doesn't clear memmap
+		 * because this is done early in sparse_add_one_section
 		 */
 		if (!(pfn & (pageblock_nr_pages - 1))) {
 			struct page *page = pfn_to_page(pfn);
 
-			__init_single_page(page, pfn, zone, nid);
+			__init_single_page(page, pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
 			cond_resched();
 		} else {
-			__init_single_pfn(pfn, zone, nid);
+			__init_single_pfn(pfn, zone, nid,
+					context != MEMMAP_HOTPLUG);
 		}
 	}
 }
