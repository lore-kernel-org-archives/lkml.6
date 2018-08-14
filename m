Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE167C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A209821655
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A209821655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbeHNU3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:29:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58908 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732016AbeHNU3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:29:02 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5DC3D83;
        Tue, 14 Aug 2018 17:40:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 037/107] x86/smp: Provide topology_is_primary_thread()
Date:   Tue, 14 Aug 2018 19:17:00 +0200
Message-Id: <20180814171523.013977044@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171520.883143803@linuxfoundation.org>
References: <20180814171520.883143803@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 6a4d2657e048f096c7ffcad254010bd94891c8c0 upstream

If the CPU is supporting SMT then the primary thread can be found by
checking the lower APIC ID bits for zero. smp_num_siblings is used to build
the mask for the APIC ID bits which need to be taken into account.

This uses the MPTABLE or ACPI/MADT supplied APIC ID, which can be different
than the initial APIC ID in CPUID. But according to AMD the lower bits have
to be consistent. Intel gave a tentative confirmation as well.

Preparatory patch to support disabling SMT at boot/runtime.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/apic.h     |    7 +++++++
 arch/x86/include/asm/topology.h |    4 +++-
 arch/x86/kernel/apic/apic.c     |   15 +++++++++++++++
 arch/x86/kernel/smpboot.c       |    9 +++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -633,6 +633,13 @@ extern int default_check_phys_apicid_pre
 #endif
 
 #endif /* CONFIG_X86_LOCAL_APIC */
+
+#ifdef CONFIG_SMP
+bool apic_id_is_primary_thread(unsigned int id);
+#else
+static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
+#endif
+
 extern void irq_enter(void);
 extern void irq_exit(void);
 
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -129,13 +129,15 @@ static inline int topology_max_smt_threa
 }
 
 int topology_update_package_map(unsigned int apicid, unsigned int cpu);
-extern int topology_phys_to_logical_pkg(unsigned int pkg);
+int topology_phys_to_logical_pkg(unsigned int pkg);
+bool topology_is_primary_thread(unsigned int cpu);
 #else
 #define topology_max_packages()			(1)
 static inline int
 topology_update_package_map(unsigned int apicid, unsigned int cpu) { return 0; }
 static inline int topology_phys_to_logical_pkg(unsigned int pkg) { return 0; }
 static inline int topology_max_smt_threads(void) { return 1; }
+static inline bool topology_is_primary_thread(unsigned int cpu) { return true; }
 #endif
 
 static inline void arch_fix_phys_package_id(int num, u32 slot)
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2041,6 +2041,21 @@ static int cpuid_to_apicid[] = {
 	[0 ... NR_CPUS - 1] = -1,
 };
 
+/**
+ * apic_id_is_primary_thread - Check whether APIC ID belongs to a primary thread
+ * @id:	APIC ID to check
+ */
+bool apic_id_is_primary_thread(unsigned int apicid)
+{
+	u32 mask;
+
+	if (smp_num_siblings == 1)
+		return true;
+	/* Isolate the SMT bit(s) in the APICID and check for 0 */
+	mask = (1U << (fls(smp_num_siblings) - 1)) - 1;
+	return !(apicid & mask);
+}
+
 /*
  * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
  * and cpuid_to_apicid[] synchronized.
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -296,6 +296,15 @@ found:
 }
 
 /**
+ * topology_is_primary_thread - Check whether CPU is the primary SMT thread
+ * @cpu:	CPU to check
+ */
+bool topology_is_primary_thread(unsigned int cpu)
+{
+	return apic_id_is_primary_thread(per_cpu(x86_cpu_to_apicid, cpu));
+}
+
+/**
  * topology_phys_to_logical_pkg - Map a physical package id to a logical
  *
  * Returns logical package id or -1 if not found


