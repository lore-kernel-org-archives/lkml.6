Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4/TcEJnHgKrXSjXgw4gHkQfPEVgc/ITzqKREHqZ3lxPvQJmwdgqzx59o6gaS4GhZ3PGrpO6
ARC-Seal: i=1; a=rsa-sha256; t=1523892347; cv=none;
        d=google.com; s=arc-20160816;
        b=iPDw7+pp509MoT4tYVGjHKq7yuBQF4ZDYmWBRrI0CCvHwLfYtPzvm2ld5PKbo25om1
         +ugg24P8UhdY0h/+JML+jOmlIohlKhsgdmF32N0GnPLfu91etEdY7c94LT0mhf8imbs8
         0AFTe9tuniIiyBXesstrk+OZ5li2nPLlnknW/WwSviur6YqGJe25BoD9bBbykV2OJ+6z
         VaBY3J6Ph0kUmFlF4g+E1ADQ9LOMmW8xziVzbYUvljyhw1TvW4IdvRoHly/qyRnP2yvJ
         ibFgU+aE8K11iK5Da7dYZBIbmPQsiPICe9kV32DhDMZ0pwlAwlPnGpD/DJ0XkX/EhYRm
         Yglw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=6dQOIlW3IjyIC9NEJ7gz1FwKgUM1vbUBR1JSU/HHuzw=;
        b=Q6KQWkzQcIcKJKXl+6ePTzoWewJCr7CfMefFdnJGjG29GIwoYZDqWyyphFWscqNSI8
         j2+L67cMyWZLaDceqYiudniBHFAGWXgpKME1jjR5/ixVoMP9LHlDm2Aa7dpA7V3xHlVY
         t4+F/ceRy9rlklwPGpihuz/M+7IncenaTn6SM7dncR71ET+lHtS2xAxwsaPyk7HNkNi3
         XTJkugwN74naGhuu9n/FlPqnxGSsBMFk3Obu+7z3w6aQrgGphxD61Lm79J3lIMkrVf6K
         Yz8lmX005sZITWKk3o2qKFsu3PkjutnZhHGAmnXYm+PLBmxqJTo/Yt941NWJTd4fZO+7
         gWUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=L1Xqtsvf;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=L1Xqtsvf;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 17/35] x86/pgtable/32: Allocate 8k page-tables when PTI is enabled
Date: Mon, 16 Apr 2018 17:25:05 +0200
Message-Id: <1523892323-14741-18-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916941616372730?=
X-GMAIL-MSGID: =?utf-8?q?1597916941616372730?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Allocate a kernel and a user page-table root when PTI is
enabled. Also allocate a full page per root for PAE because
otherwise the bit to flip in cr3 to switch between them
would be non-constant, which creates a lot of hassle.
Keep that for a later optimization.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kernel/head_32.S | 20 +++++++++++++++-----
 arch/x86/mm/pgtable.c     |  5 +++--
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index b59e4fb..12a3e8c 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -512,11 +512,18 @@ ENTRY(initial_code)
 ENTRY(setup_once_ref)
 	.long setup_once
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+#define	PGD_ALIGN	(2 * PAGE_SIZE)
+#define PTI_USER_PGD_FILL	1024
+#else
+#define	PGD_ALIGN	(PAGE_SIZE)
+#define PTI_USER_PGD_FILL	0
+#endif
 /*
  * BSS section
  */
 __PAGE_ALIGNED_BSS
-	.align PAGE_SIZE
+	.align PGD_ALIGN
 #ifdef CONFIG_X86_PAE
 .globl initial_pg_pmd
 initial_pg_pmd:
@@ -526,14 +533,17 @@ initial_pg_pmd:
 initial_page_table:
 	.fill 1024,4,0
 #endif
+	.align PGD_ALIGN
 initial_pg_fixmap:
 	.fill 1024,4,0
-.globl empty_zero_page
-empty_zero_page:
-	.fill 4096,1,0
 .globl swapper_pg_dir
+	.align PGD_ALIGN
 swapper_pg_dir:
 	.fill 1024,4,0
+	.fill PTI_USER_PGD_FILL,4,0
+.globl empty_zero_page
+empty_zero_page:
+	.fill 4096,1,0
 EXPORT_SYMBOL(empty_zero_page)
 
 /*
@@ -542,7 +552,7 @@ EXPORT_SYMBOL(empty_zero_page)
 #ifdef CONFIG_X86_PAE
 __PAGE_ALIGNED_DATA
 	/* Page-aligned for the benefit of paravirt? */
-	.align PAGE_SIZE
+	.align PGD_ALIGN
 ENTRY(initial_page_table)
 	.long	pa(initial_pg_pmd+PGD_IDENT_ATTR),0	/* low identity map */
 # if KPMDS == 3
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index ffc8c13..f4211d2 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -339,7 +339,8 @@ static inline pgd_t *_pgd_alloc(void)
 	 * We allocate one page for pgd.
 	 */
 	if (!SHARED_KERNEL_PMD)
-		return (pgd_t *)__get_free_page(PGALLOC_GFP);
+		return (pgd_t *)__get_free_pages(PGALLOC_GFP,
+						 PGD_ALLOCATION_ORDER);
 
 	/*
 	 * Now PAE kernel is not running as a Xen domain. We can allocate
@@ -351,7 +352,7 @@ static inline pgd_t *_pgd_alloc(void)
 static inline void _pgd_free(pgd_t *pgd)
 {
 	if (!SHARED_KERNEL_PMD)
-		free_page((unsigned long)pgd);
+		free_pages((unsigned long)pgd, PGD_ALLOCATION_ORDER);
 	else
 		kmem_cache_free(pgd_cache, pgd);
 }
-- 
2.7.4
