Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7D9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38E120856
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbfABWux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:50:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:59273 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfABWux (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:50:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 14:50:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,432,1539673200"; 
   d="scan'208";a="122878216"
Received: from kkubista-mobl1.amr.corp.intel.com (HELO [10.251.135.3]) ([10.251.135.3])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Jan 2019 14:50:51 -0800
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     Sinan Kaya <Okaya@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190102181038.4418-1-okaya@kernel.org>
 <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
 <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a9ccf7e1-4752-6bf5-2621-15b21a80c2ca@linux.intel.com>
Date:   Wed, 2 Jan 2019 16:50:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> This is pointing to a kconfig issue on ia64 arch.
>
> arch/ia64/Kconfig:128:error: recursive dependency detected!
> arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
> arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
>
> IA64_HP_SIM is both a choice and is selected.
>
> I did allyesconfig and disabled PCI afterwards to find all the issues
> on this patchset.

Are you saying there's a newer series that fixes this issue for both 
allyesconfig and allmodconfig?

if yes, then we're good.

>
>> 2. there are different patterns to express the dependency on PCI e.g.
>>
>>    config MMC_SDHCI_ACPI
>>        tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>>        depends on MMC_SDHCI && ACPI
>> -    select IOSF_MBI if X86
>> +    select IOSF_MBI if (X86 && PCI)
>>
>> but
>>
>> config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>>        tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>>        default ACPI
>> -    depends on X86 && ACPI
>> +    depends on X86 && ACPI && PCI
>>        select SND_SST_IPC_ACPI
>>        select SND_SST_ATOM_HIFI2_PLATFORM
>>        select SND_SOC_ACPI_INTEL_MATCH
>>
> I matched depends line to
>
> depends on X86 && ACPI && PCI
>
> for MMC_SDHCI_ACPI per feedback from Rafael on V5. This should resolve
> the inconsistency.
ok, I didn't see the delta
>
>
>> IOSF is only needed for Baytrail-CR detection, and the code will compile
>> fine without it, so maybe it'd be a better model if you used the
>> following diff?
>>
>> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
>> index 2fd1b61e8331..68af0ea5c96c 100644
>> --- a/sound/soc/intel/Kconfig
>> +++ b/sound/soc/intel/Kconfig
>> @@ -95,7 +95,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>>           select SND_SST_IPC_ACPI
>>           select SND_SST_ATOM_HIFI2_PLATFORM
>>           select SND_SOC_ACPI_INTEL_MATCH
>> -       select IOSF_MBI
>> +       select IOSF_MBI if PCI
>>
>> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
>> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
>> ACPI, so we expose drivers that can be selected but fail on probe since
>> there are no machine drivers. I am not sure if we want to be strict and
>> only expose meaningful configurations, or allow for more compilations
>> tests and corner cases?
> Hopefully, v5 resolves this too with
>
> depends on X86 && ACPI && PCI
>
> Let me know otherwise.

it doesn't but that's not a good enough reason to lay on the tracks. 
I'll follow-up with a cleanup for the Intel audio parts when this series 
is merged. The PCI dependency could be moved to the top-level since it's 
pretty much required for all platforms except for compilation tests, and 
there are multiple dependencies that repeated for no good reason, so FWIW

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

