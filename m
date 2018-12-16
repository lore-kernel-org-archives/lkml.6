Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC80C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B98D321839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544961564;
	bh=H++/7yGd5WGvrdilgvsCYCAdVkH/i0RPLtdlOZiM/3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JcIkX4TqNDudQToDJKqAlQOybKvJYyE9pFqt/xvr8FHpKh1WVeDqSyzgyqdrsi8ER
	 2+xwUqlZekzfd4zjMqCkNsRB7FakEp8Kzg9oatUE7CO6O19Mta6THHaPsVLMxY9uhB
	 r7g5b793BH5TUuDKoMxtr3iDXAcWtE+cv0gVfNas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbeLPL7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:59:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730021AbeLPL7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:59:23 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF343217FA;
        Sun, 16 Dec 2018 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544961562;
        bh=H++/7yGd5WGvrdilgvsCYCAdVkH/i0RPLtdlOZiM/3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RWjc89Rlk1KdV72SYwJOfyXH14awr3pjkIqeJ9Qvaffvf/PtZlXbkDrRCMixOXt0C
         HcaR2mzEPvYI4jniiTZMjniJshC/XAXgBEasDiSp0nGsQA/q5VrumpGJ0ai97KgYSU
         Z81klGRcXa0/m7D3UirJV47T2SHm7TQhmkNpWC1g=
Date:   Sun, 16 Dec 2018 11:59:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jeremy Fertic <jeremyfertic@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/11] staging: iio: adt7316: change interpretation of
 write to dac update mode
Message-ID: <20181216115917.0c9739eb@archlinux>
In-Reply-To: <20181212005503.28054-11-jeremyfertic@gmail.com>
References: <20181212005503.28054-1-jeremyfertic@gmail.com>
        <20181212005503.28054-11-jeremyfertic@gmail.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 17:55:02 -0700
Jeremy Fertic <jeremyfertic@gmail.com> wrote:

> Based on the output of adt7316_show_all_DAC_update_modes() and
> adt7316_show_DAC_update_mode(), adt7316_store_DAC_update_mode() should
> expect the user to enter an integer input from 0 to 3. The user input is
> currently expected to account for the actual bit positions in the register.
> For example, choosing option 3 would require a write of 0x30 (actually 48
> since it expects base 10). To address this inconsistency, create a shift
> macro to be used in the valid input check as well as the calculation for
> the register write.
> 
> Signed-off-by: Jeremy Fertic <jeremyfertic@gmail.com>
As I mentioned, long term this interface is going to need to be replaced
with something more generic.  Probably something like the power down
modes where we use a string to describe what is going on on.

Still this is a step in the right direction even if we may go further
shortly!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it,

Thanks,

Jonathan

> ---
> I'm not sure if this patch is appropriate since it's making a user visible
> change. I've included it since the driver is still in staging.
> 
>  drivers/staging/iio/addac/adt7316.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index bca599d8c51c..58b462ad0c83 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -129,6 +129,7 @@
>   */
>  #define ADT7316_DA_2VREF_CH_MASK	0xF
>  #define ADT7316_DA_EN_MODE_MASK		0x30
> +#define ADT7316_DA_EN_MODE_SHIFT	4
>  #define ADT7316_DA_EN_MODE_SINGLE	0x00
>  #define ADT7316_DA_EN_MODE_AB_CD	0x10
>  #define ADT7316_DA_EN_MODE_ABCD		0x20
> @@ -879,11 +880,11 @@ static ssize_t adt7316_store_DAC_update_mode(struct device *dev,
>  		return -EPERM;
>  
>  	ret = kstrtou8(buf, 10, &data);
> -	if (ret || data > ADT7316_DA_EN_MODE_MASK)
> +	if (ret || data > (ADT7316_DA_EN_MODE_MASK >> ADT7316_DA_EN_MODE_SHIFT))
>  		return -EINVAL;
>  
>  	dac_config = chip->dac_config & (~ADT7316_DA_EN_MODE_MASK);
> -	dac_config |= data;
> +	dac_config |= data << ADT7316_DA_EN_MODE_SHIFT;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
>  	if (ret)

