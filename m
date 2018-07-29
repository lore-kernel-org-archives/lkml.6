Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E1FA3737
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1920870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 09:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1920870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeG2KvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 06:51:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46583 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbeG2KvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 06:51:14 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1fjht5-0007jj-1O; Sun, 29 Jul 2018 10:21:15 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 29 Jul 2018 10:21:14 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     kbuild test robot <lkp@intel.com>
Cc:     Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        kbuild-all@01.org, linux-tegra@vger.kernel.org
Subject: Re: [Linux-kernel] [PATCH 3/4] ASoC: tegra: Allow 32-bit and 24-bit
 samples
In-Reply-To: <201807290647.ybnC01Ii%fengguang.wu@intel.com>
References: <20180727125931.9794-4-jorge.sanjuan@codethink.co.uk>
 <201807290647.ybnC01Ii%fengguang.wu@intel.com>
Message-ID: <0e990da63c37ef2bc0babc9ee96ef798@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-07-28 23:28, kbuild test robot wrote:
> Hi Edward,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on tegra/for-next]
> [also build test ERROR on v4.18-rc6 next-20180727]
> [if your patch is applied to the wrong git tree, please drop us a note
> to help improve the system]
> 
> url:
> https://github.com/0day-ci/linux/commits/Jorge-Sanjuan/ASoC-Tegra30-TDM-support/20180728-163720
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git 
> for-next
> config: arm-multi_v7_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm
> 
> Note: the
> linux-review/Jorge-Sanjuan/ASoC-Tegra30-TDM-support/20180728-163720
> HEAD 14bbc96df0fa027f7bc057eb2da8181baff4e22c builds fine.
>       It only hurts bisectibility.
> 
> All errors (new ones prefixed by >>):
> 
>    sound/soc/tegra/tegra30_i2s.c: In function 'tegra30_i2s_hw_params':
>>> sound/soc/tegra/tegra30_i2s.c:155:3: error: 'audio_bits' undeclared 
>>> (first use in this function); did you mean 'audit_names'?
>       audio_bits = TEGRA30_AUDIOCIF_BITS_24;
>       ^~~~~~~~~~
>       audit_names
>    sound/soc/tegra/tegra30_i2s.c:155:3: note: each undeclared
> identifier is reported only once for each function it appears in
> 
> vim +155 sound/soc/tegra/tegra30_i2s.c
> 
>    133
>    134	static int tegra30_i2s_hw_params(struct snd_pcm_substream 
> *substream,
>    135					 struct snd_pcm_hw_params *params,
>    136					 struct snd_soc_dai *dai)
>    137	{
>    138		struct device *dev = dai->dev;
>    139		struct tegra30_i2s *i2s = snd_soc_dai_get_drvdata(dai);
>    140		unsigned int mask, val, reg;
>    141		int ret, sample_size, srate, i2sclock, bitcnt;
>    142		struct tegra30_ahub_cif_conf cif_conf;
>    143
>    144		if (params_channels(params) != 2)
>    145			return -EINVAL;
>    146
>    147		mask = TEGRA30_I2S_CTRL_BIT_SIZE_MASK;
>    148		switch (params_format(params)) {
>    149		case SNDRV_PCM_FORMAT_S16_LE:
>    150			val = TEGRA30_I2S_CTRL_BIT_SIZE_16;
>    151			sample_size = 16;
>    152			break;
>    153		case SNDRV_PCM_FORMAT_S24_LE:
>    154			val = TEGRA30_I2S_CTRL_BIT_SIZE_24;
>  > 155			audio_bits = TEGRA30_AUDIOCIF_BITS_24;
>    156			sample_size = 24;
>    157			break;
>    158		case SNDRV_PCM_FORMAT_S32_LE:
>    159			val = TEGRA30_I2S_CTRL_BIT_SIZE_32;
>    160			sample_size = 32;
>    161			break;
>    162		default:
>    163			return -EINVAL;
>    164		}
> 

looks like we failed to merge in a fix from later in the internal
series we have.

jorge: can we get the channel fix from here into this patch and 
resubmit?

commit dd439f5f0b748eba43da7f18cabec8850dcd18b1
Author: Edward Cragg <edward.cragg@codethink.co.uk>
Date:   Thu Sep 15 17:01:49 2016 +0100

     ASoC: tegra: i2s: Add support for more than 2 channels


