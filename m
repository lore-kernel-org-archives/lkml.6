Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D356DC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95CAC21728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95CAC21728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388499AbeHNUOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52028 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387947AbeHNUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:41 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03AC2C5C;
        Tue, 14 Aug 2018 17:26:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jiri Kosina <jkosina@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 4.18 54/79] cpu/hotplug: Set CPU_SMT_NOT_SUPPORTED early
Date:   Tue, 14 Aug 2018 19:17:13 +0200
Message-Id: <20180814171339.903052703@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

The CPU_SMT_NOT_SUPPORTED state is set (if the processor does not support
SMT) when the sysfs SMT control file is initialized.

That was fine so far as this was only required to make the output of the
control file correct and to prevent writes in that case.

With the upcoming l1tf command line parameter, this needs to be set up
before the L1TF mitigation selection and command line parsing happens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiri Kosina <jkosina@suse.cz>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20180713142323.121795971@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    6 ++++++
 include/linux/cpu.h        |    2 ++
 kernel/cpu.c               |   13 ++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -59,6 +59,12 @@ void __init check_bugs(void)
 {
 	identify_boot_cpu();
 
+	/*
+	 * identify_boot_cpu() initialized SMT support information, let the
+	 * core code know.
+	 */
+	cpu_smt_check_topology();
+
 	if (!IS_ENABLED(CONFIG_SMP)) {
 		pr_info("CPU: ");
 		print_cpu_info(&boot_cpu_data);
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -178,9 +178,11 @@ enum cpuhp_smt_control {
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 extern enum cpuhp_smt_control cpu_smt_control;
 extern void cpu_smt_disable(bool force);
+extern void cpu_smt_check_topology(void);
 #else
 # define cpu_smt_control		(CPU_SMT_ENABLED)
 static inline void cpu_smt_disable(bool force) { }
+static inline void cpu_smt_check_topology(void) { }
 #endif
 
 #endif /* _LINUX_CPU_H_ */
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -361,6 +361,16 @@ void __init cpu_smt_disable(bool force)
 	}
 }
 
+/*
+ * The decision whether SMT is supported can only be done after the full
+ * CPU identification. Called from architecture code.
+ */
+void __init cpu_smt_check_topology(void)
+{
+	if (!topology_smt_supported())
+		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+}
+
 static int __init smt_cmdline_disable(char *str)
 {
 	cpu_smt_disable(str && !strcmp(str, "force"));
@@ -2115,9 +2125,6 @@ static const struct attribute_group cpuh
 
 static int __init cpu_smt_state_init(void)
 {
-	if (!topology_smt_supported())
-		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
-
 	return sysfs_create_group(&cpu_subsys.dev_root->kobj,
 				  &cpuhp_smt_attr_group);
 }


