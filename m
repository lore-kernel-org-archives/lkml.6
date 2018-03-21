Return-Path: <hejianet@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521619856; cv=none;
        d=google.com; s=arc-20160816;
        b=ZSQLiM3hU0rfdP5NeGt5e4lo7Hw1ZZQS3iqgM5hdpHaDPazlSmS5aOtR6iaM2RW8sC
         sNeb4VGH+j2CiFPVBTf4jwzfSqYPky7gGL6Zt/qk3I1Vq3AIDSXK/gO7MTEXR7lbAUwz
         4DKTI6nHCXyXNWUphnrbdkdVgDBRjYu8LxCyPJN5G1daNE9qlRc23ql3CVMAV31wZLBa
         8ZIPaX/MqUgkzUZE2L4nSou3XAYTwJKkmwPmmPO4kkKtndrYX7MmRHi953ELvkS7B/Xi
         +q364H6MsrkRC7Tqkts+LDpd6ry7BMbuX4jMPwcMoZNYHvzMcs3lryTSfRqyS1a63FWA
         KcaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RABvO65frYI8v2NwjIigZ+5RwFAonwVr7w9ovXuZHJA=;
        b=gel82xBCe0nYs1Pr0nS+L6GIyGFQsxWR8nDV3GKWthnG7ORSaHrWGQVoSYRMR6lvkk
         fKI2gtkmjnxe+0Ri44FygXRBhp+a4AqR2mBq0Fa44TTVnt78kWHAPwkv2eP/M9s6XcYv
         dyHlg7iwbv4/Jg+lukOBJDVVh94fjZKDIhMx1XnYvkOnKlJzXr1AX9igiaPPafi4pg68
         ++3G/c40OyySXGngDbJgHi3BrBi5k6ZtJYBZm2XX/I5MJGSYLlVEZW5ZMP2c+x/b73Sn
         i/629MX4ylwgKzKZfB1uB2FwIlG7ss5IARaq2OZDmIAVuwwYY7GWVerQaZ6RtfT5aOkn
         hNNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hR3gniP3;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hR3gniP3;
       spf=pass (google.com: domain of hejianet@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=hejianet@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELs9nWrCPrIAgj9ROK6T84t6hMj1hs0pw5jaxYJZVI2VSb2B9jMGPHDpn93sXL1ZimAoohPZxA==
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
Subject: [PATCH 3/4] arm64: introduce pfn_valid_region()
Date: Wed, 21 Mar 2018 01:09:55 -0700
Message-Id: <1521619796-3846-4-git-send-email-hejianet@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
References: <1521619796-3846-1-git-send-email-hejianet@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595534062221218011?=
X-GMAIL-MSGID: =?utf-8?q?1595534062221218011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the preparation for further optimizing in early_pfn_valid
on arm64.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 arch/arm64/include/asm/page.h |  3 ++-
 arch/arm64/mm/init.c          | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

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
index 00e7b90..1d9842e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -290,7 +290,24 @@ int pfn_valid(unsigned long pfn)
 	return memblock_is_map_memory(pfn << PAGE_SHIFT);
 }
 EXPORT_SYMBOL(pfn_valid);
-#endif
+
+int pfn_valid_region(unsigned long pfn, int *last_idx)
+{
+	struct memblock_type *type = &memblock.memory;
+
+	if (*last_idx != -1 && pfn < PFN_DOWN(type->regions[*last_idx].base
+					+ type->regions[*last_idx].size))
+		return !memblock_is_nomap(&memblock.memory.regions[*last_idx]);
+
+	*last_idx = memblock_search_pfn_regions(pfn);
+
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
