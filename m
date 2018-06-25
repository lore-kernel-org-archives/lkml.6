Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ACEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47C8C258E6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 12:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C8C258E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933370AbeFYMSS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 08:18:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41026 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeFYMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 08:18:16 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 3CD95263BD7
Date:   Mon, 25 Jun 2018 14:18:13 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
Message-ID: <20180625121813.rzqgzdbk6ue73eq4@earth.universe>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com>
 <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
 <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
 <CAHQ1cqHpNvZGAfFKrp-OiZevsha5CBwJsw8GT+uhgNSfEUejkw@mail.gmail.com>
 <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5duehklu3nfjqgin"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DAbooRgA+sHJa5EmEGy-CHW3FPydcOFtK5AqpdJzD7MQ@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5duehklu3nfjqgin
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jun 24, 2018 at 08:51:20PM -0300, Fabio Estevam wrote:
> Hi Andrey,
>=20
> On Sun, Jun 24, 2018 at 7:40 PM, Andrey Smirnov
> <andrew.smirnov@gmail.com> wrote:
>=20
> > It's definitely the bootloader, or more specifically whether or not it
> > initialized/used USB before booting the kernel. Some interesting
> > highlights:
> >
> >  - On your "good" 4.17.2 based image, if you interrupt U-Boot, do "usb
> > start" (optionally "usb stop") and then "boot", you'll get the hang
> > that I was trying to fix with my patch.
> >
> >  - Things are exact opposite with 4.18-rc1 and doing the above would
> > _prevent_ the hang and the image would boot fine.
> >
> >  - Disabling USB in Barebox based boot "stack" gets it to behave the
> > same way as U-boot from your image (hanging when booting 4.18-rc1)
> >
> > Digging more into code it seems that the reason for 4.18-rc1's
> > behavior is the fact that it's missing a call hw_phymode_configure()
> > after usb_phy_init() and, AFAICT, the only reason it is not happening
> > is because default image is being built without
> > CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS. Enabling those two
> > options on 4.18-rc1, seem to fix the problem on both your U-Boot based
> > image and my "special" Barebox setup.
> >
> > So AFAICT, this patch still fixes a valid issue (my use-case was net
> > booting via USB-Ethernet dongle), but an additional patch enabling
> > those two configuration options might be needed. Thoughts?
>=20
> Yes, I can confirm that your suggested change avoids the kernel hang:
>=20
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index d14de86..2da678c 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -300,6 +300,7 @@ CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_CHIPIDEA=3Dy
>  CONFIG_USB_CHIPIDEA_UDC=3Dy
>  CONFIG_USB_CHIPIDEA_HOST=3Dy
> +CONFIG_USB_CHIPIDEA_ULPI=3Dy
>  CONFIG_USB_SERIAL=3Dm
>  CONFIG_USB_SERIAL_GENERIC=3Dy
>  CONFIG_USB_SERIAL_FTDI_SIO=3Dm
> @@ -336,6 +337,7 @@ CONFIG_USB_GADGETFS=3Dm
>  CONFIG_USB_FUNCTIONFS=3Dm
>  CONFIG_USB_MASS_STORAGE=3Dm
>  CONFIG_USB_G_SERIAL=3Dm
> +CONFIG_USB_ULPI_BUS=3Dy
>  CONFIG_MMC=3Dy
>  CONFIG_MMC_SDHCI=3Dy
>  CONFIG_MMC_SDHCI_PLTFM=3Dy
>=20
> > Also, I don't have any i.MX53 HW, so I wasn't able to test the effects
> > of enabling those two options there.
>=20
> The imx53 board I have access to does not use ULPI.
>=20
> Maybe Sebastian on Cc may help testing this on his imx53 board as he
> is the author of:
> be9cae2479f48 ("usb: chipidea: imx: Fix ULPI on imx53")

I still have access to the imx53 based PPD from General Electric.
But I don't understand what patch you want me to test. FWIW the
images I use(d) for testing already had CONFIG_USB_CHIPIDEA_ULPI
and CONFIG_USB_ULPI_BUS enabled.

> I am wondering if we need to force some kind of USB reset to put the
> USB controller into a known state independently of what the bootloader
> has done previously.

Makes sense to me.

-- Sebastian

--5duehklu3nfjqgin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlsw3X8ACgkQ2O7X88g7
+ppPfA/+MkIOWrPTnf6628dCfDQrF7zRe4xC0A13ePHDrvHmvJDuGckDOSmEqjD3
4RGq9KMZY5jUh82eiPblx99K/HqiySxbOG87CSlnHQHZqPTu/sksiiExnoTboImV
ObfqoNtJ2HH73LD2FfnLHTtFDBS/a92dAfk1YMBDPAKiL3lCivcw4hZ13thwhqGP
c9UW3V6ZTKNalokwMUs+wm1FfSYOetKrZRVmnHJlcSMnEFeFcrc1YOZbzdnGI9wn
0HDQXP7nbm8hHJVGidAt9hBikJZw8DbPjKebVsLxU91OgVJvTNBNPUa/MQVz9Ert
Jujrk5MnvenrDfsC87MyggP3HsnK1I6T01eH48qIBDeqK+yywRTiFJyJ+arAzfFE
KTLC24AJhbIWw3Hsn9TbkPeBfgqD9T6OwISubl/bFyszxb/PCfAg2RmgDNEkEP/g
Qhf8Blf8tXmJtleD5P5YxV/ikkeoHuF1zMpNeVKwaeeyffFlueBQhs58cEvbD+r6
ZO6x6MVHOYBRrbnxEf62bCWijFIzGl4NuKMy7j6RZIM3HjPrXbDHbrB4ETvhbZUy
WS+Vay71E3hlo28JXFGjreQmgjtNek9RuS/jeCOxw5XigGCaOzfVTO5Nehaxj+xF
2HtoVgFwcwpWBV0FQSWO3ZUL0/IB/PoJwX7pr0RdocEj8Ojd/VM=
=VnDV
-----END PGP SIGNATURE-----

--5duehklu3nfjqgin--
