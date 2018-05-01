Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755074AbeEAOvr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:51:47 -0400
Received: from foss.arm.com ([217.140.101.70]:48102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752048AbeEAOvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:51:46 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Will Wong <WILLW@xilinx.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] firmware/psci: add support for SYSTEM_RESET2
Date: Tue,  1 May 2018 15:51:28 +0100
Message-Id: <1525186288-536-1-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI v1.1 introduced SYSTEM_RESET2 to allow both architectural resets
where the semantics are described by the PSCI specification itself as
well as vendor-specific resets. Currently only system warm reset
semantics is defined as part of architectural resets by the specification.

This patch implements support for SYSTEM_RESET2 by making using of
reboot_mode passed by the reboot infrastructure in the kernel.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci.c   | 21 +++++++++++++++++++++
 include/uapi/linux/psci.h |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..216b1950bbd5 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -88,6 +88,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)

 static u32 psci_cpu_suspend_feature;
+bool psci_system_reset2_supported;

 static inline bool psci_has_ext_power_state(void)
 {
@@ -253,6 +254,15 @@ static int get_set_conduit_method(struct device_node *np)

 static void psci_sys_reset(enum reboot_mode reboot_mode, const char *cmd)
 {
+	if ((reboot_mode == REBOOT_WARM || reboot_mode == REBOOT_SOFT) &&
+	    psci_system_reset2_supported)
+		/*
+		 * reset_type[31] = 0 (architectural)
+		 * reset_type[30:0] = 0 (SYSTEM_WARM_RESET)
+		 * cookie = 0 (ignored by the implementation
+		 */
+		invoke_psci_fn(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2), 0, 0, 0);
+
 	invoke_psci_fn(PSCI_0_2_FN_SYSTEM_RESET, 0, 0, 0);
 }

@@ -451,6 +461,16 @@ static const struct platform_suspend_ops psci_suspend_ops = {
 	.enter          = psci_system_suspend_enter,
 };

+static void __init psci_init_system_reset2(void)
+{
+	int ret;
+
+	ret = psci_features(PSCI_FN_NATIVE(1_1, SYSTEM_RESET2));
+
+	if (ret != PSCI_RET_NOT_SUPPORTED)
+		psci_system_reset2_supported = true;
+}
+
 static void __init psci_init_system_suspend(void)
 {
 	int ret;
@@ -588,6 +608,7 @@ static int __init psci_probe(void)
 		psci_init_smccc();
 		psci_init_cpu_suspend();
 		psci_init_system_suspend();
+		psci_init_system_reset2();
 	}

 	return 0;
diff --git a/include/uapi/linux/psci.h b/include/uapi/linux/psci.h
index b3bcabe380da..5b0ba0062541 100644
--- a/include/uapi/linux/psci.h
+++ b/include/uapi/linux/psci.h
@@ -49,8 +49,10 @@

 #define PSCI_1_0_FN_PSCI_FEATURES		PSCI_0_2_FN(10)
 #define PSCI_1_0_FN_SYSTEM_SUSPEND		PSCI_0_2_FN(14)
+#define PSCI_1_1_FN_SYSTEM_RESET2		PSCI_0_2_FN(18)

 #define PSCI_1_0_FN64_SYSTEM_SUSPEND		PSCI_0_2_FN64(14)
+#define PSCI_1_1_FN64_SYSTEM_RESET2		PSCI_0_2_FN64(18)

 /* PSCI v0.2 power state encoding for CPU_SUSPEND function */
 #define PSCI_0_2_POWER_STATE_ID_MASK		0xffff
-- 
2.7.4
