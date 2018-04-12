Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeDLOsC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:48:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53970 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752831AbeDLOsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:48:00 -0400
From: Mark Brown <broonie@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
        Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>, liam.r.girdwood@linux.intel.com,
        Harsha Priya N <harshapriya.n@intel.com>,
        Mark Brown <broonie@kernel.org>, Naveen M <naveen.m@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: Intel: atom: fix ACPI/PCI Kconfig" to the asoc tree
In-Reply-To: <20180124002712.28984-1-pierre-louis.bossart@linux.intel.com>
Message-Id: <E1f6dVv-00057S-5Q@debutante>
Date: Thu, 12 Apr 2018 15:47:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: Intel: atom: fix ACPI/PCI Kconfig

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 90619eb1dc4f19357fef5e9c13c6c9beead0fd80 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Mon, 2 Apr 2018 12:06:14 -0500
Subject: [PATCH] ASoC: Intel: atom: fix ACPI/PCI Kconfig

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
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
2.17.0
