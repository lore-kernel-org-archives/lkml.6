Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4BEC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11191205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11191205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeH2TS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:18:27 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:59309 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeH2TS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:18:26 -0400
X-IronPort-AV: E=Sophos;i="5.53,303,1531810800"; 
   d="scan'208";a="19723295"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Aug 2018 08:21:00 -0700
Received: from [10.145.4.68] (10.10.76.4) by chn-sv-exch05.mchp-main.com
 (10.10.76.106) with Microsoft SMTP Server id 14.3.352.0; Wed, 29 Aug 2018
 08:20:59 -0700
Subject: Re: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a
 WM8731)
To:     Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <nicolas.ferre@microchip.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <florian.meier@koalo.de>,
        <cristian.birsan@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Date:   Wed, 29 Aug 2018 18:20:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180829145355.GD27808@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.08.2018 17:53, Mark Brown wrote:
> On Wed, Aug 29, 2018 at 05:47:26PM +0300, Codrin Ciubotariu wrote:
> 
>> +static const unsigned int wm8731_rates_12288000[] = {
>> +	8000, 32000, 48000, 96000,
>> +};
>> +
>> +static struct snd_pcm_hw_constraint_list wm8731_constraints_12288000 = {
>> +	.list = wm8731_rates_12288000,
>> +	.count = ARRAY_SIZE(wm8731_rates_12288000),
>> +};
>> +
>> +static int snd_proto_startup(struct snd_pcm_substream *substream)
>> +{
>> +	/* Setup constraints, because there is a 12.288 MHz XTAL on the board */
>> +	snd_pcm_hw_constraint_list(substream->runtime, 0,
>> +				   SNDRV_PCM_HW_PARAM_RATE,
>> +				   &wm8731_constraints_12288000);
>> +	return 0;
>> +}
> 
> This bit is better added to the CODEC driver since it'll apply to any
> system where there's this clock rate (someone else could come in and add
> other rates, no need to do that yourself though it'd be nice of course).

I could do it.

> 
> That also has the nice bonus that with that I think you'd be able to use
> the graph card rather than a custom driver?

The main reason for adding a custom driver and not using graph/simple 
card is the snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL, 
                              XTAL_RATE, SND_SOC_CLOCK_IN) call. This 
enables the oscillator found in the wm8731 codec. Since 
WM8731_SYSCLK_XTAL is not 0, we can't use system-clock-frequency DT 
property to set it.

Best regards,
Codrin

