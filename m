Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521619868; cv=none;
        d=google.com; s=arc-20160816;
        b=jy7j4h5TV+GmbC07+IgKqPfxUZPrMMrWdTDm5jlaxQbAML1JcDqeGQ2CsTBTdbDkEV
         21sd6fo3GFyE2/zNtUYtbkIorhDVk9OxqXm+zCEaAuIL60FzLOC8P88Y1JHEw2O3xY2s
         KUL5ltNkyv+MY2Q1bbkoLGEDXQxJ3g7jv/kyyROsQXxBjxIfsuOIgOfcKYDlAG30a6PA
         Ff6k5ttGEg/Xu5pjAR8hrqjOTIFk9xlo4F55cP0YwUVv7GYgOZDXbbzTlU1Ehb+6zSYs
         O5Xfq/Q+iIfK1i4Qcoybp2QyK2JOoeF2cvigmcMJYXrTPjQ1CJKknEPEALldGLKiTGx3
         ANfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=IllwNGbVSEyW44Dcu7drhaaIK6QU55n9PaAMLuzoo2Q=;
        b=RojySNEhedIKGrGwIXE+wwpNLsR2FIYt7lEv6s1MDjne7PpfjZrRk/cfKIEj68z2gp
         9J+DtRon5aA52WzfAqxI6OSXtt8ikcFF3klFMQG3WE6NORG7ErX+8D/59IJF+G3O1Lzf
         H+iWuIhsmJeMF5zxi3q553Z2hVQwZgMfRwkhJW8kPnANyJQyXjAbvXjcW1OOl/SdNZh1
         mPL1P+/woGCaH9BbB8ki/nVnyP5g7tcjFmqsGuRyaGRSI/xh1gpPm4i8EM8ZZVKYKrJ7
         sDLRi7aQzQKEeMsyF7X+0LLo/2auVlcd3p4Pz1i6QAKiBCAniFhYYdlpnUCXsxq2sHg6
         j3+g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VH7QcpI4;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VH7QcpI4;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELulvnEbKXQGHn1iWeV9TFntzmhmsRpCa/RsbCChSiSVWlGqQsgw8WcM7STrHfEKb2gN0z9LDg==
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
Subject: [PATCH 4/4] mm: page_alloc: reduce unnecessary binary search in early_pfn_valid()
Date: Wed, 21 Mar 2018 01:09:56 -0700
Message-Id: <1521619796-3846-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534075911740492?=
X-GMAIL-MSGID: =?utf-8?q?1595534075911740492?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") optimized the loop in memmap_init_zone(). But there is
still some room for improvement. E.g. in early_pfn_valid(), we can record
the last returned memblock region index and check check pfn++ is still in
the same region.

Currently it only improves the performance on arm64 and has no impact on
other arches.

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
index f28c62c..215dc92 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5481,7 +5481,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context != MEMMAP_EARLY)
 			goto not_early;
 
-		if (!early_pfn_valid(pfn)) {
+		if (!early_pfn_valid(pfn, &idx)) {
 #ifdef CONFIG_HAVE_MEMBLOCK
 			/*
 			 * Skip to the pfn preceding the next valid one (or
-- 
2.7.4
