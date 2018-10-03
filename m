Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B201721470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjLORK1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B201721470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeJCV1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:37 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37891 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeJCV1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:35 -0400
Received: by mail-lj1-f194.google.com with SMTP id v7-v6so4907407ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=24N1Dc3/4aVSfatj0cCLPTM9sDMCdxo5zYgoCR5YTHc=;
        b=XjLORK1OYwzVBRY8kPy7QP/UtnW4VxCS18LStrS5+NaSElLf53WYhSsAeOpJRZ878b
         VqSg3YrZ+3izUx8IHKra0aZC8NThLEYOzlsrPV1UKUz850Cj11Hr//MXWdQh2hoGNqL3
         G9+bkTyfOZHm7ZpL8euDuDaqLQg9V8vs/pk+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=24N1Dc3/4aVSfatj0cCLPTM9sDMCdxo5zYgoCR5YTHc=;
        b=nxVD6IZpOcYRMSrLxwXm4lGzlatTj44rHmV39WwdRHo1VazDTiXmpQ0hzoGSidjt+e
         ywt+DkvgReLZVWGpV4QMMiwYgfI90yKm1ipImZSGaO5WBtQTnWaju8xhLbR/XdMCGfzw
         DyfaTM1xw9RCQJ5FZ3EKRh/Xy4pLmHrJYw2qyUMfnzbTaQOJ6HS49g2/BoA9POFuWlib
         NHYsDC/bVo+wj5d9NBtWcaTxhgEATBJvhhtFZAe4Groe5nz8fBlYkbdkJDbHrEjuj2S/
         ylXffH+KSd2PYOvMhzP1nNHMPnKd+BvF8aEpdGuImtQjkxmvUvOB0IBiUFfkHCOrZ+Ht
         uDtA==
X-Gm-Message-State: ABuFfohwbMqPQYrGgQ17k8a/HN5tvpBI0gtroxiUm54JFRFF1ZzB0xw/
        2OhyJ0MXKw1oobkZLUdtdCiz9A==
X-Google-Smtp-Source: ACcGV60MQ4bvS0UIONM4xmbNp7c8w3D3iNVTmeIbx24qsydvm8zeVD1SDHaFgQtHq/VCA7CWpui8zQ==
X-Received: by 2002:a2e:90d8:: with SMTP id o24-v6mr1361712ljg.97.1538577532011;
        Wed, 03 Oct 2018 07:38:52 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:51 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 07/11] drivers: firmware: psci: Move psci to separate directory
Date:   Wed,  3 Oct 2018 16:38:20 +0200
Message-Id: <20181003143824.13059-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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
index 6e83880046d7..923c42d5a2e6 100644
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
index e18a041cfc53..ea284e551dc8 100644
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
index 000000000000..26a3b32bf7ab
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
index 000000000000..1956b882470f
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
2.17.1

