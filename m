Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD73C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA96C2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC/bkxfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393145AbfAPN2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:28:06 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33066 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732867AbfAPN2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:28:05 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so1055507wmh.0;
        Wed, 16 Jan 2019 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wf0ohWoL4hHD+GJXTi+WxtzMT4Vn9saqHQGLGnIdDfg=;
        b=mC/bkxfUZqoJxSf2VXd/6WR1mZxvzD7HySxrN2Ba0vT5+oPOErdRH6r49K37mVwtXJ
         PWrmFAlVJQ+PCvqIHRrwW/M+iRiBiFzFdYmIE/d8teXYybm0S1aYf43em1wfNQvCAlDu
         Ba0+Vxn8wVtMo0zw9gGT7edLin+N7o22UusN3v3qhW378LuvUXguzvWzUvvho/lfX/MU
         sHYdTJT72UqSD75uBqbjuRUrrF0SmMO84R+z+atCMmusvocPBE749Bfx2xmrcbjxXBt2
         Cv1qKdTv5EGm/18T2fjdzNsk1lS/1XzCDpJ/ZLtb/pmQ1v9V2mUkvO/knefl1xF4mWq5
         77Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wf0ohWoL4hHD+GJXTi+WxtzMT4Vn9saqHQGLGnIdDfg=;
        b=ckbrLVhM1YkU7ZJEkbalAsYI6pC4MyXxEbmrEPaQML3/2sh03OFHNksYamdd9MU+Z6
         rmChvVjGP2jT6D04J1ULGb1jO0DxCvulBiXSDdptvP96WJUgjxqzbTOaEUD+NPs+TSnh
         /tACjA/TNPRzATnLTtiyFGIEvw4qpDJwYHLxnGByDd2e9B2Zkqz2NsX+71tCJYZumPni
         nBb0S5TlfUIJ0531FthhQynYh7sr6+M0CtZSuM76ioaksgQDe4yA59C85Pi10zHIfl+v
         LJy1Lc9JjG8PMpMBD9rUYIZlkP70wfrw9s/+icY8Gvk0lt/1759PnNggRHc6mkOdFeTb
         cSig==
X-Gm-Message-State: AJcUukf5icou2oqC1SeexP/bVsak7qw498SIrzTmozr3ERlkaUwGr3YR
        Qfln2QLZk5Fq4w4GVtXp1qM=
X-Google-Smtp-Source: ALg8bN7sYTM6w+vcpsWXLatJxSpSt/mfIo0plm47llifkZqMQe6O4tIQ0qNtHNvzE5J2xUhERsd9Fg==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr7337654wme.119.1547645283243;
        Wed, 16 Jan 2019 05:28:03 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id f18sm65227607wrs.92.2019.01.16.05.27.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 05:27:48 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:27:47 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: sdhci-omap: drop ->get_ro() implementation
Message-ID: <20190116132747.GB11050@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-3-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:36PM +0100, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,

"know" -> "now"

> so there is no longer any need for the sdhci-omap code to implement
> ->get_ro() using mmc_gpio_get_ro().
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-omap.c | 1 -
>  1 file changed, 1 deletion(-)

I can't runtime test this myself, but it certainly looks like this would
do the right thing because it calls the core now call the very same
function as this used to, so:

Reviewed-by: Thierry Reding <treding@nvidia.com>

Adding Tony and linux-omap for a slightly wider audience and hopefully
find someone to test this on. For reference, the whole series is here:

	https://patchwork.kernel.org/project/linux-mmc/list/?series=3D66905

Thierry

>=20
> diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
> index d264391616f9..c2a28930086f 100644
> --- a/drivers/mmc/host/sdhci-omap.c
> +++ b/drivers/mmc/host/sdhci-omap.c
> @@ -987,7 +987,6 @@ static int sdhci_omap_probe(struct platform_device *p=
dev)
>  		goto err_put_sync;
>  	}
> =20
> -	host->mmc_host_ops.get_ro =3D mmc_gpio_get_ro;
>  	host->mmc_host_ops.start_signal_voltage_switch =3D
>  					sdhci_omap_start_signal_voltage_switch;
>  	host->mmc_host_ops.set_ios =3D sdhci_omap_set_ios;
> --=20
> 2.20.1
>=20

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/MVMACgkQ3SOs138+
s6HiJA/+PASp1njciDjqY+I9wKP97EQV3tpvJIzGCCFsL7iQ2O6p8f846Eo+OXBi
aJmcEhUT8URqPeRZGm83NUaqBySGLZ17XyWIAOgx+pQEPgcRSvcV4Z7fUeSxlzp1
tilRGoFwd4dgvXk/HSpYsgnWPOLBfnUuvHJZVMC31XykOiBcRNL8nNanq2tLXu5+
+7+bAw44SZbYjkMaEmkVnY1SoiaLCHXdbZekCjE205pWToOwjqy21GdZVc7hSNpG
KS72f7xL23boeJ9R5RGJl7ez+Oq2EdfUpuC9a9D6P4iFpwmAlCvX2DrxeQycmyRJ
IyFyRuvj+ucI27Oz9UQe9BDPNCy3BhaJLLrYlhMYZs0QPhE1lj6RXmmfH6yKMyRW
YYr0XzWiC6gC5XoxVdhZJ7DPzkXEWpScybITgUj/kABRy9I9e9KpRmNWDo1KGeoG
f/Cze3Q+Eg6HDotplopOhlDprFGunOSYbexvJkjyYsWw/75BzCqxIpcGSb3Dzmj+
cI4rGS+i1BWZGSN5Js4Gzf9tasHaRUD4L8ITQCzNU1FdmGAJx/OHNcgqTr/nVqs/
eqbgMf9W9Fwh5YhVc0293gTuXRrRtDGzoTXKhFuzfSKftHNR/peZQ8+zzp1iexK6
4qeLEkNxH/dT16ZRzEBhQssBMO/XByXGcuU5unkCA9l0uR69auo=
=TNNh
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
