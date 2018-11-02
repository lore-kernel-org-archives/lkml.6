Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7534DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DD2A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 14:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DD2A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeKCAEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:04:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:55981 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbeKCAEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:04:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 07:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="246506517"
Received: from ltvarghe-mobl1.amr.corp.intel.com (HELO [10.254.11.218]) ([10.254.11.218])
  by orsmga004.jf.intel.com with ESMTP; 02 Nov 2018 07:56:52 -0700
Subject: Re: [PATCH] ASoC: skl: always select SND_SOC_HDAC_HDA
To:     Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Sriram Periyasamy <sriramx.periyasamy@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>,
        Guneshwor Singh <guneshwor.o.singh@intel.com>,
        Naveen Manohar <naveen.m@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20181102112456.780127-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <943d10e2-299c-4393-f2f5-4ac8bbe400c3@linux.intel.com>
Date:   Fri, 2 Nov 2018 09:56:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181102112456.780127-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/18 6:24 AM, Arnd Bergmann wrote:
> The skylake sound support is written to work both with or without
> CONFIG_SND_SOC_HDAC_HDA, and uses an #ifdef to decide whether it should
> link against that. However, this fails with SND_SOC_ALL_CODECS=m or
> SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=m when the Skylake support itself
> is built-in, with this link error:
>
> sound/soc/intel/skylake/skl.o: In function `skl_probe':
> skl.c:(.text+0x56c): undefined reference to `snd_soc_hdac_hda_get_ops'
>
> Using an explicit 'select' here simplifies the logic and prevents
> it from happening, at the cost of always including the compile
> time dependency.

Thanks Arnd for the report. I don't quite agree with the proposal, this 
should be similar to HDAC_HDMI which is not selected by default, and 
there's no reason to force the support for HDAudio when the vast 
majority of Skylake+ devices which enable this driver don't have any 
HDaudio codec.

Also the code is skl.c is already conditional, so this function should 
not be required.

Do you have a config that fails, I'd like to look at this further.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/intel/Kconfig       | 1 +
>   sound/soc/intel/skylake/skl.c | 2 --
>   2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 0caa1f4eb94d..c21ce7624af1 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -109,6 +109,7 @@ config SND_SOC_INTEL_SKYLAKE
>   	depends on PCI && ACPI
>   	select SND_HDA_EXT_CORE
>   	select SND_HDA_DSP_LOADER
> +	select SND_SOC_HDAC_HDA
>   	select SND_SOC_TOPOLOGY
>   	select SND_SOC_INTEL_SST
>   	select SND_SOC_ACPI_INTEL_MATCH
> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
> index 29225623b4b4..1069ee265ce5 100644
> --- a/sound/soc/intel/skylake/skl.c
> +++ b/sound/soc/intel/skylake/skl.c
> @@ -870,9 +870,7 @@ static int skl_create(struct pci_dev *pci,
>   	hbus = skl_to_hbus(skl);
>   	bus = skl_to_bus(skl);
>   
> -#if IS_ENABLED(CONFIG_SND_SOC_HDAC_HDA)
>   	ext_ops = snd_soc_hdac_hda_get_ops();
> -#endif
>   	snd_hdac_ext_bus_init(bus, &pci->dev, &bus_core_ops, io_ops, ext_ops);
>   	bus->use_posbuf = 1;
>   	skl->pci = pci;
