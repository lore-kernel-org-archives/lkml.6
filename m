Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522397836; cv=none;
        d=google.com; s=arc-20160816;
        b=AKrfj26TAV0fMaGLL9qg1VdmjRGw9x1OOaM9RVTkwVLIECFJJ+L7/chGXfQ1kgEx5s
         BYpWYoPYGKfamdIl7b0z2K76InyFErcUuZt3y6U+ey9Dinj38hvl2mNMA9PZYwf++nex
         u+twltWAlzUogo0+XfuwO0L3ZDTQ3qcioILd7mguWXQq1Z1qta08tU8RXUPSXG+i/5PI
         Uk3JfEw8/A092xxkoD3K007CFqLT2X//eDHfE0nxZsT/9jRcAm2NDGv/PfJxJ3IWZJ6Z
         D6jzWrlo5gW8H7/BZMuerB5rbcFLzmRtvtI9Ev3sLnQzPoYeCCXUPabWnEMb/ZryTPKO
         mR4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=+sMsi/H8lVfVBGinev4JqDbIw6xiqVkQl34aLu2Ouvo=;
        b=lzrkgcxukI5hYK60QCNDdBphWraqGIMC/VoT3JC8+i+9jWZqWAbUrRIVLddfTajZNG
         otvsc+ImeXk/xEuRehslhYABYVa6v8Oyw6gs125ZhynPW9cxDnsoKUtE6TA7yfjFdCSG
         kCPKO6SQE0WHqDkU3yUvWvrqL7TSs3kkbc9xwSsKJcQBanOXbNJrBIKaSS4cMSf8hyUc
         TnsbMJfkj49m1KWuRsfQDWmtje/3q1JCf7tf9Wsbaz5TKV6CR05nkCL5AvxvfAEZBob6
         Wfy7n/EVVWNm1tmNcXlMXakAaHsZYFIdlyJEnhPKaF5IpZ8UCaYyUKnCWm61d8RW6qMM
         PIZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EaStRcMi;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EaStRcMi;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+v+c5aTjwxahxvewqT0XyTEla20KKT2zCl8fzXOOiENEYGxkaQci3kcUkPuevLoM0Tkmlmcg==
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
Subject: [PATCH v4 4/5] arm64: introduce pfn_valid_region()
Date: Fri, 30 Mar 2018 01:15:54 -0700
Message-Id: <1522397755-33393-5-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
References: <1522397755-33393-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596349833759050421?=
X-GMAIL-MSGID: =?utf-8?q?1596349833759050421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the preparation for further optimizing in early_pfn_valid
on arm and arm64.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm/include/asm/page.h   |  3 ++-
 arch/arm/mm/init.c            | 23 +++++++++++++++++++++++
 arch/arm64/include/asm/page.h |  3 ++-
 arch/arm64/mm/init.c          | 23 +++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/page.h b/arch/arm/include/asm/page.h
index 7a0404f..559b414 100644
--- a/arch/arm/include/asm/page.h
+++ b/arch/arm/include/asm/page.h
@@ -158,7 +158,8 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int early_region_idx;
-extern int pfn_valid(unsigned long);
+extern int pfn_valid(unsigned long pfn);
+extern int pfn_valid_region(unsigned long pfn, int *last_idx);
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7779804..11f9b82 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -201,6 +201,29 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
 
+int pfn_valid_region(unsigned long pfn, int *last_idx)
+{
+	unsigned long start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
+
+	if (*last_idx != -1) {
+		start_pfn = PFN_DOWN(regions[*last_idx].base);
+		end_pfn = PFN_DOWN(regions[*last_idx].base +
+					regions[*last_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(&regions[*last_idx]);
+	}
+
+	*last_idx = memblock_search_pfn_regions(pfn);
+	if (*last_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&regions[*last_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
+
 /* HAVE_MEMBLOCK is always enabled on arm */
 unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 							int *last_idx)
diff --git a/arch/arm64/include/asm/page.h b/arch/arm64/include/asm/page.h
index 84b503a..27892d5 100644
--- a/arch/arm64/include/asm/page.h
+++ b/arch/arm64/include/asm/page.h
@@ -39,7 +39,8 @@ typedef struct page *pgtable_t;
 
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 extern int early_region_idx;
-extern int pfn_valid(unsigned long);
+extern int pfn_valid(unsigned long pfn);
+extern int pfn_valid_region(unsigned long pfn, int *last_idx);
 #endif
 
 #include <asm/memory.h>
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index cd9b473..6dedd77 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -293,6 +293,29 @@ int pfn_valid(unsigned long pfn)
 }
 EXPORT_SYMBOL(pfn_valid);
 
+int pfn_valid_region(unsigned long pfn, int *last_idx)
+{
+	unsigned long start_pfn, end_pfn;
+	struct memblock_type *type = &memblock.memory;
+	struct memblock_region *regions = type->regions;
+
+	if (*last_idx != -1) {
+		start_pfn = PFN_DOWN(regions[*last_idx].base);
+		end_pfn = PFN_DOWN(regions[*last_idx].base +
+				regions[*last_idx].size);
+
+		if (pfn >= start_pfn && pfn < end_pfn)
+			return !memblock_is_nomap(&regions[*last_idx]);
+	}
+
+	*last_idx = memblock_search_pfn_regions(pfn);
+	if (*last_idx == -1)
+		return false;
+
+	return !memblock_is_nomap(&regions[*last_idx]);
+}
+EXPORT_SYMBOL(pfn_valid_region);
+
 /* HAVE_MEMBLOCK is always enabled on arm64 */
 unsigned long __init_memblock memblock_next_valid_pfn(unsigned long pfn,
 							int *last_idx)
-- 
2.7.4
