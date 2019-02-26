Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C6C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F10521852
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lsj7qKqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfBZMDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:03:50 -0500
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:20110
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726063AbfBZMDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:03:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjNJAvpY45/UF8rVbyDRsUQ30Q+c3pkeMgMVahrgWKg=;
 b=Lsj7qKqt1SJydiOjJAhGUEwV8gzITe5PdbtrjrNP5POSBIcR468kURGyVz0kK2mSVUb9tki3XQxkQP9FTgqlicw6dFyUPuNeDWITdeFMpOp3qnKmo/PL2J2DrHBvWu9LPr/XC0atcYqP3fw+gAOPGdwuXy4rxZWOXoiDNOVMB5c=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4290.eurprd04.prod.outlook.com (52.134.91.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Tue, 26 Feb 2019 12:03:45 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 12:03:45 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>
CC:     Stephen Boyd <sboyd@kernel.org>, Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQgAACEoCAAAWUMIAABaoA
Date:   Tue, 26 Feb 2019 12:03:45 +0000
Message-ID: <20190226120344.r5ymbrdfddaoslbn@fsr-ub1664-175>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
 <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <20190226112329.slvskbyokeqe7vik@fsr-ub1664-175>
 <VI1PR04MB4222FB04467A3FF699FF43D8807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB4222FB04467A3FF699FF43D8807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 708b819f-97fa-49de-115d-08d69be275a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4290;
x-ms-traffictypediagnostic: AM0PR04MB4290:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4290;23:ZU/Sk7JpFbv6acEoMlzhxITzz5KcQKxr6TBXMxCdh?=
 =?us-ascii?Q?4VntaZGk4vx10SKqfkSBqpyCdAqWwGCBySBFD9wxNqyH1Li0/NB5AsGDj5eD?=
 =?us-ascii?Q?SjMd0HosVMv0l2jAmXtB1u2Goi4hH3IpwGl8aFpafBzAAy74OWZVtfklDJ/h?=
 =?us-ascii?Q?bB/c9l1Fxymt+0svtE2y2mrwLK/6fVpCzMUeZt4c7Y5dSabnE1ZyeGDv2SHT?=
 =?us-ascii?Q?8oKvLP1olYcvYyFOWy2Cj670D9qJfuWm0j4QPEJ0iUZ9KeBojwOh5QSZ3ThA?=
 =?us-ascii?Q?wOAPQcM1+zvYd9wF9ATsN+CEjq9tVuj1jc4qlrO9eB/QEqmMJCMT1mUvHC5a?=
 =?us-ascii?Q?crey3c0s1u0EEy0pa/PTr6TE8HXInfdFGIk+4nYy+OhispJhSLztz79C+5qt?=
 =?us-ascii?Q?vtwbWrkNpHEzrfCvq/1NbfQwpx3mxvAQpI95VrTi0k/13l/3MhxO8Fde3vqu?=
 =?us-ascii?Q?7Wd2r7R1AhCL9WvLYIqR3TCK8dl34TzuH5PUpDAGtfjMI435+3hUGNTLZT5X?=
 =?us-ascii?Q?ys6piA5+ytPTz42DyW9FhIqBooDOcO5KuE1zdJmi9pxnvW3VrN+n+Epitox2?=
 =?us-ascii?Q?nR0fOWsnMx3loPz0WXHW9+i7A0vgUwnhDGPC5VTxOjjRT+rVj1LhHAoP3Acd?=
 =?us-ascii?Q?Br8jJQrguC60/UiG4rRemzQ/0fIfeqgFk7XecQXdO53Ob+G0Uw/X48MUS0LC?=
 =?us-ascii?Q?bwCC4s76kMtryFXyNcLpM654LQKZcU5C0KzOqAWvI0w+lysyLgeKd2bxnpLa?=
 =?us-ascii?Q?juS9RubgwT9ggr74TgEiVISzbK2lN+CB//Fpbinwek99nVES3ZXNytptbsZC?=
 =?us-ascii?Q?08pPPWzFxmarwJb0efYc7rauq2+MdkCXIn8WAP5l+kb8/86kOmSWxOp/Nhof?=
 =?us-ascii?Q?WujjlrAy3PVdlGioasJAnkFdX7lQpayox7x7g/oLAbtwlXTa0+PUXU6CvqEx?=
 =?us-ascii?Q?2AgKLvBdwyf8ewi23TefI35PZrVQqy2PZiEL3u078r3VyGwjVYg9FyoKyTOW?=
 =?us-ascii?Q?Q64l+sPnthO28wEIFomlNPRNhCb/OMJ44JSz13k4H51PIzs2rDgydJotnBDl?=
 =?us-ascii?Q?Ik5NKys61XS3OA/R6Oc7yvJux4gW4CXsA/LqfCuT+Q4kuMUC091SKwF593yp?=
 =?us-ascii?Q?+JCOiyY+fS5AyNjIBWQxUEE52xWvuZRSaQfF5Cy7oJcW+GE4tM/oGKE5oIv5?=
 =?us-ascii?Q?iJmUhmlnwRrwT7wiXT4vG+rd5Gp5gkcE73/yIXJxSthfaNnO6sDBYYVUKBED?=
 =?us-ascii?Q?VHAUTgWZcNdMg9T5DvurQDzvHhLJ4m+9nhAdjO846r08jANo/YtDpaz0RXJv?=
 =?us-ascii?B?UT09?=
x-microsoft-antispam-prvs: <AM0PR04MB4290B58AD2A465F7CFE12990F67B0@AM0PR04MB4290.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(4326008)(229853002)(3846002)(14454004)(6246003)(6116002)(186003)(106356001)(26005)(6862004)(478600001)(6506007)(99286004)(1076003)(105586002)(102836004)(76176011)(25786009)(53546011)(66066001)(9686003)(5660300002)(316002)(44832011)(486006)(54906003)(476003)(6512007)(305945005)(7736002)(11346002)(446003)(2906002)(93886005)(81156014)(53936002)(8936002)(256004)(86362001)(6636002)(71190400001)(6486002)(97736004)(71200400001)(8676002)(81166006)(68736007)(6436002)(33716001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4290;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: v8dQGVfNwkbPNqBfyQj9RWPUie/j1xl1wcD2bWiPqPAefg/MBpi5El7pVLn7HsoUcEH+eQSth52o7kYD+uUyIs+JVsMJBQUacusCb6rqD0sql3EZbF00+SWjS7wm3WQz75ZA+OV9zLA3M3k7eGRzKVsKCLQxigMQ0zNE5q/C5YNvaSLxSKT8HR/U0QNrd1kA0EcO2ect/wZzsyqwpn/U1Gkx5ITCKo9Y1ap8r4WgElASXCEzGqiCw/TQR/w4eoW1hRLHIiMKpuXdBzOivp76NQLRvUjZOm0Pyr1n56zUE4HBSlzA+wh+R1Zl603aoXsalOpOaEFQxmk9ScOTONmMFdX2uL4tr9kiL7Janb6QxaBIXsQSbWzw3To7pN5/qJAojG9BGniatNutb8VkGq6o5zDJOvYv0PzgEsYuamzJf3A=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1361B4BE64762642BA864C327BB269F2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708b819f-97fa-49de-115d-08d69be275a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 12:03:45.6152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-26 11:45:17, Aisheng Dong wrote:
> [...]
>=20
> > > > > > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > >
> > > > > > I suspect these tested by and acked tags should have been
> > > > > > dropped, unless you discussed and tested off-list?
> > > > > >
> > > > >
> > > > > Oups, I forgot to drop them.
> > > >
> > > > Ok. Can Lucas re-test?
> > >
> > > Tested on clk-next by cherry-pick a few defconfig patches from imx tr=
ee.
> > > So:
> > > Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
> > >
> >=20
> > Thanks for helping with the testing.
> >=20
> > I don't think there should be any defconfig changes required by this pa=
tch.
> >=20
> > Can you please list here the CONFIGs added?
> >=20
> > Just wanna make sure I'm not missing anything.
> >=20
>=20
> Clk-next does not have MX8 defconfig patches.
> So I manually cherry-picked them from imx-next.
> Below two needed:
> dee305e arm64: defconfig: Add i.MX8MQ boot necessary configs
> a1624ef arm64: defconfig: add imx8qxp support
>=20

Ah, makes sense.

Thanks.

> Regards
> Dong Aisheng
>=20
> > > Regards
> > > Dong Aisheng=
