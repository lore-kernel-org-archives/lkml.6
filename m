Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AB8JxZqrL4cRvG/4TKAgY4eMioiUhgiVfgPD/g9fdVj4fU3VEHWCfL1YZ/ddTv4ZlP0aev4mqrHm
ARC-Seal: i=1; a=rsa-sha256; t=1524498478; cv=none;
        d=google.com; s=arc-20160816;
        b=hePi9+F3CzoUT3hbpNAzYTxiLTexYy7nOaxUsP86rm3MTDKlsRgZIH3JIAxt2t4GsE
         laiXuWe/OBqGONBg5xxCvtd0PyDOFTet1w5+6oosC1h8NEZi+ZFNNei1hA+P/+fNA0Zw
         NrmMEmqswODtJ6q0M5XUOsKVDCrFgN/v3oPVxu73FeqM9PCG6hhrAw+4vvg1SkDrYtWX
         l1GcNwKpeA5g/ki0dZBxtcb51tM12RcJRfaTzWsRaz67JroVA3LEGbm7NQUIINqRFAv1
         RZjwYH23W0g9bVBVuzzmb0VAo6xoN1H1JWdOFwS5QE5ATSwy3zz8tD6YPU5tyTx8JoO0
         vb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=yeJCtUDKHFYe91WUcNLRz3p3YGDITGPFwOm/v6LB79k=;
        b=CbbZJLz6gpBM+RR0qABkJNJCyDT5g9T0A8xjv5DWKXwi49yl3xw6A/wdAJQFH22sqt
         4ld+RJxXKlmgAS+YzuP9pMl510ueg4agqPH1Q2e+vbAAuvVTKrbbnWG5xP6xkf5ZjVu6
         eQSXWk9aRxUTYakB0sNIgf0N6xyRMI5eXRRNDPgbn68x+0rFv2oD6zQCJ8NvWKePj9qc
         7ScWwjXcCeySQqHbWMNAK7YyCrf7uSEv43jMaf1xsqFSD7qrLoEKYjMv/PQ+QDqSHwYF
         2BwpddOc6q8RHpw0tX7xfDRFOgURD4gAkGMHUgUpTtNnvNjr69w1JVUlaO4bNBf/5gXZ
         t4tA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=lsswCyC+;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=lsswCyC+;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
Subject: [PATCH 29/37] x86/mm/dump_pagetables: Define INIT_PGD
Date: Mon, 23 Apr 2018 17:47:32 +0200
Message-Id: <1524498460-25530-30-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552515832538200?=
X-GMAIL-MSGID: =?utf-8?q?1598552515832538200?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Define INIT_PGD to point to the correct initial page-table
for 32 and 64 bit and use it where needed. This fixes the
build on 32 bit with CONFIG_PAGE_TABLE_ISOLATION enabled.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/dump_pagetables.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index cc7ff59..23d24d1 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -111,6 +111,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	((pgd_t *) &init_top_pgt)
+
 #else /* CONFIG_X86_64 */
 
 enum address_markers_idx {
@@ -139,6 +141,8 @@ static struct addr_marker address_markers[] = {
 	[END_OF_SPACE_NR]	= { -1,			NULL }
 };
 
+#define INIT_PGD	(swapper_pg_dir)
+
 #endif /* !CONFIG_X86_64 */
 
 /* Multipliers for offsets within the PTEs */
@@ -496,11 +500,7 @@ static inline bool is_hypervisor_range(int idx)
 static void ptdump_walk_pgd_level_core(struct seq_file *m, pgd_t *pgd,
 				       bool checkwx, bool dmesg)
 {
-#ifdef CONFIG_X86_64
-	pgd_t *start = (pgd_t *) &init_top_pgt;
-#else
-	pgd_t *start = swapper_pg_dir;
-#endif
+	pgd_t *start = INIT_PGD;
 	pgprotval_t prot, eff;
 	int i;
 	struct pg_state st = {};
@@ -566,7 +566,7 @@ EXPORT_SYMBOL_GPL(ptdump_walk_pgd_level_debugfs);
 static void ptdump_walk_user_pgd_level_checkwx(void)
 {
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
-	pgd_t *pgd = (pgd_t *) &init_top_pgt;
+	pgd_t *pgd = INIT_PGD;
 
 	if (!static_cpu_has(X86_FEATURE_PTI))
 		return;
-- 
2.7.4
