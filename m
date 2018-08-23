Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC79EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED7208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 09:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87ED7208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbeHWMhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:37:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56350 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbeHWMhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:37:54 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 57E91CA0;
        Thu, 23 Aug 2018 09:09:08 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, keescook@google.com,
        aarcange@redhat.com, jgross@suse.com, jpoimboe@redhat.com,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: [PATCH 4.17 305/324] x86/mm/init: Add helper for freeing kernel image pages
Date:   Thu, 23 Aug 2018 09:56:11 +0200
Message-Id: <20180823075011.331600305@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Hansen <dave.hansen@linux.intel.com>

commit 6ea2738e0ca0e626c75202fb051c1e88d7a950fa upstream.

When chunks of the kernel image are freed, free_init_pages() is used
directly.  Consolidate the three sites that do this.  Also update the
string to give an incrementally better description of that memory versus
what was there before.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: keescook@google.com
Cc: aarcange@redhat.com
Cc: jgross@suse.com
Cc: jpoimboe@redhat.com
Cc: gregkh@linuxfoundation.org
Cc: peterz@infradead.org
Cc: hughd@google.com
Cc: torvalds@linux-foundation.org
Cc: bp@alien8.de
Cc: luto@kernel.org
Cc: ak@linux.intel.com
Cc: Kees Cook <keescook@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20180802225829.FE0E32EA@viggo.jf.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/processor.h |    1 +
 arch/x86/mm/init.c               |   15 ++++++++++++---
 arch/x86/mm/init_64.c            |    4 ++--
 3 files changed, 15 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -980,6 +980,7 @@ static inline uint32_t hypervisor_cpuid_
 
 extern unsigned long arch_align_stack(unsigned long sp);
 extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
+extern void free_kernel_image_pages(void *begin, void *end);
 
 void default_idle(void);
 #ifdef	CONFIG_XEN
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -775,13 +775,22 @@ void free_init_pages(char *what, unsigne
 	}
 }
 
+/*
+ * begin/end can be in the direct map or the "high kernel mapping"
+ * used for the kernel image only.  free_init_pages() will do the
+ * right thing for either kind of address.
+ */
+void free_kernel_image_pages(void *begin, void *end)
+{
+	free_init_pages("unused kernel image",
+			(unsigned long)begin, (unsigned long)end);
+}
+
 void __ref free_initmem(void)
 {
 	e820__reallocate_tables();
 
-	free_init_pages("unused kernel",
-			(unsigned long)(&__init_begin),
-			(unsigned long)(&__init_end));
+	free_kernel_image_pages(&__init_begin, &__init_end);
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1283,8 +1283,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_init_pages("unused kernel", text_end, rodata_start);
-	free_init_pages("unused kernel", rodata_end, _sdata);
+	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
+	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
 
 	debug_checkwx();
 


