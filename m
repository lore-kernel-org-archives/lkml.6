Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840DBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512D520685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 512D520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbeKGAWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:22:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:45828 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388851AbeKGAWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:22:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 06:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="247425957"
Received: from dnperich-mobl2.amr.corp.intel.com (HELO [10.251.132.149]) ([10.251.132.149])
  by orsmga004.jf.intel.com with ESMTP; 06 Nov 2018 06:56:39 -0800
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1
 (sound/pci/hda/patch_ca0132.c)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
References: <20181105220559.27458-1-geert@linux-m68k.org>
 <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
 <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
Date:   Tue, 6 Nov 2018 08:56:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>>
>>>> *** ERRORS ***
>>>>
>>>>    + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
>>> sh4-all{mod,yes}config
>>>
>>> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
>>> pci_iomap() on SH")
>>> is not sufficient?
>> Different problem.  This is about "select":
>>
>> config SND_SOC_ALL_CODECS
>>          tristate "Build all ASoC CODEC drivers"
>>
>> That enables (sets):
>>          select SND_SOC_HDAC_HDA
>> which selects SND_HDA even though CONFIG_PCI is not enabled.
>>
>> After SND_HDA is selected (above), the Kconfig symbols in
>> sound/pci/hda/Kconfig are available for enabling, so
>> SND_HDA_CODEC_CA0132 is enabled but will not build.
> Thanks for looking into this!
>
>> One simple solution (but possibly too naive) is:
>>
>> ---
>>   sound/soc/codecs/Kconfig |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
>> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
>> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
>>          select SND_SOC_ES7241
>>          select SND_SOC_GTM601
>>          select SND_SOC_HDAC_HDMI
>> -       select SND_SOC_HDAC_HDA
>> +       select SND_SOC_HDAC_HDA if PCI
>>          select SND_SOC_ICS43432
>>          select SND_SOC_INNO_RK3036
>>          select SND_SOC_ISABELLE if I2C
> I guess that will work. There are already plenty of "select foo if bar" lines.
> However, looking at what else can enable SND_HDA, I think it should be
>
>      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

This codec can only be used by the Skylake driver (and the upcoming SOF 
one). For Tegra this module will never be used unless they follow the 
same path of enabling ASoC to deal with the HDaudio codecs instead of 
the legacy.

Likewise HDAC_HDMI will only work on Intel platforms for now.

>
> That still leaves the issue that pci_iomap() on SH should be an empty stub if
> PCI is not available, like on other architectures.

I thought Mark Brown provided a fix to SH maintainers?


