Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D9AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 751572147E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 08:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vfoE3DoM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751572147E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbeHYMJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 08:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbeHYMJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 08:09:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E36920C51;
        Sat, 25 Aug 2018 08:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535185860;
        bh=LY6/wcQgM3ZcJk17EzSyELyLVriu5+NMEUBP0QLSNLQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vfoE3DoMwgKVZ5syxCf3WHsVYaGBCWtJXyrVTd7cIhXWbkMSRo+8m9R6BPC3M3iSv
         G9hMpDRxvFtAYqzDmBsmOZQfKFVZk3RN8S//Q+k0+S3ZxgAXfuz7YQ1tzjJmwlMBqb
         v2NDOp9dNgW4qXK/949+CM0kOClPFjLgd4XJBaqc=
Date:   Sat, 25 Aug 2018 09:30:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29501: Simplify code to kill compiler
 warning
Message-ID: <20180825093055.2cee2159@archlinux>
In-Reply-To: <20180823212436.17423-1-geert@linux-m68k.org>
References: <20180823212436.17423-1-geert@linux-m68k.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Aug 2018 23:24:35 +0200
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> With gcc 4.1.2:
>=20
>     drivers/iio/proximity/isl29501.c: In function =E2=80=98isl29501_regis=
ter_write=E2=80=99:
>     drivers/iio/proximity/isl29501.c:235: warning: =E2=80=98msb=E2=80=99 =
may be used uninitialized in this function
>=20
> While this is a false positive, it can easily be avoided by removing the
> "msb" intermediate variable.
> Remove the "lsb" intermediate variable for consistency.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Looks sensible to me, but I'd obviously like to leave a little time for=20
Mathieu to comment as it's his driver.

Jonathan

> ---
> Compile-tested only.
> ---
>  drivers/iio/proximity/isl29501.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl=
29501.c
> index e5e94540f404dd2c..5ae549075b27c50d 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -232,7 +232,6 @@ static u32 isl29501_register_write(struct isl29501_pr=
ivate *isl29501,
>  				   u32 value)
>  {
>  	const struct isl29501_register_desc *reg =3D &isl29501_registers[name];
> -	u8 msb, lsb;
>  	int ret;
> =20
>  	if (!reg->msb && value > U8_MAX)
> @@ -241,22 +240,15 @@ static u32 isl29501_register_write(struct isl29501_=
private *isl29501,
>  	if (value > U16_MAX)
>  		return -ERANGE;
> =20
> -	if (!reg->msb) {
> -		lsb =3D value & 0xFF;
> -	} else {
> -		msb =3D (value >> 8) & 0xFF;
> -		lsb =3D value & 0xFF;
> -	}
> -
>  	mutex_lock(&isl29501->lock);
>  	if (reg->msb) {
>  		ret =3D i2c_smbus_write_byte_data(isl29501->client,
> -						reg->msb, msb);
> +						reg->msb, value >> 8);
>  		if (ret < 0)
>  			goto err;
>  	}
> =20
> -	ret =3D i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
> +	ret =3D i2c_smbus_write_byte_data(isl29501->client, reg->lsb, value);
> =20
>  err:
>  	mutex_unlock(&isl29501->lock);

