Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21274C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A9D206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 03:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IohwVjGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbfAIDhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:37:07 -0500
Received: from mail-eopbgr150059.outbound.protection.outlook.com ([40.107.15.59]:50736
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727947AbfAIDhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 22:37:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szIOhE2NKWs1y6W57Y3QJZ08ZYX+iKIsxOjouKLmAcg=;
 b=IohwVjGKrVoBQoIEttHo62CSYQYpQKnf5FUOvDOqPKajoF2tkXxNQ6djaCjSWNi23hmTmzIPUWB2pU+x3vIQ1KCU4SsjN9a0XbRLdMvvVGDSR0QXajLbVYAHhhp4vdh5w5k+KhG4+WsMbAw7W1P0tTRQVv7ptfTFpJmHnHaBfYg=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2900.eurprd04.prod.outlook.com (10.175.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Wed, 9 Jan 2019 03:37:01 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Wed, 9 Jan 2019
 03:37:01 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUpxgC6yBGLPIm9UWYEo0ogu0Vc6WljdKAgAC5jzA=
Date:   Wed, 9 Jan 2019 03:37:01 +0000
Message-ID: <AM5PR0402MB28654E2A6EB5914CB3C35174F18B0@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190108060426.11581-2-ran.wang_1@nxp.com>
 <Pine.LNX.4.44L0.1901081118121.1355-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901081118121.1355-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [223.104.3.158]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2900;6:qdWwmm1ZSpfq1W5Fgj5G1jV6+M+UqSIdA/fYRPOmSCwBEM/IKeIWo3alA4SnHg8dwI5TTYrlVvRzlXBr6ad/ldJtk+/h0gkLYMYOWbjrujZ+qF1ZXmAlXIgNr7eSmO60WnhTqoWd9kcp3CC8zo/ZfsL33OzGDbJAhTAi3b76h3azeBd53PeAsLwlnPpe72pYiNi4Lz2bcGOdS4m1Bw8HoKgLSHboJL3tcdZNpiheaFlk80C5wGeWGuQRtKi/DiRUxjqdbz5hnktJ+loY/EO6/aQWzKxgyHEvuFhrzi8qLGA1slXA3lL6alAILb2U4DufxqAPsTdkFvwa9KuzjPrsFahh2hCxi7zezHJXZjwIssQsmCqVxt+7DQy6CCX4XfXW+skakweUl2tyZ+JmX2Pld7m2fZY56IjD8yNu2At+irzueHwJsJT5PSFSNApmi6CmOHTlOFwopIBG78Ql5wGOdg==;5:wRejwAX0EI6h1dgmmr19VRbRk3bqjVdqkm9EyjmFcuf8if1NN2JKACVHiiMItNVucC7JWNIToP0EtK2KCEgLn55XmebO0RNNm2nos4qDIiGhdINUD1dp/++or9XIZgcssXDxY7Fpce65udfSRHCWiA+w1ncgjOTtuaBmqN5hzSPYba03JC3sNE/gXwszuFOHs9NAngb439zgVoRHVcZ5xw==;7:0xJB0ZG4vnU9QAWTQHavbX+J/TLD5olqxR4OZdmTtUNLGGq9JE5ApAU3n+Qg6NijTN46+4p1mrfWrPMauqynXKIUVVeUMtrv3zB/WrLQI3NtqHpMXJz1zQyOp05QDKp50ui0wuKQERMq4m2FB1p1jQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: b711b1fe-2c4d-4007-2b38-08d675e3b79f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2900;
x-ms-traffictypediagnostic: AM5PR0402MB2900:
x-microsoft-antispam-prvs: <AM5PR0402MB2900069CDFFF5AB9458F8AA1F18B0@AM5PR0402MB2900.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(6055026)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2900;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2900;
x-forefront-prvs: 0912297777
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(396003)(376002)(346002)(39860400002)(366004)(189003)(199004)(13464003)(256004)(106356001)(14444005)(33656002)(486006)(6916009)(8936002)(229853002)(7696005)(4326008)(55016002)(6436002)(74316002)(81166006)(6116002)(316002)(5660300001)(81156014)(8676002)(99286004)(68736007)(15650500001)(54906003)(105586002)(3846002)(2906002)(305945005)(478600001)(97736004)(86362001)(66066001)(14454004)(7736002)(9686003)(53936002)(6246003)(2171002)(476003)(26005)(102836004)(6506007)(53546011)(11346002)(446003)(186003)(71190400001)(25786009)(71200400001)(76176011)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2900;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kkEPYmH8BYSPx7u7BHkZoWqMr0fqrj7U65NJ/jayRhbeBWE/UWkhQep5Zgode0sCEeqvQd7ukoFSWj0b1IR742UW70/I8cBm2x7NsIzZs5dO6Ushipyy/8ZlD+2NuyNQnH7Vhq4icON2kDfWvplXejLPZTv5cY7jv2KdBmnRhqdjtE+KQRLDvL/sg6YgTlpx/15yBPSqXxEQ1XoeYJciOQEICMS8f9yxW7e2gK8+UY7OIva+fNze20DyutOcRE87clC8pGwxgSG0nNfppFMnOVnLPT9KUdg5MlJZ7P9pbgP3p/AUfNNLgdVjd0EzgQh2
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b711b1fe-2c4d-4007-2b38-08d675e3b79f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2019 03:37:01.7722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> -----Original Message-----
> From: Alan Stern <stern@rowland.harvard.edu>
> Sent: Wednesday, January 09, 2019 00:20
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> usb@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
> arm/arm64 platforms
>=20
> On Tue, 8 Jan 2019, Ran Wang wrote:
>=20
> > arm/arm64's io.h doesn't define clrbits32() and clrsetbits_be32(),
> > which causing compile failure on some Layerscape Platforms (such as
> > LS1021A and LS2012A which also integrates FSL EHCI controller). So use
> > ioread32be()/iowrite32be() instead to make it workable on both powerpc
> > and arm.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/host/ehci-fsl.c |   64 ++++++++++++++++++++++++++++-------=
-----
> ---
> >  1 files changed, 42 insertions(+), 22 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
> > index 0a9fd20..59ebe1b 100644
> > --- a/drivers/usb/host/ehci-fsl.c
> > +++ b/drivers/usb/host/ehci-fsl.c
> > @@ -23,6 +23,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/fsl_devices.h>
> >  #include <linux/of_platform.h>
> > +#include <linux/io.h>
> >
> >  #include "ehci.h"
> >  #include "ehci-fsl.h"
> > @@ -50,6 +51,7 @@ static int fsl_ehci_drv_probe(struct platform_device
> *pdev)
> >  	struct resource *res;
> >  	int irq;
> >  	int retval;
> > +	u32 tmp;
> >
> >  	pr_debug("initializing FSL-SOC USB Controller\n");
> >
> > @@ -114,18 +116,23 @@ static int fsl_ehci_drv_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	/* Enable USB controller, 83xx or 8536 */
> > -	if (pdata->have_sysif_regs && pdata->controller_ver <
> FSL_USB_VER_1_6)
> > -		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
> > -				CONTROL_REGISTER_W1C_MASK, 0x4);
> > -
> > +	if (pdata->have_sysif_regs && pdata->controller_ver <
> FSL_USB_VER_1_6) {
> > +		tmp =3D ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
> > +		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
> > +		tmp |=3D 0x4;
> > +		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
> > +	}
> >  	/*
> >  	 * Enable UTMI phy and program PTS field in UTMI mode before
> asserting
> >  	 * controller reset for USB Controller version 2.5
> >  	 */
> >  	if (pdata->has_fsl_erratum_a007792) {
> > -		clrsetbits_be32(hcd->regs + FSL_SOC_USB_CTRL,
> > -				CONTROL_REGISTER_W1C_MASK,
> CTRL_UTMI_PHY_EN);
> > -		writel(PORT_PTS_UTMI, hcd->regs + FSL_SOC_USB_PORTSC1);
> > +		tmp =3D ioread32be(hcd->regs + FSL_SOC_USB_CTRL);
> > +		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
> > +		tmp |=3D CTRL_UTMI_PHY_EN;
> > +		iowrite32be(tmp, hcd->regs + FSL_SOC_USB_CTRL);
> > +
> > +		iowrite32be(PORT_PTS_UTMI, hcd->regs +
> FSL_SOC_USB_PORTSC1);
>=20
> Why do you change this writel() into iowrite32be() but leave other instan=
ces
> of writel() unchanged?  Was this a mistake?

Yes, I didn't notice there are other writel() used in this file.
However, as I know, on both powerpc and arm SoC, EHCI FSL IP's memory mappe=
d
register block is always Big-endian, so I'd like to replace all writel() wi=
th iowrite32be()
in this file. Is it necessary?=20

Or I just replace them with ehci_writel() and select CONFIG_USB_EHCI_BIG_EN=
DIAN_MMIO?

> >  	}
> >
> >  	/* Don't need to set host mode here. It will be done by tdi_reset()
> > */ @@ -174,7 +181,7 @@ static int ehci_fsl_setup_phy(struct usb_hcd
> *hcd,
> >  			       enum fsl_usb2_phy_modes phy_mode,
> >  			       unsigned int port_offset)
> >  {
> > -	u32 portsc;
> > +	u32 portsc, tmp;
> >  	struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
> >  	void __iomem *non_ehci =3D hcd->regs;
> >  	struct device *dev =3D hcd->self.controller; @@ -192,11 +199,16 @@
> > static int ehci_fsl_setup_phy(struct usb_hcd *hcd,
> >  	case FSL_USB2_PHY_ULPI:
> >  		if (pdata->have_sysif_regs && pdata->controller_ver) {
> >  			/* controller version 1.6 or above */
> > -			clrbits32(non_ehci + FSL_SOC_USB_CTRL,
> > -				  CONTROL_REGISTER_W1C_MASK |
> UTMI_PHY_EN);
> > -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> > -					CONTROL_REGISTER_W1C_MASK,
> > -					ULPI_PHY_CLK_SEL |
> USB_CTRL_USB_EN);
> > +			/* turn off UTMI PHY first */
> > +			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> > +			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK |
> UTMI_PHY_EN);
> > +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> > +
> > +			/* then turn on ULPI and enable USB controller */
> > +			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> > +			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK);
>=20
> Unnecessary parens.

Got it, fix it in next version.

> > +			tmp |=3D ULPI_PHY_CLK_SEL | USB_CTRL_USB_EN;
> > +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> >  		}
> >  		portsc |=3D PORT_PTS_ULPI;
> >  		break;
> > @@ -210,16 +222,21 @@ static int ehci_fsl_setup_phy(struct usb_hcd *hcd=
,
> >  	case FSL_USB2_PHY_UTMI_DUAL:
> >  		if (pdata->have_sysif_regs && pdata->controller_ver) {
> >  			/* controller version 1.6 or above */
> > -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> > -					CONTROL_REGISTER_W1C_MASK,
> UTMI_PHY_EN);
> > +			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> > +			tmp &=3D ~(CONTROL_REGISTER_W1C_MASK);
>=20
> Unnecessary parens.

Got it.

Regards,
Ran
> > +			tmp |=3D UTMI_PHY_EN;
> > +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> > +
> >  			mdelay(FSL_UTMI_PHY_DLY);  /* Delay for UTMI PHY
> CLK to
> >  						become stable - 10ms*/
> >  		}
> >  		/* enable UTMI PHY */
> > -		if (pdata->have_sysif_regs)
> > -			clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> > -					CONTROL_REGISTER_W1C_MASK,
> > -					CTRL_UTMI_PHY_EN);
> > +		if (pdata->have_sysif_regs) {
> > +			tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> > +			tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
> > +			tmp |=3D CTRL_UTMI_PHY_EN;
> > +			iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> > +		}
> >  		portsc |=3D PORT_PTS_UTMI;
> >  		break;
> >  	case FSL_USB2_PHY_NONE:
> > @@ -241,9 +258,12 @@ static int ehci_fsl_setup_phy(struct usb_hcd
> > *hcd,
> >
> >  	ehci_writel(ehci, portsc, &ehci->regs->port_status[port_offset]);
> >
> > -	if (phy_mode !=3D FSL_USB2_PHY_ULPI && pdata->have_sysif_regs)
> > -		clrsetbits_be32(non_ehci + FSL_SOC_USB_CTRL,
> > -				CONTROL_REGISTER_W1C_MASK,
> USB_CTRL_USB_EN);
> > +	if (phy_mode !=3D FSL_USB2_PHY_ULPI && pdata->have_sysif_regs) {
> > +		tmp =3D ioread32be(non_ehci + FSL_SOC_USB_CTRL);
> > +		tmp &=3D ~CONTROL_REGISTER_W1C_MASK;
> > +		tmp |=3D USB_CTRL_USB_EN;
> > +		iowrite32be(tmp, non_ehci + FSL_SOC_USB_CTRL);
> > +	}
> >
> >  	return 0;
> >  }
>=20
> Alan Stern

