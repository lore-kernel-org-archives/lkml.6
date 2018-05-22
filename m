Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEVBJD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 21:09:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47088 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752062AbeEVBJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 21:09:02 -0400
Subject: Re: sound/soc//codecs/pcm1789.c:247:19: error: implicit declaration
 of function 'devm_gpiod_get_optional'
To: kbuild test robot <lkp@intel.com>,
        =?UTF-8?Q?Myl=c3=a8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <201805220838.a6Vu2I8T%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <928b3b97-ab32-e4c6-8fe3-0bbd372aa483@infradead.org>
Date: Mon, 21 May 2018 18:08:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <201805220838.a6Vu2I8T%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 05:57 PM, kbuild test robot wrote:
> Hi Mylène,
> 
> FYI, the error/warning still remains.

Just needs this patch:
https://marc.info/?l=alsa-devel&m=152644577507060&w=2

Thanks.

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c85061e6e0ee07e131b929e6a17bb2e20d19b321
> commit: 4ae340d1be36378505498606e6c640dd0507ad61 ASoC: codecs: Add support for PCM1789
> date:   9 weeks ago
> config: x86_64-randconfig-s2-05220828 (attached as .config)
> compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
> reproduce:
>         git checkout 4ae340d1be36378505498606e6c640dd0507ad61
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc//codecs/pcm1789.c: In function 'pcm1789_common_init':
>>> sound/soc//codecs/pcm1789.c:247:19: error: implicit declaration of function 'devm_gpiod_get_optional' [-Werror=implicit-function-declaration]
>      pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>                       ^~~~~~~~~~~~~~~~~~~~~~~
>>> sound/soc//codecs/pcm1789.c:247:57: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
>      pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>                                                             ^~~~~~~~~~~~~~
>    sound/soc//codecs/pcm1789.c:247:57: note: each undeclared identifier is reported only once for each function it appears in
>>> sound/soc//codecs/pcm1789.c:251:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror=implicit-function-declaration]
>      gpiod_set_value_cansleep(pcm1789->reset, 0);
>      ^~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/devm_gpiod_get_optional +247 sound/soc//codecs/pcm1789.c
> 
>    233	
>    234	int pcm1789_common_init(struct device *dev, struct regmap *regmap)
>    235	{
>    236		struct pcm1789_private *pcm1789;
>    237	
>    238		pcm1789 = devm_kzalloc(dev, sizeof(struct pcm1789_private),
>    239				       GFP_KERNEL);
>    240		if (!pcm1789)
>    241			return -ENOMEM;
>    242	
>    243		pcm1789->regmap = regmap;
>    244		pcm1789->dev = dev;
>    245		dev_set_drvdata(dev, pcm1789);
>    246	
>  > 247		pcm1789->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>    248		if (IS_ERR(pcm1789->reset))
>    249			return PTR_ERR(pcm1789->reset);
>    250	
>  > 251		gpiod_set_value_cansleep(pcm1789->reset, 0);
>    252		msleep(300);
>    253	
>    254		INIT_WORK(&pcm1789->work, pcm1789_work_queue);
>    255	
>    256		return devm_snd_soc_register_component(dev, &soc_component_dev_pcm1789,
>    257						       &pcm1789_dai, 1);
>    258	}
>    259	EXPORT_SYMBOL_GPL(pcm1789_common_init);
>    260	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
