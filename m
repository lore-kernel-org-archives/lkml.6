Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEE8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC98A20823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LFoPl8Ht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfBVJkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:40:53 -0500
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:12782
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725860AbfBVJkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:40:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rumMgBiGTGc1sSv+1pJTqydv877azE6w+km+7oCZWMA=;
 b=LFoPl8Ht2HG33JWAymY+JPROTIARM52hCKkmqGjjHpcu7MrlmENb1UvZz68tTFZb39jArZ+thhv9fiA1J38f0dpsUAu89rkJKQmWYmNN0fWM1qtYgS4qyHYM9+nguqZ9Uxf0N4DrmOmC4ByIuE70gOuRJLOTK+UvS/LasUpwjf8=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6157.eurprd04.prod.outlook.com (20.179.27.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 22 Feb 2019 09:40:47 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::790f:a219:bcbd:6fd2%3]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 09:40:47 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: RE: [PATCH v4 2/2] usb: chipidea: Refactor USB PHY selection and keep
 a single PHY
Thread-Topic: [PATCH v4 2/2] usb: chipidea: Refactor USB PHY selection and
 keep a single PHY
Thread-Index: AQHUydMmUuHv2CNDn0KF2MOzT4y1fKXrkYkw
Date:   Fri, 22 Feb 2019 09:40:47 +0000
Message-ID: <VI1PR04MB5327B630752F676889265EF88B7F0@VI1PR04MB5327.eurprd04.prod.outlook.com>
References: <20190221104914.32031-1-paul.kocialkowski@bootlin.com>
 <20190221104914.32031-2-paul.kocialkowski@bootlin.com>
In-Reply-To: <20190221104914.32031-2-paul.kocialkowski@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ee37038-6d4e-49b7-3bcc-08d698a9d315
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB6157;
x-ms-traffictypediagnostic: VI1PR04MB6157:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB6157;23:dKd2VnsbAjJ6H8cQKzVAe8NZAkUtSGWnkz5CaD2Zl?=
 =?us-ascii?Q?wL+i+FLfAgKsv8Avsx+pbHv2WH7rkHveuqrfH7wxVRsI4Rvxs05qwlP5MxYR?=
 =?us-ascii?Q?Mpc93VIcZSzgSKQ0wGSXAgT6efFXrZO4zib0CSJmemlKsApf7zWvhKydKWnA?=
 =?us-ascii?Q?zReHaFy5r4iK2l3O9dy5xMQ4YaPem66/MqXI+haswB8yngzg2H3TUgGBc4tu?=
 =?us-ascii?Q?P/yUDQ9dOHv9DQsRyl23Y7XMPonot8Xo5Y/sYyoFTb1uBEpr9p7XFO+iKM1w?=
 =?us-ascii?Q?TnRjpMdccm8YO7Vcl8QvYZiJme/snf2UhTIm2VIUJHIvoxBKI8/Y29gYfct7?=
 =?us-ascii?Q?EiA/wH5gLxl7HDkC1A53GVzf5kYCd7MXCR9wHBmPlEmRF9X3NyE96VYzf6jG?=
 =?us-ascii?Q?CTsZEiPOUVY9nQc4mhqj0r873RwO1Rci5Z7NA/eMzVgJWnyWVmyHBhZIiO+N?=
 =?us-ascii?Q?8CXqmNL6SHqlG+SMyVift63wQvUnlR92DcCNVM97U0jZ/Gb1yXRGa9IkAtIV?=
 =?us-ascii?Q?7GA0rftIRocfWY5E++f92uSwPhIKQCF73dru66wktSdI6fuMnMnKWyFXCZJQ?=
 =?us-ascii?Q?jD7aHP/2ouVEsybLJligaWZXoZGVTdTVkD/+7g5yi2sUa5WmrqVUXXNxrDSg?=
 =?us-ascii?Q?vA2NV7i7V+Sq+xPIzQFwj1Jmc3gkq1ZjmmU9EkN3jAP7Efjk5E/cebNYlWrl?=
 =?us-ascii?Q?cDmHeDsNuF92k7CR7z6+qbWBUoeWzQwahpyvpHSOul4C4r8Nk16g0YNmk/6y?=
 =?us-ascii?Q?ECeexBFDLvcJ+D7s5R/2hTgCftykFBsr+ZN0pd0I3uNyTGRyFnYOd7Tuak8o?=
 =?us-ascii?Q?vr/SBUm+0wZuNQy4fUho4mo+AGCDTjF7vKay3Cxb03RppcxCe3kZTsG2+UMf?=
 =?us-ascii?Q?9845w5DVjt5PgmyFc6lZz0Bwq+JNrWI66jeUleO+8UE3g7PfDXuwh49hLUxg?=
 =?us-ascii?Q?IjRXjqYNnx+8RJKSnwqoazDM0W6YzwWdVP2wHBlzYfE0P3jI46mWsmgHIwO1?=
 =?us-ascii?Q?4oeX7GiC+uAyNOYz094HddV/q2mQhMqzLkuPoympGWZv5bGLFHmNjzcSyowU?=
 =?us-ascii?Q?B5LwtkLxE0C1Gta9Ev0U5+0bqg0ZwX3y5XcloHQzP7k7oq3xjFXAcHSoUxAb?=
 =?us-ascii?Q?U/CR76mlnCScbmgegw35vXd81NCW7FEMDBLtgs6D17AClLQqkLL/xF8zQQa3?=
 =?us-ascii?Q?4vkxIKQWTIfeqnse2449NwULFdcv6jqFgvZ2+I1dbWzFOfJhIkm2wvm0H0XM?=
 =?us-ascii?Q?s8Tnk12CwpCBk7L1D4=3D?=
x-microsoft-antispam-prvs: <VI1PR04MB615792CF2B745027DBE037018B7F0@VI1PR04MB6157.eurprd04.prod.outlook.com>
x-forefront-prvs: 09565527D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39860400002)(136003)(396003)(189003)(199004)(11346002)(476003)(76176011)(446003)(66066001)(6506007)(256004)(26005)(6436002)(486006)(74316002)(81156014)(102836004)(305945005)(2501003)(7736002)(71200400001)(44832011)(8676002)(81166006)(71190400001)(6246003)(106356001)(9686003)(7696005)(53936002)(14454004)(97736004)(2906002)(55016002)(229853002)(478600001)(105586002)(6116002)(2201001)(33656002)(86362001)(5660300002)(3846002)(99286004)(186003)(316002)(4326008)(25786009)(8936002)(110136005)(54906003)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6157;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TN8F01rkAbGYk14Igdtsk/XlVKwE/mNMQYiByWOR4duD/iiTmcE6b/riAyVPkz3YjgppcSCuu9e9sejmDr+rtSXrJ7ZRhsaPoHUZ6T4FJexoUq2QdL2IqtJDir9UDGHJCc8McgAKxaCLOmKQPNxJO+CbzwVwbACdzkacv/25IL4nWPorjvLNXVFZ4jcxwVi4m+Cn+/V0otZqK6WbVXJkljbCmgAUej3Ge+y1oVthcEXY5hKl7A6eLq8uU+UROhUpR0inBPMWIAc8LKejXoAqGB/n4S2ILYioDx0URfcbKDcP0f3LktQVPEXi30MXVHCltYdQLt4J6m3beUglvr2pKPK4TkSsOH90sDS2VKfF4LXAAGRi90svkOjOeYQCddWVBWWzyiBaotgSn578+mzUDXgDwutWr9wiDOp7j0CCZcQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee37038-6d4e-49b7-3bcc-08d698a9d315
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 09:40:47.6592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
>=20
> Refactor the code in charge of looking up the USB PHY when no platdata is
> provided. Attempt to get a generic USB PHY first, then look for a legacy =
USB PHY
> through device-tree and finally get any registered PHY with the correct t=
ype.
>=20
> This way, only a single USB PHY is obtained and the flow is easier to und=
erstand
> and follow.
>=20
> All error pointers (except for EPROBE_DEFER) are considered as PHY not fo=
und.
>=20
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  drivers/usb/chipidea/core.c | 49 ++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c in=
dex
> 016e4004fe9d..27749ace2d93 100644
> --- a/drivers/usb/chipidea/core.c
> +++ b/drivers/usb/chipidea/core.c
> @@ -954,32 +954,47 @@ static int ci_hdrc_probe(struct platform_device *pd=
ev)
>  	} else if (ci->platdata->usb_phy) {
>  		ci->usb_phy =3D ci->platdata->usb_phy;
>  	} else {
> -		ci->usb_phy =3D devm_usb_get_phy_by_phandle(dev->parent, "phys",
> -							  0);
> +		/* Look for a generic PHY first */
>  		ci->phy =3D devm_phy_get(dev->parent, "usb-phy");
>=20
> -		/* Fallback to grabbing any registered USB2 PHY */
> -		if (IS_ERR(ci->usb_phy) &&
> -		    PTR_ERR(ci->usb_phy) !=3D -EPROBE_DEFER)
> +		if (PTR_ERR(ci->phy) =3D=3D -EPROBE_DEFER) {
> +			ret =3D -EPROBE_DEFER;
> +			goto ulpi_exit;
> +		} else if (IS_ERR(ci->phy)) {
> +			ci->phy =3D NULL;
> +		}
> +
> +		/* Look for a legacy USB PHY from device-tree next */
> +		if (!ci->phy) {
> +			ci->usb_phy =3D devm_usb_get_phy_by_phandle(dev->parent,
> +								  "phys", 0);
> +
> +			if (PTR_ERR(ci->usb_phy) =3D=3D -EPROBE_DEFER) {
> +				ret =3D -EPROBE_DEFER;
> +				goto ulpi_exit;
> +			} else if (IS_ERR(ci->usb_phy)) {
> +				ci->usb_phy =3D NULL;
> +			}
> +		}
> +
> +		/* Look for any registered legacy USB PHY as last resort */
> +		if (!ci->phy && !ci->usb_phy) {
>  			ci->usb_phy =3D devm_usb_get_phy(dev->parent,
>  						       USB_PHY_TYPE_USB2);
>=20
> -		/* if both generic PHY and USB PHY layers aren't enabled */
> -		if (PTR_ERR(ci->phy) =3D=3D -ENOSYS &&
> -				PTR_ERR(ci->usb_phy) =3D=3D -ENXIO) {
> -			ret =3D -ENXIO;
> -			goto ulpi_exit;
> +			if (PTR_ERR(ci->usb_phy) =3D=3D -EPROBE_DEFER) {
> +				ret =3D -EPROBE_DEFER;
> +				goto ulpi_exit;
> +			} else if (IS_ERR(ci->usb_phy)) {
> +				ci->usb_phy =3D NULL;
> +			}
>  		}
>=20
> -		if (IS_ERR(ci->phy) && IS_ERR(ci->usb_phy)) {
> -			ret =3D -EPROBE_DEFER;
> +		/* No USB PHY was found in the end */
> +		if (!ci->phy && !ci->usb_phy) {
> +			ret =3D -ENXIO;
>  			goto ulpi_exit;
>  		}
> -
> -		if (IS_ERR(ci->phy))
> -			ci->phy =3D NULL;
> -		else if (IS_ERR(ci->usb_phy))
> -			ci->usb_phy =3D NULL;
>  	}
>=20
=20
This patch should work, I will queue it if test is ok.

Peter

