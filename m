Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C054CC5ACCB
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46861214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46861214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeKUIIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:14 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbeKUIIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:36:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632615"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:58 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 4/6] ASoC: Intel: Skylake: Add more platform granularity
Date:   Tue, 20 Nov 2018 15:36:42 -0600
Message-Id: <20181120213644.19103-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current SKYLAKE kconfig is a all-you-can-eat selection that will
support all known plaforms. This is however not necessarily a good
thing: most platforms for SKL and KBL don't support the DSP, but a
number of CNL/WHL ones do. Selecting this driver in all cases isn't
really smart and will require users to muck with blacklists.

Partition the configs to allow distributions to select on which
platform this driver is used. Keep the existing SND_SOC_INTEL_SKYLAKE
config to select everything for backwards compatibility. This patch does
not provide new functionality, only finer-grained choices in supported
platforms.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/Kconfig        | 73 ++++++++++++++++++++++++++++++----
 sound/soc/intel/boards/Kconfig | 16 +++++++-
 sound/soc/intel/skylake/skl.c  | 12 ++++++
 3 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 18e717703685..99a62ba409df 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -102,15 +102,74 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	  recommended option
 
 config SND_SOC_INTEL_SKYLAKE
-	tristate "SKL/BXT/KBL/GLK/CNL... Platforms"
+	tristate "All Skylake/SST Platforms"
 	depends on PCI && ACPI
-	select SND_SOC_INTEL_SKYLAKE_COMMON
+	select SND_SOC_INTEL_SKL
+	select SND_SOC_INTEL_APL
+	select SND_SOC_INTEL_KBL
+	select SND_SOC_INTEL_GLK
+	select SND_SOC_INTEL_CNL
+	select SND_SOC_INTEL_CFL
 	help
-	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
-	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
-	  then enable this option by saying Y or m.
+          This is a backwards-compatible option to select all devices
+	  supported by the Intel SST/Skylake driver. This option is no
+	  longer recommended and will be deprecated when the SOF
+	  driver is introduced.  Distributions should explicitly
+	  select which platform uses this driver.
+
+config SND_SOC_INTEL_SKL
+	tristate "Skylake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Skylake platform with the DSP enabled
+	  in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_APL
+	tristate "Broxton/ApolloLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Broxton/ApolloLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_KBL
+	tristate "Kabylake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel Kabylake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_GLK
+	tristate "GeminiLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel GeminiLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_CNL
+	tristate "CannonLake/WhiskyLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CNL/WHL platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_CFL
+	tristate "CoffeeLake Platforms"
+	depends on PCI && ACPI
+	select SND_SOC_INTEL_SKYLAKE_FAMILY
+	help
+	  If you have a Intel CoffeeLake platform with the DSP
+	  enabled in the BIOS then enable this option by saying Y or m.
+
+config SND_SOC_INTEL_SKYLAKE_FAMILY
+	tristate
+	select SND_SOC_INTEL_SKYLAKE_COMMON
 
-if  SND_SOC_INTEL_SKYLAKE
+if SND_SOC_INTEL_SKYLAKE_FAMILY
 
 config SND_SOC_INTEL_SKYLAKE_SSP_CLK
 	tristate
@@ -135,7 +194,7 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
-endif ## SND_SOC_INTEL_SKYLAKE
+endif ## SND_SOC_INTEL_SKYLAKE_FAMILY
 
 config SND_SOC_ACPI_INTEL_MATCH
 	tristate
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index b177db2a0dbb..980bccaeb7aa 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -172,7 +172,7 @@ config SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH
 
 endif ## SND_SST_ATOM_HIFI2_PLATFORM
 
-if SND_SOC_INTEL_SKYLAKE
+if SND_SOC_INTEL_SKL
 
 config SND_SOC_INTEL_SKL_RT286_MACH
 	tristate "SKL with RT286 I2S mode"
@@ -212,6 +212,10 @@ config SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH
 	  Say Y or m if you have such a device. This is a recommended option.
 	  If unsure select "N".
 
+endif ## SND_SOC_INTEL_SKL
+
+if SND_SOC_INTEL_APL
+
 config SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH
 	tristate "Broxton with DA7219 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -239,6 +243,10 @@ config SND_SOC_INTEL_BXT_RT298_MACH
 	   Say Y or m if you have such a device. This is a recommended option.
 	   If unsure select "N".
 
+endif ## SND_SOC_INTEL_APL
+
+if SND_SOC_INTEL_KBL
+
 config SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH
 	tristate "KBL with RT5663 and MAX98927 in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -293,6 +301,10 @@ config SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH
 	  Say Y if you have such a device.
 	  If unsure select "N".
 
+endif ## SND_SOC_INTEL_KBL
+
+if SND_SOC_INTEL_GLK
+
 config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	tristate "GLK with RT5682 and MAX98357A in I2S Mode"
 	depends on MFD_INTEL_LPSS && I2C && ACPI
@@ -307,7 +319,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH
 	   Say Y if you have such a device.
 	   If unsure select "N".
 
-endif ## SND_SOC_INTEL_SKYLAKE
+endif ## SND_SOC_INTEL_GLK
 
 if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0bdb1f7fdd4a..73f82532770e 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1110,24 +1110,36 @@ static void skl_remove(struct pci_dev *pci)
 
 /* PCI IDs */
 static const struct pci_device_id skl_ids[] = {
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL)
 	/* Sunrise Point-LP */
 	{ PCI_DEVICE(0x8086, 0x9d70),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_skl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_APL)
 	/* BXT-P */
 	{ PCI_DEVICE(0x8086, 0x5a98),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_bxt_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_KBL)
 	/* KBL */
 	{ PCI_DEVICE(0x8086, 0x9D71),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_kbl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_GLK)
 	/* GLK */
 	{ PCI_DEVICE(0x8086, 0x3198),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_glk_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CNL)
 	/* CNL */
 	{ PCI_DEVICE(0x8086, 0x9dc8),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
+#if IS_ENABLED(CONFIG_SND_SOC_INTEL_CFL)
 	/* CFL */
 	{ PCI_DEVICE(0x8086, 0xa348),
 		.driver_data = (unsigned long)&snd_soc_acpi_intel_cnl_machines},
+#endif
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, skl_ids);
-- 
2.17.1

