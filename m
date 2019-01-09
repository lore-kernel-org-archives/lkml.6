Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291E8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000C9214DA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 23:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfAIXzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 18:55:54 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53304 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbfAIXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 18:55:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE8C9EBD;
        Wed,  9 Jan 2019 15:55:50 -0800 (PST)
Received: from beelzebub.austin.arm.com (beelzebub.austin.arm.com [10.118.12.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 019CC3F5AF;
        Wed,  9 Jan 2019 15:55:49 -0800 (PST)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, marc.zyngier@arm.com,
        suzuki.poulose@arm.com, dave.martin@arm.com,
        shankerd@codeaurora.org, linux-kernel@vger.kernel.org,
        ykaukab@suse.de, julien.thierry@arm.com, mlangsdo@redhat.com,
        steven.price@arm.com, stefan.wahren@i2se.com,
        Jeremy Linton <jeremy.linton@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH v3 1/7] sysfs/cpu: Allow individual architectures to select vulnerabilities
Date:   Wed,  9 Jan 2019 17:55:38 -0600
Message-Id: <20190109235544.2992426-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190109235544.2992426-1-jeremy.linton@arm.com>
References: <20190109235544.2992426-1-jeremy.linton@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested on the list, https://lkml.org/lkml/2019/1/4/282, there are
a number of cases where its useful for a system to avoid exporting a
sysfs entry for a given vulnerability. This set adds an architecture
specific callback which returns the bitmap of vulnerabilities the
architecture would like to advertise.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Kosina <jkosina@suse.cz>
---
 drivers/base/cpu.c  | 19 +++++++++++++++++++
 include/linux/cpu.h |  7 +++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index eb9443d5bae1..35f6dfb24cd6 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -561,6 +561,11 @@ static struct attribute *cpu_root_vulnerabilities_attrs[] = {
 	NULL
 };
 
+uint __weak arch_supported_vuln_attr_fields(void)
+{
+	return VULN_MELTDOWN|VULN_SPECTREV1|VULN_SPECTREV2|VULN_SSB|VULN_L1TF;
+}
+
 static const struct attribute_group cpu_root_vulnerabilities_group = {
 	.name  = "vulnerabilities",
 	.attrs = cpu_root_vulnerabilities_attrs,
@@ -568,6 +573,20 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
 
 static void __init cpu_register_vulnerabilities(void)
 {
+	int fld;
+	int max_fields = ARRAY_SIZE(cpu_root_vulnerabilities_attrs) - 1;
+	struct attribute **hd = cpu_root_vulnerabilities_attrs;
+	uint enabled_fields = arch_supported_vuln_attr_fields();
+
+	/* only enable entries requested by the arch code */
+	for (fld = 0; fld < max_fields; fld++) {
+		if (enabled_fields & 1 << fld) {
+			*hd = cpu_root_vulnerabilities_attrs[fld];
+			hd++;
+		}
+	}
+	*hd = NULL;
+
 	if (sysfs_create_group(&cpu_subsys.dev_root->kobj,
 			       &cpu_root_vulnerabilities_group))
 		pr_err("Unable to register CPU vulnerabilities\n");
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f4d3e1..5e45814bcc24 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -189,4 +189,11 @@ static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+/* generic cpu vulnerability attributes */
+#define VULN_MELTDOWN  0x01
+#define VULN_SPECTREV1 0x02
+#define VULN_SPECTREV2 0x04
+#define VULN_SSB       0x08
+#define VULN_L1TF      0x10
+
 #endif /* _LINUX_CPU_H_ */
-- 
2.17.2

