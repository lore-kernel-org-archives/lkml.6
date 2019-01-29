Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C06EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12DEA21852
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfA2KdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:33:02 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:52005 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfA2KdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:33:01 -0500
Received: from [77.22.253.72] (helo=calia.hitronhub.home)
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <jan@schnhrr.de>)
        id 1goQXN-0003Gk-RD; Tue, 29 Jan 2019 11:22:37 +0100
From:   =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>
To:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc:     =?UTF-8?q?Jan=20H=2E=20Sch=C3=B6nherr?= <jan@schnhrr.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpu/hotplug: Unfreeze sibling CPU first on resume from S3
Date:   Tue, 29 Jan 2019 11:23:29 +0100
Message-Id: <20190129102329.27610-3-jan@schnhrr.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190129102329.27610-1-jan@schnhrr.de>
References: <20190129102329.27610-1-jan@schnhrr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Df-Sender: am5Ac2Nobmhyci5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At least one system declares the TSC unstable after resume from S3,
because the TSC is observed going backwards up to roughly 500 cycles
every now and then, when bringing secondary CPUs back online.

The system in question is an AMD Ryzen Threadripper 2950X, microcode
0x800820b, on an ASRock Fatal1ty X399 Professional Gaming, BIOS P3.30.

This unexplained behavior goes away as soon as the sibling CPU of the
boot CPU is brought back up. Hence, add a hack to restore the sibling
CPU before all others on unfreeze. This keeps the TSC stable.

Signed-off-by: Jan H. Schönherr <jan@schnhrr.de>
---
 kernel/cpu.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 91d5c38eb7e5..7097ee8c1b17 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1193,6 +1193,7 @@ EXPORT_SYMBOL_GPL(cpu_up);
 
 #ifdef CONFIG_PM_SLEEP_SMP
 static cpumask_var_t frozen_cpus;
+static int frozen_primary_sibling;
 
 int freeze_secondary_cpus(int primary)
 {
@@ -1211,6 +1212,8 @@ int freeze_secondary_cpus(int primary)
 	for_each_online_cpu(cpu) {
 		if (cpu == primary)
 			continue;
+		if (cpumask_test_cpu(cpu, topology_sibling_cpumask(primary)))
+			frozen_primary_sibling = cpu;
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, true);
 		error = _cpu_down(cpu, 1, CPUHP_OFFLINE);
 		trace_suspend_resume(TPS("CPU_OFF"), cpu, false);
@@ -1246,9 +1249,23 @@ void __weak arch_enable_nonboot_cpus_end(void)
 {
 }
 
+static void enable_nonboot_cpu(int cpu)
+{
+	int error;
+
+	trace_suspend_resume(TPS("CPU_ON"), cpu, true);
+	error = _cpu_up(cpu, 1, CPUHP_ONLINE);
+	trace_suspend_resume(TPS("CPU_ON"), cpu, false);
+	if (!error) {
+		pr_info("CPU%d is up\n", cpu);
+		return;
+	}
+	pr_warn("Error taking CPU%d up: %d\n", cpu, error);
+}
+
 void enable_nonboot_cpus(void)
 {
-	int cpu, error;
+	int cpu;
 
 	/* Allow everyone to use the CPU hotplug again */
 	cpu_maps_update_begin();
@@ -1260,16 +1277,13 @@ void enable_nonboot_cpus(void)
 
 	arch_enable_nonboot_cpus_begin();
 
-	for_each_cpu(cpu, frozen_cpus) {
-		trace_suspend_resume(TPS("CPU_ON"), cpu, true);
-		error = _cpu_up(cpu, 1, CPUHP_ONLINE);
-		trace_suspend_resume(TPS("CPU_ON"), cpu, false);
-		if (!error) {
-			pr_info("CPU%d is up\n", cpu);
-			continue;
-		}
-		pr_warn("Error taking CPU%d up: %d\n", cpu, error);
+	cpu = frozen_primary_sibling;
+	if (cpumask_test_cpu(cpu, frozen_cpus)) {
+		enable_nonboot_cpu(cpu);
+		cpumask_clear_cpu(cpu, frozen_cpus);
 	}
+	for_each_cpu(cpu, frozen_cpus)
+		enable_nonboot_cpu(cpu);
 
 	arch_enable_nonboot_cpus_end();
 
-- 
2.19.2

