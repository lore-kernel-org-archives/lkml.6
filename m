Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/dsf/rEgBI+T6OCLnO6tyiwewn3TWyEBWzXJBEn4UwFINvxVmb5d00dTwz7ynl+Mbjt6C1
ARC-Seal: i=1; a=rsa-sha256; t=1522168559; cv=none;
        d=google.com; s=arc-20160816;
        b=T0WlOWZN6o1ChRD1dW7+K+n5gD/l2mqMvQbnFua9kVI8XV8USoIeSCyngkVzjCb/XY
         8lkVWQpa57gc7wKVqVjHQwhuJrR9rZ+Atti585RlLTGKhhf6uzd1/jRdSgSNUjt3lIju
         cgMNWSBL+qzgtOIVl7wB8e2/kHfV7iqYwMM73lnrTsahzBUH4xFbd30HcFY1YxYv2Mgd
         G657XGx9N2cm0E2Pv1A7ilJ6IABzW6pdcQTRMpTwX49IRF3Mb1q+K/3xA4e6tzhmlJms
         9CgK2ycTTWf+SvZbDcM4SixRnrj2/sBrRBXGmvlDJnTBwCV4iOD1yucYUePpdvHEAx1Q
         vqdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GrUM2BkmbvktphXSpwPcInJUuwSaBd1zsaSaqRB8Qyk=;
        b=MQryO/vu4njIcczU5ujbIF3I2HOo0TNth4MHX/du8rPFqPT4RJHKqNgCEkT+BDPW2Y
         OnTmmJ9dmWsmh+KDSqTJPMEZspoaXzJvOZLGKPjYQwx/mU+M9vysBvrIhe1YaxHRYe5C
         sOamWxPXAK6UkPriXICPTNn7N4R0FaktSeTEMosIj5E781Eg+Z2F2pFrKYkMWX7f+K5E
         bBgwfmRik0cNTlf27hMe7icFkgVrIcnUSaDZmKNfQgQZ7ObgYiO9AoQuozRXTWV4vR+I
         /5v3sOzdVYGjVzDZwN9weJLb+XnIOWVIIIqA3nH4SgnYupTftNsN0wQnmx6Xatjrgb77
         O/2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Daniel Vacek <neelx@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Paul Burton <paul.burton@imgtec.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 052/101] Revert "mm: page_alloc: skip over regions of invalid pfns where possible"
Date: Tue, 27 Mar 2018 18:27:24 +0200
Message-Id: <20180327162753.214261520@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109419985580324?=
X-GMAIL-MSGID: =?utf-8?q?1596109419985580324?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vacek <neelx@redhat.com>

commit f59f1caf72ba00d519c793c3deb32cd3be32edc2 upstream.

This reverts commit b92df1de5d28 ("mm: page_alloc: skip over regions of
invalid pfns where possible").  The commit is meant to be a boot init
speed up skipping the loop in memmap_init_zone() for invalid pfns.

But given some specific memory mapping on x86_64 (or more generally
theoretically anywhere but on arm with CONFIG_HAVE_ARCH_PFN_VALID) the
implementation also skips valid pfns which is plain wrong and causes
'kernel BUG at mm/page_alloc.c:1389!'

  crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
  kernel BUG at mm/page_alloc.c:1389!
  invalid opcode: 0000 [#1] SMP
  --
  RIP: 0010: move_freepages+0x15e/0x160
  --
  Call Trace:
    move_freepages_block+0x73/0x80
    __rmqueue+0x263/0x460
    get_page_from_freelist+0x7e1/0x9e0
    __alloc_pages_nodemask+0x176/0x420
  --

  crash> page_init_bug -v | grep RAM
  <struct resource 0xffff88067fffd2f8>          1000 -        9bfff       System RAM (620.00 KiB)
  <struct resource 0xffff88067fffd3a0>        100000 -     430bffff       System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
  <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff       System RAM ( 14.83 MiB = 15188.00 KiB)
  <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff       System RAM (391.02 MiB = 400408.00 KiB)
  <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
  <struct resource 0xffff88067fffd640>     100000000 -    67fffffff       System RAM ( 22.00 GiB)

  crash> page_init_bug | head -6
  <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff       System RAM (480.00 KiB)
  <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
  <struct page 0xffffea0001ede200>       505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
  <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
  <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
  BUG, zones differ!

  crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
  ffffea0001e00000  78000000                0        0  0 0
  ffffea0001ed7fc0  7b5ff000                0        0  0 0
  ffffea0001ed8000  7b600000                0        0  0 0       <<<<
  ffffea0001ede1c0  7b787000                0        0  0 0
  ffffea0001ede200  7b788000                0        0  1 1fffff00000000

Link: http://lkml.kernel.org/r/20180316143855.29838-1-neelx@redhat.com
Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/memblock.h |    1 -
 mm/memblock.c            |   28 ----------------------------
 mm/page_alloc.c          |   11 +----------
 3 files changed, 1 insertion(+), 39 deletions(-)

--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -187,7 +187,6 @@ int memblock_search_pfn_nid(unsigned lon
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 			  unsigned long *out_end_pfn, int *out_nid);
-unsigned long memblock_next_valid_pfn(unsigned long pfn, unsigned long max_pfn);
 
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1101,34 +1101,6 @@ void __init_memblock __next_mem_pfn_rang
 		*out_nid = r->nid;
 }
 
-unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
-						      unsigned long max_pfn)
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
-
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5302,17 +5302,8 @@ void __meminit memmap_init_zone(unsigned
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn)) {
-#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
-			/*
-			 * Skip to the pfn preceding the next valid one (or
-			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop.
-			 */
-			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
-#endif
+		if (!early_pfn_valid(pfn))
 			continue;
-		}
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
