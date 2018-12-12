Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FAC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F07F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQvMpOVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F07F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeLLKCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:02:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40364 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLLKCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:02:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id d3so15026607edx.7;
        Wed, 12 Dec 2018 02:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6aofmVUkFfPtmf1M+JegKRPmHjWic3GIPwQ7heN2KBo=;
        b=JQvMpOVcp4359H0uSDkvl2TiOGrKjY0m8G78/JZ3X6nQzzpNEh2jP6YAz7+MG0HP87
         3h/yGDJ7FyL6Jx0vPCh2CeMFpFVwZDsNVTiBqDLOkj1B/PYXUHZ04B8IJ39MJSvDpdIo
         fx1NFpOduGR/NA8Ku8UePKHDEmSxmals4VY94dwSZsPgYMnH10YTQqgfj4CRMytvooDl
         9T2pnH/etMxAD6mybeIWIfoGVPNMbJ6vNAHZLC4EnF/RLeOVOUmUpBkJ+NJyBFE1pI3d
         hNAyeqQ5zq/HatYf6teFPRHLNbuEbhrAwyCcRaIhRMDO2vmV2s7tmRYkE00DUBFMlnfq
         /OvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aofmVUkFfPtmf1M+JegKRPmHjWic3GIPwQ7heN2KBo=;
        b=XJ+sgzwUuohrIyuRKOrsbIDTtprqLlX4FXwbiHJRqe0SC8VJfZOdDUG2nNxwo8CVaS
         IjCMv590pV9adssME12sfrtZD7oQEbP1WHpiAAvnRcWPCs7WhWri+28AKJpcsra+vjdY
         E8igz8H1GRVr8+oqMeGKG01Cg4o/IhofmkV9MLlNfAI6atgQh1rq63dnSY2gaFG8sLPZ
         mNMs6tq6zF4Hgq9wm0JRApgEijUT4VcIQ7kBWGVHcp7fN+QLQHaP17OBU6T1y0BEJXnt
         TeLnBg7HBxWLqmJS6BHFTTE4mJjTI8p8srzm2G11NsfBMEhxmSB/9wxQRvp06lpvXGwo
         wETQ==
X-Gm-Message-State: AA+aEWaDpo9EmN/CaYHhyx8Bgv3cnhT9/N+KhrudH7Il7lwruO/bbfwL
        JF5X19N/WR9cBZNxqUR0Dv8a0uO8
X-Google-Smtp-Source: AFSGD/XY+3vwg6+PSYos7gIf9dQhe6B+dptkpv/if1LnF/6Lk0CNnU8e83MPhoCSpKZ21seOEycCJA==
X-Received: by 2002:a50:8fe4:: with SMTP id y91mr17964446edy.231.1544608962092;
        Wed, 12 Dec 2018 02:02:42 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id a13sm4525908edt.83.2018.12.12.02.02.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 02:02:41 -0800 (PST)
Date:   Wed, 12 Dec 2018 11:02:40 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/21] memory: tegra: Don't invoke Tegra30+ specific
 memory timing setup on Tegra20
Message-ID: <20181212100240.GE15092@ulmo>
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Content-Disposition: inline
In-Reply-To: <20181209202950.31486-9-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 09, 2018 at 11:29:37PM +0300, Dmitry Osipenko wrote:
> This fixes irrelevant "tegra-mc 7000f000.memory-controller: no memory
> timings for RAM code 0 registered" warning message during of kernels
> boot-up on Tegra20.
>=20
> Fixes: a8d502fd3348 ("memory: tegra: Squash tegra20-mc into common tegra-=
mc driver")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/mc.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Acked-by: Thierry Reding <treding@nvidia.com>

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlwQ3MAACgkQ3SOs138+
s6G2aQ/+KD5RdCGYz1SWzQhTm7DVXypS7nOngN1v/CDf5Zt8ZavPn2kSksNkC8Ub
Bj3MVBMOnmmyrcjHbz1lbio75ULX4igdx5BjKVWBq/nYyq0W9tSKfCydNu0wURX6
Zffuk8TT3GHUHB45eekxWIRQFZiy68MO3XtNvBfd6gpCoTahAYQP14pN7RVYLGXt
/W0MZoV+swTBAms56x11rZ+gZiq7kfErXjDYkslTnPYLzKyM5NjTuML20dr/O4Tl
Grfw0AAwdtzrPKfC9ogiuvzZSKUT/GxXzIiUixuogJO+/y0701m9Nva1BOYqFJFK
iurUym4MFe8y/sMmRoCg5/mlVHiUJk7HSHV+ifQorzEKk2yT0ZbPqY1dJMz4b0df
ytmfW0OiaWNIzCrrYPTWWBa0G409XapFaqmYX4uYrXimZWEnt5ybjzQYt3labnrm
VgzOcRhq0nQmAdxWL5fWZuButOgWrYiIkxDJ/PBOvdTZ1dsr1pUoa4yM7VMGleyx
PvLwZ1xZP3CNbdrI+BQpGxUFFo+Gvhlw3a/Tmr7JUjITtWtvwPNyGC/dZ+saUeff
u2zL55tW7bxeAOEbChNQEEDX67jSmf1qbisIdqw8seFpaa09sdqhGiApmrcGnGo9
uCcTn7u6m82mjNEEdbdVddrwAcoFEw9+Xj8/Qu1JSmxRiCZ4Jw0=
=nQFn
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
