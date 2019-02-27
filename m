Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAE4C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81A00218D9
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="RnfiIOgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfB0Ixn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:53:43 -0500
Received: from mail-eopbgr1310115.outbound.protection.outlook.com ([40.107.131.115]:47668
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbfB0Ixn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mUa/vym5ddVBhZIqOEynsOi0KZa15p+8beP3S6vewA=;
 b=RnfiIOgI0Fqpz8hNLbdrFFy/HtoQm6SZfJ+nUpWs9q5Mj2IQ5rwlQDi7CPd+kuL5pQMOQFQKWTB2b8So/oI3Kpv/nGpsZw/HEZ6ltcW+i41hUeoc5Nnphw2Iq9PoH12FsF9sAvJjIQHFnx0LCYWSdweqS2Nvv518q5t/6B0X7ek=
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com (20.179.170.147) by
 TY2PR01MB3275.jpnprd01.prod.outlook.com (20.177.100.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 08:53:35 +0000
Received: from TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819]) by TY2PR01MB4812.jpnprd01.prod.outlook.com
 ([fe80::44b:a054:4954:f819%2]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 08:53:35 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error paths
Thread-Topic: [PATCH] phy: renesas: rcar-gen2: Fix memory leak at error paths
Thread-Index: AQHUzmoRtGFFVYG3M06xnOGKQQhNVaXzTx6AgAAGzdA=
Date:   Wed, 27 Feb 2019 08:53:35 +0000
Message-ID: <TY2PR01MB4812FABCB851C22F4295B9D4D8740@TY2PR01MB4812.jpnprd01.prod.outlook.com>
References: <1551250826-10302-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <alpine.DEB.2.21.1902270920300.2671@hadrien>
In-Reply-To: <alpine.DEB.2.21.1902270920300.2671@hadrien>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [124.210.22.195]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9899241-c4f7-4750-38d7-08d69c910f42
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY2PR01MB3275;
x-ms-traffictypediagnostic: TY2PR01MB3275:
x-microsoft-exchange-diagnostics: 1;TY2PR01MB3275;20:b4UylppEWkWztrYBLrA+vfi3feI0xUepowyMHv8JWAaWPanEPziA8vNww0uUgRVI+n5XyzQSeGllbEJW//51pRfgNsbNSABtCOfB/Vi/jt7X6cgS3TZUUi/scLBpbSthAYr+4GFiMhK4/D3fpL/bWULghLcowZE+Pv/5q/CffY4=
x-microsoft-antispam-prvs: <TY2PR01MB3275F32B234BA7090C330DCFD8740@TY2PR01MB3275.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(136003)(199004)(189003)(446003)(55236004)(11346002)(102836004)(6506007)(97736004)(316002)(68736007)(486006)(256004)(71200400001)(6246003)(4326008)(71190400001)(476003)(25786009)(52536013)(26005)(76176011)(86362001)(186003)(5660300002)(53936002)(8676002)(229853002)(6916009)(106356001)(8936002)(7736002)(33656002)(6116002)(74316002)(3846002)(9686003)(55016002)(7696005)(14454004)(66066001)(478600001)(99286004)(54906003)(2906002)(81166006)(81156014)(105586002)(305945005)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2PR01MB3275;H:TY2PR01MB4812.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PrKjwdykwSeRlIw9BqKkXYYR3osXZ9vdZsU42xEAWtvXA1BCOK100jH2LDxBcshBztgGG4ZIk70df/nK3fkxoEQzkG+812HrhkXLO2DQwOvRXISE035muUQRwFz49jdJQ2f5SbAbjHM9g6QAWz3ev0Syw390XNgza7usDV6CKhY7OnNuzATvbXImX5MATd2UeoE5o8xmOEGQ3U3VYpUkrOCKQrKie8drLLh4qingHo5MrmHH/wpjDha+6m9CTy360/NdDVlHIXtg8i4q3CJsdHQCQ6gdHz6o0v+XqV4QXQKGMTqyf3+Cg/YI3o8yk25G27vxu8P2QbZCDJ/+erQq+l7t6P2wghHB6J9XN39mhuD5yC6AH8NQEkVqyvpX78NBuXvYrsuMEQpbXDtSgXL2wc1JnsZoI57g0wIVuk/cBc4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9899241-c4f7-4750-38d7-08d69c910f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 08:53:35.7821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3275
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> From: Julia Lawall, Sent: Wednesday, February 27, 2019 5:25 PM
>=20
> On Wed, 27 Feb 2019, Yoshihiro Shimoda wrote:
>=20
> > This patch fixes memory leak at error paths of the probe function.
> > In for_each_child_of_node, if the loop returns, the driver should
> > call of_put_node() before returns.
> >
> > Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> > Fixes: 1233f59f745 ("phy: Renesas R-Car Gen2 PHY driver")
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  drivers/phy/renesas/phy-rcar-gen2.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/phy/renesas/phy-rcar-gen2.c b/drivers/phy/renesas/=
phy-rcar-gen2.c
> > index 72eeb06..570b4e4 100644
> > --- a/drivers/phy/renesas/phy-rcar-gen2.c
> > +++ b/drivers/phy/renesas/phy-rcar-gen2.c
> > @@ -285,6 +285,7 @@ static int rcar_gen2_phy_probe(struct platform_devi=
ce *pdev)
> >  		error =3D of_property_read_u32(np, "reg", &channel_num);
> >  		if (error || channel_num > 2) {
> >  			dev_err(dev, "Invalid \"reg\" property\n");
> > +			of_node_put(np);
> >  			return error;
> >  		}
> >  		channel->select_mask =3D select_mask[channel_num];
> > @@ -300,6 +301,7 @@ static int rcar_gen2_phy_probe(struct platform_devi=
ce *pdev)
> >  						   &rcar_gen2_phy_ops);
> >  			if (IS_ERR(phy->phy)) {
> >  				dev_err(dev, "Failed to create PHY\n");
> > +				of_node_put(np);
> >  				return PTR_ERR(phy->phy);
> >  			}
> >  			phy_set_drvdata(phy->phy, phy);
>=20
> Hello,
>=20
> I was concerned about the assignment channel->of_node =3D np;.  Because
> channels is allocated with a devm function, it will get freed on an error
> return, so this pointer doesn't matter.  But don't you need an of_node_ge=
t
> on this assignment?  Does the fact that you haven't seen a problem with
> this in testing mean that the field is actually never accessed?

The channel->of_node will be used in the rcar_gen2_phy_xlate() as drv->chan=
nels[i].of_node.
The assignment is not used for any device tree APIs, just comparing the poi=
nter.
So, I don't think this driver needs an of_node_get() on this assignment.
Is my understanding incorrect?

---
static struct phy *rcar_gen2_phy_xlate(struct device *dev,
				       struct of_phandle_args *args)
{
	struct rcar_gen2_phy_driver *drv;
	struct device_node *np =3D args->np;
	int i;

	drv =3D dev_get_drvdata(dev);
	if (!drv)
		return ERR_PTR(-EINVAL);

	for (i =3D 0; i < drv->num_channels; i++) {
		if (np =3D=3D drv->channels[i].of_node)	// <--- here only
			break;
	}

	if (i >=3D drv->num_channels || args->args[0] >=3D 2)
		return ERR_PTR(-ENODEV);

	return drv->channels[i].phys[args->args[0]].phy;
}
---

Best regards,
Yoshihiro Shimoda

> julia
