Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27502C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88EF21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2CII9L7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfBGQGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 11:06:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53037 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 11:06:36 -0500
Received: by mail-wm1-f66.google.com with SMTP id m1so424973wml.2;
        Thu, 07 Feb 2019 08:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aht6OGBgd8mlZL14wL2PjAaSPop+eMLomhcHFftgGUY=;
        b=E2CII9L71u6TWSSHZkzEL2yVs5ZckdCiQELNAXn4oiPJ9SBRTmYLitfF6r0zPFisuQ
         5KTC0pfqMJKl6TIuGwiddr7/ylzhQ6z2VXLXMsdjRvPP/0wCxQ6sSLdHXxlti6GAfrLd
         MVJgPnyqj5GipBek3nqcw3qAlQd7sIlMUgkYjZUvqDx2SUcXLUWyKoSLEuD+l5j7BpDc
         3EP/LKlNGl6grxxnM/wZOEWmlK4vKElgXlhUxQ0sThLrtgIOI2ErGa66mqoofbR2poXY
         5qyFAVJPlXzms1Hm1aOqSyOal864+EVKjbTfphuwAyu19LWQH9OdQgGpotVyw1sc0Pdx
         HwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aht6OGBgd8mlZL14wL2PjAaSPop+eMLomhcHFftgGUY=;
        b=nvexKiqhIkp8VL4aBeN1iB6I4QOWI4tTFlKAdT53CWwxZ54TEJz7iWTRYiQMMQGK2c
         Fc/68UOyAg7duTuFmdb4sbmiIXylMugxn1kiTTzaDbnP2r6ULQE3c4Fc/GlefXiSrza2
         Lg/plyoIaaeboE/RJQZDZ2idrRllI6s93P/wfoMWXjR83Eo/9cZXjmbhZI+Dryhv4q7H
         +iQWLI9srk3z3z2h6S0MMMD6psecu93EigiUnu4CbJLjSLvKN52tychFKi9GFVZ64TIO
         HNYpNnNP0EdWJxaE+qNmLEJZrxDUDuzPDLF4mmBIXdVOEBo8X6z5ZKx9MP2kzGgAF/ld
         h+sQ==
X-Gm-Message-State: AHQUAuaq/mRkTPN8V1cbx+bb4dk31nAyLTD3t09GU8JfstDwydy2abY8
        qSP3duHMi4hpiroQ3TOMWM/sZkQsXMc=
X-Google-Smtp-Source: AHgI3IaFFuomKFqj4rxtgp7uZCCF1HW3m3mc5y+b20vZg3EFdXJgc83xYHb3O65DsDuqVil2vk6T/A==
X-Received: by 2002:a1c:6707:: with SMTP id b7mr8011754wmc.138.1549555592725;
        Thu, 07 Feb 2019 08:06:32 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id r14sm7596999wrr.65.2019.02.07.08.06.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 08:06:32 -0800 (PST)
Date:   Thu, 7 Feb 2019 17:06:30 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V14 3/5] i2c: tegra: Add DMA support
Message-ID: <20190207160630.GB17445@ulmo>
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-3-git-send-email-skomatineni@nvidia.com>
 <32b0b694-f912-044e-1a50-55b9c355d0c3@gmail.com>
 <BYAPR12MB3398350797241F90AE347FB5C2680@BYAPR12MB3398.namprd12.prod.outlook.com>
 <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcHopEYAB45HaUaB"
Content-Disposition: inline
In-Reply-To: <0a7d62c4-9dcd-08dd-4e3f-877184848daa@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcHopEYAB45HaUaB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2019 at 07:01:45PM +0300, Dmitry Osipenko wrote:
> 07.02.2019 18:23, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >=20
> >> It became apparent to me that there is a problem here. The size of dma=
_buf is 4096 bytes and maximum message length is 4096 too, we have pushed 1=
2 bytes packet_header to the buffer >and now there are 4084 bytes left for =
the message in the buffer. Hence transfer of 4KB will cause buffer overflow=
 and either crash kernel or corrupt memory. One solution is to just always =
>push packet_header using PIO, other to reduce max_write_len or increase dm=
a_buf size.
> >=20
> > Yes, This is known to me and I will add separate patch for this to upda=
te quirks to take care for t186 and t194 to exclude packet hdr lengths
> > There was separate patch when quirks were added and it got merged alrea=
dy from 5.0-rc1 but don=E2=80=99t want to sneak that here. Will send separa=
te patch to take care of this.
> > Need to update quirk to exclude packet header
> >=20
>=20
> No. This is a bug of this patch, it must be fixed in this patch as well.=
=20
>=20
> Please include this snippet into the next version of this patch.
>=20
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegr=
a.c
> index 7921d3e6237d..0ed8162a37e4 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -1293,7 +1293,7 @@ static const struct i2c_algorithm tegra_i2c_algo =
=3D {
>  static const struct i2c_adapter_quirks tegra_i2c_quirks =3D {
>         .flags =3D I2C_AQ_NO_ZERO_LEN,
>         .max_read_len =3D 4096,
> -       .max_write_len =3D 4096,
> +       .max_write_len =3D 4096 - I2C_PACKET_HEADER_SIZE,
>  };
> =20
>  static const struct i2c_adapter_quirks tegra194_i2c_quirks =3D {
> @@ -1545,7 +1545,7 @@ static int tegra_i2c_probe(struct platform_device *=
pdev)
>         i2c_dev->is_dvc =3D of_device_is_compatible(pdev->dev.of_node,
>                                                   "nvidia,tegra20-i2c-dvc=
");
>         i2c_dev->adapter.quirks =3D i2c_dev->hw->quirks;
> -       i2c_dev->dma_buf_size =3D i2c_dev->adapter.quirks->max_write_len;
> +       i2c_dev->dma_buf_size =3D i2c_dev->adapter.quirks->max_read_len;
>         init_completion(&i2c_dev->msg_complete);
>         init_completion(&i2c_dev->dma_complete);
>         spin_lock_init(&i2c_dev->xfer_lock);

I'm not sure we actually need this. My understanding is that it's really
the payload size that's 4 KiB and 64 KiB, respectively. I don't think
that includes the header.

Thierry

--qcHopEYAB45HaUaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxcV4YACgkQ3SOs138+
s6Hn6xAAtaKryn5ZUxlKtRHXvGv6HV+qA1Tjcbz/keZEbeWm6qk+jRtnelTQ2hzx
AhtlGgFcmQ0Y8kdcSnT8nMdCHNGsYTgMr6IDgiNfbFrmTc7A40+oHZZdDGg/pxBL
96BHqHf48SbXSvWFwEllI/Q06+ns8vHGZFwjqqPfqqkpwa9uYkXy2593uVA6la9S
sv38ND89fRhNO+YDMIegjiysTAx5T6i7QZBNrAhg1f0kq68BQViQM87SSSW8Qa3i
ukkMk51AAbVX2KMgpjtjVNMNwNs3l3X7u2qawPj9bBiVyMhWIBnhX9xAXEW3SaVn
d2T3nuGVPiTeCd1Mroyx6yOa4N4JYChoNeZ7nk8yyGQ3U/PKDqtUOhVKATZKLlJH
6fYkKlthujgk6fdB2IA+y/QImmO0OLxYtJwwgzYt3xeHnQX17b+0eYXGQV8BxZpM
5BPfY3Y0DH0PNa6DeihbKm6li8oV4CbIi01QNKoCTBhFJ6Ft4krz83e2GFCdxLO+
1t3cfE8aUm0FadXuUcNJqYZ4u61BHFIZB/ovGUnxy53xVKK66J9IRigUr1stN3md
2/X390GM55l8ugPp7GoFgReVsbfycZKUBr96Y2J8XW6ia0h+mXQAJTT6IvSoNXCH
HFCSJdlnwdP7VIdvNLlJBg9rmKrqxTMUukWjPnNy2P1k0RCMmig=
=82wt
-----END PGP SIGNATURE-----

--qcHopEYAB45HaUaB--
