Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522033380; cv=none;
        d=google.com; s=arc-20160816;
        b=xvZokKCIvmft6Rq6m5hIq8V/RYEX0K4DtW9Vb1J9HpBf1yx4V2xRvZSw7tuk9ixsk+
         3kVBJxNslWMiEv9EcAnIlSGjcbzm1pC3bV0JvYTZt6/3M1EoJiff+PVvU0/VGfaMYVzo
         u5Nsio9X8i3RpuJR5WOj0MxUJJGW4TZ567kldfV6NtRgai8tfvpRaEsK9iyL5Pz0sHyg
         jayA2cbwJZs41WB6lI3LB9c6oC4snmvNFKmljw1AFQ87MFCeVVlTYFIUIrukANk6mgwu
         2Tqhi6Jq48EH8spARTNmB4iVNiyrikjpt+j4r8OFpqFxzxQj/VQDu1dmc6+c4egiTj+i
         TXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=zPjYOchOIUoUOg+AeshAkXKjILJ9DfOv2dGhtrvsThM=;
        b=ypnHkfRqux3Zd6bQDHhbgkN3ri3a35zPCVIjNtsgdXCeskJSQiQVGh+/b/R2ZNm0tm
         CV62BlbdQN0uHsn+Muv6ygMDOE0QuuRpMc4/Z6nAF+sqslyoQFMqyE4v5voM0L8CjwaJ
         0DtWbZ4zdXy3pmvkL1X3SvEOP7LgrQTpPaW2LLhQYAhOrYHuEeyZQVKcfJapQm7ozmWh
         yRj8IBnIQgQF8hYQ0+zktql6HmDc2LNfMchMzJHuVmzcQqVGNVRjrLEr72zu9YFEjSf9
         dTdiRJyhNHcFPdSYdpqIMshWkDFxB2oW0Dn3A+SCSlaJHCEChXiZAKw1FEQmmC8lOLj3
         Vzow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DF3CzckQ;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DF3CzckQ;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELu9sxfZkcN3fHt5AWJByDW4Bxi1v+h9zBFrUDSa4UStDQqa9UCpbDiXx/zP83LgNMA6zbIxrQ==
From: Jia He <hejianet@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mel Gorman <mgorman@suse.de>,
	Will Deacon <will.deacon@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
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
Subject: [PATCH v3 1/5] mm: page_alloc: remain memblock_next_valid_pfn() when CONFIG_HAVE_ARCH_PFN_VALID is enable
Date: Sun, 25 Mar 2018 20:02:15 -0700
Message-Id: <1522033340-6575-2-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967673442117233?=
X-GMAIL-MSGID: =?utf-8?q?1595967673442117233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But it causes
possible panic bug. So Daniel Vacek reverted it later.

But memblock_next_valid_pfn is valid when CONFIG_HAVE_ARCH_PFN_VALID is
enable. And as verified by Eugeniu Rosca, arm can benifit from this
commit. So remain the memblock_next_valid_pfn.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 include/linux/memblock.h |  4 ++++
 mm/memblock.c            | 29 +++++++++++++++++++++++++++++
 mm/page_alloc.c          | 11 ++++++++++-
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 0257aee..efbbe4b 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -203,6 +203,10 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
 	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
 #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
 
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+unsigned long memblock_next_valid_pfn(unsigned long pfn);
+#endif
+
 /**
  * for_each_free_mem_range - iterate through free memblock areas
  * @i: u64 used as loop variable
diff --git a/mm/memblock.c b/mm/memblock.c
index ba7c878..bea5a9c 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1102,6 +1102,35 @@ void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 		*out_nid = r->nid;
 }
 
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
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
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
+
 /**
  * memblock_set_node - set node ID on memblock regions
  * @base: base of area to set node ID for
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c19f5ac..2a967f7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5483,8 +5483,17 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn))
+		if (!early_pfn_valid(pfn)) {
+#if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
+			/*
+			 * Skip to the pfn preceding the next valid one (or
+			 * end_pfn), such that we hit a valid pfn (or end_pfn)
+			 * on our next iteration of the loop.
+			 */
+			pfn = memblock_next_valid_pfn(pfn) - 1;
+#endif
 			continue;
+		}
 		if (!early_pfn_in_nid(pfn, nid))
 			continue;
 		if (!update_defer_init(pgdat, pfn, end_pfn, &nr_initialised))
-- 
2.7.4
