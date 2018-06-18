Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09428C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DB720874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:15:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DB720874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933929AbeFRIPj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:15:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933763AbeFRIPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:15:33 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0D4BAC74;
        Mon, 18 Jun 2018 08:15:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 004/279] ASoC: Intel: atom: fix ACPI/PCI Kconfig
Date:   Mon, 18 Jun 2018 10:09:49 +0200
Message-Id: <20180618080609.025142850@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618080608.851973560@linuxfoundation.org>
References: <20180618080608.851973560@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 90619eb1dc4f19357fef5e9c13c6c9beead0fd80 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/intel/Kconfig |   22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

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


