Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF9FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F19208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk2YG8Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07F19208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbeH0VBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbeH0VBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:01:13 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7303208B4;
        Mon, 27 Aug 2018 17:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535390025;
        bh=LPe+qoDzPAdko8ur91kmRTODDdL/M4AVAWrcTtzg7OQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fk2YG8Z5SgmSK9Izm8s+LoOaPbskyzzla+2l2Hg0IBJtKFEhoRy/9mMEoqYJEUSSX
         F3hjR27M9rNRAOnkHqWfPZanKHnG4JSUHZ45RR3e8YdoLW06eZABXkLlUTwQc/lT7m
         85k0Wm6M4Qfvcol+eTby8my5jcTmlfCoOmDtZYac=
Date:   Mon, 27 Aug 2018 18:13:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180827181341.6563c0bf@archlinux>
In-Reply-To: <20180825211910.22929-2-afonsobordado@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180825211910.22929-2-afonsobordado@az8.co>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 22:19:08 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> This patch adds device tree support for the fxas21002c driver, including
> bindings.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
Now, the devicetree bindings should not reflect just what the driver
uses right now, but rather describe the hardware.

There are interrupts on there for starters that definitely want to be
described from the start.  Also there is a reset line that should probably
be here from the start.

Potentially also the two power supplies though that's less critical
(nice to have though)

It is also an i2c and spi part though that can probably be added later as
we can argue we are only documenting the bindings for the device in i2c mode
for now.

So what is here is fine, but I think we need to describe more.

It's all well understood details of how it is connected so no need to
have tested it with a driver to be sure it will be right.

Jonathan

> ---
>  .../bindings/iio/gyroscope/fsl,fxas21002c.txt        | 12 ++++++++++++
>  drivers/iio/gyro/fxas21002c.c                        | 10 +++++++++-
>  2 files changed, 21 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> new file mode 100644
> index 000000000000..62f8c1bad85a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/fsl,fxas21002c.txt
> @@ -0,0 +1,12 @@
> +* Freescale FXAS21002C Digital Angular Rate Gyroscope
> +
> +Required properties:
> +
> +  - compatible: must be "fsl,fxas21002c"
> +  - reg : the I2C address of the sensor
> +
> +Example:
> +gyroscope@0 {
> +       compatible = "fsl,fxas21002c";
> +       reg = <0x20>;
> +};
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> index 7626b2f88d72..6fef210630e0 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -8,7 +8,6 @@
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
>   *        ODR / Scale Support
> - *        Devicetree
>   *        Power management
>   *        LowPass/HighPass Filters
>   *        Buffers
> @@ -340,6 +339,14 @@ static int fxas21002c_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id fxas21002c_of_ids[] = {
> +	{.compatible = "fsl,fxas21002c"},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
> +#endif
> +
>  static const struct i2c_device_id fxas21002c_id[] = {
>  	{"fxas21002c", ID_FXAS21002C},
>  	{}
> @@ -350,6 +357,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
>  static struct i2c_driver fxas21002c_driver = {
>  	.driver = {
>  		.name = FXAS21002C_DRV_NAME,
> +		.of_match_table = of_match_ptr(fxas21002c_of_ids),
>  	},
>  	.probe		= fxas21002c_probe,
>  	.remove		= fxas21002c_remove,

