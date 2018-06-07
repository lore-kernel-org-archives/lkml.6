Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jPGjA0JmGVuXDQAAmS7hNA
	; Thu, 07 Jun 2018 17:07:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F2570607E7; Thu,  7 Jun 2018 17:07:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 66E1560115;
	Thu,  7 Jun 2018 17:07:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 66E1560115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934651AbeFGRG0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 13:06:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:32208 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932789AbeFGRGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 13:06:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 10:06:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="206183224"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga004.jf.intel.com with ESMTP; 07 Jun 2018 10:06:23 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
Date: Thu,  7 Jun 2018 10:06:06 -0700
Message-Id: <1528391168-22224-6-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
References: <1528391168-22224-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

64-bit doesn't use the entry for per CPU data, but for CPU
numbers. The change will clarify the real usage of this
entry in GDT.

Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vma.c      | 5 ++++-
 arch/x86/include/asm/segment.h | 5 ++---
 arch/x86/include/asm/vgtod.h   | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 5b8b556..833e229 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -359,7 +359,10 @@ static void vgetcpu_cpu_init(void *arg)
 	d.p = 1;		/* Present */
 	d.d = 1;		/* 32-bit */
 
-	write_gdt_entry(get_cpu_gdt_rw(cpu), GDT_ENTRY_PER_CPU, &d, DESCTYPE_S);
+	write_gdt_entry(get_cpu_gdt_rw(cpu),
+			GDT_ENTRY_CPU_NUMBER,
+			&d,
+			DESCTYPE_S);
 }
 
 static int vgetcpu_online(unsigned int cpu)
diff --git a/arch/x86/include/asm/segment.h b/arch/x86/include/asm/segment.h
index 8f09012b..492e3d1 100644
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
index fb856c9..9cd9036 100644
--- a/arch/x86/include/asm/vgtod.h
+++ b/arch/x86/include/asm/vgtod.h
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
