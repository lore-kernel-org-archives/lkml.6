Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B657C282C2
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C3F218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bx4hnikT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfBFT03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:26:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34367 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfBFT02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:26:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id h3so3545214pfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 11:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IO1b2rIxlXmCYusacwZhrnlrE0qF6qD/rBMjHKjItCo=;
        b=bx4hnikTeAtgC6uK10isDZORzzKECANBIJkSn7AZZs9K4s5pdbtSS3mWjpaz2oV0//
         DTef6FyNbKHG8kNxUHPy9Q3bycV37o17e5rgUFj+V3BBOnYJGGmI1T+XBtfzfn+NuQ1J
         XSpI7Ii0U2vgFX5jGDkPmXVFux3TseOZ31CzV+GXxZkUjyKKQPepGuGZNiBu4MGOBZGO
         BoMoOXlnT1plnTEVb3QUvGRao28igKV1oSMf3u8YFlbDZFO0dOf5ZuNBYB/KXp9i1OUB
         Q4vs4AjWPbQGG3bsp+YNFEAQtRiQPNn5ARGds70W2N7QHM12JNmtbfVNiJdmHcOZPb70
         9a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IO1b2rIxlXmCYusacwZhrnlrE0qF6qD/rBMjHKjItCo=;
        b=AoLHZf07YMpvsgmQaBi5FF3vxjNjCFTK2ULJGQjKs8C5KZa6cNL9zh1Ilp9/EDGqKS
         +b2CwZjN5vCcp8ZqtijmTQAVaJtD+8G9U9PYDZs2WkS5mjA8La/w+ANe3BqfL4QM3w1l
         gXEzrW9gbMlIeluOvU5Z+xfYtSauzlf6jK35qwFUoNFVUU7rctEXcdqyQpQ4sw2Yx6ot
         RHm+y2uXHYpXVQpDTsKAjsI5P3UyJTh/re/xZk6fhUXeDpFjkKsvNqjVRHDrlF3glgJZ
         E4iVdVZqFqG6NgNBNZ1VyXWM1uGa4mvbCHB8PAqpYSxjUNTDREpyXk8iukBgQGSqvnyF
         yG5g==
X-Gm-Message-State: AHQUAuYl7aBld2BC+j9rP5q/dkXC8r4jwZh0iSk0tipWVumOdmD4Q7lC
        RIh/pYYYG/HsaulXxdCN0oiYMQ==
X-Google-Smtp-Source: AHgI3IZW7ScvqCwucqao0NXO6vkUkfFSTax1HVPQc/Wbsl2Mq2VN+pkeu8NfdzMXD1XEjQHr6VVRXw==
X-Received: by 2002:a65:6542:: with SMTP id a2mr10953238pgw.389.1549481186333;
        Wed, 06 Feb 2019 11:26:26 -0800 (PST)
Received: from google.com ([2620:15c:202:1:c562:226a:6d78:2ae4])
        by smtp.gmail.com with ESMTPSA id 85sm11170205pfw.17.2019.02.06.11.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 11:26:25 -0800 (PST)
Date:   Wed, 6 Feb 2019 11:26:23 -0800
From:   Benson Leung <bleung@google.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, groeck@chromium.org,
        lee.jones@linaro.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, Guenter Roeck <linux@roeck-us.net>,
        bleung@google.com
Subject: Re: [PATCH v2] mfd: cros_ec_dev: Return number of bytes read with
 CROS_EC_DEV_IOCRDMEM
Message-ID: <20190206192623.GA120245@google.com>
References: <20190206173959.23925-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20190206173959.23925-1-enric.balletbo@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 06:39:59PM +0100, Enric Balletbo i Serra wrote:
> From: Guenter Roeck <linux@roeck-us.net>
>=20
> While ioctls normally return a negative error or 0 on success, this is not
> the case for CROS_EC_DEV_IOCXCMD in the cros_ec driver, which returns the
> number of bytes read instead. However, CROS_EC_DEV_IOCRDMEM in the same
> driver does not return the number of byte read on success. This is both
> inconsistent and problematic, since the amount of returned data can be
> dynamic. Have it return the number of data bytes for consistency.
>=20
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Benson Leung <bleung@chromium.org>

> ---
> Hi,
>=20
> This patch was send long time ago and never landed to mainline [1]. This
> is a second attempt. Originally was made to apply on platform/chrome but
> after the recent changes we did it should go now throught the MFD
> subsystem. Without this patch userspace tools like ectool doesn't work
> as expected.
>=20
> Best regards,
>  Enric
>=20
> [1] https://lore.kernel.org/patchwork/patch/665211/
>=20
> Changes in v2:
> - Adapt and rebase to current mainline.
>=20
>  drivers/mfd/cros_ec_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index ed809fc97df8..d275deaecb12 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -224,7 +224,7 @@ static long ec_device_ioctl_readmem(struct cros_ec_de=
v *ec, void __user *arg)
>  	if (copy_to_user((void __user *)arg, &s_mem, sizeof(s_mem)))
>  		return -EFAULT;
> =20
> -	return 0;
> +	return num;
>  }
> =20
>  static long ec_device_ioctl(struct file *filp, unsigned int cmd,
> --=20
> 2.20.1
>=20

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlxbNN8ACgkQHwn1ewov
5lgNJBAAqEKRzL1S4HrmJhITKNnok8q/Fq2WhLjJwISymscAjOqsu5EJpiQMC5A2
mCj7dY2H2LtD3Roi5ubOY+MrZFCsGj1NKUEqUwdjs0j0sEmvcJ63GK2YyBKrWPDR
BCUod0IO/2zcE7Q0tdIpBo4YZAd8iYihUGsPdKQ+HUDqPqqHYsUKPUwn9Pcqfxzx
iI70xep8kB8vZiFdF+mVLLlFjHptn9d2YWW7ZR2+vWynBgQKowcGEzdv4i1bvueu
7WHIV9Iz1L8p4e/vcnn1k9/A+P4qYhE3hy9H0n130UUIgTK080tIb2075zUNuXLM
qxitZxZvtznMpEz/pjsm5uacBkWUlshWsEkscTBKCW+YAbWO7jDCO1Zurv72EebC
jn3EML6bzk0NjPEuKQgcX3lMc46ZpOmKn1yH9AE61NCdpoMBFZjgR2N9jx5mi2sl
RGB3ikU82VKPBv1oqWbjPtp2jB6Na0LY8aJhP/OyxndZX2rZ4cHwVoDoWIkiAkik
Ry9IehUvevKM5xGBoQniP9/XUFq/QVuP1I4xidvBK9iFZ+bxNYMyLOm3pO8a9mYg
oBcnnvQN53EaI7/RKQZk32XoL478qVUi/6RVviOzK+AlQq8QACaj8m2Lubq9VsJo
+SA7A8et56Umud+qpK2S21m5GYG1d++nXRYmfmvaabWZzUCf9NA=
=bLFI
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
