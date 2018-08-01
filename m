Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6BC46467
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B7E20844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B7E20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbeHATsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:48:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:59002 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731689AbeHATsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:48:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 11:01:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="220951779"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by orsmga004.jf.intel.com with ESMTP; 01 Aug 2018 11:01:07 -0700
Subject: [PATCH 4/5] x86/mm/init: add helper for freeing kernel image pages
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Wed, 01 Aug 2018 11:01:03 -0700
References: <20180801180058.EC46D963@viggo.jf.intel.com>
In-Reply-To: <20180801180058.EC46D963@viggo.jf.intel.com>
Message-Id: <20180801180103.E42368F9@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

When chunks of the kernel image are freed, free_init_pages()
is used directly.  Consolidate the three sites that do this.
Also update the string to give an incrementally better
description of that memory versus what was there before.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
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
---

 b/arch/x86/include/asm/processor.h |    1 +
 b/arch/x86/mm/init.c               |   15 ++++++++++++---
 b/arch/x86/mm/init_64.c            |    4 ++--
 3 files changed, 15 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/processor.h~x86-mm-init-common-kernel-image-free-helper arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86-mm-init-common-kernel-image-free-helper	2018-07-30 09:53:14.295915691 -0700
+++ b/arch/x86/include/asm/processor.h	2018-07-30 09:53:14.303915690 -0700
@@ -975,6 +975,7 @@ static inline uint32_t hypervisor_cpuid_
 
 extern unsigned long arch_align_stack(unsigned long sp);
 extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
+extern void free_kernel_image_pages(void *begin, void *end);
 
 void default_idle(void);
 #ifdef	CONFIG_XEN
diff -puN arch/x86/mm/init_64.c~x86-mm-init-common-kernel-image-free-helper arch/x86/mm/init_64.c
--- a/arch/x86/mm/init_64.c~x86-mm-init-common-kernel-image-free-helper	2018-07-30 09:53:14.297915691 -0700
+++ b/arch/x86/mm/init_64.c	2018-07-30 09:53:14.304915690 -0700
@@ -1283,8 +1283,8 @@ void mark_rodata_ro(void)
 	set_memory_ro(start, (end-start) >> PAGE_SHIFT);
 #endif
 
-	free_init_pages("unused kernel", text_end, rodata_start);
-	free_init_pages("unused kernel", rodata_end, _sdata);
+	free_kernel_image_pages((void *)text_end, (void *)rodata_start);
+	free_kernel_image_pages((void *)rodata_end, (void *)_sdata);
 
 	debug_checkwx();
 
diff -puN arch/x86/mm/init.c~x86-mm-init-common-kernel-image-free-helper arch/x86/mm/init.c
--- a/arch/x86/mm/init.c~x86-mm-init-common-kernel-image-free-helper	2018-07-30 09:53:14.298915691 -0700
+++ b/arch/x86/mm/init.c	2018-07-30 09:53:14.304915690 -0700
@@ -771,13 +771,22 @@ void free_init_pages(char *what, unsigne
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
_
