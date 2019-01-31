Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36DCC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CDB218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akTQCSLf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbfAaMsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:48:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33063 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbfAaMsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:48:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id p7so3190526wru.0;
        Thu, 31 Jan 2019 04:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yd43TovcFvn+gTu3MXDUxMgu2UPcVgf1mZ4D2qpgkmQ=;
        b=akTQCSLfMZvazv1E64Dfc+P7eWHwUWlj1Xupp/q9WOhOnESLJaxTwrf5oAgIQR0eFp
         vVHU++ndgynNBOVq6CT6HbpWewg9sadINV01Hbuuxod2pwbwq1e0MEPpoAI4HFPzvFmJ
         lmERuDNPMk5ncL/gmpRKzDC28cnAxytltQpSSULrp7AueX5GQodI28yQBMRuX1ujqYBC
         +goF1Z30NtvHUx2XwycMMHZINDi4dPmbXlW7tg+GLCdvOSWhKEilVrLLZ5quOAMPXslG
         DlZqWD99lm9Zoh95uNDPeRqaoIvmNgHGvkTvqITA44j+rbVQsPqpj7Uzkw7IAKecFugI
         dLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yd43TovcFvn+gTu3MXDUxMgu2UPcVgf1mZ4D2qpgkmQ=;
        b=X+IDsp1X5QYAFzAAeeC8eLxz7/95f+UXjk1RvSDodOoF/6ZKVcqip8sGLB6ilZD6pK
         +Tvod/A2NyA7b3TaSK/spJffSyzZ/sGLsv+nRSVO/PzIAsNF2PiV4Uc7iR2h4kVg5uDF
         U0Er4iIDpdz/VFsHo6J/9o9jgC/e2SVIw3C0UXKU3L/62bHM+aJqG+KVqNRqs1UV/JuS
         /PNclj7PBH5tWN+0RZCasHa2VbzuyR5NKONc/0e7r8a+lutBy4UG2XCFADpWaRRyBFMZ
         LOObmi5nUVWWWogTFXlHbCa6yULy00FinovtHkYTjNJqJVwUq26khV5geNiY1qnIUnwk
         gdLQ==
X-Gm-Message-State: AJcUukdbHC5uZi4ylAmgHGA5OAciPmSwcEdZj+18tXFfj/J9hLgOz3Oa
        MmuwT0IJasgr+muP1UW57c9O97+T+8c=
X-Google-Smtp-Source: ALg8bN74ErqOd/ePEuO/9fNfd00nN4cFK+qtIHw9IudEJmhpTzFrbdzuTdwtwljepSxPFaYRnkzPMA==
X-Received: by 2002:adf:f009:: with SMTP id j9mr33783666wro.170.1548938894549;
        Thu, 31 Jan 2019 04:48:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id k19sm9630268wre.5.2019.01.31.04.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 04:48:13 -0800 (PST)
Date:   Thu, 31 Jan 2019 13:48:13 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Subject: Re: [PATCH V8 4/5] i2c: tegra: Update transfer timeout
Message-ID: <20190131124813.GJ23438@ulmo>
References: <1548915387-28826-1-git-send-email-skomatineni@nvidia.com>
 <1548915387-28826-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kr14OxHsRwZHHqxS"
Content-Disposition: inline
In-Reply-To: <1548915387-28826-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kr14OxHsRwZHHqxS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 30, 2019 at 10:16:26PM -0800, Sowjanya Komatineni wrote:
> Tegra194 allows max of 64K bytes and Tegra186 and prior allows
> max of 4K bytes of transfer per packet.
>=20
> one sec timeout is not enough for transfers more than 10K bytes
> at STD bus rate.
>=20
> This patch updates I2C transfer timeout based on the transfer size
> and I2C bus rate to allow enough time during max transfer size at
> lower bus speed.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V8] : Added comment with explaination of xfer time calculation
>  [V5/V6/V7] : Same as V4
>  [V4] : V4 series includes bus clear support and this patch is updated wi=
th
> 	fixed timeout of 1sec for bus clear operation.
>  [V3] : Same as V2
>  [V2] : Added this patch in V2 series to allow enough time for data trans=
fer
> 	to happen.
> 	This patch has dependency with DMA patch as TEGRA_I2C_TIMEOUT define
> 	takes argument with this patch.
>=20
>  drivers/i2c/busses/i2c-tegra.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index 025d63972e50..435518cd91b6 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -25,7 +25,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> =20
> -#define TEGRA_I2C_TIMEOUT (msecs_to_jiffies(1000))
> +#define TEGRA_I2C_TIMEOUT(ms) (msecs_to_jiffies(ms))

I think I would've just gone with direct usage of msecs_to_jiffies() but
this is also fine.

>  #define BYTES_PER_FIFO_WORD 4
> =20
>  #define I2C_CNFG				0x000
> @@ -901,8 +901,9 @@ static int tegra_i2c_issue_bus_clear(struct tegra_i2c=
_dev *i2c_dev)
>  		i2c_writel(i2c_dev, reg, I2C_BUS_CLEAR_CNFG);
>  		tegra_i2c_unmask_irq(i2c_dev, I2C_INT_BUS_CLR_DONE);
> =20
> -		time_left =3D wait_for_completion_timeout(&i2c_dev->msg_complete,
> -							TEGRA_I2C_TIMEOUT);
> +		time_left =3D wait_for_completion_timeout(
> +						&i2c_dev->msg_complete,
> +						TEGRA_I2C_TIMEOUT(1000));
>  		if (time_left =3D=3D 0) {
>  			dev_err(i2c_dev->dev, "timed out for bus clear\n");
>  			return -ETIMEDOUT;
> @@ -930,6 +931,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i=
2c_dev,
>  	int err =3D 0;
>  	bool dma =3D false;
>  	struct dma_chan *chan;
> +	u16 xfer_time =3D 100;
> =20
>  	tegra_i2c_flush_fifos(i2c_dev);
> =20
> @@ -945,6 +947,13 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *=
i2c_dev,
>  		xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> =20
>  	xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> +	/*
> +	 * Transfer time =3D Total bits / transfer rate
> +	 * Total bits =3D 9 bits per byte (including ACK bit) + Start & stop bi=
ts
> +	 */
> +	xfer_time +=3D DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * 1000,

This doesn't really explain the factor of 1000 in there, which I assume
is just to scale this to milliseconds required by msecs_to_jiffies().
Might be worth to replace it by MSEC_PER_SEC to clarify the purpose.

With that fixed:

Acked-by: Thierry Reding <treding@nvidia.com>

--kr14OxHsRwZHHqxS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxS7owACgkQ3SOs138+
s6E76xAAvSz9qAlZnj7BW53L1XZQeW7kegHf0EWkwPTJ4Y5xOBK/K6vmPzoiktAb
B7IvwQs5MWFz1QN8T3ElgWKBffzpUrxk9jdMM77xqKEOuPPmpx4s1w5H9l47aSkc
krq4Su92XeHGzbB8+kDJvTYEUjqgMI7r0gUEU1qnHyFb1Rzcz/vfgP7BHYPKMhKx
hwWkPchG/TyVvKqhbaaUdMQt4Q5i9hNlN2ZftjQMHQOe1PTWaFV/yc+Y+xkCSTJB
fXtz/iq9XD4TbJkbKAaeECkNaGsteq4kfmmG9v7yqiocEo0zz85NfoFNn97Ax8mU
gJQvwNgQMbN5LW9oNfK0lg9t8ksMIaCA8WVGFXu8+2oDzp8PiAhrUNdzu1SWo+6s
gW4JDdj5uEywtS/qOKm/Owjkhd2It5b+EyvFSr7N/lw1AnCZoXcC0BVNazqmBews
iB8XYgOvN+lxGDhTynCDfWAEykArqfYYY3jLEdVD8wNI57QuTfRHZay6V5qW2i+Q
lZz3NKjI8Pe117A2N/+QP7GHRLQub+9+6B9DaFW+aAmGnSSOL4yfW15pGSl2eXql
Avd49+hSYtyJEb/S9dm7ywO0M35hIcPjU++7NrQFxhX6NSpAm/kNu6/jcQTvh9M8
PW/74CRENFdPWyjX5zQ3Hn5Be0lqFs9++fIg1csSVcJvWDhVm7A=
=yHym
-----END PGP SIGNATURE-----

--kr14OxHsRwZHHqxS--
