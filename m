Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522033367; cv=none;
        d=google.com; s=arc-20160816;
        b=WJuZwoTm7tBDqSdS2352BPOm3kTD7qFGWVrxJ/3UDf1etY41kukgEps4ZQTHWL3k2C
         lUtGskX2d7r2x4YvU/meAvQhtDr0pa5YKGMI4dBKYfgwygbXYQV3veLsUMvHh47+ZzzI
         jXX+so2kUYbgTrsOjPiiEMYJkSf0y8Jte+3iPJ51hwVoQApiBOCNekytJTCqasWATHy4
         bEMS2Yb6iJ8TmvsdZkhvtLaOci82RonjoMS0vS0up22gYbdbM/WHS28dVf8d+kEDmKPM
         n5veOTNj6ywY1qUv0UViTWIkwMNKRhwy8PS6eCK7Kq1mZyivYlf34EgEZA049hHRTuUm
         6DyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=zh+0zQGBLR7Nh+3PBhWXVdj8NW9l7auABjxWlkUEbLU=;
        b=r3dpGU6BmAYqbsz7ttdpiZEIj67t0W6LLaxcfjW7+TswEgGFqwrhDKOUlHd24WEsMW
         QMVwusabZy+QFciGycG8FPxdsPjZOOL0ziLeGR5awWKYF0jWwzC9AZJdKsJAuSI3YPgV
         DkeDH1GBe7Wq7J2AB6brN/XdQYO5FjASbvRbxFnTeIvR1v7w8PzulvRRWjtGaERi8Pf9
         uKHxP3hSXhJjfEcdWHpaklW2zgCcolHlEmhXrim55L0VXRbl5UiDO1yQwpUYVfWFKm8g
         iM5Fgn0zhf5Ut30QaVCvJsKdVwTPIkJ+rsZfdHvKqq91NAmEfSIHh3d/3sOd0u4aeblz
         4sOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mwej+VCC;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=mwej+VCC;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsEAyGW1sdX+uWYrKKT8IaUx+G0Nj9oeRN+cuhut7GugPuookO5I8r3360Rn+1SZF9IsqNi+g==
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
	Jia He <hejianet@gmail.com>
Subject: [PATCH v3 0/5] optimize memblock_next_valid_pfn and early_pfn_valid
Date: Sun, 25 Mar 2018 20:02:14 -0700
Message-Id: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967659920779416?=
X-GMAIL-MSGID: =?utf-8?q?1595967659920779416?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") tried to optimize the loop in memmap_init_zone(). But
there is still some room for improvement.

Patch 1 remain the memblock_next_valid_pfn when CONFIG_HAVE_ARCH_PFN_VALID
        is enabled
Patch 2 optimizes the memblock_next_valid_pfn()
Patch 3~5 optimizes the early_pfn_valid(), I have to split it into parts
        because the changes are located across subsystems.

I tested the pfn loop process in memmap_init(), the same as before.
As for the performance improvement, after this set, I can see the time
overhead of memmap_init() is reduced from 41313 us to 24345 us in my
armv8a server(QDF2400 with 96G memory).

Attached the memblock region information in my server.
[   86.956758] Zone ranges:
[   86.959452]   DMA      [mem 0x0000000000200000-0x00000000ffffffff]
[   86.966041]   Normal   [mem 0x0000000100000000-0x00000017ffffffff]
[   86.972631] Movable zone start for each node
[   86.977179] Early memory node ranges
[   86.980985]   node   0: [mem 0x0000000000200000-0x000000000021ffff]
[   86.987666]   node   0: [mem 0x0000000000820000-0x000000000307ffff]
[   86.994348]   node   0: [mem 0x0000000003080000-0x000000000308ffff]
[   87.001029]   node   0: [mem 0x0000000003090000-0x00000000031fffff]
[   87.007710]   node   0: [mem 0x0000000003200000-0x00000000033fffff]
[   87.014392]   node   0: [mem 0x0000000003410000-0x000000000563ffff]
[   87.021073]   node   0: [mem 0x0000000005640000-0x000000000567ffff]
[   87.027754]   node   0: [mem 0x0000000005680000-0x00000000056dffff]
[   87.034435]   node   0: [mem 0x00000000056e0000-0x00000000086fffff]
[   87.041117]   node   0: [mem 0x0000000008700000-0x000000000871ffff]
[   87.047798]   node   0: [mem 0x0000000008720000-0x000000000894ffff]
[   87.054479]   node   0: [mem 0x0000000008950000-0x0000000008baffff]
[   87.061161]   node   0: [mem 0x0000000008bb0000-0x0000000008bcffff]
[   87.067842]   node   0: [mem 0x0000000008bd0000-0x0000000008c4ffff]
[   87.074524]   node   0: [mem 0x0000000008c50000-0x0000000008e2ffff]
[   87.081205]   node   0: [mem 0x0000000008e30000-0x0000000008e4ffff]
[   87.087886]   node   0: [mem 0x0000000008e50000-0x0000000008fcffff]
[   87.094568]   node   0: [mem 0x0000000008fd0000-0x000000000910ffff]
[   87.101249]   node   0: [mem 0x0000000009110000-0x00000000092effff]
[   87.107930]   node   0: [mem 0x00000000092f0000-0x000000000930ffff]
[   87.114612]   node   0: [mem 0x0000000009310000-0x000000000963ffff]
[   87.121293]   node   0: [mem 0x0000000009640000-0x000000000e61ffff]
[   87.127975]   node   0: [mem 0x000000000e620000-0x000000000e64ffff]
[   87.134657]   node   0: [mem 0x000000000e650000-0x000000000fffffff]
[   87.141338]   node   0: [mem 0x0000000010800000-0x0000000017feffff]
[   87.148019]   node   0: [mem 0x000000001c000000-0x000000001c00ffff]
[   87.154701]   node   0: [mem 0x000000001c010000-0x000000001c7fffff]
[   87.161383]   node   0: [mem 0x000000001c810000-0x000000007efbffff]
[   87.168064]   node   0: [mem 0x000000007efc0000-0x000000007efdffff]
[   87.174746]   node   0: [mem 0x000000007efe0000-0x000000007efeffff]
[   87.181427]   node   0: [mem 0x000000007eff0000-0x000000007effffff]
[   87.188108]   node   0: [mem 0x000000007f000000-0x00000017ffffffff]
[   87.194791] Initmem setup node 0 [mem 0x0000000000200000-0x00000017ffffffff]

Without this patchset:
[  117.106153] Initmem setup node 0 [mem 0x0000000000200000-0x00000017ffffffff]
[  117.113677] before memmap_init
[  117.118195] after  memmap_init
>>> memmap_init takes 4518 us
[  117.121446] before memmap_init
[  117.154992] after  memmap_init
>>> memmap_init takes 33546 us
[  117.158241] before memmap_init
[  117.161490] after  memmap_init
>>> memmap_init takes 3249 us
>>> totally takes 41313 us

With this patchset:
[   87.194791] Initmem setup node 0 [mem 0x0000000000200000-0x00000017ffffffff]
[   87.202314] before memmap_init
[   87.206164] after  memmap_init
>>> memmap_init takes 3850 us
[   87.209416] before memmap_init
[   87.226662] after  memmap_init
>>> memmap_init takes 17246 us
[   87.229911] before memmap_init
[   87.233160] after  memmap_init
>>> memmap_init takes 3249 us
>>> totally takes 24345 us

Changelog:
V3: - fix 2 issues reported by kbuild test robot
V2: - rebase to mmotm latest
    - remain memblock_next_valid_pfn on arm64
    - refine memblock_search_pfn_regions and pfn_valid_region

Jia He (5):
  mm: page_alloc: remain memblock_next_valid_pfn() when
    CONFIG_HAVE_ARCH_PFN_VALID is enable
  mm: page_alloc: reduce unnecessary binary search in
    memblock_next_valid_pfn()
  mm/memblock: introduce memblock_search_pfn_regions()
  arm64: introduce pfn_valid_region()
  mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()

 arch/arm64/include/asm/page.h    |  3 ++-
 arch/arm64/mm/init.c             | 25 ++++++++++++++++++-
 arch/x86/include/asm/mmzone_32.h |  2 +-
 include/linux/memblock.h         |  6 +++++
 include/linux/mmzone.h           | 12 ++++++---
 mm/memblock.c                    | 53 ++++++++++++++++++++++++++++++++++++++++
 mm/page_alloc.c                  | 12 ++++++++-
 7 files changed, 106 insertions(+), 7 deletions(-)

-- 
2.7.4
