Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA86ECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A1821476
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtFtsrg3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A1821476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbeIPPHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:07:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbeIPPHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:07:46 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ADF92087E;
        Sun, 16 Sep 2018 09:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537091125;
        bh=vVt/mQWCTpC1dp6dJ+o5VLhq7AtKcJU3iNvTg17WBGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtFtsrg3oXS59CueOdeQtzKAL2XR0+ziCSd0oG2CWOB2e+Xzkkw6uykZQGvBY/0gB
         8kDtmTF4csyhgQJP8+gDnaihUu/ePjERO6IpFkGmAQf83Olf+Pon0FYLE8hGAotKZU
         PK0bNbKJ3TuYEmuzUssH/x15hQlfnGDCT7AJszvs=
Date:   Sun, 16 Sep 2018 10:45:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ryang <decatf@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1750: Add device tree support
Message-ID: <20180916104526.2c386591@archlinux>
In-Reply-To: <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
References: <c414a26cdc176d9982f3c609fa39cf245ac939be.1537033044.git.decatf@gmail.com>
        <387c145949692c0318f90d98426be95c82ea2e58.1537033044.git.decatf@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Sep 2018 13:42:14 -0400
ryang <decatf@gmail.com> wrote:

> Add device tree support for ROHM BH1750 series ambient light sensors.
> 
> Signed-off-by: ryang <decatf@gmail.com>
Just to check, how is it picking up on the enum value which is provided
in the i2c_device_id entries?

i.e. What is setting id->driver_data in the probe?
There may be something in the i2c core that I'm missing that will do the
association but I don't remember anything trying to do this.

Jonathan

> ---
>  drivers/iio/light/bh1750.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
> index a814828e69f5..50b599abb383 100644
> --- a/drivers/iio/light/bh1750.c
> +++ b/drivers/iio/light/bh1750.c
> @@ -315,9 +315,19 @@ static const struct i2c_device_id bh1750_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, bh1750_id);
>  
> +static const struct of_device_id bh1750_of_match[] = {
> +	{ .compatible = "rohm,bh1710", },
> +	{ .compatible = "rohm,bh1715", },
> +	{ .compatible = "rohm,bh1721", },
> +	{ .compatible = "rohm,bh1750", },
> +	{ .compatible = "rohm,bh1751", },
> +	{ }
> +};
> +
>  static struct i2c_driver bh1750_driver = {
>  	.driver = {
>  		.name = "bh1750",
> +		.of_match_table = of_match_ptr(bh1750_of_match),
>  		.pm = BH1750_PM_OPS,
>  	},
>  	.probe = bh1750_probe,

