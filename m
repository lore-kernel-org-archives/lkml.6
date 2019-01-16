Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F98C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1816020859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547626898;
	bh=Glnfas44zREpYviceaOBIfEKtvEurpB8LJB0mVbU470=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=Dm4uU6aJw7BjNIQDaG51+uEZ7LYZcgMFSlazPM7HAn1VYMVbDDFpiKwZtv0K+ufDC
	 PABHRCsj28fRnqvC4IkjH+A8CCiMENCqLVIyM4HrPBo+rMMxuTwIb87b/SqcjgIteI
	 e8W/U+5Eu66v+vLbN+y/xxMBO8FOMOhj9OoeknTk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbfAPIVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 03:21:23 -0500
Received: from mga03.intel.com ([134.134.136.65]:46231 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730345AbfAPIVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 03:21:22 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2019 00:21:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,485,1539673200"; 
   d="asc'?scan'208";a="138685795"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 16 Jan 2019 00:21:19 -0800
From:   Felipe Balbi <balbi@kernel.org>
To:     Ran Wang <ran.wang_1@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree\@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH 2/2] usb: dwc3: Add workaround for host mode VBUS glitch when boot
In-Reply-To: <20190116064820.20007-3-ran.wang_1@nxp.com>
References: <20190116064820.20007-1-ran.wang_1@nxp.com> <20190116064820.20007-3-ran.wang_1@nxp.com>
Date:   Wed, 16 Jan 2019 10:21:15 +0200
Message-ID: <87y37lko78.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Ran Wang <ran.wang_1@nxp.com> writes:
> +static void dwc3_power_off_all_roothub_ports(struct dwc3 *dwc)
> +{
> +	int i, port_num;
> +	u32 reg, op_regs_base, offset;
> +	void __iomem		*xhci_regs;
> +
> +	/* xhci regs is not mapped yet, do it temperary here */
> +	if (dwc->xhci_resources[0].start) {
> +		xhci_regs =3D ioremap(dwc->xhci_resources[0].start,
> +				DWC3_XHCI_REGS_END);
> +		if (IS_ERR(xhci_regs)) {
> +			dev_err(dwc->dev, "Failed to ioremap xhci_regs\n");
> +			return;
> +		}
> +
> +		op_regs_base =3D HC_LENGTH(readl(xhci_regs));
> +		reg =3D readl(xhci_regs + XHCI_HCSPARAMS1);
> +		port_num =3D HCS_MAX_PORTS(reg);
> +
> +		for (i =3D 1; i <=3D port_num; i++) {
> +			offset =3D op_regs_base + XHCI_PORTSC_BASE + 0x10*(i-1);
> +			reg =3D readl(xhci_regs + offset);
> +			reg &=3D ~PORT_POWER;
> +			writel(reg, xhci_regs + offset);
> +		}
> +
> +		iounmap(xhci_regs);

why can't this be done during xhci_gen_setup()?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAlw+6XsACgkQzL64meEa
mQaYthAA0N7cZj+TDKBtt13xQYprxukJbw0hJF5r+Xwp64RbDU04hHDxOqrV7S7G
gI+RWTZ1p/dvBZ5z0cf9/5Wj4Uyzcnyesd/OCWvTzJA18zNVObO7Dx/KrZawzgJf
B6s3deHMVN1wUVJprVqqUFEXOyJ0hgvup9dQOVeatZMJLYqgW1ubPrK/7LSW52vy
4KUBT4Ol4hXeJiz/SIngZopM9Vc1BTNXFs7ldR6UqWWtU9KnCajBz0QK5T0k4eqj
cvw+jKj8PMts0beRRqTIRAL128aov+/+9o2X+1PEIrPYmiRlFDwUjSGTEaXfb/K2
wHg1Bt6FdBufnlWYTuhGkT5mp1MPe6L2q11m/q6rYnJJNfqnCAExp6hx8K6cQSHP
SATYdBr/ZaOpYJ3RaNOHX3ehfhCkLKFeofT3I/DJEUqSld5s4AmDH8VYLkSx+YtC
KCBjwhYq9Rs1MF66jVWL+oaTG57q+Ta5FVlxlR/ARnZf3Rp65+NvSzZfckmze8p7
pR+G1J34nziVWCNLV4YXmkfYVV3CHLdPl1YM6hvzEZiBOY0lAHPK40f56L9I/IIF
I+eQmDT/SDNqXcEBs5pZh+2UXZSd1GWFGl2z6C5qXzXo8nGXjhHMg8powkudXxp4
8OFNnT6Se2d9OYRnADDbMR1valZ3spQbsnjX1YPyh2s9ztsEfaU=
=lIIu
-----END PGP SIGNATURE-----
--=-=-=--
