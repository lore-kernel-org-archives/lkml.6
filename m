Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753168AbeDBR2g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:28:36 -0400
Received: from mga09.intel.com ([134.134.136.24]:43247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752898AbeDBR2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:28:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,396,1517904000";
   d="scan'208";a="188042078"
Message-ID: <1522690110.21176.202.camel@linux.intel.com>
Subject: Re: [PATCH][RESEND] ASoC: Intel: atom: fix ACPI/PCI Kconfig
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Harsha Priya N <harshapriya.n@intel.com>,
        Naveen M <naveen.m@intel.com>, Daniel Drake <drake@endlessm.com>
Date: Mon, 02 Apr 2018 20:28:30 +0300
In-Reply-To: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
References: <20180402170614.5599-1-pierre-louis.bossart@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-02 at 12:06 -0500, Pierre-Louis Bossart wrote:
> The split between ACPI and PCI platforms generated issues with
> randconfig:
> 
> with SND_SST_ATOM_HIFI2_PLATFORM_PCI=y and
> SND_SST_ATOM_HIFI2_PLATFORM=m, we get this module link failure:
> 
> ERROR: "sst_context_init"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_context_cleanup"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "sst_alloc_drv_context"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> ERROR: "intel_sst_pm" [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko]
> undefined!
> 
> ERROR: "sst_configure_runtime_pm"
> [sound/soc/intel/atom/sst/snd-intel-sst-acpi.ko] undefined!
> 
> To keep things simple, let's expose two configs for
> SND_SST_ATOM_HIFI2_PLATFORM_PCI and SND_SST_ATOM_HIFI2_PLATFORM_ACPI,
> which select a common SND_SST_ATOM_HIFI2_PLATFORM option. To avoid
> breaking existing solutions with the semantics change,
> SND_SST_ATOM_HIFI2_PLATFORM_ACPI uses "default ACPI" so that "make
> oldnoconfig" and "make olddefconfig" still work as expected.
> 
> Also remove mentions of Medfield while we are at it since it was
> removed recently.
> 

Assuming we will see no more kbuild bot complains,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4772c16ede52 ("ASoC: Intel: Kconfig: Simplify-clarify ACPI/PCI
> dependencies")
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.
> com>
> ---
> already sent on January 23 but apparently missed
> 
> 
>  sound/soc/intel/Kconfig | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index ceb105cbd461..addac2a8e52a 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -72,24 +72,28 @@ config SND_SOC_INTEL_BAYTRAIL
>  	  for Baytrail Chromebooks but this option is now deprecated
> and is
>  	  not recommended, use SND_SST_ATOM_HIFI2_PLATFORM instead.
>  
> +config SND_SST_ATOM_HIFI2_PLATFORM
> +	tristate
> +	select SND_SOC_COMPRESS
> +
>  config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> -	tristate "PCI HiFi2 (Medfield, Merrifield) Platforms"
> +	tristate "PCI HiFi2 (Merrifield) Platforms"
>  	depends on X86 && PCI
>  	select SND_SST_IPC_PCI
> -	select SND_SOC_COMPRESS
> +	select SND_SST_ATOM_HIFI2_PLATFORM
>  	help
> -	  If you have a Intel Medfield or Merrifield/Edison platform,
> then
> +	  If you have a Intel Merrifield/Edison platform, then
>  	  enable this option by saying Y or m. Distros will typically
> not
> -	  enable this option: Medfield devices are not available to
> -	  developers and while Merrifield/Edison can run a mainline
> kernel with
> -	  limited functionality it will require a firmware file which
> -	  is not in the standard firmware tree
> +	  enable this option: while Merrifield/Edison can run a
> mainline
> +	  kernel with limited functionality it will require a
> firmware file
> +	  which is not in the standard firmware tree
>  
> -config SND_SST_ATOM_HIFI2_PLATFORM
> +config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>  	tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> +	default ACPI
>  	depends on X86 && ACPI
>  	select SND_SST_IPC_ACPI
> -	select SND_SOC_COMPRESS
> +	select SND_SST_ATOM_HIFI2_PLATFORM
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	select IOSF_MBI
>  	help

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
