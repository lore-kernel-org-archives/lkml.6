Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77579C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6F6218D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 02:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UEaykZ/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbfB0CfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 21:35:20 -0500
Received: from mail-eopbgr20066.outbound.protection.outlook.com ([40.107.2.66]:33958
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729276AbfB0CfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 21:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsIb+uxrctVQ5VA9jlYBM+oQcHCdag5CYKjXssWQDcY=;
 b=UEaykZ/kNyGnjJpg0uthBazcG4wcj+uMjEbRyVFe1QhPa/xQqYDQPCZmSZ1AaHv3A6k7jA9cWVXJRl6RJYG1EUn92+JHo3glZeeYx7rqPC2Xr9rodsUv/fxQXtb3UuS0AmrUbGtFb45+AE6cUElMIGBRDwl361k/LypqOK6E7+s=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2770.eurprd04.prod.outlook.com (10.175.41.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Wed, 27 Feb 2019 02:35:15 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::54f5:3bc4:9018:f123%6]) with mapi id 15.20.1643.022; Wed, 27 Feb 2019
 02:35:15 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Li <pku.leo@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci  reset
Thread-Topic: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen during
 xhci  reset
Thread-Index: AQHUzfHmauKj0nbPoU2toyXsYrER/KXy7LfA
Date:   Wed, 27 Feb 2019 02:35:15 +0000
Message-ID: <AM5PR0402MB2865656822F6CA28AF9E50E5F1740@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190226070016.27372-1-ran.wang_1@nxp.com>
 <20190226163948.GA8854@bogus>
In-Reply-To: <20190226163948.GA8854@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a915b37-2129-463a-1dac-08d69c5c34d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2770;
x-ms-traffictypediagnostic: AM5PR0402MB2770:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM5PR0402MB2770;23:P2uDFBybeXrQTXM6svRT9NMwxBINkoZDik+PxS3?=
 =?us-ascii?Q?oUvk8urUiLU+H+6B1oE78hcNjT5+fM4nzcsfe7CPfewO9/rNkRjQjQPagk0l?=
 =?us-ascii?Q?7oHV8HK0oHnSlY4g4HjdPlBHGw7cT0IWCRIjP32fl3+9yK+OAnpHjAmFGQD5?=
 =?us-ascii?Q?rRAnZ0wE+Ag9wiWlZBXftFn1/84aVphWGzQUa8sxAFK2hcHKKgbC7ZVLM5Cd?=
 =?us-ascii?Q?ID13p7Juv9yQZiKEbbNx2fC3yeXEYNvktw7YEGiB3RCG08vWYYa4vW+H2QfP?=
 =?us-ascii?Q?tAGgvflPoV6fk/0lWCJBTTwvhwHpQShTh+1Ll0wqIDbFrd95QZalAKudGBsZ?=
 =?us-ascii?Q?GV51Gb1RsFd9Z0DAbq1fcRJO+vLcQwb3mGmNykYz3vk5JOYHEfLNeBixm7pO?=
 =?us-ascii?Q?Iemq1G06De74Q8+SF1rrl1aQCbvAbUt8ZYLX0nl6RmHoDFV4HGfrBvDrNFoy?=
 =?us-ascii?Q?QY/ty02GFSzFrBNv1Bm2cJaqioomZdNVp39MN1XnVxbzS/9ovFCop/o7nItB?=
 =?us-ascii?Q?QB9DQseGbK7OQshbn3pr3cOQ4dDUvF0KnYBN7ftb3RvK7XQAyg0vs3ysm6Hb?=
 =?us-ascii?Q?bYVYt9JxXz/WYa4nWc+scnET3UzDmWSOUlFScGKkpB+8yGs25F8whWisut+F?=
 =?us-ascii?Q?Vt7KLCpfl3gj4wxSMegQ/cKoQ/W2pksXxLVa3lXnYVLNg2jiq/yZ/3k3C7Ac?=
 =?us-ascii?Q?JaQ5aDoP2AdlaYWMWzVuE6fpUrAvm1eZCyq4GBI+miv87eSZPmreotU3ag6Q?=
 =?us-ascii?Q?7DhZn+sLnggQWl6kLLjYgtkNjO2lXpNqArnfSTEbJQB8ZFNpEX3HGbW7GNxp?=
 =?us-ascii?Q?HalDlYxOix4H6E9lxucUZe+dE0Y/8Vi7P0pFS+WS+/EuZBInV3C/2mQAhPO0?=
 =?us-ascii?Q?hxbgEdGr/dEiJgkRis1apylmv1kWvfe1qGAsWvxcZeoySx+l5tCd6Ji5Bct6?=
 =?us-ascii?Q?VzH8PndiSBf7eVmKfEMJ9WLZSLF2cJkb4o5jcuWWyaaujcVIeAuZHXAL6V91?=
 =?us-ascii?Q?0uPWxrLqmFb+lxwcezWDQAY46i59TJwJHYRTsF/aqPJ6eZel70p5J3VZoD67?=
 =?us-ascii?Q?frLFhoICDO8mXSig2aVQiVX2NoSRg0aHZAnbrLVxscTTQH3LPcz2MYRAhaqD?=
 =?us-ascii?Q?SRYBj8sCy/4E8RKiVSZoe9Evd3V+5A+Q9XL673ByvcsAkR1b3rQjVwuGCcpt?=
 =?us-ascii?Q?rvorcksFCOK5PTCSL7AYYU8pOiNYMma7gI3P39gzUmRjjJxECxvTHRJ3coYT?=
 =?us-ascii?Q?Fu1hPZShE70YNMTgbff2zVmM4VUpUdJHDCt9hrPknH+vkhvjp13Td6q4hJ03?=
 =?us-ascii?Q?JhA=3D=3D?=
x-microsoft-antispam-prvs: <AM5PR0402MB2770859EA35BEE9B2066401EF1740@AM5PR0402MB2770.eurprd04.prod.outlook.com>
x-forefront-prvs: 0961DF5286
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(396003)(376002)(136003)(39860400002)(13464003)(189003)(199004)(76176011)(7696005)(33656002)(6116002)(3846002)(6506007)(26005)(102836004)(53546011)(316002)(55016002)(6436002)(7736002)(9686003)(74316002)(11346002)(305945005)(476003)(486006)(186003)(2906002)(53936002)(446003)(106356001)(105586002)(4326008)(6246003)(99286004)(25786009)(54906003)(229853002)(68736007)(81166006)(8676002)(8936002)(81156014)(6916009)(5024004)(14444005)(256004)(97736004)(478600001)(71190400001)(71200400001)(86362001)(52536013)(14454004)(5660300002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2770;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UV2ORTXmAB5imdFOv/i5i3n1IzpuAo4Rhk5P12G1Yw92eTqn80bsjTWgFPxTRB9xbd8IXTgHFeuQQAFMRAPGgIgL77UT66IWvTPAV6OvLnyaQNPRvzgNboNAogRoGHt1NTIgjIM79jhjYNIg8hdML1mg2hvK349AY5TwMUX8NqXvKPTSw3qAaCSqayPvkf+Csd3DB9G1zqc9hE0JjCLnIiaqvFEm9hqOBG0Vk7lcRpO3qa5ThR6Iv0hpGVTHHSMytBTMb/OlBizxpfxeAjou5ARITtBt+lmfA/VaHM1xj5tFWhZQXVD3WzINrpqajK1VEKsm43lSa3EL1NjIe24lpXcez+4q4laaqPy8tCxDMpzXYGb7zTxYXUP3UumePEBXkmdCKO42qvi5Oq7hpPT2j5Fif3tNeDFDzpM9vUU7mF4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a915b37-2129-463a-1dac-08d69c5c34d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2019 02:35:15.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2770
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Wednesday, February 27, 2019 00:40
> To: Ran Wang <ran.wang_1@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Yang Li
> <pku.leo@gmail.com>; linux-usb@vger.kernel.org; devicetree@vger.kernel.or=
g;
> linux-kernel@vger.kernel.org; Ran Wang <ran.wang_1@nxp.com>
> Subject: Re: [PATCH v3 1/2] usb: dwc3: Add avoiding vbus glitch happen du=
ring
> xhci reset
>=20
> On Tue, 26 Feb 2019 06:59:21 +0000, Ran Wang wrote:
> > When DWC3 is set to host mode by programming register DWC3_GCTL, VBUS
> > (or its control signal) will turn on immediately on related Root Hub
> > ports. Then the VBUS will be de-asserted for a little while during
> > xhci reset (conducted by xhci driver) for a little while and back to no=
rmal.
> >
> > This VBUS glitch might cause some USB devices emuration fail if kernel
> > boot with them connected. One SW workaround which can fix this is to
> > program all PORTSC[PP] to 0 to turn off VBUS immediately after setting
> > host mode in DWC3 driver(per signal measurement result, it will be too
> > late to do it in xhci-plat.c or xhci.c).
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> > Changes in v3:
> >   - None
> >
> > Changes in v2:
> >   - Correct typos
> >   - Shorten the name to snps,host-vbus-glitches
> >
> >  Documentation/devicetree/bindings/usb/dwc3.txt |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.

Got it, thanks for telling me this. So if I need to update patch 2/2 in nex=
t version,
I still need to attach this 1/2 patch with adding tag 'Reviewed-by' to it, =
am I right?

>=20
> If a tag was not added on purpose, please state why and what changed.

OK

Regards,
Ran
