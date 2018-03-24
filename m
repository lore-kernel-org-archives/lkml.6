Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521894370; cv=none;
        d=google.com; s=arc-20160816;
        b=KfAxMR6zNtLXSpQtXVXf2L6kYStfo4C9aFxU641Tww6NfwAcKmYYLOnnsn1/9bqB9a
         UUqXd2hZVB0loKD0HqGAVR/02kTOc0v4a0oeYqHwSSRpv8GvYrOsJOF7j8f2OIhcJlbf
         GfoAWruTx9l1r/7fgzNdFodNdJsmr93xA4CInADvp//TUxpQYZlvQUJH+AH3iGSw5o3s
         edHmoMxypNOR5WzlW0Pyf20CSs5TvfwH/CM+sPdtEK12iuFH2unxb0mmvQ5uiMy2VH2W
         fLWEv0T7XRZnezgbE0xrZlOS5QJViJTLSDqqIgRRNkytZP9dfQzJa2Z8Cev9WrUiWtL/
         7HxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=ID/HHnJy8Od0sv4ugrwey4ueEG+z0zzevhay9oki3bU=;
        b=j8NEUwW6oaJTKFgWO1o0CaE6NMwPd+JEmdN3AWtUYqbwHPvFmiKq08AsYmqIAOkztr
         PAcJA31ipUMlz7zGTab/y0Q11dQYuM1oaOC9zZwslisxa8EkmKI2zYh/IJNLs+YYNFIY
         7Jzy50o2Xrtzma+Np3CMWlUgwF1HSKEqa81Ir4La2P4rFyGS2Z6klXeMyit2KmH1WP+6
         7UdqUB+zmaZn1HmRRUGBuFOi3PYUxm99g0gVCY4CEyqxSDLaoM7kCJeRDBjRoM5QBaE1
         /l0EpyiS24/HRWDGSujMh1acogKc1GI2k3of+rPqF1ErB52PvmaadnN9DpEpchYZD9Cg
         ncOw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jn4V0Stb;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Jn4V0Stb;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48ha87D3uPiHj5wuavgGAcPdbZVjTZ65ovT6v2Se2Apk1IP7hCAkjQrJxPkclLlu9d8bjNuhQ==
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
Subject: [PATCH v2 5/5] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date: Sat, 24 Mar 2018 05:24:42 -0700
Message-Id: <1521894282-6454-6-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
References: <1521894282-6454-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595821910974305677?=
X-GMAIL-MSGID: =?utf-8?q?1595821910974305677?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), if pfn and
pfn+1 are in the same memblock region, we can record the last returned
memblock region index and check if pfn++ is still in the same region.

Currently it only improve the performance on arm64 and will have no
impact on other arches.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/x86/include/asm/mmzone_32.h |  2 +-
 include/linux/mmzone.h           | 12 +++++++++---
 mm/page_alloc.c                  |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mmzone_32.h b/arch/x86/include/asm/mmzone_32.h
index 73d8dd1..329d3ba 100644
--- a/arch/x86/include/asm/mmzone_32.h
+++ b/arch/x86/include/asm/mmzone_32.h
@@ -49,7 +49,7 @@ static inline int pfn_valid(int pfn)
 	return 0;
 }
 
-#define early_pfn_valid(pfn)	pfn_valid((pfn))
+#define early_pfn_valid(pfn, last_region_idx)	pfn_valid((pfn))
 
 #endif /* CONFIG_DISCONTIGMEM */
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index d797716..3a686af 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1267,9 +1267,15 @@ static inline int pfn_present(unsigned long pfn)
 })
 #else
 #define pfn_to_nid(pfn)		(0)
-#endif
+#endif /*CONFIG_NUMA*/
+
+#ifdef CONFIG_HAVE_ARCH_PFN_VALID
+#define early_pfn_valid(pfn, last_region_idx) \
+				pfn_valid_region(pfn, last_region_idx)
+#else
+#define early_pfn_valid(pfn, last_region_idx)	pfn_valid(pfn)
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
 
-#define early_pfn_valid(pfn)	pfn_valid(pfn)
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
@@ -1288,7 +1294,7 @@ struct mminit_pfnnid_cache {
 };
 
 #ifndef early_pfn_valid
-#define early_pfn_valid(pfn)	(1)
+#define early_pfn_valid(pfn, last_region_idx)	(1)
 #endif
 
 void memory_present(int nid, unsigned long start, unsigned long end);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0bb0274..68aef71 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5484,8 +5484,8 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn)) {
 #if (defined CONFIG_HAVE_MEMBLOCK) && (defined CONFIG_HAVE_ARCH_PFN_VALID)
+		if (!early_pfn_valid(pfn, &idx)) {
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-- 
2.7.4
