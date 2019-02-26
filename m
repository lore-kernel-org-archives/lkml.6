Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9284AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D8A217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bdNJtht7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfBZLpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:45:32 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:37536
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbfBZLpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxAgVazUHAlLOBQRN5TQlIOe0kAqmYDoV3vZO0Ey/Q8=;
 b=bdNJtht7kb2W5ttq+G8nF95mHCNwNJmc8H+zftiJ4Yc/VfCp174ciI4aCxXDEVyK037kHTmLVn7PitQ7Odw5GM/65QOGJX2yPUhWCaVyXc05z6SdajA0QqnMJ9X2ZVgDIoGMkHGDcrRVqPa+rIG0ObU/jz/XI+nBgn1neNB0/1U=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5088.eurprd04.prod.outlook.com (20.177.50.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Tue, 26 Feb 2019 11:45:17 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::b1cb:82a5:aacb:238d%6]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 11:45:17 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>
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
Subject: RE: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Topic: [PATCH v2] clk: imx: Refactor entire sccg pll clk
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4CAA5A8AIABK8BQgAACEoCAAAWUMA==
Date:   Tue, 26 Feb 2019 11:45:17 +0000
Message-ID: <VI1PR04MB4222FB04467A3FF699FF43D8807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
 <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
 <155111539427.77512.17052467596124902632@swboyd.mtv.corp.google.com>
 <VI1PR04MB42229D26B9713EA6DFC484D2807B0@VI1PR04MB4222.eurprd04.prod.outlook.com>
 <20190226112329.slvskbyokeqe7vik@fsr-ub1664-175>
In-Reply-To: <20190226112329.slvskbyokeqe7vik@fsr-ub1664-175>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02672e38-0465-47d0-251c-08d69bdfe13f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5088;
x-ms-traffictypediagnostic: VI1PR04MB5088:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;VI1PR04MB5088;23:jmuXOYwMMoE9qV6JCgD63EQl03PV2FiMcIGuKBmHH?=
 =?us-ascii?Q?027JEFL0HPyFx70SKREKJU3tvLmgcqiwolUw6AmCSA9H7EbgHKDvUJTnCXov?=
 =?us-ascii?Q?1I4SSlEnTWtuAYcBNwSEaBBpESxtDTbP6fvrbwqrv7J3tVhH2lNziSBpTv9z?=
 =?us-ascii?Q?IqToT7GrBVQNLtSyPqqoxp4TMt7RA0wv7NGkfrHuSe+Jayb3jVAwclE3LEn8?=
 =?us-ascii?Q?NZQWEBe3BMuUFSg8cVtujgL25ipL1M5Bhx7hDGPflR95WLB9NmGFDmd9fF+o?=
 =?us-ascii?Q?lMeonrQYVsS1aJJcayfZOaiUPwr+o5fizB1Zg3yDjtSgNpYJYCpfYL9Q9UsV?=
 =?us-ascii?Q?OfucSYLX5AXFzc1ehoLgRWCu+w3iUDnjGGXPPBo1FvB654WBzz298TbD5D2B?=
 =?us-ascii?Q?lN/biJGjL+uKFY3c0i7j7mKAWuLBAoEdE+Ptldxqnhr3cdKpsvmvcXfcwqaC?=
 =?us-ascii?Q?Y8kcVOdmsj+j7HI/rGYV1gTsqEVHt1WFMlrgXtN+OpY6Tz9rHoOXtmxeA6G4?=
 =?us-ascii?Q?tHKRMm/qPx4x9Zwnptql3crNBN09Pz/gUZnuJYG3pi23Vf/O1+lL7v1DDAzF?=
 =?us-ascii?Q?TJuER5ZiPtUJBQHWmdKzLaMvfHLw7cc65f7X2M0ahcbAVc+E7cOBDfOs6CFo?=
 =?us-ascii?Q?2OrSpCJZqy7/x93Av2qtGuheI2AD+2kMeVIv11kCUaAcPj/ux7XfzzGWNRHf?=
 =?us-ascii?Q?AkGRu97nV1kZi+ploxYI0PL/nhT3Mbhx8zQdcMrBDKqvrTpmyqLIpg9G81eA?=
 =?us-ascii?Q?okwdOEY+6a995UeIFcq+fXuqhTnkalZwEOgwvwBJKMz5w6DfLQMvGiaQgon7?=
 =?us-ascii?Q?BXP9Bv39huWkMQhMLIi77z99RI3xyOVG28ReBqLfQPkjqEqGDdWYSGZ/eBUO?=
 =?us-ascii?Q?W95R+GWtq8gqBIblYkbQ/2Z+Jbx3uLr6QbDcnl5OzMIxrbCUdtHChUg2pNSp?=
 =?us-ascii?Q?AafoVV6wu5RuhPmPxjCivmtT6O3LET6JBoq6yQ74426rNdIoo3cN5HqLH8pX?=
 =?us-ascii?Q?FARz043oxnTItrK3Q5y0d47JoQwTQugq53n+vNQkqsyqcK8yrhYP/BYfPuqc?=
 =?us-ascii?Q?nIz3OkRXiYELHkNyw0Doix+3UkwtpT+wWv6X14/JQtdk9EN/4+WZxalVXlqW?=
 =?us-ascii?Q?Rj5qcBUKBE4LSi4vnqkYxnCS7gelX0G4RuIyfmzPbr/vx5psZf4Reyp73Cv4?=
 =?us-ascii?Q?sQP5YOxxn1o5FcaiRnH/pTNGcY2R3AK0LXEtj38wlNySY9cfToU5tY980jxY?=
 =?us-ascii?Q?Yo0AO4bCjo7UGpYf8bPgjRnB63aMRjmbH2ebXwUk8zNIqX27xjlSGPzVa3CY?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <VI1PR04MB50884CDFB1E81FA3CB1A77DE807B0@VI1PR04MB5088.eurprd04.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(478600001)(68736007)(99286004)(476003)(486006)(93886005)(8936002)(6116002)(3846002)(66066001)(25786009)(55016002)(6436002)(316002)(6636002)(54906003)(9686003)(229853002)(4744005)(14454004)(53936002)(81166006)(81156014)(8676002)(186003)(305945005)(102836004)(26005)(105586002)(2906002)(5660300002)(6246003)(97736004)(106356001)(52536013)(76176011)(6506007)(11346002)(74316002)(446003)(7696005)(44832011)(256004)(86362001)(33656002)(4326008)(71200400001)(71190400001)(7736002)(6862004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5088;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xH0BpJjZ6Ct5LKmkbm7G/fBRHsxOVciQfnNp74klDPCG/VYdh3RyxbpCSPn7e/7THCmMDeHg9jQ7sMBv9zVP1qMptdzNwCBCU3gzbRzj0LmEowLdrmOncgm3dxUe5NkCMp/YFcOYe0eM+Q7bYxclGtrCJMyvndZdq+p4gyEmZLhc1P/p2OB/8hu5nKr4YqWCYpQd7hUQREa5VfTxh0khC4svQ8t8IjgdwenLi5YKowgUk7cijeS6y+r1oWkyAP/bQ6pzSgcydxkq9747MJzaY8A3lufGSZgSyTMNlij25+4pgPqg3yOL5kyRyqkUKODe+VPkMRwFJnGhjYikGP2LJHd1Awk8AfrGTpPKRtOOSTfQO23upoPjjpoCYZuoW65kJMexgvZYy1iCFn5up2l5Ats/OuPridLVL/I7U080UU4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02672e38-0465-47d0-251c-08d69bdfe13f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 11:45:17.7297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

> > > > > > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > > Acked-by: Lucas Stach <l.stach@pengutronix.de>
> > > > >
> > > > > I suspect these tested by and acked tags should have been
> > > > > dropped, unless you discussed and tested off-list?
> > > > >
> > > >
> > > > Oups, I forgot to drop them.
> > >
> > > Ok. Can Lucas re-test?
> >
> > Tested on clk-next by cherry-pick a few defconfig patches from imx tree=
.
> > So:
> > Tested-by: Dong Aisheng <aisheng.dong@nxp.com>
> >
>=20
> Thanks for helping with the testing.
>=20
> I don't think there should be any defconfig changes required by this patc=
h.
>=20
> Can you please list here the CONFIGs added?
>=20
> Just wanna make sure I'm not missing anything.
>=20

Clk-next does not have MX8 defconfig patches.
So I manually cherry-picked them from imx-next.
Below two needed:
dee305e arm64: defconfig: Add i.MX8MQ boot necessary configs
a1624ef arm64: defconfig: add imx8qxp support

Regards
Dong Aisheng

> > Regards
> > Dong Aisheng
