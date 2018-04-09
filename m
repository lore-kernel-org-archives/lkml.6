Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+J9hOGIYOu8V0q0XJv7f7QiB4ZhYB8ZOt/+afvJsrk566TFpTbRk2unPX6/7mDRmPKt28Z
ARC-Seal: i=1; a=rsa-sha256; t=1523294236; cv=none;
        d=google.com; s=arc-20160816;
        b=EE1rpZM1VbWENqhGULN+uvES5L7+JwmiRmrF78hRQcZm48MYtVvyRQyZHoexl0keR4
         liUlb5cCRB12vLz3lTuhBprsa6e/g3IUf1kcGinx8yS+ajoXq1FLNJvTj6bCd8/9BNdk
         sHXroYFkNM2ptA2s7RFvUvYWhIixT9hlVSTzHade2KKyffdCQK6DJpQIy5hsWrRUMsA7
         /xgccmXGuro5y/YMBsmIxheyX3AKIqJfF1didr8crL9MHS3VuZ3o5MEeHJtnR3GDYTLj
         hnVmgmzCv5NXzoNYLxlUi88+BrhDIKDbCkCrcgIIYJVIcxX0MqyqmfxeC2FSFU8c2sZW
         H9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=OArWgqfxvZYv9VKnxmLOwTPWeRrvPnsEb8bTt28NHoI=;
        b=NzeTlzPyk8N+i1bwmBykPd/kNr+70RA0wOxds+JYM6Al7AHILdm2VBOdwf27aG8lU4
         SeWVWXtme/DUUloFHqQhrjtPQGBygUPuRhG+ziWF8EMwuNx9ZqthtNL1R40cO2oBeg4B
         yplAyS97Htu32R6VGsD/Pk/eHM9wTlPbmDeqJg7YJ3TGi/Un/+fy9Bbgh097/dLwZ6Bk
         E7z3iEutgmhAGskISvCWXNkzojCgctw3wkvyA1kZrQk7rs5srufB+g56YPPRI9zmdf65
         fHJxGafrFu6TczSOG1I1ypeUdLbDhxF1nPS9S6IpbNppOU/cmuC3atwDTixAeemA5i+P
         KMfw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:16:33 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-0564258fb2cfe6876738665314445bf391f450e2@git.kernel.org>
Cc: torvalds@linux-foundation.org, hughd@google.com, arjan@linux.intel.com,
        luto@kernel.org, namit@vmware.com, aarcange@redhat.com,
        gregkh@linuxfoundation.org, bp@alien8.de, dwmw2@infradead.org,
        mingo@kernel.org, jgross@suse.com, keescook@google.com,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org, dan.j.williams@intel.com
Reply-To: aarcange@redhat.com, namit@vmware.com, gregkh@linuxfoundation.org,
        arjan@linux.intel.com, luto@kernel.org, torvalds@linux-foundation.org,
        hughd@google.com, jgross@suse.com, mingo@kernel.org,
        keescook@google.com, bp@alien8.de, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, tglx@linutronix.de,
        dan.j.williams@intel.com, peterz@infradead.org, hpa@zytor.com,
        dave.hansen@linux.intel.com
In-Reply-To: <20180406205518.E3D989EB@viggo.jf.intel.com>
References: <20180406205518.E3D989EB@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Leave kernel text global for !PCID
Git-Commit-ID: 0564258fb2cfe6876738665314445bf391f450e2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289777108065729?=
X-GMAIL-MSGID: =?utf-8?q?1597289777108065729?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  0564258fb2cfe6876738665314445bf391f450e2
Gitweb:     https://git.kernel.org/tip/0564258fb2cfe6876738665314445bf391f450e2
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:18 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:34 +0200

x86/pti: Leave kernel text global for !PCID

Global pages are bad for hardening because they potentially let an
exploit read the kernel image via a Meltdown-style attack which
makes it easier to find gadgets.

But, global pages are good for performance because they reduce TLB
misses when making user/kernel transitions, especially when PCIDs
are not available, such as on older hardware, or where a hypervisor
has disabled them for some reason.

This patch implements a basic, sane policy: If you have PCIDs, you
only map a minimal amount of kernel text global.  If you do not have
PCIDs, you map all kernel text global.

This policy effectively makes PCIDs something that not only adds
performance but a little bit of hardening as well.

I ran a simple "lseek" microbenchmark[1] to test the benefit on
a modern Atom microserver.  Most of the benefit comes from applying
the series before this patch ("entry only"), but there is still a
signifiant benefit from this patch.

  No Global Lines (baseline  ): 6077741 lseeks/sec
  88 Global Lines (entry only): 7528609 lseeks/sec (+23.9%)
  94 Global Lines (this patch): 8433111 lseeks/sec (+38.8%)

[1.] https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205518.E3D989EB@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/include/asm/pti.h |  2 ++
 arch/x86/mm/init_64.c      |  6 ++++
 arch/x86/mm/pti.c          | 78 +++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 0b5ef05b2d2d..38a17f1d5c9d 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -6,8 +6,10 @@
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
+extern void pti_clone_kernel_text(void);
 #else
 static inline void pti_check_boottime_disable(void) { }
+static inline void pti_clone_kernel_text(void) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index e6c52dbbf649..6d1ff39c2438 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1290,6 +1290,12 @@ void mark_rodata_ro(void)
 			(unsigned long) __va(__pa_symbol(_sdata)));
 
 	debug_checkwx();
+
+	/*
+	 * Do this after all of the manipulation of the
+	 * kernel text page tables are complete.
+	 */
+	pti_clone_kernel_text();
 }
 
 int kern_addr_valid(unsigned long addr)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 1470b173963f..f1fd52f449e0 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -66,12 +66,22 @@ static void __init pti_print_if_secure(const char *reason)
 		pr_info("%s\n", reason);
 }
 
+enum pti_mode {
+	PTI_AUTO = 0,
+	PTI_FORCE_OFF,
+	PTI_FORCE_ON
+} pti_mode;
+
 void __init pti_check_boottime_disable(void)
 {
 	char arg[5];
 	int ret;
 
+	/* Assume mode is auto unless overridden. */
+	pti_mode = PTI_AUTO;
+
 	if (hypervisor_is_type(X86_HYPER_XEN_PV)) {
+		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on XEN PV.");
 		return;
 	}
@@ -79,18 +89,23 @@ void __init pti_check_boottime_disable(void)
 	ret = cmdline_find_option(boot_command_line, "pti", arg, sizeof(arg));
 	if (ret > 0)  {
 		if (ret == 3 && !strncmp(arg, "off", 3)) {
+			pti_mode = PTI_FORCE_OFF;
 			pti_print_if_insecure("disabled on command line.");
 			return;
 		}
 		if (ret == 2 && !strncmp(arg, "on", 2)) {
+			pti_mode = PTI_FORCE_ON;
 			pti_print_if_secure("force enabled on command line.");
 			goto enable;
 		}
-		if (ret == 4 && !strncmp(arg, "auto", 4))
+		if (ret == 4 && !strncmp(arg, "auto", 4)) {
+			pti_mode = PTI_AUTO;
 			goto autosel;
+		}
 	}
 
 	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
 	}
@@ -149,7 +164,7 @@ pgd_t __pti_set_user_pgd(pgd_t *pgdp, pgd_t pgd)
  *
  * Returns a pointer to a P4D on success, or NULL on failure.
  */
-static __init p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
+static p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
 {
 	pgd_t *pgd = kernel_to_user_pgdp(pgd_offset_k(address));
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
@@ -177,7 +192,7 @@ static __init p4d_t *pti_user_pagetable_walk_p4d(unsigned long address)
  *
  * Returns a pointer to a PMD on success, or NULL on failure.
  */
-static __init pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
+static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 {
 	gfp_t gfp = (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
 	p4d_t *p4d = pti_user_pagetable_walk_p4d(address);
@@ -267,7 +282,7 @@ static void __init pti_setup_vsyscall(void)
 static void __init pti_setup_vsyscall(void) { }
 #endif
 
-static void __init
+static void
 pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 {
 	unsigned long addr;
@@ -372,6 +387,58 @@ static void __init pti_clone_entry_text(void)
 		       _PAGE_RW);
 }
 
+/*
+ * Global pages and PCIDs are both ways to make kernel TLB entries
+ * live longer, reduce TLB misses and improve kernel performance.
+ * But, leaving all kernel text Global makes it potentially accessible
+ * to Meltdown-style attacks which make it trivial to find gadgets or
+ * defeat KASLR.
+ *
+ * Only use global pages when it is really worth it.
+ */
+static inline bool pti_kernel_image_global_ok(void)
+{
+	/*
+	 * Systems with PCIDs get litlle benefit from global
+	 * kernel text and are not worth the downsides.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_PCID))
+		return false;
+
+	/*
+	 * Only do global kernel image for pti=auto.  Do the most
+	 * secure thing (not global) if pti=on specified.
+	 */
+	if (pti_mode != PTI_AUTO)
+		return false;
+
+	/*
+	 * K8 may not tolerate the cleared _PAGE_RW on the userspace
+	 * global kernel image pages.  Do the safe thing (disable
+	 * global kernel image).  This is unlikely to ever be
+	 * noticed because PTI is disabled by default on AMD CPUs.
+	 */
+	if (boot_cpu_has(X86_FEATURE_K8))
+		return false;
+
+	return true;
+}
+
+/*
+ * For some configurations, map all of kernel text into the user page
+ * tables.  This reduces TLB misses, especially on non-PCID systems.
+ */
+void pti_clone_kernel_text(void)
+{
+	unsigned long start = PFN_ALIGN(_text);
+	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
+
+	if (!pti_kernel_image_global_ok())
+		return;
+
+	pti_clone_pmds(start, end, _PAGE_RW);
+}
+
 /*
  * This is the only user for it and it is not arch-generic like
  * the other set_memory.h functions.  Just extern it.
@@ -388,6 +455,9 @@ void pti_set_kernel_image_nonglobal(void)
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long end = ALIGN((unsigned long)_end, PMD_PAGE_SIZE);
 
+	if (pti_kernel_image_global_ok())
+		return;
+
 	pr_debug("set kernel image non-global\n");
 
 	set_memory_nonglobal(start, (end - start) >> PAGE_SHIFT);
