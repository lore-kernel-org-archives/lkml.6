Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeDBRKC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:10:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:42817 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753081AbeDBRKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:10:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="43382186"
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Harsha Priya N <harshapriya.n@intel.com>,
        Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH][RESEND] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Date: Mon,  2 Apr 2018 12:06:14 -0500
Message-Id: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The split between ACPI and PCI platforms generated issues with randconfig:

with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:

ERROR: "sst_context_init"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "sst_context_cleanup"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "sst_alloc_drv_context"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
undefined!

ERROR: "sst_configure_runtime_pm"
[sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!

To keep things simple, let's expose two configs for
SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
breaking existing solutions with the semantics change,
SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
oldnoconfig" and "make olddefconfig" still work as expected.

Also remove mentions of Medfield while we are at it since it was
removed recently.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
dependencies")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
already sent on January 23 but apparently missed


 sound/soc/intel/Kconfig | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index ceb105cbd461..addac2a8e52a 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -72,24 +72,28 @@ config SND_SOC_INTEL_BAYTRAIL
 	  for Baytrail Chromebooks but this option is now deprecated and is
 	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
 
+config SND_SST_ATOM_HIFI2_PLATFORM
+	tristate
+	select SND_SOC_COMPRESS
+
 config SND_SST_ATOM_HIFI2_PLATFORM_PCI
-	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
+	tristate "PCI HiFi2 (Merrifield) Platforms"
 	depends on X86 && PCI
 	select SND_SST_IPC_PCI
-	select SND_SOC_COMPRESS
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	help
-	  If you have a Intel Medfield or Merrifield/Edison platform, then
+	  If you have a Intel Merrifield/Edison platform, then
 	  enable this option by saying Y or m. Distros will typically not
-	  enable this option: Medfield devices are not available to
-	  developers and while Merrifield/Edison can run a mainline kernel with
-	  limited functionality it will require a firmware file which
-	  is not in the standard firmware tree
+	  enable this option: while Merrifield/Edison can run a mainline
+	  kernel with limited functionality it will require a firmware file
+	  which is not in the standard firmware tree
 
-config SND_SST_ATOM_HIFI2_PLATFORM
+config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
 	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
+	default ACPI
 	depends on X86 && ACPI
 	select SND_SST_IPC_ACPI
-	select SND_SOC_COMPRESS
+	select SND_SST_ATOM_HIFI2_PLATFORM
 	select SND_SOC_ACPI_INTEL_MATCH
 	select IOSF_MBI
 	help
-- 
2.14.1
