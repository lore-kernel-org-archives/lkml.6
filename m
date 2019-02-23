Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16159C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81F920684
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 10:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lyakD850"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbfBWK6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 05:58:18 -0500
Received: from mail-eopbgr60074.outbound.protection.outlook.com ([40.107.6.74]:5677
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726269AbfBWK6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 05:58:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Arh/XAY6anGIWLDVGnZoqKxA4shfTu26Xfs7rjVxYcc=;
 b=lyakD8503yJ40MypIOI7iND6MECaJfM727bht9Urox37AUAZUushuoqbKirKKgTfq89YDiGWfSubEd06e+AT61l0ajkP2HZRfIXlBqhktMXUALNzTBLRPOyROGJ5Nxo1CzZZsWXPIVIUVCsCsRlfZQqcx6mEDLNekJJFvwR310M=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB6098.eurprd04.prod.outlook.com (20.179.34.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Sat, 23 Feb 2019 10:58:14 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1622.018; Sat, 23 Feb 2019
 10:58:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
CC:     Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
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
Thread-Index: AQHUytEZ0gNCfcsGj0q44zlYEICsNKXsF2qAgAEgS4A=
Date:   Sat, 23 Feb 2019 10:58:14 +0000
Message-ID: <20190223105813.aepvfxzbjcdjvkzy@fsr-ub1664-175>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
 <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
In-Reply-To: <155085758346.77512.1117855723990616329@swboyd.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7b666910-c0cf-45bf-4b2c-08d6997dcf1b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6098;
x-ms-traffictypediagnostic: AM0PR04MB6098:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB6098;23:5tgJzMyadcza+QQilHkXxeOt3odstM3qO95LVoYua?=
 =?us-ascii?Q?Bbf/Rm/15vAYmAwZaKpo84qHuGpwFwBUR7ztC9RYvETeOmVudU3jRB5kcgBS?=
 =?us-ascii?Q?ZyaUCNMmg7welRyOU2bwAViexNRrMbchpbG44xCgPsj4O+pZpNqNl+O4nvO1?=
 =?us-ascii?Q?ILaIMI8YuCyRvIwKk/bbvL8zmEOE7zLjgWElhpmdsbFFClbigaP11mT2BP2D?=
 =?us-ascii?Q?Kg1/bWNnJpj3rx9qs6XcmO0z7blZrk+u9P2vejBWSQL4mcOMQ8i8jsYpu5Pd?=
 =?us-ascii?Q?CVXVvS6SPyJpB0OnmxWU6q2GVyVBvMYNyEWrzSByMCLNxduoZD5BR1dOYy9n?=
 =?us-ascii?Q?M6Kcz947wVV+gL8lnmhHU/z939Z4APHCi6VeaLb0XHZ+vazZR6l1SiY1ZYHH?=
 =?us-ascii?Q?+F/GM5Ofh7fRaLA2Mm8lRVUNyAkj6QSTRrZJjCYJCen96yab+Zylm0Esz+ep?=
 =?us-ascii?Q?QDXFLPZzfkVcwiT2LQ2AWsx0yCcwIksjNaZdb+YOHTJXYmbPNWG51baIFLr9?=
 =?us-ascii?Q?AZsi+Am1WPIqHUnwFYLyK/M3Pii8nnonwS5b4DaUsTUYrcXmkcDRqVdcjnjk?=
 =?us-ascii?Q?HYKZhay0u/JguI2WCnRu0DEA76t1gk7Yfa5bjOKQnJ7pACMeARUap4+VX7qP?=
 =?us-ascii?Q?qPdJe+5i0FPjZ8EWoNfL+EDNwACFgRzZzB9vEAtzCL2XruiZBEgjQavp/XwN?=
 =?us-ascii?Q?mEeC5Ll3gNtKNkgWsgCq5F6HZ1hwG6XAy+zbedQ+V+JZhKIxnKJmM0HIHfS+?=
 =?us-ascii?Q?GUgryJJGxj1ndwKsnUNg4on57SLZ+2RnQQAWusKiLOCkM3wJo5/2dXsPuQjS?=
 =?us-ascii?Q?ZQCeQIs1F65xJqowytoJekHmBVQKXfNOnOE3GqSexA0t/hJi8BgSmdASQh1X?=
 =?us-ascii?Q?uu1zBiKsVNPvWsyueKNL6Nj5wfOVQkXgK6trNzMuLM4Y5GSTVyV/Lm7UG2XJ?=
 =?us-ascii?Q?yygN9JoBPeHZU6XMhBpQWaKMxiHWOdW+kWqq/fuCWDFc1v+S0Zx3ZlUTYSNF?=
 =?us-ascii?Q?UIOAcA37RWHEs11Zl0k7hkwoNdS4GksEboHwxgaYSy/uqbVff7zsDKCeQbm6?=
 =?us-ascii?Q?3+onkSynYM816URQyYyXw9iTDuTlL5Dls9GbDM+PltbTKcFDubAvmH97IkFp?=
 =?us-ascii?Q?ab3M5kqY4px/1kRjOe9H1y7bpkeMSXfCjoZxzhgnnY7vlmtGrHYE+k28169F?=
 =?us-ascii?Q?j6TATgPUP6+63bAH+hPbW8E82/GXZumnp4doUwWpAy6oDo8BoG/7eB9Xv392?=
 =?us-ascii?Q?S7U7bBpMe4OJLjC4J6D089emKuR2fTB+u7tw/1gojzrdwbLwBDcNd/DUjt5I?=
 =?us-ascii?B?Zz09?=
x-microsoft-antispam-prvs: <AM0PR04MB609858DF8EA3BF70731E6CBBF6780@AM0PR04MB6098.eurprd04.prod.outlook.com>
x-forefront-prvs: 0957AD37A0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(136003)(366004)(376002)(346002)(39860400002)(396003)(199004)(189003)(25786009)(186003)(7736002)(44832011)(6116002)(2906002)(8936002)(446003)(476003)(53936002)(9686003)(68736007)(11346002)(6246003)(305945005)(486006)(3846002)(99286004)(6512007)(3716004)(14454004)(102836004)(86362001)(6506007)(53546011)(478600001)(106356001)(105586002)(76176011)(33716001)(1076003)(81166006)(26005)(256004)(97736004)(66066001)(4326008)(6486002)(71200400001)(4744005)(229853002)(71190400001)(6916009)(316002)(5660300002)(54906003)(81156014)(6436002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6098;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tSGxPNNb4sV5czdnHD33/JdFBbYf4Snw9hFbZEFQ7bjmp0UTUChhzNUwMGY64aFVQ8v4lr2ZtLShtWQsvtLVqjE0tblBpdvKW0XZqj31WiHGsVFQdwmoWKPBXW7Z2dwnZLIvYQZbLLqr9sZbkHtlR3r1fy1K4D98dWu/1/PnWhYcGFQxe/i3NP2A2tV9fMg21JoODtP2/8rBhdM2UfbRFYiS7h5Q1iRyEuCZFUBUSFSzW4B2dnifjL7Y0MXM8oy3NOVIc4sbPVWWeH/1P3HGyQXEGzCfXRTXkI5Jbr0v8feBMa8Fcf5IleXpyblNa+CpC1LWKYPpJvuhnrslr1BSVdK+sn/uE1yNBPuUhCY1MiVrlPPVk1TqO2iMJ8WE0xf2PkMRFpWtvZlO50MiqeUgqMyFPEE2+H9HqIFabp74FNg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6EFEBA46439D1A4F83553E95406276CC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b666910-c0cf-45bf-4b2c-08d6997dcf1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2019 10:58:14.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-22 09:46:23, Stephen Boyd wrote:
> Quoting Abel Vesa (2019-02-22 09:07:32)
> > Make the entire combination of plls to be one single clock. The parents=
 used
> > for bypasses are specified each as an index in the parents list.
> > The determine_rate does a lookup throughout all the possible combinatio=
ns
> > for all the divs and returns the best possible 'setup' which in turn is=
 used
> > by set_rate later to set up all the divs and bypasses.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > Tested-by: Lucas Stach <l.stach@pengutronix.de>
> > Acked-by: Lucas Stach <l.stach@pengutronix.de>
>=20
> I suspect these tested by and acked tags should have been dropped,
> unless you discussed and tested off-list?
>=20

Oups, I forgot to drop them.=
