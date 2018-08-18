Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C306C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 157A721767
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="cyKDHv7c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 157A721767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbeHRQKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:10:14 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:59680 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbeHRQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:10:14 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id CC4165C11DF;
        Sat, 18 Aug 2018 15:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1534597351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/GwdlPhuLnxCVxTOWoSMZC1cZSvbOR/r3dZmLFUMaY=;
        b=cyKDHv7cperVFIAN36Gvbrb5a0bP1H/X2P3r5gwQyJUbe/xnzwti7hpRhsinVl3r2nxmmB
        QkWvw0aO7/pQU/qpYoYSAzRqZ0x4ImDmiJ4FnhQFBR2iCdbyzCRln9So1vx/NuoedfwZeZ
        4HyCI4g4uvZTjyllpXrmQyk3mlU4kwI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sat, 18 Aug 2018 15:02:31 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Marcel Ziswiler <marcel@ziswiler.com>, alsa-devel@alsa-project.org,
        linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] ASoC: tegra: probe deferral error reporting
In-Reply-To: <930b05df-c502-192e-3cb9-9e1874701cce@nvidia.com>
References: <20180814140145.12212-1-marcel@ziswiler.com>
 <930b05df-c502-192e-3cb9-9e1874701cce@nvidia.com>
Message-ID: <1edf4e289d6ede7d6bac43a6a9fdb613@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.08.2018 18:02, Jon Hunter wrote:
> On 14/08/18 15:01, Marcel Ziswiler wrote:
>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> Actually report the error codes from of_get_named_gpio() resp.
>> devm_gpio_request_one() upon trying to get the codec reset resp. sync
>> GPIOs unless it is just a probe deferral.
>>
>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>
>> ---
>>
>> Changes in v2:
>> - Silence probe deferral as suggested by Stefan.
>> - Fix line over 80 characters as reported by checkpatch.
>>
>>  sound/soc/tegra/tegra20_ac97.c | 19 ++++++++++++++++---
>>  1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/tegra/tegra20_ac97.c b/sound/soc/tegra/tegra20_ac97.c
>> index 682ef33afb5f..2ac6b2d73980 100644
>> --- a/sound/soc/tegra/tegra20_ac97.c
>> +++ b/sound/soc/tegra/tegra20_ac97.c
>> @@ -351,18 +351,31 @@ static int tegra20_ac97_platform_probe(struct platform_device *pdev)
>>  		ret = devm_gpio_request_one(&pdev->dev, ac97->reset_gpio,
>>  					    GPIOF_OUT_INIT_HIGH, "codec-reset");
>>  		if (ret) {
>> -			dev_err(&pdev->dev, "could not get codec-reset GPIO\n");
>> +			if (ret != -EPROBE_DEFER)
>> +				dev_err(&pdev->dev,
>> +					"could not get codec-reset GPIO: %d\n",
>> +					ret);
>> +
>>  			goto err_clk_put;
>>  		}
>>  	} else {
>> -		dev_err(&pdev->dev, "no codec-reset GPIO supplied\n");
>> +		ret = ac97->reset_gpio;
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev,
>> +				"no codec-reset GPIO supplied: %d\n",
>> +				ret);
>> +
>>  		goto err_clk_put;
>>  	}
>>
>>  	ac97->sync_gpio = of_get_named_gpio(pdev->dev.of_node,
>>  					    "nvidia,codec-sync-gpio", 0);
>>  	if (!gpio_is_valid(ac97->sync_gpio)) {
>> -		dev_err(&pdev->dev, "no codec-sync GPIO supplied\n");
>> +		ret = ac97->sync_gpio;
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err(&pdev->dev, "no codec-sync GPIO supplied: %d\n",
>> +				ret);
>> +
>>  		goto err_clk_put;
>>  	}
> 
> Thanks, looks good to me. However, I wonder why we don't request the
> 'sync_gpio' in the probe like we do for the reset? Otherwise ...

The comment in tegra20_ac97_codec_warm_reset() is probably the reason:

/*
 * although sync line is driven by the DAC pad group warm reset using
 * the controller cmd is not working, have to toggle sync line
 * manually.
 */

I guess the GPIO need to be freed so that the DAC pad group can use the
sync line?

> 
> Acked-by: Jon Hunter <jonathanh@nvidia.com>

Also looks good to me:

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan
