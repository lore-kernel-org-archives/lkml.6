Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522397796; cv=none;
        d=google.com; s=arc-20160816;
        b=FqNKEC2SwMYkv1kw+ngbifP/BDM0z4y2VAX3SjmKzmX3Ene5zeXj9fxo05IKRv3SMm
         IqlmiZgF17Q/L4cC85N0KYr2XyTqYC9SgI7fTNW7f375egxEuAec20sOX6Cq+sPcmqv2
         MmIub2/l88Pd1wB+iQNsNtKgSHy3UjBH/8vsBcML5FaCzpUVEUbttK8xkwg7EJm6NdTb
         D2vGL1FXjaqP1dFGmdWvvfw9+lEzzA5/a8Vk4ZB7fb4Cy9g8qfweaYJ1e9C8GOw283JM
         zwjdeMdQviIoLEyWymb3NS+adcfJz9TdE7ex1jr88VpXxyk+TaJg+sxZJCataLMIjTEA
         vVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=wG4eG8g85RYT7S7ST1+KqNO2x+rwpOwBbjh5gR0j/YI=;
        b=FUKBwstWjJok4tAJWexaqFcVuwXPNhjHXbIBSp8FbXL2LiBpXKJ5MEeGWTo2Rcb9bJ
         1aMSnn+Ov8W2wGYB8ONnsqr9FoD3Gwj+EmxTme1iqPw5NDDvAl3C0puQErtMITF5b3If
         LWCUO6o3ttfY1U2lX4CYJocFCQSdJKtBk0I+CSR/Fdp4qxTZFBaRwLaksOxA67fZtct7
         q7Iz6/6N+kc0+pR9PDAIYHHZBGimAxTEqCoBPv+EqmYAhj4OpPFBowmFawwCZ/TsrAcU
         GBYxgMXqfga4px/A0F8293ud82pP/6JZB52xuTQ3S8s3ZKjL4Rj1oPeH+WKtE5nmS8ut
         P19w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kcHeXujA;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kcHeXujA;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48xUtj190kgjaFIGXYHyu2C8AI2Y55LVygGqFDFzfr8nCy3pAZZZjOFvciSG3oR+tfFIuVUfg==
From: Jia He <hejianet@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
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
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
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
	richard.weiyang@gmail.com,
	Jia He <hejianet@gmail.com>,
	Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH v4 1/5] mm: page_alloc: remain memblock_next_valid_pfn() on arm and arm64
Date: Fri, 30 Mar 2018 01:15:51 -0700
Message-Id: <1522397755-33393-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
References: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596349791646884565?=
X-GMAIL-MSGID: =?utf-8?q?1596349791646884565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But as suggested by Daniel Vacek, it is fine to using memblock to skip
gaps and finding next valid frame with CONFIG_HAVE_ARCH_PFN_VALID.

On arm and arm64, memblock is used by default. But generic version of
pfn_valid() is based on mem sections and memblock_next_valid_pfn() does
not always return the next valid one but skips more resulting in some
valid frames to be skipped (as if they were invalid). And that's why
kernel was eventually crashing on some !arm machines.

And as verified by Eugeniu Rosca, arm can benifit from commit
b92df1de5d28. So remain the memblock_next_valid_pfn on arm{,64} and move
the related codes to arm64 arch directory.

Suggested-by: Daniel Vacek <neelx@redhat.com>
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/mm/init.c   | 31 ++++++++++++++++++++++++++++++-
 arch/arm64/mm/init.c | 31 ++++++++++++++++++++++++++++++-
 mm/page_alloc.c      | 13 ++++++++++++-
 3 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index a1f11a7..0fb85ca 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -198,7 +198,36 @@ int pfn_valid(unsigned long pfn)
 	return memblock_is_map_memory(__pfn_to_phys(pfn));
 }
 EXPORT_SYMBOL(pfn_valid);
-#endif
+
+/* HAVE_MEMBLOCK is always enabled on arm */
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	unsigned int right = type->cnt;
+	unsigned int mid, left = 0;
+	phys_addr_t addr = PFN_PHYS(++pfn);
+
+	do {
+		mid = (right + left) / 2;
+
+		if (addr < type->regions[mid].base)
+			right = mid;
+		else if (addr >= (type->regions[mid].base +
+				  type->regions[mid].size))
+			left = mid + 1;
+		else {
+			/* addr is within the region, so pfn is valid */
+			return pfn;
+		}
+	} while (left < right);
+
+	if (right == type->cnt)
+		return -1UL;
+	else
+		return PHYS_PFN(type->regions[right].base);
+}
+EXPORT_SYMBOL(memblock_next_valid_pfn);
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
 
 #ifndef CONFIG_SPARSEMEM
 static void __init arm_memory_present(void)
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 00e7b90..13e43ff 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -290,7 +290,36 @@ int pfn_valid(unsigned long pfn)
 	return memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
-#endif
+
+/* HAVE_MEMBLOCK is always enabled on arm64 */
+unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn)
+{
+	struct memblock_type *type = &memblock.memory;
+	unsigned int right = type->cnt;
+	unsigned int mid, left = 0;
+	phys_addr_t addr = PFN_PHYS(++pfn);
+
+	do {
+		mid = (right + left) / 2;
+
+		if (addr < type->regions[mid].base)
+			right = mid;
+		else if (addr >= (type->regions[mid].base +
+				  type->regions[mid].size))
+			left = mid + 1;
+		else {
+			/* addr is within the region, so pfn is valid */
+			return pfn;
+		}
+	} while (left < right);
+
+	if (right == type->cnt)
+		return -1UL;
+	else
+		return PHYS_PFN(type->regions[right].base);
+}
+EXPORT_SYMBOL(memblock_next_valid_pfn);
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
 
 #ifndef CONFIG_SPARSEMEM
 static void __init arm64_memory_present(void)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c19f5ac..8a92df7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5452,6 +5452,15 @@ void __ref build_all_zonelists(pg_data_t *pgdat)
  * up by free_all_bootmem() once the early boot process is
  * done. Non-atomic initialization, single-pass.
  */
+#if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
+extern unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#define skip_to_last_invalid_pfn(pfn) (memblock_next_valid_pfn(pfn) - 1)
+#endif
+
+#ifndef skip_to_last_invalid_pfn
+#define skip_to_last_invalid_pfn(pfn) (pfn)
+#endif
+
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn, enum memmap_context context,
 		struct vmem_altmap *altmap)
@@ -5483,8 +5492,10 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn))
+		if (!early_pfn_valid(pfn)) {
+			pfn = skip_to_last_invalid_pfn(pfn);
 			continue;
+		}
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-- 
2.7.4
