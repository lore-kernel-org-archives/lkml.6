Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD25ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D47E20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D47E20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGTAUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:20:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49987 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGTAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:20:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNXmPj2454168
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:33:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNXm5V2454165;
        Thu, 19 Jul 2018 16:33:48 -0700
Date:   Thu, 19 Jul 2018 16:33:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-b976690f5db26fbc7c2be413bfa0fbd270547a94@git.kernel.org>
Cc:     torvalds@linux-foundation.org, dave.hansen@intel.com,
        llong@redhat.com, tglx@linutronix.de, brgerst@gmail.com,
        jgross@suse.com, peterz@infradead.org, pavel@ucw.cz,
        mingo@kernel.org, jpoimboe@redhat.com, boris.ostrovsky@oracle.com,
        luto@kernel.org, will.deacon@arm.com, dhgutteridge@sympatico.ca,
        jroedel@suse.de, aarcange@redhat.com, eduval@amazon.com,
        jkosina@suse.cz, gregkh@linuxfoundation.org, hpa@zytor.com,
        David.Laight@aculab.com, dvlasenk@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org
Reply-To: boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
          mingo@kernel.org, luto@kernel.org, will.deacon@arm.com,
          dhgutteridge@sympatico.ca, eduval@amazon.com, jroedel@suse.de,
          aarcange@redhat.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, llong@redhat.com, dave.hansen@intel.com,
          brgerst@gmail.com, pavel@ucw.cz, peterz@infradead.org,
          jgross@suse.com, dvlasenk@redhat.com, bp@alien8.de,
          linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
          jkosina@suse.cz, hpa@zytor.com, David.Laight@aculab.com
In-Reply-To: <1531906876-13451-30-git-send-email-joro@8bytes.org>
References: <1531906876-13451-30-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Introduce pti_finalize()
Git-Commit-ID: b976690f5db26fbc7c2be413bfa0fbd270547a94
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  b976690f5db26fbc7c2be413bfa0fbd270547a94
Gitweb:     https://git.kernel.org/tip/b976690f5db26fbc7c2be413bfa0fbd270547a94
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:45 +0200

x86/mm/pti: Introduce pti_finalize()

Introduce a new function to finalize the kernel mappings for the userspace
page-table after all ro/nx protections have been applied to the kernel
mappings.

Also move the call to pti_clone_kernel_text() to that function so that it
will run on 32 bit kernels too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Pavel Machek <pavel@ucw.cz>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: linux-mm@kvack.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Laight <David.Laight@aculab.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aliguori@amazon.com
Cc: daniel.gruss@iaik.tugraz.at
Cc: hughd@google.com
Cc: keescook@google.com
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Waiman Long <llong@redhat.com>
Cc: "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Cc: joro@8bytes.org
Link: https://lkml.kernel.org/r/1531906876-13451-30-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/pti.h |  3 +--
 arch/x86/mm/init_64.c      |  6 ------
 arch/x86/mm/pti.c          | 14 +++++++++++++-
 include/linux/pti.h        |  1 +
 init/main.c                |  7 +++++++
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 38a17f1d5c9d..5df09a0b80b8 100644
--- a/arch/x86/include/asm/pti.h
+++ b/arch/x86/include/asm/pti.h
@@ -6,10 +6,9 @@
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 extern void pti_init(void);
 extern void pti_check_boottime_disable(void);
-extern void pti_clone_kernel_text(void);
+extern void pti_finalize(void);
 #else
 static inline void pti_check_boottime_disable(void) { }
-static inline void pti_clone_kernel_text(void) { }
 #endif
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index a688617c727e..9b19f9a8948e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1291,12 +1291,6 @@ void mark_rodata_ro(void)
 			(unsigned long) __va(__pa_symbol(_sdata)));
 
 	debug_checkwx();
-
-	/*
-	 * Do this after all of the manipulation of the
-	 * kernel text page tables are complete.
-	 */
-	pti_clone_kernel_text();
 }
 
 int kern_addr_valid(unsigned long addr)
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index e41ee93c430d..fcfb815d420f 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -462,7 +462,7 @@ static inline bool pti_kernel_image_global_ok(void)
  * For some configurations, map all of kernel text into the user page
  * tables.  This reduces TLB misses, especially on non-PCID systems.
  */
-void pti_clone_kernel_text(void)
+static void pti_clone_kernel_text(void)
 {
 	/*
 	 * rodata is part of the kernel image and is normally
@@ -526,3 +526,15 @@ void __init pti_init(void)
 	pti_setup_espfix64();
 	pti_setup_vsyscall();
 }
+
+/*
+ * Finalize the kernel mappings in the userspace page-table.
+ */
+void pti_finalize(void)
+{
+	/*
+	 * Do this after all of the manipulation of the
+	 * kernel text page tables are complete.
+	 */
+	pti_clone_kernel_text();
+}
diff --git a/include/linux/pti.h b/include/linux/pti.h
index 0174883a935a..1a941efcaa62 100644
--- a/include/linux/pti.h
+++ b/include/linux/pti.h
@@ -6,6 +6,7 @@
 #include <asm/pti.h>
 #else
 static inline void pti_init(void) { }
+static inline void pti_finalize(void) { }
 #endif
 
 #endif
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..fcfef46c935a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1065,6 +1065,13 @@ static int __ref kernel_init(void *unused)
 	jump_label_invalidate_initmem();
 	free_initmem();
 	mark_readonly();
+
+	/*
+	 * Kernel mappings are now finalized - update the userspace page-table
+	 * to finalize PTI.
+	 */
+	pti_finalize();
+
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
