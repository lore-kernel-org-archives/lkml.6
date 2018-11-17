Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B7C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1666320817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwT2pJIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1666320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeKRDWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:22:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726128AbeKRDWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:22:40 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B842080D;
        Sat, 17 Nov 2018 17:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542474322;
        bh=6x4OsypFqLZD2F1LcmDqLP//eVnDUH0QmBGSAMWnoPM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qwT2pJIvrIuT3SzJsb7l5WosYp2tnNOOkZSGdIXg7U2Bksn3wd3w1F+9D1DUsmGMF
         cc80Zq8nKezLy9Z6QPoM8dx6L075QuYwvL6zBdm2st+lEzfyhiPHneJMg2k6UIKGDm
         xUFhxY8jlapN6ZDiWIqABKHXq5NpgQ22469GKMBA=
Date:   Sat, 17 Nov 2018 17:05:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] Staging: iio: adt7316: Add of_device_id table
Message-ID: <20181117170517.29ebecdd@archlinux>
In-Reply-To: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
References: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Nov 2018 04:25:37 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> When the kernel starts up, it kicks off compiled-in drivers
> that match =E2=80=9Ccompatible=E2=80=9D entries it finds in the device tr=
ee.
> At a later stage (when /lib/modules is available), all kernel modules
> that match =E2=80=9Ccompatible=E2=80=9D entries in the device tree are lo=
aded.
> Hence to be able to use device tree for ADT7316, add of_device_id
> table which specifies the supported devices through compatible
> property.
> Note that there is a fall back path in i2c that will result
> in i2c_device_id table being used if there is no of_devcie_id table.
of_device_id

Should also assign of_match_table in the driver structure so that
we will use these to match when probing rather than just
for module autoloading which is what this does.  See for
example drivers/adc/max1363.c

Do not use of_match_ptr, just assign directly to avoid blocking
the random ACPI probing with DT bindings route.

This does make me wonder if the adt7518 is compatible or not
as those are fairly random part numbers!

Thanks,

Jonathan
>=20
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
>  drivers/staging/iio/addac/adt7316-i2c.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/ii=
o/addac/adt7316-i2c.c
> index 473e5e34ec00..d4b5060c18ee 100644
> --- a/drivers/staging/iio/addac/adt7316-i2c.c
> +++ b/drivers/staging/iio/addac/adt7316-i2c.c
> @@ -126,6 +126,18 @@ static const struct i2c_device_id adt7316_i2c_id[] =
=3D {
> =20
>  MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
> =20
> +static const struct of_device_id adt7316_of_match[] =3D {
> +	{ .compatible =3D "adi,adt7316" },
> +	{ .compatible =3D "adi,adt7317" },
> +	{ .compatible =3D "adi,adt7318" },
> +	{ .compatible =3D "adi,adt7516" },
> +	{ .compatible =3D "adi,adt7517" },
> +	{ .compatible =3D "adi,adt7519" },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, adt7316_of_match);
> +
>  static struct i2c_driver adt7316_driver =3D {
>  	.driver =3D {
>  		.name =3D "adt7316",

