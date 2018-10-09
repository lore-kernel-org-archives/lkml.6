Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F9EC67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D2220C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 01:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fg6TVWF1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11D2220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJIIik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 04:38:40 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:47125
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbeJIIij (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 04:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtUm7ndIQjPfUvx+9jWbfmfXnp81mm94Z49wz42dzHA=;
 b=fg6TVWF1VUZDR6sCsWwqXGsszrCFS9dR3p2DV337sn3xcAR17AecIaxAx3KevhjrOehgTwX3XeH1IWRbVzVL+m/2hVzvKx/7Gw2lEP0VboG52PdcHRAzXaDKAiIRQ8bE1OkADSa3MZElJiYJp+o9GXAErtEoBM6hrd/tDKeZFHc=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB4046.eurprd04.prod.outlook.com (10.171.182.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.21; Tue, 9 Oct 2018 01:24:10 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::5c50:30f3:3805:71f9]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::5c50:30f3:3805:71f9%4]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 01:24:09 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
Thread-Topic: [RFC] usb: chipidea: Add minimal support for HSIC interface on
 i.MX6QDL
Thread-Index: AQHUXwsDLRUbQlbQbUi4BM689kvOEaUWHfPw
Date:   Tue, 9 Oct 2018 01:24:09 +0000
Message-ID: <VI1PR04MB5327D0F4AA27C5AED5C535388BE70@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
In-Reply-To: <1539005352-10909-1-git-send-email-frieder.schrempf@exceet.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB4046;6:ImtWuUQbtLsJKwis0rVYVmNRuLd0er0t9+JwSjYtvRGtViWPJSPTAtL+YZcgQKIHoEiKxnc4hiGkdDw2o3AHgJqK2GHLo1bJdZWLXVTrDwxBiYXuwJ2tqC6W8NDa1V7Wnhuo/2B/gDrTazc7b2ioe2bRcCKAua4ZoubEddito/MFGcT5ao7/W/nKRB8SKm9VgDqj7FMLC3zwDiL2a72T1x03HL28Z0KZRITwQtjGhtwCprWqPqStm+IrB2ydyY61emSeZyI/qRRATb6iMEvxSORInbooHVDjLDaD/ZQCe1rqrCRG/SrBZPBMlZLJFeNvNni9gPcoZYf+Ka/6kkKfbvvR4Ub2QMfew+8472ht8+VpwLBc27d/EvB7fBy+drx8Nhd01cpMdVt+4OieolFBnx4pvs8cpkt1mPA1a+cOVkjsHwYc8XckG9KQIptm5F06kTHPE2+g4Ac3+MG4vh4HiA==;5:oaTqxaEvG92ikDNAzT9ohg4OnZ2duYku2An1NAMltDZADCg1SSvOr+Ok103NJBlzCwjLZR8w4STiv2BkY6fytHJ5ICwU8gVHVqjpkJtDsLOUXo1k4yOqKaIIZ//e5F+OiOn8BZecjATOv1Y+YbobZfamJWr/VLu0LJPQT+ldZWU=;7:vPABljn48mdfJg9pXCUZLZ1Ej788yZt163l0KZPneakLf1TiWG6UFuOVRbzkOCyuMAGqFN65fCfgvhuURJOpX+zGC8509N7K/tZYFB03klllRHf5LsvbeIWFG8h7qnIfZ1ER+2HnS/Md4LAGXyu6c4OjiBMAoQoo2noQWhbGvlGoM+Pt7U2L0KOlncuETjr0jIyX/KASZXxXlAGZtVbEIkOY50gnb4zmSQmJYfoWzssNCflZZRKvwZ6K9PoAWMGm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 45216917-ab17-4ad1-a4a1-08d62d85ea09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4046;
x-ms-traffictypediagnostic: VI1PR04MB4046:
x-microsoft-antispam-prvs: <VI1PR04MB4046A0271380D37E85D232848BE70@VI1PR04MB4046.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(45079756050767)(189930954265078);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR04MB4046;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4046;
x-forefront-prvs: 08200063E9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(136003)(346002)(39860400002)(199004)(189003)(486006)(11346002)(4326008)(76176011)(305945005)(6116002)(3846002)(44832011)(81156014)(81166006)(2900100001)(6506007)(8936002)(476003)(25786009)(14444005)(256004)(8676002)(54906003)(45080400002)(97736004)(68736007)(478600001)(5250100002)(2501003)(106356001)(7696005)(110136005)(71190400001)(33656002)(99286004)(105586002)(74316002)(2906002)(6246003)(53936002)(229853002)(14454004)(7736002)(71200400001)(26005)(316002)(6436002)(186003)(86362001)(575784001)(102836004)(446003)(966005)(66066001)(6306002)(9686003)(5660300001)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4046;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MYy/WBWT0Ua66YXSipLWpDC93IegT6+TOqyvVHM+m6ar/AXe6tueWNVuEAPmzoohwDzO/h2oNG0xdPmFM8XyPnrHoLRzE/Y2S0mQ9BMTOGqV8omyGGmXlhwiI5J3Ipna7LMjoLvvVMEI5zKfmVlaViHLKf759M2mrsfcH704UkXXH0ZkxtsXsCEj2Wk3JArnPpgHUloc5QMC2bu543I2DgCd7STVJlk2ugr3Mk05qxVmNwG52T2ngmipgwLiB80P1Znucke0Y6e3LnJ1+QNTuiEf+Zqst2YFDjZYcTKCNkHQrbfId2t8ERAuLuIkbkC59bH+Yd2yBD7Mh8/H5kjLM7fw4nlx0f0dgVzffw+LFg8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45216917-ab17-4ad1-a4a1-08d62d85ea09
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 01:24:09.7983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> The topic has been discussed before: [1] And there is some implementation=
 in the
> vendor kernel: [2]
>=20
> It seems like two things need to be done:
>=20
> 1. Switch the pinmux of the strobe signal to use a pullup after
>    the core has been initialized.
> 2. Enable HSIC mode and HSIC clock
>=20
> This patch only implements these basics in a minimal approach.
> You need to have an additional pinmux setting "active" in the dt, that se=
ts the pullup.
>=20
> It was tested with the SMSC LAN9730 USB Ethernet adapter on the iMXceet S=
olo S
> board.
>=20

Thanks, I should do it earlier, I could not find a suitable board with HSIC=
 support at mainline kernel.
It is very kind that you could help on it and test function at real board. =
My suggestion is
follow all flows in Link [2] since we need to cover suspend/resume and remo=
te wakeup.=20

Peter

> [1]
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpatc=
hwork.
> kernel.org%2Fpatch%2F3541771%2F&amp;data=3D02%7C01%7CPeter.Chen%40nx
> p.com%7Cea362518eae9440028aa08d62d22246b%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C636746022015840824&amp;sdata=3DsHE2yZha9%2FhN
> SSBjXogDMtdflhNc2n9mNlUe9t8E1kY%3D&amp;reserved=3D0
> [2]
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fgit.f=
reescale
> .com%2Fgit%2Fcgit.cgi%2Fimx%2Flinux-
> imx.git%2Fcommit%2F%3Fid%3Dcf2d3ff6b217ef41f0e594daa9615e2&amp;data=3D0
> 2%7C01%7CPeter.Chen%40nxp.com%7Cea362518eae9440028aa08d62d22246b
> %7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636746022015840824
> &amp;sdata=3DiDRlnA9liWua7UMHBcVdUlMkBP6MIG7KUpHIAwQbDA0%3D&amp;re
> served=3D0
>=20
> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> ---
>  drivers/usb/chipidea/ci_hdrc_imx.c | 10 ++++++++++
> drivers/usb/chipidea/usbmisc_imx.c | 22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>=20
> diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci=
_hdrc_imx.c
> index 19f5f5f..fef8bda 100644
> --- a/drivers/usb/chipidea/ci_hdrc_imx.c
> +++ b/drivers/usb/chipidea/ci_hdrc_imx.c
> @@ -256,6 +256,7 @@ static int ci_hdrc_imx_probe(struct platform_device *=
pdev)
>  	const struct of_device_id *of_id;
>  	const struct ci_hdrc_imx_platform_flag *imx_platform_flag;
>  	struct device_node *np =3D pdev->dev.of_node;
> +	struct pinctrl *pinctrl;
>=20
>  	of_id =3D of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
>  	if (!of_id)
> @@ -331,6 +332,15 @@ static int ci_hdrc_imx_probe(struct platform_device =
*pdev)
>  		pm_runtime_enable(&pdev->dev);
>  	}
>=20
> +	pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +	if (!IS_ERR(pinctrl)) {
> +		struct pinctrl_state *state;
> +
> +		state =3D pinctrl_lookup_state(pinctrl, "active");
> +		if (!IS_ERR(state))
> +			pinctrl_select_state(pinctrl, state);
> +	}
> +
>  	device_set_wakeup_capable(&pdev->dev, true);
>=20
>  	return 0;
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/us=
bmisc_imx.c
> index 34ad5bf..a6556c8 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -64,10 +64,16 @@
>  #define MX6_BM_OVER_CUR_DIS		BIT(7)
>  #define MX6_BM_OVER_CUR_POLARITY	BIT(8)
>  #define MX6_BM_WAKEUP_ENABLE		BIT(10)
> +#define MX6_BM_UTMI_ON_CLOCK		BIT(13)
>  #define MX6_BM_ID_WAKEUP		BIT(16)
>  #define MX6_BM_VBUS_WAKEUP		BIT(17)
>  #define MX6SX_BM_DPDM_WAKEUP_EN		BIT(29)
>  #define MX6_BM_WAKEUP_INTR		BIT(31)
> +
> +#define MX6_USB_HSIC_CTRL_OFFSET	0x10
> +#define MX6_BM_HSIC_CLK_ON		BIT(11)
> +#define MX6_BM_HSIC_EN			BIT(12)
> +
>  #define MX6_USB_OTG1_PHY_CTRL		0x18
>  /* For imx6dql, it is host-only controller, for later imx6, it is otg's =
*/
>  #define MX6_USB_OTG2_PHY_CTRL		0x1c
> @@ -351,6 +357,22 @@ static int usbmisc_imx6q_init(struct imx_usbmisc_dat=
a
> *data)
>  	writel(reg | MX6_BM_NON_BURST_SETTING,
>  			usbmisc->base + data->index * 4);
>=20
> +	/*
> +	 * Core 2 and 3 are host only and HSIC only,
> +	 * so we enable HSIC by default to make them usable
> +	 */
> +	if (data->index =3D=3D 2 || data->index =3D=3D 3) {
> +		reg =3D readl(usbmisc->base + data->index * 4);
> +		writel(reg | MX6_BM_UTMI_ON_CLOCK,
> +		       usbmisc->base + data->index * 4);
> +
> +		reg =3D readl(usbmisc->base + MX6_USB_HSIC_CTRL_OFFSET +
> +			    (data->index - 2) * 4);
> +		reg |=3D MX6_BM_HSIC_EN | MX6_BM_HSIC_CLK_ON;
> +		writel(reg, usbmisc->base + MX6_USB_HSIC_CTRL_OFFSET +
> +		       (data->index - 2) * 4);
> +	}
> +
>  	spin_unlock_irqrestore(&usbmisc->lock, flags);
>=20
>  	usbmisc_imx6q_set_wakeup(data, false);
> --
> 2.7.4

