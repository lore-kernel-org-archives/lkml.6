Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521619831; cv=none;
        d=google.com; s=arc-20160816;
        b=q/LKON/rThjU1rPLMD/7XxNU7pD1E4zAd4hQ2Cm8IsJ3hvmLj/1pZZ1zBEfPExTrPL
         4FfrZyj4MCs1WNS3K2UUNe2R7P6sPjfKLViax+aAaJhBimtU6edfYfEk3SS/J+sUJZOr
         vl6EAZzDfmxHvDA9QwH2/lBvoqXnxlvpMZ3+GEwG/zN7oeUQ/+RRAmSyG6Le8f0yIPEz
         bIURokVGfAtPjZ8CXAqDs7Nu5TDn+GgC0/gA/Kk5mIW+3lNffmVOVURFZaRkyWYLEY4z
         NPysqoyoymfCBIhB7ptzai5UA2PKmhfPbQXqLlMWHH/l2lVPdCZDloE5831IwnPox3Z6
         y7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=avmYRN6/vnItuyI7N23b9DdVPaH9+/pqg1OKGOcnB88=;
        b=AikJyis/HwR2sstmLw1LJQhhc3JjKGQC9IPXWnpb/vdP9Eljd/4i8ubsXyQ9lqlHHM
         Bi/ZCbCvFySFhOHmS9GaElkzpTio8zTPBVXK7n0ifgA7HEPvk6adMeiQjukumHdy37/H
         LzYM7i6zSMEFD39IP3OnyFoy+e8+t/sp5B/vDkW6DfXi0QUQbw5wCLbzdUYvXBq8Cy1z
         l+Lopd9p3s9RJNfHK3N9R2Roi2I6EAprfOCD1in7YEOrwjctYaaET2Vmax4PGi8TEVmF
         j1wUS7HdHajI/E/NtligKrykADb8FvCBt5Ft3oNIbfk6DAmVLtoK8+QPIRqpWsjzY9r9
         nXAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oimjIJAo;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oimjIJAo;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs4ppvo0nODfw9Qx//6+C8c0VwE08RGf74v5d6ME8Avh1ddm8QllB0DZaD7PmuLyjcOpcw06A==
From: Jia He <hejianet@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Gioh Kim <gi-oh.kim@profitbricks.com>,
	Steven Sistare <steven.sistare@oracle.com>,
	Daniel Vacek <neelx@redhat.com>,
	Eugeniu Rosca <erosca@de.adit-jv.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	James Morse <james.morse@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Steve Capper <steve.capper@arm.com>,
	x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Kemi Wang <kemi.wang@intel.com>,
	Petr Tesarik <ptesarik@suse.com>,
	YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Borisov <nborisov@suse.com>,
	Jia He <hejianet@gmail.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH 1/4] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn()
Date: Wed, 21 Mar 2018 01:09:53 -0700
Message-Id: <1521619796-3846-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534036182363270?=
X-GMAIL-MSGID: =?utf-8?q?1595534036182363270?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. if pfn and pfn+1 are in the same
memblock region, we can simply pfn++ instead of doing the binary search
in memblock_next_valid_pfn.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h |  3 +--
 mm/memblock.c            | 23 +++++++++++++++++++----
 mm/page_alloc.c          |  3 ++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index b7aa3ff..9471db4 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,8 +203,7 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
-unsigned long memblock_next_valid_pfn(unsigned long pfn);
-
+unsigned long memblock_next_valid_pfn(unsigned long pfn, int *last_idx);
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index c87924d..a9e8da4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1133,13 +1133,26 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
-unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
+							int *last_idx)
 {
 	struct memblock_type *type = &memblock.memory;
 	unsigned int right = type->cnt;
 	unsigned int mid, left = 0;
+	unsigned long start_pfn, end_pfn;
 	phys_addr_t addr = PFN_PHYS(++pfn);
 
+	/* fast path, return pfh+1 if next pfn is in the same region */
+	if (*last_idx != -1) {
+		start_pfn = PFN_DOWN(type->regions[*last_idx].base);
+		end_pfn = PFN_DOWN(type->regions[*last_idx].base +
+				type->regions[*last_idx].size);
+
+		if (pfn < end_pfn && pfn > start_pfn)
+			return pfn;
+	}
+
+	/* slow path, do the binary searching */
 	do {
 		mid = (right + left) / 2;
 
@@ -1149,15 +1162,17 @@ unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
 				  type->regions[mid].size))
 			left = mid + 1;
 		else {
-			/* addr is within the region, so pfn is valid */
+			*last_idx = mid;
 			return pfn;
 		}
 	} while (left < right);
 
 	if (right == type->cnt)
 		return -1UL;
-	else
-		return PHYS_PFN(type->regions[right].base);
+
+	*last_idx = right;
+
+	return PHYS_PFN(type->regions[*last_idx].base);
 }
 
 static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3899209..f28c62c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5456,6 +5456,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	unsigned long end_pfn = start_pfn + size;
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
+	int idx = -1;
 	unsigned long nr_initialised = 0;
 	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
@@ -5487,7 +5488,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
 			 * on our next iteration of the loop.
 			 */
-			pfn = memblock_next_valid_pfn(pfn) - 1;
+			pfn = memblock_next_valid_pfn(pfn, &idx) - 1;
 #endif
 			continue;
 		}
-- 
2.7.4
