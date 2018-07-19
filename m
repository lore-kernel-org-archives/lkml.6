Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1BECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82E5020684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 23:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82E5020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbeGTATF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 20:19:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36907 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbeGTATF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 20:19:05 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JNWgrZ2453940
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 16:32:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JNWglX2453937;
        Thu, 19 Jul 2018 16:32:42 -0700
Date:   Thu, 19 Jul 2018 16:32:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Joerg Roedel <tipbot@zytor.com>
Message-ID: <tip-39d668e04edad25abe184fb329ce35a131146ee5@git.kernel.org>
Cc:     gregkh@linuxfoundation.org, boris.ostrovsky@oracle.com,
        will.deacon@arm.com, dvlasenk@redhat.com, llong@redhat.com,
        jkosina@suse.cz, pavel@ucw.cz, luto@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        dhgutteridge@sympatico.ca, eduval@amazon.com, jgross@suse.com,
        tglx@linutronix.de, bp@alien8.de, brgerst@gmail.com,
        David.Laight@aculab.com, jroedel@suse.de, dave.hansen@intel.com,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        aarcange@redhat.com, mingo@kernel.org
Reply-To: brgerst@gmail.com, bp@alien8.de, tglx@linutronix.de,
          jgross@suse.com, mingo@kernel.org, hpa@zytor.com,
          aarcange@redhat.com, jpoimboe@redhat.com,
          linux-kernel@vger.kernel.org, dave.hansen@intel.com,
          jroedel@suse.de, David.Laight@aculab.com, jkosina@suse.cz,
          llong@redhat.com, dvlasenk@redhat.com, will.deacon@arm.com,
          boris.ostrovsky@oracle.com, gregkh@linuxfoundation.org,
          eduval@amazon.com, dhgutteridge@sympatico.ca,
          torvalds@linux-foundation.org, peterz@infradead.org,
          luto@kernel.org, pavel@ucw.cz
In-Reply-To: <1531906876-13451-28-git-send-email-joro@8bytes.org>
References: <1531906876-13451-28-git-send-email-joro@8bytes.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Make pti_clone_kernel_text() compile on
 32 bit
Git-Commit-ID: 39d668e04edad25abe184fb329ce35a131146ee5
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

Commit-ID:  39d668e04edad25abe184fb329ce35a131146ee5
Gitweb:     https://git.kernel.org/tip/39d668e04edad25abe184fb329ce35a131146ee5
Author:     Joerg Roedel <jroedel@suse.de>
AuthorDate: Wed, 18 Jul 2018 11:41:04 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 01:11:44 +0200

x86/mm/pti: Make pti_clone_kernel_text() compile on 32 bit

The pti_clone_kernel_text() function references __end_rodata_hpage_align,
which is only present on x86-64.  This makes sense as the end of the rodata
section is not huge-page aligned on 32 bit.

Nevertheless a symbol is required for the function that points at the right
address for both 32 and 64 bit. Introduce __end_rodata_aligned for that
purpose and use it in pti_clone_kernel_text().

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
Link: https://lkml.kernel.org/r/1531906876-13451-28-git-send-email-joro@8bytes.org

---
 arch/x86/include/asm/sections.h |  1 +
 arch/x86/kernel/vmlinux.lds.S   | 17 ++++++++++-------
 arch/x86/mm/pti.c               |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 5c019d23d06b..4a911a382ade 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -7,6 +7,7 @@
 
 extern char __brk_base[], __brk_limit[];
 extern struct exception_table_entry __stop___ex_table[];
+extern char __end_rodata_aligned[];
 
 #if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 5e1458f609a1..8bde0a419f86 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -55,19 +55,22 @@ jiffies_64 = jiffies;
  * so we can enable protection checks as well as retain 2MB large page
  * mappings for kernel text.
  */
-#define X64_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
+#define X86_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
 
-#define X64_ALIGN_RODATA_END					\
+#define X86_ALIGN_RODATA_END					\
 		. = ALIGN(HPAGE_SIZE);				\
-		__end_rodata_hpage_align = .;
+		__end_rodata_hpage_align = .;			\
+		__end_rodata_aligned = .;
 
 #define ALIGN_ENTRY_TEXT_BEGIN	. = ALIGN(PMD_SIZE);
 #define ALIGN_ENTRY_TEXT_END	. = ALIGN(PMD_SIZE);
 
 #else
 
-#define X64_ALIGN_RODATA_BEGIN
-#define X64_ALIGN_RODATA_END
+#define X86_ALIGN_RODATA_BEGIN
+#define X86_ALIGN_RODATA_END					\
+		. = ALIGN(PAGE_SIZE);				\
+		__end_rodata_aligned = .;
 
 #define ALIGN_ENTRY_TEXT_BEGIN
 #define ALIGN_ENTRY_TEXT_END
@@ -141,9 +144,9 @@ SECTIONS
 
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-	X64_ALIGN_RODATA_BEGIN
+	X86_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
-	X64_ALIGN_RODATA_END
+	X86_ALIGN_RODATA_END
 
 	/* Data */
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index a594e3b6401a..453d23760941 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -470,7 +470,7 @@ void pti_clone_kernel_text(void)
 	 * clone the areas past rodata, they might contain secrets.
 	 */
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = (unsigned long)__end_rodata_hpage_align;
+	unsigned long end = (unsigned long)__end_rodata_aligned;
 
 	if (!pti_kernel_image_global_ok())
 		return;
