Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D52C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ACD20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51ACD20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932806AbeFTXQg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:16:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:65395 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932154AbeFTXP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:15:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66325222"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 16:15:26 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] x86/segments/64: Rename PER_CPU segment to CPU_NUMBER
Date:   Wed, 20 Jun 2018 16:15:04 -0700
Message-Id: <1529536506-26237-6-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
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

