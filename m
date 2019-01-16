Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF41C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DAB8206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XebWT00R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404278AbfAPNWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:22:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35213 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730369AbfAPNWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:22:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so1996888wmt.0;
        Wed, 16 Jan 2019 05:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qat7NAH2wgz0kBN6Rm1NUBgILwMI0JGJB4kAZEO41mA=;
        b=XebWT00R/vnEpqIoI4I6cbfzsud0PCYtb49l8uxmyemi/ceVWLie37k7I6Nyuqr1dM
         snGfeAJ2LITnHv7pDhuVQOUBT1QSZS7zkpwPQC1SxAUt7SaT8EgD9kexLCekPaiGNkZo
         M2g8ePa2HKlLObgtQM8oy4razM08LDP16FjVzg27nLmab5TDSvRL5XP8nz1yhQdmGNpF
         GjAoBB7U2doToawpzYBdiBSzFxbTqshrLOr1fXlpWHulIszP8SydOEZuDh22CpkcK5iJ
         cTfXMngKKjO+P+RZi03V215/YrARoyVHmOimssDlstGxXfMpiCnk/vzRAVSeR7KCH3v5
         sUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qat7NAH2wgz0kBN6Rm1NUBgILwMI0JGJB4kAZEO41mA=;
        b=cCQH1zusDAYj41zaJFRkIIkpa12ZzUjq8aox9ylMyG5RNyFRdvVnAnmAEg79ldqUQu
         0qiWAR+GsApEBJJAJT0hSUV4HsVilMuqjqsSpUT60qf5wfYaQCubAztUvhSs4BHtb9Hw
         A/WP8EkeruGoGfktA26TRu52Z/XjmY/tNYmiW+XeGcUHqDjJ4Tr8rLQGAkYO8WJ59b3y
         r6GFmpreutkzgaRBBSHiZtq20fLv90XDdAuVziyLJoAQWVtdA8xFhKvNkhKgtN1/SkLl
         fOJGXognraCasza2EGgkS0KCVDdkdLsMskhj+VYaYVohlnAvKllRmC8X7pTKm6qiKUPd
         z6eA==
X-Gm-Message-State: AJcUukeGGaBwmdX0qRVpqpRQU/td5TQnTrPASYHbd8VDSPHdrelhJ8ph
        5TFkk1+Uv9cFvjgGtfTIi+s=
X-Google-Smtp-Source: ALg8bN4C/Q72+T3XjRtk2IJfq3wpm0jlb002rsaLs2ZVCJvOnvCu73zVVT2oBFz13ZGuWTwfqaQ9kQ==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr7236266wme.4.1547644957428;
        Wed, 16 Jan 2019 05:22:37 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a17sm77575049wrs.58.2019.01.16.05.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 05:22:22 -0800 (PST)
Date:   Wed, 16 Jan 2019 14:22:21 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-tegra: drop ->get_ro() implementation
Message-ID: <20190116132221.GA11050@ulmo>
References: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
 <20190115162837.5399-4-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20190115162837.5399-4-thomas.petazzoni@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 05:28:37PM +0100, Thomas Petazzoni wrote:
> The SDHCI core is know properly checking for the state of a WP GPIO,
> so there is no longer any need for the sdhci-tegra code to implement
> ->get_ro() using mmc_gpio_get_ro().
>=20
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
> Note: this patch has only been compiled tested, as I don't have the
> hardware to test it.
> ---
>  drivers/mmc/host/sdhci-tegra.c | 9 ---------
>  1 file changed, 9 deletions(-)

So, if I apply this on top of next-20180116 I do get a BUG from
bio_split() on line 1833 in block/bio.c. However, that BUG also exists
without these patches.

More importantly, read-only detection with this applied still works on
for example Jetson TK1:

	[   28.547261] mmc1: new high speed SDHC card at address 59b4
	[   28.558814] mmcblk1: mmc1:59b4 SDC   14.7 GiB (ro)

So:

Tested-by: Thierry Reding <treding@nvidia.com>

and:

Acked-by: Thierry Reding <treding@nvidia.com>

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlw/MAkACgkQ3SOs138+
s6HgOg/9EJguIr3+CPkDImyXcLEzTTvJelPHUixE4x937+wH9whe3D0vbI3anIsl
u7LclTY1qgNStdqzUpj8MVTTgPa0Y1dlQY/npJxzf1YECnLgsL0U6KUKWH/AmDlS
XEtb9h4iyCKUGXgjUmKVtXV7ljNW1ZzydCaX+CD523zbd+uAzj/kDys64Y/owvnk
2PhScdYXLH9L2+b0vNSTL/R9EaY/RZumucpRwhsPaiOZSEHkKeYmbpsUMUrMz4re
PFjz62HG4kYJ4a5fO3S+kxIcCZtqHEsFM2CpDlu+hUx1JrPw66VdOD2ECog2Sta1
p+NIVLv6TgUfjTvyn5g0yanJoIzDbKJeYp2btY5ENPx5mtqTiEm1OI/954N2EUAm
S+wyHP/UkxKhu9+iZRpFYHULREMfceYH0UFtv3Wc8S511TON+6jmEVxPI3SxAj1k
8I02iXMvWpzw8UIhbdinCX8o5N9ln4MYJRoiQ8tCF903L3hzI9YFAqCl2JvgaUgo
hjWpjifabP+agFNOnaSteXzEVjWPFZJI0MNOlAlosVdkKdFsOlX/LIfFoVrZjR90
fKs6USdx/TqHpICf/dlg47UwEqi5z9QuzUKNSvmxrl6/SsoGfqPbWHEZbwNOb47z
z/Cbb0h9+5PictazpRr9XwCpqDmVGCZXiLLtvVV9l15q/ItNV6k=
=JB/h
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
