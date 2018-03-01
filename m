Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966864AbeCAJRj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 04:17:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42475 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966683AbeCAJRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 04:17:37 -0500
Date: Thu, 1 Mar 2018 01:17:28 -0800
From: tip-bot for Dou Liyang <tipbot@zytor.com>
Message-ID: <tip-8f1561680f42a5491b371b513f1ab8197f31fd62@git.kernel.org>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
        douly.fnst@cn.fujitsu.com, linux-kernel@vger.kernel.org
Reply-To: douly.fnst@cn.fujitsu.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
In-Reply-To: <20180301055930.2396-4-douly.fnst@cn.fujitsu.com>
References: <20180301055930.2396-4-douly.fnst@cn.fujitsu.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Drop logical_smp_processor_id() inline
Git-Commit-ID: 8f1561680f42a5491b371b513f1ab8197f31fd62
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8f1561680f42a5491b371b513f1ab8197f31fd62
Gitweb:     https://git.kernel.org/tip/8f1561680f42a5491b371b513f1ab8197f31fd62
Author:     Dou Liyang <douly.fnst@cn.fujitsu.com>
AuthorDate: Thu, 1 Mar 2018 13:59:30 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 1 Mar 2018 10:12:21 +0100

x86/apic: Drop logical_smp_processor_id() inline

The logical_smp_processor_id() inline which is only called in
setup_local_APIC() on x86_32 systems has no real value.

Drop it and directly use GET_APIC_LOGICAL_ID() at the call site and use a
more suitable variable name for readability

Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: andy.shevchenko@gmail.com
Cc: bhe@redhat.com
Cc: ebiederm@xmission.com
Link: https://lkml.kernel.org/r/20180301055930.2396-4-douly.fnst@cn.fujitsu.com

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
