Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522033418; cv=none;
        d=google.com; s=arc-20160816;
        b=wC5eLTS0q53uBwOIIp/BMtFUMHZR+6AKzkscPoRLYTAdUNuieQtQzzl35Gl+mi93A2
         ebaEdEgReADTVnWQ2v2dlXPPHDPWjgv7UBdY8v0c0bi2JV++iletWnwVQsuHKcrcJmyq
         scThTFJSPMeNBc29hEAARYRnw6vjZy7FCxS7gusg6L9/Psl3P0PDz1K02ud0qccDNxpQ
         EFuvJyKUI+A9gnXs7F6xidBPXm8D9PsZ6buRBcp3W/yUhEeg29D93H4M2ttOsqK8Xjnk
         e8ZOCBrOFbPWygF/dV2BPbuzxE0f9DY1gu5hiir843ddanEWDme3ENgBAPEp9UrfPHzD
         N/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=CgVDV6TnbNT0G6IPq/hrv4xR6TOYvoiXvBonAgQwMio=;
        b=IINXZNX1GRJkFtiEylNGFcJPNqviMXaGYPmxeBTihE8Br2P9tWP/pz04X9+HIEdG0A
         L+dYNlTNj7xeL+ouNkmuJf71Ksd/zLuKhCSL4wHYaNa6DFnG+bUnIrjmqS/aera5ut+7
         fzEj99uM9B+WsgcnVAmebHe1CCJQdoUlvRa6Kx3mmiqDRBuVwzlOc90mvaHUIu7tirxY
         tGrmO3UwJ+KLJmiLpBfsxleEPR6FYKrSUMLpOPURIHguKS1pUIrYWz1xRvgdT/wy2yvp
         3yy76JzVFR0hONMrAIjdEy4YKCN4YnEe3RVIuWQ5rADNJcc9weI7KPbu6hgMK97CrGKN
         YHyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ievLv0Uf;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ievLv0Uf;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELumu+HtlaqnLKaOfuAL2ImNiTcLQpPzOY1XjmjnO+jVr/LPbbm9yEJGk4YQK1fBsahwMxLmDw==
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
Subject: [PATCH v3 4/5] arm64: introduce pfn_valid_region()
Date: Sun, 25 Mar 2018 20:02:18 -0700
Message-Id: <1522033340-6575-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
References: <1522033340-6575-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595967713881202535?=
X-GMAIL-MSGID: =?utf-8?q?1595967713881202535?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the preparation for further optimizing in early_pfn_valid
on arm64.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm64/include/asm/page.h |  3 ++-
 arch/arm64/mm/init.c          | 25 ++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 60d02c8..da2cba3 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -38,7 +38,8 @@ extern void clear_page(void *to);
 typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
-extern int pfn_valid(unsigned long);
+extern int pfn_valid(unsigned long pfn);
+extern int pfn_valid_region(unsigned long pfn, int *last_idx);
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 00e7b90..06433d5 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -290,7 +290,30 @@ int pfn_valid(unsigned long pfn)
 	return memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
-#endif
+
+int pfn_valid_region(unsigned long pfn, int *last_idx)
+{
+	unsigned long start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+
+	if (*last_idx != -1) {
+		start_pfn = PFN_DOWN(type->regions[*last_idx].base);
+		end_pfn= PFN_DOWN(type->regions[*last_idx].base +
+					type->regions[*last_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(
+				&memblock.memory.regions[*last_idx]);
+	}
+
+	*last_idx = memblock_search_pfn_regions(pfn);
+	if (*last_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&memblock.memory.regions[*last_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
+#endif /*CONFIG_HAVE_ARCH_PFN_VALID*/
 
 #ifndef CONFIG_SPARSEMEM
 static void __init arm64_memory_present(void)
-- 
2.7.4
