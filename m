Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B9DC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B93214DE
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 16:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpjU/cf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B93214DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbeKLBwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 20:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:32800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbeKLBwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 20:52:01 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D180D2148E;
        Sun, 11 Nov 2018 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541952185;
        bh=VNeyg8NSZeRmrbVaYIFI39QVs1frkLEKCLsu2UGobsA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jpjU/cf1BPzfK2vTywWtne5dItEm2oaM/4UX+uaA6MwIyux2Mc0b6oBVjGxIkfhRf
         lQAJqYc9dcHezfNKzWCOdLdSAc1ynicmXCywY/piNU4jHqGGGNeA5+BAiA4eEj0OEQ
         3vV9VHzfC5lqDTv2yk9lSFu/G7f57feN9YdXX1/k=
Date:   Sun, 11 Nov 2018 16:03:00 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com, Mark Brown <broonie@kernel.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
Message-ID: <20181111160300.3193196c@archlinux>
In-Reply-To: <CAMz4kuJoJAEq1uGvwnnkbQDi8SqS+kWfpgjtmcNoutfgJDwQaw@mail.gmail.com>
References: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
        <20181111124044.52f61897@archlinux>
        <CAMz4kuJoJAEq1uGvwnnkbQDi8SqS+kWfpgjtmcNoutfgJDwQaw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Nov 2018 23:00:18 +0800
Baolin Wang <baolin.wang@linaro.org> wrote:

> Hi Jonathan,
> 
> On 11 November 2018 at 20:40, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri,  9 Nov 2018 11:25:31 +0800
> > Baolin Wang <baolin.wang@linaro.org> wrote:
> >  
> >> From: Freeman Liu <freeman.liu@unisoc.com>
> >>
> >> Sometimes the ADC controller met some problems, and it will not complete
> >> the data conversion, that will can not wake up the read process any more
> >> to block users. So we should add one maximum conversion time to avoid
> >> this issue.
> >>
> >> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>  
> > Hi.
> >
> > Patch looks good, but sounds like this is a fix so could I have a fixes
> > tag and a patch title that makes that clear?
> >
> > I think we will want this one back ported to stable by the sound of it.
> >
> > If it is just a theoretical issue then perhaps we don't need to bother.  
> 
> Thanks for your review. This patch is not one bug fix, just make the
> code more robust in case of some bad cases. So I think we do not need
> the stable tag.
Thanks.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Jonathan

> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> >> ---
> >>  drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
> >>  1 file changed, 11 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> >> index 7940b23..f7f7a189 100644
> >> --- a/drivers/iio/adc/sc27xx_adc.c
> >> +++ b/drivers/iio/adc/sc27xx_adc.c
> >> @@ -52,6 +52,9 @@
> >>  /* Timeout (ms) for the trylock of hardware spinlocks */
> >>  #define SC27XX_ADC_HWLOCK_TIMEOUT    5000
> >>
> >> +/* Timeout (ms) for ADC data conversion according to ADC datasheet */
> >> +#define SC27XX_ADC_RDY_TIMEOUT               100
> >> +
> >>  /* Maximum ADC channel number */
> >>  #define SC27XX_ADC_CHANNEL_MAX               32
> >>
> >> @@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
> >>       if (ret)
> >>               goto disable_adc;
> >>
> >> -     wait_for_completion(&data->completion);
> >> +     ret = wait_for_completion_timeout(&data->completion,
> >> +                             msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
> >> +     if (!ret) {
> >> +             dev_err(data->dev, "read ADC data timeout\n");
> >> +             ret = -ETIMEDOUT;
> >> +     } else {
> >> +             ret = 0;
> >> +     }
> >>
> >>  disable_adc:
> >>       regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,  
> >  
> 
> 
> 

