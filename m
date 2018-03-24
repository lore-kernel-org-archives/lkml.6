Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521894331; cv=none;
        d=google.com; s=arc-20160816;
        b=udSfh0UvT21f00Ced6Jt+IWbb/dSgiNrVpqv2/0B6iZDU1Phj2PniFFJ+45TKjrAc4
         fvsP4gZ4nZ0IMhOPn2jydkTIFozwmpeqVPDdDTJrwhZcMmTJUVTE/TAu4/0KtC80mkeG
         E7F5K1FiTTVu9i8mwAsc4MJSEPDXwFhugvsVHSfF2ypOmPq0coRlQSjqI+WNSyhHD7CO
         fQR2JQuOt8aHltEcoJP7xJuO5So33HquDMPFdcSQ0OklEYBJnyyl5ihFg/F2mzSrY3za
         7JQYz9SGjKaUIRB6WQyZdGWh+c48goGQw3wrw3+6BOe0TthVBRHW3erpSOXosd1k4ME3
         VTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WHFmlfNAE9U76an5wu3zBer5Fq9IRnmvrxVUl0/2ymQ=;
        b=B5QmmbfYScliroGRcj7msSfAmLZzBd11fVmn26HAbZ5L4bqf4bmTDK7enbOqqXaome
         h7+eDbkYURj5XRWcJjMMNqfNHPdIZ4AjIiW09CP3iaRwIdKjm4cTWd1OJwDWYLJC4cvs
         d8xZBpnp35ix3+yXxPulBc/VBz+OeyBWMIvw7BK5tuFGzqlbRUzdDzyGBIJw6A0wsiXf
         F9jsYoQYtnYPxN2ttCfJJa1n6I60LKbIsucMppr7aLD5nqmFnWoQr7RJLdS+sMkwvLT+
         KpfUfOCAa/ESBfAGsAX+RkkZtu4fEXP1x0LvSjWzZBykA6rBTjXICOdOHSznv1dQfzJG
         XTUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=klXQgHgv;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=klXQgHgv;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtE065ytV/7Ham3rwFHGHFJUZME3uCAfsEpGsNbNwWmDpzMYMrmxP+x6fwAe8znntjWSdwGuw==
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
Subject: [PATCH v2 2/5] mm: page_alloc: reduce unnecessary binary search in memblock_next_valid_pfn()
Date: Sat, 24 Mar 2018 05:24:39 -0700
Message-Id: <1521894282-6454-3-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
References: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595821870789767811?=
X-GMAIL-MSGID: =?utf-8?q?1595821870789767811?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. if pfn and pfn+1 are in the same
memblock region, we can simply pfn++ instead of doing the binary search
in memblock_next_valid_pfn.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h |  2 +-
 mm/memblock.c            | 73 +++++++++++++++++++++++++++++-------------------
 mm/page_alloc.c          |  3 +-
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index efbbe4b..a8fb2ab 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -204,7 +204,7 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
-unsigned long memblock_next_valid_pfn(unsigned long pfn);
+unsigned long memblock_next_valid_pfn(unsigned long pfn, int *idx);
 #endif
 
 /**
diff --git a/mm/memblock.c b/mm/memblock.c
index bea5a9c..06c1a08 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1102,35 +1102,6 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r->nid;
 }
 
-#ifdef CONFIG_HAVE_ARCH_PFN_VALID
-unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
-{
-	struct memblock_type *type = &memblock.memory;
-	unsigned int right = type->cnt;
-	unsigned int mid, left = 0;
-	phys_addr_t addr = PFN_PHYS(++pfn);
-
-	do {
-		mid = (right + left) / 2;
-
-		if (addr < type->regions[mid].base)
-			right = mid;
-		else if (addr >= (type->regions[mid].base +
-				  type->regions[mid].size))
-			left = mid + 1;
-		else {
-			/* addr is within the region, so pfn is valid */
-			return pfn;
-		}
-	} while (left < right);
-
-	if (right == type->cnt)
-		return -1UL;
-	else
-		return PHYS_PFN(type->regions[right].base);
-}
-#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
-
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
@@ -1162,6 +1133,50 @@ int __init_memblock memblock_set_node(phys_addr_t base, phys_addr_t size,
 }
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
+							int *last_idx)
+{
+	struct memblock_type *type = &memblock.memory;
+	unsigned int right = type->cnt;
+	unsigned int mid, left = 0;
+	unsigned long start_pfn, end_pfn;
+	phys_addr_t addr = PFN_PHYS(++pfn);
+
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
+	do {
+		mid = (right + left) / 2;
+
+		if (addr < type->regions[mid].base)
+			right = mid;
+		else if (addr >= (type->regions[mid].base +
+				  type->regions[mid].size))
+			left = mid + 1;
+		else {
+			*last_idx = mid;
+			return pfn;
+		}
+	} while (left < right);
+
+	if (right == type->cnt)
+		return -1UL;
+
+	*last_idx = right;
+
+	return PHYS_PFN(type->regions[*last_idx].base);
+}
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 static phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid, ulong flags)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2a967f7..0bb0274 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5459,6 +5459,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	unsigned long end_pfn = start_pfn + size;
 	pg_data_t *pgdat = NODE_DATA(nid);
 	unsigned long pfn;
+	int idx = -1;
 	unsigned long nr_initialised = 0;
 	struct page *page;
 #ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
@@ -5490,7 +5491,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
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
