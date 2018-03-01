Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752438AbeCAGAF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 01:00:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30554 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966023AbeCAF77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:59:59 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="37362743"
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: <tglx@linutronix.de>, <mingo@kernel.org>, <ebiederm@xmission.com>,
        <bhe@redhat.com>, <andy.shevchenko@gmail.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: [PATCH v5 3/3] x86/apic: Drop the logical_smp_processor_id()
Date: Thu, 1 Mar 2018 13:59:30 +0800
Message-ID: <20180301055930.2396-4-douly.fnst@cn.fujitsu.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180301055930.2396-1-douly.fnst@cn.fujitsu.com>
References: <20180301055930.2396-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.226.106]
X-yoursite-MailScanner-ID: 069E149F19B0.A216A
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: douly.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logical_smp_processor_id() which is only called in setup_local_APIC()
on x86_32 system looks redundant.

Drop it, then directly use GET_APIC_LOGICAL_ID() marco and more suitable
variable name for readability

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/include/asm/smp.h  | 10 ----------
 arch/x86/kernel/apic/apic.c | 10 +++++-----
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 461f53d27708..e2057780d67f 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -176,16 +176,6 @@ static inline int wbinvd_on_all_cpus(void)
 extern unsigned disabled_cpus;
 
 #ifdef CONFIG_X86_LOCAL_APIC
-
-#ifndef CONFIG_X86_64
-static inline int logical_smp_processor_id(void)
-{
-	/* we don't want to mark this access volatile - bad code generation */
-	return GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
-}
-
-#endif
-
 extern int hard_smp_processor_id(void);
 
 #else /* CONFIG_X86_LOCAL_APIC */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 7a347d7450b6..ce2066373922 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -1468,7 +1468,7 @@ static void setup_local_APIC(void)
 	int cpu = smp_processor_id();
 	unsigned int value;
 #ifdef CONFIG_X86_32
-	int i;
+	int logical_apicid, ldr_apicid;
 #endif
 
 
@@ -1507,11 +1507,11 @@ static void setup_local_APIC(void)
 	 * initialized during get_smp_config(), make sure it matches the
 	 * actual value.
 	 */
-	i = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
-	WARN_ON(i != BAD_APICID && i != logical_smp_processor_id());
+	logical_apicid = early_per_cpu(x86_cpu_to_logical_apicid, cpu);
+	ldr_apicid = GET_APIC_LOGICAL_ID(apic_read(APIC_LDR));
+	WARN_ON(logical_apicid != BAD_APICID && logical_apicid != ldr_apicid);
 	/* always use the value from LDR */
-	early_per_cpu(x86_cpu_to_logical_apicid, cpu) =
-		logical_smp_processor_id();
+	early_per_cpu(x86_cpu_to_logical_apicid, cpu) = ldr_apicid;
 #endif
 
 	/*
-- 
2.14.3
