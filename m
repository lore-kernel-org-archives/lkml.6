Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039AFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F28208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 11:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Gcz9K5kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F28208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbeGKLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 07:35:02 -0400
Received: from 8bytes.org ([81.169.241.247]:37802 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733028AbeGKLeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 07:34:13 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 61F681A0E; Wed, 11 Jul 2018 13:30:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531308607; bh=w6IEnwiFb5igPoQcBU4Vm3UbctYunXcFUtJ3fSOqaF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gcz9K5kGh32sGspT/+8WCbrNJfL+D6XpwFrJe4o21jggLaMr/tN/wijxLoRy9trIB
         34VTXu2ntqsYBIOWxovduwLigB1vyR1PwHq2R2dpoSaIWSVfo036ACo6lxg0suQ1Ps
         zx1r9R8B6KH06LDWsB6shoGvd+OXGdBtgWPep8ftxlokZZa+Cnie492teLwQGOaeHl
         l9pdJ75QbFcQQYKH0l4PwUbXKwBvqMnp7B1UDX5RGHaGVnTOTOPrzeMgMqMAQpfz/E
         MjCT8LeO1LD8p3edHOfOtxCOo/FnCLq7qkV/fPT9R6hQedtQE7IvVObMoCJWz+Zugi
         PNrYel4nopmcQ==
From:   Joerg Roedel <joro@8bytes.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        jroedel@suse.de, joro@8bytes.org
Subject: [PATCH 29/39] x86/mm/pti: Introduce pti_finalize()
Date:   Wed, 11 Jul 2018 13:29:36 +0200
Message-Id: <1531308586-29340-30-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531308586-29340-1-git-send-email-joro@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Introduce a new function to finalize the kernel mappings for
the userspace page-table after all ro/nx protections have been
applied to the kernel mappings.

Also move the call to pti_clone_kernel_text() to that
function so that it will run on 32 bit kernels too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pti.h |  3 +--
 arch/x86/mm/init_64.c      |  6 ------
 arch/x86/mm/pti.c          | 14 +++++++++++++-
 include/linux/pti.h        |  1 +
 init/main.c                |  7 +++++++
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/pti.h b/arch/x86/include/asm/pti.h
index 38a17f1..5df09a0 100644
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
index a688617..9b19f9a 100644
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
index fc77054..1825f30 100644
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
index 0174883..1a941ef 100644
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
index 3b4ada1..fcfef46 100644
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
 
-- 
2.7.4

