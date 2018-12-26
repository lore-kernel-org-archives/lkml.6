Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CADFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6282821741
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 17:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeLZRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 12:35:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:18132 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeLZRfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 12:35:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Dec 2018 09:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,401,1539673200"; 
   d="scan'208";a="130795853"
Received: from amoreill-mobl1.amr.corp.intel.com (HELO [10.252.137.235]) ([10.252.137.235])
  by fmsmga004.fm.intel.com with ESMTP; 26 Dec 2018 09:35:06 -0800
Subject: Re: [PATCH v3 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>, linux-next@vger.kernel.org
Cc:     linux-acpi@vger.kernel.org,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181223232521.11320-1-okaya@kernel.org>
 <20181223232521.11320-9-okaya@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <39200a36-6592-f010-8309-a249a8d514f4@linux.intel.com>
Date:   Wed, 26 Dec 2018 11:35:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181223232521.11320-9-okaya@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/23/18 5:25 PM, Sinan Kaya wrote:
> Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> CONFIG_PCI set but this is not specified anywhere.

Can you please share the .config that exposes this problem? This hasn't 
changed in a long time and I wonder why this pops up now. You have 
similar cases elsewhere, e.g. arch/x86/Kconfig

config X86_INTEL_LPSS
     bool "Intel Low Power Subsystem Support"
     depends on X86 && ACPI
     select COMMON_CLK
     select PINCTRL
     select IOSF_MBI

or for the MMC.

config MMC_SDHCI_ACPI
     tristate "SDHCI support for ACPI enumerated SDHCI controllers"
     depends on MMC_SDHCI && ACPI
     select IOSF_MBI if X86

The use of IOSF_MBI is only for the Baytrail-CR detection and there are 
already in-flight patches to change the code and move it to a helper.

My understanding is that for compilation you only need CONFIG_x86 since 
there are fall-back routines available in iosf_mbi.h

Thanks!

>
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..b0764b2fe001 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>   config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>   	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>   	default ACPI
> -	depends on X86 && ACPI
> +	depends on X86 && ACPI && PCI
>   	select SND_SST_IPC_ACPI
>   	select SND_SST_ATOM_HIFI2_PLATFORM
>   	select SND_SOC_ACPI_INTEL_MATCH
