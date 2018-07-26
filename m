Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9DAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33D72083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33D72083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbeGZOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:01:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:60113 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730135AbeGZOBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:01:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 05:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,405,1526367600"; 
   d="asc'?scan'208";a="249130991"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.68.37])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2018 05:45:00 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        gregkh@linuxfoundation.org
Cc:     v.anuragkumar@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Add quirk for enabling AutoRetry feature in the controller
In-Reply-To: <1532608663-4091-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1532608663-4091-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
Date:   Thu, 26 Jul 2018 15:41:43 +0300
Message-ID: <87va92yxrs.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com> writes:
> By default when core sees any transaction error(CRC or overflow)
> it replies with terminating retry ACK (Retry=3D1 and Nump =3D=3D 0).
> Enabling this Auto Retry feature in controller, on seeing any
> transaction errors makes the core to send a non-terminating ACK
> transaction packet (that is, ACK TP with Retry=3D1 and Nump !=3D 0).
> Doing so will give controller a chance to recover from the error
> condition.
>
> Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
> ---
>  Changes in v2:
> 	1. As suggested by Rob Herring & Felipe Balbi removed the
> 	   quirk logic and setting the AutoRetry bits unconditionally
> 	   for hostmode
> ---
>  drivers/usb/dwc3/core.c | 14 ++++++++++++++
>  drivers/usb/dwc3/core.h |  3 +++
>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index 1038075..478c8a6 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -883,6 +883,20 @@ static int dwc3_core_init(struct dwc3 *dwc)
>  		dwc3_writel(dwc->regs, DWC3_GUCTL1, reg);
>  	}
>=20=20
> +	if (dwc->dr_mode =3D=3D USB_DR_MODE_HOST) {

almost there. You also wanna check for dr_mode =3D=3D OTG. OTG
configurations can switch between device and host mode at will.

> +		reg =3D dwc3_readl(dwc->regs, DWC3_GUCTL);
> +
> +		/* Enable Auto retry Feature to make the controller operating in

match the multi-line comment style already in this file:

	/*
         * Enable Auto ....

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAltZwYcACgkQzL64meEa
mQZ/Lg/+MDJg6xsXXkHpcZLrMFu6bb2/c62RAQ3S4wlBNdB+endWIXb034swEC+S
j8ATziCzQD1RbSyiyE4PK+0hNSQVhBHk42jsu0fQs3CJXdQwC6evcFX15iFxl/S6
Z9nrUUmhWGE+wBcSiOSeeQTgZ17CBH7+oHmHWUQ8aLx3FnIv/WvauE+pL+qrtPLT
BS6Lr7IudP+rRoTUOFXiHlsbneNkbfMBmyQlJ5ry5XZ8zU8hNEnqFDRK0huN9j1F
vLkZNF+EKOOaoA7onFnzWDP7+751emjjC3QDbBeu+GIhfI+C34fmwwglyyUHGHH1
9asy9NvJExOBfCSuVb8t3MGPBeC7MOyifW+WakqfZlibBwvxwGfFqMeVWWPcM1pg
TbYW90kk1FiSvHDRlBvJ/KSr2riW0SpeNfagDVJPHFsGRpmIuaCF1uNS+1AdI+Hb
PGg3CTEiJRnWkazgc16LlwunvbWGu/dEtdY2aJscTjW5DIEKSpZc9adID8AXl/Lr
zPB3MT3Me2di0FmiLhV4Ylrkxc7jGFHZZZh/54ikhKZIGrvAF63/404X5Y6EmIxO
v4JCrBLOTXm366BMntlv42fTV5xM4HWoq/qe9aePZJ8sJcfAjxMJ84U0fliBCDJC
sCbpUjb7UPP+6ui4Jize2on6T/jn6F3G8DUL8KwFAIEwnYqmmA4=
=tyh2
-----END PGP SIGNATURE-----
--=-=-=--
