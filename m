Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12407C5ACBA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADFF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 21:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ADFF214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbeKUIId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 03:08:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:35018 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbeKUII3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 03:08:29 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 13:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,258,1539673200"; 
   d="scan'208";a="281632617"
Received: from pmvancle-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.10.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Nov 2018 13:36:59 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        liam.r.girdwood@linux.intel.com, andriy.shevchenko@linux.intel.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 5/6] ALSA: hda: Allow fallback binding with legacy HD-audio for Intel SKL+
Date:   Tue, 20 Nov 2018 15:36:43 -0600
Message-Id: <20181120213644.19103-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
References: <20181120213644.19103-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

Previous patches enabled distributions to select for which platform
the Skylake driver will be used. This is not enough however since the
DSP may or may not enabled by the BIOS, and a probe-time dynamic
fallback is highly desired.

This patch introduces a new AZX_DCAPS value, and when this field is
set for the relevant PCI ID the HDaudio legacy driver will stop its
probe. Conversely the Skylake driver will attempt to probe, but in
case of errors (typically DSP not present or no HDAudio streams found)
it will fall back to the HDaudio legacy.

The behavior can be influenced by static Kconfig definitions to enable
or disable this fallback. A 'legacy' parameter also controls the
fallback, allowing testers to prevent the Skylake driver from probing
or conversely preventing the fallback from happening.

This patch only introduces the fallback capabilities and handling, the
platform definitions are provided in a follow-up patch.

Errors beyond the initial DSP capability parsing (e.g. missing
firmware file, firmware authentication issue, missing topology file,
bad topology configuration, etc) are considered out-of-scope. It is
nearly impossible to handle all possible error cases and most errors
are only detected after a timeout which isn't compatible with usual
probe expectations. It is expected that additional debug hooks will
have to be provided at a later point, e.g. module parameters to
override hard-coded firmware name and topology files.

Credits to Takashi for the initial code shared on the alsa-devel
mailing list. Testing with base-defconfig, sst-defconfig and
hdaudio-defconfigs provided at
https://github.com/thesofproject/kconfig

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hdaudio.h        |  6 +++
 sound/pci/hda/hda_controller.h |  2 +-
 sound/pci/hda/hda_intel.c      | 32 ++++++++++++++-
 sound/soc/intel/Kconfig        |  7 ++++
 sound/soc/intel/skylake/skl.c  | 73 ++++++++++++++++++++++++++++++++--
 5 files changed, 114 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index cd1773d0e08f..2ed67f315962 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -8,6 +8,7 @@
 
 #include <linux/device.h>
 #include <linux/interrupt.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/timecounter.h>
 #include <sound/core.h>
@@ -634,4 +635,9 @@ static inline unsigned int snd_array_index(struct snd_array *array, void *ptr)
 	for ((idx) = 0, (ptr) = (array)->list; (idx) < (array)->used; \
 	     (ptr) = snd_array_elem(array, ++(idx)))
 
+/* shared resource with ASoC and legacy HD-audio drivers */
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+const struct pci_driver *snd_hda_intel_probe(struct pci_dev *pci);
+#endif
+
 #endif /* __SOUND_HDAUDIO_H */
diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index c95097bb5a0c..2351115f922e 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -37,7 +37,7 @@
 #else
 #define AZX_DCAPS_I915_COMPONENT 0		/* NOP */
 #endif
-/* 14 unused */
+#define AZX_DCAPS_INTEL_SHARED	(1 << 14)	/* shared with ASoC */
 #define AZX_DCAPS_CTX_WORKAROUND (1 << 15)	/* X-Fi workaround */
 #define AZX_DCAPS_POSFIX_LPIB	(1 << 16)	/* Use LPIB as default */
 /* 17 unused */
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d8eb2b5f51ae..eb00e37c1c27 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2081,8 +2081,8 @@ static const struct hda_controller_ops pci_hda_ops = {
 	.link_power = azx_intel_link_power,
 };
 
-static int azx_probe(struct pci_dev *pci,
-		     const struct pci_device_id *pci_id)
+static int __azx_probe(struct pci_dev *pci, const struct pci_device_id *pci_id,
+		       bool skip_shared)
 {
 	static int dev;
 	struct snd_card *card;
@@ -2091,6 +2091,10 @@ static int azx_probe(struct pci_dev *pci,
 	bool schedule_probe;
 	int err;
 
+	/* skip the entry if it's shared with ASoC */
+	if (skip_shared && (pci_id->driver_data & AZX_DCAPS_INTEL_SHARED))
+		return -ENODEV;
+
 	if (dev >= SNDRV_CARDS)
 		return -ENODEV;
 	if (!enable[dev]) {
@@ -2158,6 +2162,12 @@ static int azx_probe(struct pci_dev *pci,
 	return err;
 }
 
+static int azx_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
+{
+	return __azx_probe(pci, pci_id,
+			   IS_ENABLED(CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT));
+}
+
 #ifdef CONFIG_PM
 /* On some boards setting power_save to a non 0 value leads to clicking /
  * popping sounds when ever we enter/leave powersaving mode. Ideally we would
@@ -2650,4 +2660,22 @@ static struct pci_driver azx_driver = {
 	},
 };
 
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+const struct pci_driver *
+snd_hda_intel_probe(struct pci_dev *pci)
+{
+	const struct pci_device_id *pci_id;
+	int ret;
+
+	pci_id = pci_match_id(azx_ids, pci);
+	if (!pci_id)
+		return ERR_PTR(-ENODEV);
+	ret = __azx_probe(pci, pci_id, false);
+	if (ret < 0)
+		return ERR_PTR(ret);
+	return &azx_driver;
+}
+EXPORT_SYMBOL_GPL(snd_hda_intel_probe);
+#endif
+
 module_pci_driver(azx_driver);
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 99a62ba409df..c02d08d31d0d 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -194,6 +194,13 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
 	  GeminiLake or CannonLake platform with the DSP enabled in the BIOS
 	  then enable this option by saying Y or m.
 
+config SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+	bool "Fallback legacy HD-audio binding"
+	depends on SND_HDA_INTEL=y || SND_SOC_INTEL_SKYLAKE_FAMILY=SND_HDA_INTEL
+	help
+	  Fallback binding with the legacy HD-audio driver when no DSP is
+	  found
+
 endif ## SND_SOC_INTEL_SKYLAKE_FAMILY
 
 config SND_SOC_ACPI_INTEL_MATCH
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 73f82532770e..b67cb54d382c 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -41,6 +41,21 @@
 #include "../../../soc/codecs/hdac_hda.h"
 #endif
 
+enum {
+	SKL_BIND_AUTO,		/* fallback to legacy driver */
+	SKL_BIND_LEGACY,	/* bind only with legacy driver */
+	SKL_BIND_ASOC		/* bind only with ASoC driver */
+};
+
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+static const struct pci_driver *skl_fallback_driver;
+#define FALLBACK_PM_CALL(dev, method)					\
+	do {								\
+		if (skl_fallback_driver &&				\
+		    skl_fallback_driver->driver.pm->method)		\
+			return skl_fallback_driver->driver.pm->method(dev); \
+	} while (0)
+
 /*
  * initialize the PCI registers
  */
@@ -264,6 +279,9 @@ static int skl_suspend_late(struct device *dev)
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct skl *skl = bus_to_skl(bus);
 
+	if (skl_fallback_driver)
+		return 0;
+
 	return skl_suspend_late_dsp(skl);
 }
 
@@ -313,6 +331,8 @@ static int skl_suspend(struct device *dev)
 	struct skl *skl  = bus_to_skl(bus);
 	int ret = 0;
 
+	FALLBACK_PM_CALL(dev, suspend);
+
 	/*
 	 * Do not suspend if streams which are marked ignore suspend are
 	 * running, we need to save the state for these and continue
@@ -351,6 +371,8 @@ static int skl_resume(struct device *dev)
 	struct hdac_ext_link *hlink = NULL;
 	int ret;
 
+	FALLBACK_PM_CALL(dev, resume);
+
 	/* Turned OFF in HDMI codec driver after codec reconfiguration */
 	if (IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)) {
 		ret = snd_hdac_display_power(bus, true);
@@ -405,6 +427,8 @@ static int skl_runtime_suspend(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 
+	FALLBACK_PM_CALL(dev, runtime_suspend);
+
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
 	return _skl_suspend(bus);
@@ -415,15 +439,24 @@ static int skl_runtime_resume(struct device *dev)
 	struct pci_dev *pci = to_pci_dev(dev);
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 
+	FALLBACK_PM_CALL(dev, runtime_resume);
+
 	dev_dbg(bus->dev, "in %s\n", __func__);
 
 	return _skl_resume(bus);
 }
+
+static int skl_runtime_idle(struct device *dev)
+{
+	FALLBACK_PM_CALL(dev, runtime_idle);
+	return 0;
+}
 #endif /* CONFIG_PM */
 
 static const struct dev_pm_ops skl_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(skl_suspend, skl_resume)
-	SET_RUNTIME_PM_OPS(skl_runtime_suspend, skl_runtime_resume, NULL)
+	SET_RUNTIME_PM_OPS(skl_runtime_suspend, skl_runtime_resume,
+			   skl_runtime_idle)
 	.suspend_late = skl_suspend_late,
 };
 
@@ -980,8 +1013,8 @@ static int skl_first_init(struct hdac_bus *bus)
 	return skl_init_chip(bus, true);
 }
 
-static int skl_probe(struct pci_dev *pci,
-		     const struct pci_device_id *pci_id)
+static int __skl_probe(struct pci_dev *pci,
+		       const struct pci_device_id *pci_id)
 {
 	struct skl *skl;
 	struct hdac_bus *bus = NULL;
@@ -1060,6 +1093,25 @@ static int skl_probe(struct pci_dev *pci,
 	return err;
 }
 
+static int skl_probe(struct pci_dev *pci,
+		     const struct pci_device_id *pci_id)
+{
+	int ret = -ENODEV;
+
+	if (skl_legacy_binding != SKL_BIND_LEGACY)
+		ret = __skl_probe(pci, pci_id);
+
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+	if (ret < 0 && skl_legacy_binding != SKL_BIND_ASOC) {
+		skl_fallback_driver = snd_hda_intel_probe(pci);
+		ret = PTR_ERR_OR_ZERO(skl_fallback_driver);
+		if (ret)
+			skl_fallback_driver = NULL;
+	}
+#endif
+	return ret;
+}
+
 static void skl_shutdown(struct pci_dev *pci)
 {
 	struct hdac_bus *bus = pci_get_drvdata(pci);
@@ -1067,6 +1119,13 @@ static void skl_shutdown(struct pci_dev *pci)
 	struct hdac_ext_stream *stream;
 	struct skl *skl;
 
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+	if (skl_fallback_driver) {
+		skl_fallback_driver->shutdown(pci);
+		return;
+	}
+#endif
+
 	if (!bus)
 		return;
 
@@ -1089,6 +1148,14 @@ static void skl_remove(struct pci_dev *pci)
 	struct hdac_bus *bus = pci_get_drvdata(pci);
 	struct skl *skl = bus_to_skl(bus);
 
+#ifdef CONFIG_SND_SOC_INTEL_SKL_LEGACY_SUPPORT
+	if (skl_fallback_driver) {
+		skl_fallback_driver->remove(pci);
+		skl_fallback_driver = NULL;
+		return;
+	}
+#endif
+
 	release_firmware(skl->tplg);
 
 	pm_runtime_get_noresume(&pci->dev);
-- 
2.17.1

