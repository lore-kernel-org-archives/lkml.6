Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753368AbeDLLSd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:18:33 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36268 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeDLLPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:02 -0400
X-Google-Smtp-Source: AIpwx49laUzMVJQeR8LP7VdhgyGpGDG2yXLZKZ6L5VkNDnt4g57/zMUkaFtMk8/nptWRaXUDInIvjQ==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/26] drivers: firmware: psci: Move psci to separate directory
Date: Thu, 12 Apr 2018 13:14:18 +0200
Message-Id: <1523531671-27491-14-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some following changes extends the PSCI driver with some additional new
files.  Let's avoid to continue cluttering the toplevel firmware directory
and first move the PSCI files into a PSCI sub-directory.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/Kconfig                   | 15 +--------------
 drivers/firmware/Makefile                  |  3 +--
 drivers/firmware/psci/Kconfig              | 13 +++++++++++++
 drivers/firmware/psci/Makefile             |  4 ++++
 drivers/firmware/{ => psci}/psci.c         |  0
 drivers/firmware/{ => psci}/psci_checker.c |  0
 6 files changed, 19 insertions(+), 16 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (100%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 6e83880..923c42d 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -5,20 +5,6 @@
 
 menu "Firmware Drivers"
 
-config ARM_PSCI_FW
-	bool
-
-config ARM_PSCI_CHECKER
-	bool "ARM PSCI checker"
-	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
-	help
-	  Run the PSCI checker during startup. This checks that hotplug and
-	  suspend operations work correctly when using PSCI.
-
-	  The torture tests may interfere with the PSCI checker by turning CPUs
-	  on and off through hotplug, so for now torture tests and PSCI checker
-	  are mutually exclusive.
-
 config ARM_SCMI_PROTOCOL
 	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
@@ -286,6 +272,7 @@ config TI_SCI_PROTOCOL
 config HAVE_ARM_SMCCC
 	bool
 
+source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index e18a041..ea284e5 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,8 +2,6 @@
 #
 # Makefile for the linux kernel.
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
-obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
@@ -26,6 +24,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
+obj-y				+= psci/
 obj-y				+= broadcom/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
new file mode 100644
index 0000000..26a3b32
--- /dev/null
+++ b/drivers/firmware/psci/Kconfig
@@ -0,0 +1,13 @@
+config ARM_PSCI_FW
+	bool
+
+config ARM_PSCI_CHECKER
+	bool "ARM PSCI checker"
+	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
+	help
+	  Run the PSCI checker during startup. This checks that hotplug and
+	  suspend operations work correctly when using PSCI.
+
+	  The torture tests may interfere with the PSCI checker by turning CPUs
+	  on and off through hotplug, so for now torture tests and PSCI checker
+	  are mutually exclusive.
diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
new file mode 100644
index 0000000..1956b88
--- /dev/null
+++ b/drivers/firmware/psci/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
similarity index 100%
rename from drivers/firmware/psci.c
rename to drivers/firmware/psci/psci.c
diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
similarity index 100%
rename from drivers/firmware/psci_checker.c
rename to drivers/firmware/psci/psci_checker.c
-- 
2.7.4
