Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31804C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAFF20870
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bc+bz+8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbfAKJLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:11:06 -0500
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:10174
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfAKJLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qyhTE5L/MJrtI7CzUq3OaymtsBsAVP0l+yJbWxIifU=;
 b=bc+bz+8T1VYCBs3neApnZXmR2IHbysA+vk2MgXIRVkoP/yi8I6ghhR70n4Yg6UJM7ZkeXSR/Pl2NuSnQJp/FOtgBCCAbmqAJmgVfJz0EPcSmerGJ1eaW5LLCw1F79k9l5Bwi3bFS78t7kpJtnKDOrfAng0REZHbe5DROFMY3j9Y=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2723.eurprd04.prod.outlook.com (10.175.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Fri, 11 Jan 2019 09:10:57 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1516.016; Fri, 11 Jan 2019
 09:10:57 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Alan Stern <stern@rowland.harvard.edu>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Topic: [PATCH 2/3] usb: ehci: fsl: Update register accessing for
 arm/arm64 platforms
Thread-Index: AQHUpxgC6yBGLPIm9UWYEo0ogu0Vc6WljdKAgAC5jzCAAMZlAIAAz2UAgADHFwCAASdcEA==
Date:   Fri, 11 Jan 2019 09:10:57 +0000
Message-ID: <AM5PR0402MB2865711AB90A1FE18F00852CF1850@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <AM5PR0402MB286596CEFCD502488F579FADF1840@AM5PR0402MB2865.eurprd04.prod.outlook.com>
 <Pine.LNX.4.44L0.1901101018160.1497-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1901101018160.1497-100000@iolanthe.rowland.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2723;6:+CtLrc0xJdoijo/6fIHIDejnmGM6iZ+v4a3VYL8OAV6gpjXpidM7jLg0iJAc0nZBT1RLC6zyTfxcGcjDwU0JqdJR6VZZUgJ+Via2bvZaEZUSEv9F6d4IVIiwWlnvwR6ZY5xcr+c0I7/beMmnuhJoEMvZ8+54a1ULg4gYOALoZS6QaE2ADVFAGZ8AcnpA7n0oNAk0/kASV3+6wXu20IzHDmaFq67FiF/4yO5UiCsuormwgZOfvwOSrHdxIb+mts8cxHJnhtJZaJRXZwV3JRyvCUr9JyAxSfhFnhpKNd094rTgvVqmmlmVanDPqLHkMAW8nfQq5Q2qgejv4uahpV8Le7j/ZqQony+dMkicfhRla2meTynL/ONp8HDfmG7oR1ksgyrj6dU0flq/W0pZwSsu/NnEdakUuM9M0xZRveAF2I7bwr6a5OfbmAZwmsTPEYdVPzOrmMJZo8PeRVJaHtC6PQ==;5:gD1gt4yhUafGp+SrKZi+sd+LY1/ehnsUVOL9O/COu99fsDj4nQ1qcEbkN7YBzyCWa6tbSMUgT9MD0eRAvMZ2hVAOOVWok32HDv2IiIp8o2+QNiKGJiAx2hn5cEhGku8qoXmxRUBUR7s+oWMSnU8sZTMHNH626dFldKbl5/yzF12K+xaUrSu35Bq9HMA6Jn8w8KTeUBNRumgbG7XeRluzIw==;7:jbsqZYJ64HR6/Ydek1a/iIvuhqCi8tZvY6rciKIMSVwa89DXtZc1+du60+grjvudwXGehm/CbdcBqxhK/Qhbh3MDkc8Oj8Vs95CJ/JVQ2a+2EwSjzrJN7o0dRlFMFrbKPtJAnJEj613oA4GVB2iPXA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8921a204-777d-4d5b-b00f-08d677a4b2cf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2723;
x-ms-traffictypediagnostic: AM5PR0402MB2723:
x-microsoft-antispam-prvs: <AM5PR0402MB27234D7CEF219FFE6B853062F1850@AM5PR0402MB2723.eurprd04.prod.outlook.com>
x-forefront-prvs: 09144DB0F7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(366004)(13464003)(199004)(189003)(33656002)(6436002)(6916009)(2906002)(4326008)(9686003)(8676002)(486006)(76176011)(74316002)(66066001)(229853002)(81166006)(14454004)(81156014)(2171002)(105586002)(54906003)(8936002)(305945005)(186003)(7696005)(7736002)(71200400001)(71190400001)(106356001)(25786009)(15650500001)(102836004)(86362001)(316002)(97736004)(26005)(53936002)(11346002)(446003)(55016002)(68736007)(478600001)(6116002)(476003)(6246003)(3846002)(53546011)(6506007)(5660300001)(14444005)(256004)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2723;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Uix7a9SY/FDukjOdN9J6Pekhnmlp0JtsUz0SB68SwHytiIQ5IoQs9dZjh+5mskJKa6Z4ppT55d879KLmpLC+ddEwYemUYRtg61K0Jv7dWJGyzHnYNDAMlJBn/xIeAW2+xQDBk7SmajlQWXqRJdLOhqzCHB3EFzJLuOM5lEl8RYvwYN6FqvtxrW4XP2GY1G1XPAXZq428TEDKarp/mJ2t5fq8YyJ6opJeI/bGk3mVvEPwZklLyqx8FYD5BoaPBtO8aF/YErSVTW+3W3V3NxgezLW/OHr9NV74W89axakUwsBdxe8qBZbjK1q7vbO9ZSab9YyeaLCumFhbRDCIHFUzGR2JRkvKNKpJ2bgjN1R5fZnTpi1n/rtwHjm0Jkw1LrjKpQYESAC3WXZIkeL0pFbqy4jIFKIV46A9qwb1qQW4Z90=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8921a204-777d-4d5b-b00f-08d677a4b2cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2019 09:10:57.6690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2723
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Thursday, January 10, 2019, Alan wrote:
>=20
> On Thu, 10 Jan 2019, Ran Wang wrote:
>=20
> > Hi Alan,
> >
> > > -----Original Message-----
> > > From: Alan Stern <stern@rowland.harvard.edu>
> > > Sent: Wednesday, January 09, 2019 23:14
> > > To: Ran Wang <ran.wang_1@nxp.com>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> > > usb@vger.kernel.org; linux-kernel@vger.kernel.org
> > > Subject: RE: [PATCH 2/3] usb: ehci: fsl: Update register accessing
> > > for
> > > arm/arm64 platforms
> > >
> > > On Wed, 9 Jan 2019, Ran Wang wrote:
> > >
> > > > > Why do you change this writel() into iowrite32be() but leave
> > > > > other instances of writel() unchanged?  Was this a mistake?
> > > >
> > > > Yes, I didn't notice there are other writel() used in this file.
> > > > However, as I know, on both powerpc and arm SoC, EHCI FSL IP's
> > > > memory mapped register block is always Big-endian, so I'd like to
> > > > replace all
> > > > writel() with iowrite32be() in this file. Is it necessary?
> > > >
> > > > Or I just replace them with ehci_writel() and select
> > > CONFIG_USB_EHCI_BIG_ENDIAN_MMIO?
> > >
> > > That should work okay.  ehci_fsl_setup() sets ehci->big_endian_desc
> > > and
> > > ehci->big_endian_mmio according to the platform data, so you just
> > > ehci->have
> > > to make sure the platform data is initialized correctly.
> > >
> > OK, so I should not change writel() into iowrite32be() at that place
> > you mentioned, and still using iowrite32be()/ioread32be() to replace
> > clrsetbits_be32(), am I right?
>=20
> Actually, I think it would be good to use ehci_writel() and
> ehci_readl() everywhere except in fsl_ehci_drv_probe().
>=20
> But if you prefer to use iowrite32be() and ioread32be() instead, that's
> probably okay.  (However, it won't work if anyone ever produces a little-
> endian version of the IP.)

Got it, I'll verify with ehci_readl() then work out the v2 patch if pass.
Thanks for advice.

Regards,
Ran
