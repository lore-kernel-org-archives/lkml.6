Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0303AC2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF68D2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbfAUOqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:46:20 -0500
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:31506 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfAUOqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:46:19 -0500
X-Greylist: delayed 2649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Jan 2019 09:46:17 EST
Received: from [91.248.4.1] (helo=localhost)
        by smtprelay08.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <git@jochen.sprickerhof.de>)
        id 1gla9K-0001mS-0a; Mon, 21 Jan 2019 15:02:02 +0100
Date:   Mon, 21 Jan 2019 15:02:04 +0100
From:   Jochen Sprickerhof <git@jochen.sprickerhof.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vivek Gautam <gautam.vivek@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH] usb: dwc3: Enable GBit Ethernet on Odroid XU4
Message-ID: <20190121140204.GA2360@vis>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Df-Sender: NTc3MDAz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Note that it only works with USB_XHCI_PLATFORM=3Dy. Also it needs a hard
reset when coming from an unpatched kernel.

This was included in the original patch in
https://patchwork.kernel.org/patch/9992809/ but got dropped when
accepted in d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for
exynos5420/5800.

Old behaviour:

$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
/:  Bus 05.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 480M
    |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152,=
 480M

New behaviour:

$ lsusb -t
/:  Bus 06.Port 1: Dev 1, Class=3Droot_hub, Driver=3Dxhci-hcd/1p, 5000M
    |__ Port 1: Dev 2, If 0, Class=3DVendor Specific Class, Driver=3Dr8152,=
 5000M

Tested on Debian unstable using u-boot-exynos (2018.11+dfsg-2) and Linux
4.19.14.

Signed-off-by: Jochen Sprickerhof <git@jochen.sprickerhof.de>
---

Hi,

I'm not sure why this it only works with the driver compiled into the
kernel nor why it needs a hard reset or why it was the line was dropped
when the patch was accepted. Would be great to get some feedback of the
authors.

Cheers Jochen

 drivers/usb/dwc3/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index a1b126f90261..0008bccc30aa 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1169,7 +1169,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 				dev_err(dev, "failed to initialize host\n");
 			return ret;
 		}
-		phy_calibrate(dwc->usb2_generic_phy);
+		if (dwc->usb2_generic_phy)
+			phy_calibrate(dwc->usb2_generic_phy);
 		break;
 	case USB_DR_MODE_OTG:
 		INIT_WORK(&dwc->drd_work, __dwc3_set_mode);
--=20
2.20.1


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEc7KZy9TurdzAF+h6W//cwljmlDMFAlxF0NgACgkQW//cwljm
lDORFQ//YgYObEIdtQH/MdY800FHHWjNZV7S7zRKI3dZF7zF93biHkgkbUlsw9c6
VVb4kRLO04JKAofyOhWJWeVsVVCRfIpRAaaQnWQJZgHJ7+3pJZWgdiCJz8ItoZka
EnoEE+D6ihdMlU61GkbyCHyNen4B/An9XfgBt3LxXiN63jL22xi90ZKKydqKr9zA
8kWMweVw2NHBpoI0c3EBwlmOe9KfvnbHnftNiO3lzJblKiVnr9rINfQv9rWFflvU
IUX55QuZn/48qk4q9D4tAikdnWGqBbVbq7JjXptufgvnd6nsTEf6+/KWTX4jLa4T
uYypc9jRPVOxKSdXhhxPIoqSxSpi3nl9Tbx8vEGtJhENTxEwNumrscY0bD4OnG2k
2lzh7Hrks/rVzeUf86bwnPnaPf9CeiASjL8Usx6FuQJUxvNkHLFfEp26ZrOWn2ak
XzxSecQ0e/eAsn9/Qjok5zcD3JACSqU6R69KtLyB0ptuwYMK2IVZFiELMg25Txyj
Vx2UjFwGBY5lfp1SNf8FmxSqIIOivrBTjU3VVCid0HiG19Uf/9M9+KNc6WT1R1wl
ouvUsETuE18kC10GSPPtjqzDxVUYvShYaz0YKITXnrw04xVx/r48AslKN+EDYMGL
/Zx2Cvv2UROy5lhKG9RICF+pi5aR56cN1ER3VpEtx91GUliUrHc=
=c7cG
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
