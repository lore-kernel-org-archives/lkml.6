Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0155C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D3A20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731104AbfAUOLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:11:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:47949 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729764AbfAUOLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:11:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Jan 2019 06:11:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,503,1539673200"; 
   d="scan'208";a="127675435"
Received: from mylly.fi.intel.com (HELO mylly.fi.intel.com.) ([10.237.72.159])
  by orsmga002.jf.intel.com with ESMTP; 21 Jan 2019 06:11:31 -0800
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        linux-i2c@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH] mfd: Fix I2C_DESIGNWARE_PLATFORM dependencies
Date:   Mon, 21 Jan 2019 16:11:28 +0200
Message-Id: <20190121141128.5283-1-jarkko.nikula@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INTEL_SOC_PMIC, INTEL_SOC_PMIC_CHTWC and MFD_TPS68470 select the
I2C_DESIGNWARE_PLATFORM without its dependencies making it possible to see
warning and build error like below:

WARNING: unmet direct dependencies detected for I2C_DESIGNWARE_PLATFORM
  Depends on [n]: I2C [=y] && HAS_IOMEM [=y] && (ACPI [=y] && COMMON_CLK [=n] || !ACPI [=y])
  Selected by [y]:
  - MFD_TPS68470 [=y] && HAS_IOMEM [=y] && ACPI [=y] && I2C [=y]=y

/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_resume':
i2c-designware-platdrv.c:(.text+0x62): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_suspend':
i2c-designware-platdrv.c:(.text+0x9a): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: drivers/i2c/busses/i2c-designware-platdrv.o: in function `dw_i2c_plat_probe':
i2c-designware-platdrv.c:(.text+0x41c): undefined reference to `i2c_dw_prepare_clk'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x438): undefined reference to `i2c_dw_read_comp_param'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x545): undefined reference to `i2c_dw_probe'
/usr/bin/ld: i2c-designware-platdrv.c:(.text+0x727): undefined reference to `i2c_dw_probe_slave'

Fix this by making above options to depend on I2C_DESIGNWARE_PLATFORM
being built-in. I2C_DESIGNWARE_PLATFORM is a visible symbol with
dependencies so in general the select should be avoided.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: acebcff9eda8 ("mfd: intel_soc_pmic: Select designware i2c-bus driver")
Fixes: de85d79f4aab ("mfd: Add Cherry Trail Whiskey Cove PMIC driver")
Fixes: 9bbf6a15ce19 ("mfd: Add support for TPS68470 device")
Cc: Stable <stable@vger.kernel.org> # v4.14+
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 drivers/mfd/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f461460a2aeb..6a84a8ecd4a9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -519,10 +519,10 @@ config INTEL_SOC_PMIC
 	bool "Support for Crystal Cove PMIC"
 	depends on ACPI && HAS_IOMEM && I2C=y && GPIOLIB && COMMON_CLK
 	depends on X86 || COMPILE_TEST
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  Select this option to enable support for Crystal Cove PMIC
 	  on some Intel SoC systems. The PMIC provides ADC, GPIO,
@@ -548,10 +548,10 @@ config INTEL_SOC_PMIC_CHTWC
 	bool "Support for Intel Cherry Trail Whiskey Cove PMIC"
 	depends on ACPI && HAS_IOMEM && I2C=y && COMMON_CLK
 	depends on X86 || COMPILE_TEST
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
 	select REGMAP_IRQ
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  Select this option to enable support for the Intel Cherry Trail
 	  Whiskey Cove PMIC found on some Intel Cherry Trail systems.
@@ -1420,9 +1420,9 @@ config MFD_TPS65217
 config MFD_TPS68470
 	bool "TI TPS68470 Power Management / LED chips"
 	depends on ACPI && I2C=y
+	depends on I2C_DESIGNWARE_PLATFORM=y
 	select MFD_CORE
 	select REGMAP_I2C
-	select I2C_DESIGNWARE_PLATFORM
 	help
 	  If you say yes here you get support for the TPS68470 series of
 	  Power Management / LED chips.
-- 
2.20.1

