Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF0CC04E85
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEF120A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 16:45:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AEF120A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeHWUPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 16:15:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:1808 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbeHWUPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 16:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2018 09:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,278,1531810800"; 
   d="scan'208";a="227129274"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 23 Aug 2018 09:45:15 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH V5 6/8] x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
Date:   Thu, 23 Aug 2018 09:44:36 -0700
Message-Id: <1535042678-31366-7-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
References: <1535042678-31366-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64-bit doesn't use the entry for per CPU data, but for CPU
(and node) numbers. The change will clarify the real usage
of this entry in GDT.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/entry/vdso/vma.c      | 2 +-
 arch/x86/include/asm/segment.h | 5 ++---
 arch/x86/include/asm/vgtod.h   | 6 +++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556..0b114aa 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -359,7 +359,7 @@ static void vgetcpu_cpu_init(void *arg)
 	d.p = 1;		/* Present */
 	d.d = 1;		/* 32-bit */
 
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PER_CPU, &d, DESCTYPE_S);
+	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_CPU_NUMBER, &d, DESCTYPE_S);
 }
 
 static int vgetcpu_online(unsigned int cpu)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index e293c12..e3e788ea 100644
--- a/arch/x86/include/asm/segment.h
+++ b/arch/x86/include/asm/segment.h
@@ -186,8 +186,7 @@
 #define GDT_ENTRY_TLS_MIN		12
 #define GDT_ENTRY_TLS_MAX		14
 
-/* Abused to load per CPU data from limit */
-#define GDT_ENTRY_PER_CPU		15
+#define GDT_ENTRY_CPU_NUMBER		15
 
 /*
  * Number of entries in the GDT table:
@@ -207,7 +206,7 @@
 #define __USER_DS			(GDT_ENTRY_DEFAULT_USER_DS*8 + 3)
 #define __USER32_DS			__USER_DS
 #define __USER_CS			(GDT_ENTRY_DEFAULT_USER_CS*8 + 3)
-#define __PER_CPU_SEG			(GDT_ENTRY_PER_CPU*8 + 3)
+#define __CPU_NUMBER_SEG		(GDT_ENTRY_CPU_NUMBER*8 + 3)
 
 #endif
 
diff --git a/arch/x86/include/asm/vgtod.h b/arch/x86/include/asm/vgtod.h
index fb856c9..dd58a2e 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
@@ -86,8 +86,8 @@ static inline unsigned int __getcpu(void)
 	unsigned int p;
 
 	/*
-	 * Load per CPU data from GDT.  LSL is faster than RDTSCP and
-	 * works on all CPUs.  This is volatile so that it orders
+	 * Load CPU (and node) number from GDT.  LSL is faster than RDTSCP
+	 * and works on all CPUs.  This is volatile so that it orders
 	 * correctly wrt barrier() and to keep gcc from cleverly
 	 * hoisting it out of the calling function.
 	 *
@@ -96,7 +96,7 @@ static inline unsigned int __getcpu(void)
 	alternative_io ("lsl %[p],%[seg]",
 			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
 			X86_FEATURE_RDPID,
-			[p] "=a" (p), [seg] "r" (__PER_CPU_SEG));
+			[p] "=a" (p), [seg] "r" (__CPU_NUMBER_SEG));
 
 	return p;
 }
-- 
2.7.4

