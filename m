Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C175C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3284720870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 09:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m7UHfHb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfAWJUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 04:20:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36673 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfAWJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 04:20:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id p6so1203130wmc.1;
        Wed, 23 Jan 2019 01:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uc6mswHiG8t3sLwOSPGxri+hbxVTstOLoSzfXDVy0z4=;
        b=m7UHfHb/uGwgZXc5lODgRpFq3jrqo0uQ93OEvdia5+7ZnQgDElKMMHKqjLxeY5p11l
         ryuLz2rgiVLwNz58TgWnETTLv5KoFPHegj41+Q13Ft+zwQtmT/JgmMGFybA+XTyLOj3Q
         uzBm6cS8vLI22UJU81anbtP29qXYsbmAn1MOiNqYLu9W1CRzxWjHAv6zfSCbJxzjTNO1
         kGrJBgjTUJgs2Mwo/d8/ICxnMHbij556q/fCHkIcr8JTcSg4sKI0fgvZWl5mf+DGz9wo
         qUbyGDU/TqRNGKbq+nD+Go8qDFJYLQsDSFflH7Avxeu2NS1FFSvKZdgLLeF1sqAOieEr
         ywZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uc6mswHiG8t3sLwOSPGxri+hbxVTstOLoSzfXDVy0z4=;
        b=NWy6ysdPwO5aC1sjS/seaZd/pIMi7z4cu2X/hJ2tVBYFxyRJlhBD29gvSl+CSemwew
         MyteKlXGxlyEtsmG55fMjGXGy5nccdsCoLwpGqxfxDZp19v1VP62IWeIoney+VVpIlxQ
         yrIR993/ihzLrapi6BCuijbD3PaSrh14qJQQAHjaffupAar/6c/r0IWuT1oqrylM4EFF
         udMafNUzMbVM66W1X2/IFOqE9dmTgsomeNi4cqs2JY6PEsVBwnBKYkXdM/qC3lgcMlC5
         sVtCuRIG0dSQlyvgYq3mzVDn8fwQW04VYk6rCIsIFK6GrvNGOmlUAfWOvcq7wfR9BCmQ
         77+A==
X-Gm-Message-State: AJcUukftRZ8GtYk1xw2rruIdfNmnUxFieccwhyQMEpU+eyBxviW6fMiY
        bvND9P54HTgP+I54RIdLNQsjyh5k1M0=
X-Google-Smtp-Source: ALg8bN7NhQGDX6d/59OJuZ0/sV+kfppich2HJBUX83nZU00MiyvbxAWyVPN1vT7IVIZdDq6vkokVTQ==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr1827980wme.4.1548235214680;
        Wed, 23 Jan 2019 01:20:14 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 124sm58044347wmh.22.2019.01.23.01.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 01:20:13 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:20:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mperttunen@nvidia.com,
        chunyan.zhang@unisoc.com, jonathanh@nvidia.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, anrao@nvidia.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH V10 4/4] mmc: tegra: HW Command Queue Support for Tegra
 SDMMC
Message-ID: <20190123092012.GC24072@ulmo>
References: <1548186993-6229-1-git-send-email-skomatineni@nvidia.com>
 <1548186993-6229-4-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Content-Disposition: inline
In-Reply-To: <1548186993-6229-4-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 11:56:33AM -0800, Sowjanya Komatineni wrote:
> This patch adds HW Command Queue for supported Tegra SDMMC
> controllers.
>=20
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V10]: Changes are same as V9 except this series has SDHCI core changes
> 	into seperate patch=20
>=20
>  drivers/mmc/host/Kconfig       |   1 +
>  drivers/mmc/host/sdhci-tegra.c | 117 +++++++++++++++++++++++++++++++++++=
++++--
>  2 files changed, 114 insertions(+), 4 deletions(-)

Sowjanya,

it's good practice to collect the various tags that you've received on
patches when resending. I had already acked patches 1 and 3 of v9, so
you should've added the Acked-by for at least this patch 4/4 because it
is unchanged from v9. The Acked-by on patch 1 was also valid because you
only moved the documentation, but it is otherwise unchanged.

No worries, though, just something to keep in mind when you send v11
with the typofix that Adrian pointed out.

Acked-by: Thierry Reding <treding@nvidia.com>

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxIMcwACgkQ3SOs138+
s6HjCg/7BEzZlYzmxabweiblsUj1bl1Cab3v45QDeCgs88YXI1MKXY69Z5BL483E
2dk680JImRyLxh3elk838WgLAxn/fNRAO284BXKy0kB66bLZBpUXc96lSoWjpPKD
+hLZmy85NLMuv966QGLxwMbKeIFgsWkPIH3VJ1noixtrKNNFiVjXAUdBqyj4sdXY
8YigDcSMyL6jp+oourgLPuTUYPkYCb9h+rYrJe/tjhqTXRaXQ9VMv7NE97WYjjXA
yf9m9Bn4weOnLBClVd2NEQQiy2YAQbNM/EL8I01vOTqZRU+/i4/PwhQo9s+5zAEk
Mqz+NqkyBnFlhgRLkXG+Xqoip49rraP1h6JgiqUJlDYbI5VAuEK+3D06Nkid8sdK
rwf7esBXV4z3m9iZ5O/3mEmdRrekCqcOn6QTFF1kR8U6D0sSl4heQyiAYTRBUqyv
TysZgJ5F3l+s6JPsIL8N2jD+O3z6bL5sPK1ieUHjQ935QFdVyc8iSrpYA7uWSZkA
gRo/AxlXLQ/xNFeGThZPDouOwwfGlcOv+DqsIOk3Rju8jdKsUil/jqwkI/8UDWsG
aqE1cY9qZqoJhWRnbJ/JwXkUrhW8ZQUia87xCg9zOXhCVY/Nbe5FpSsqOIelxlib
IX2UrsQatNWBnMqex421w6wWqbRGLvs12R3is8sZruv3iMDasCo=
=hvy0
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
