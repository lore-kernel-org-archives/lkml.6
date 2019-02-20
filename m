Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B2AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB5EF20851
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="oSB+ZW61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfBTLdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:33:17 -0500
Received: from mail-eopbgr1410124.outbound.protection.outlook.com ([40.107.141.124]:21945
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726360AbfBTLdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G9qisA95YL6yM0O/NBczs3hvbvxLiM3YwmlODlQVs4=;
 b=oSB+ZW61BZjI35vxbBoEHbFTatGQiF+poUka7qnSRg/NUAUN3NVpo4jfVWvCjYy6n1hFJKycsPicfUYGVXRsZi4GgARgWJbrMXGVFSbWlwb2E5s2B1A4pDK6k4YJr9/B5QubL+AKzMfktUu1qoIKH6QlevF7U5qZXH5D+W+Tq6I=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1563.jpnprd01.prod.outlook.com (52.133.162.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.20; Wed, 20 Feb 2019 11:33:12 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::4cc6:14ba:d8cd:4107%2]) with mapi id 15.20.1622.020; Wed, 20 Feb 2019
 11:33:12 +0000
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: RE: [PATCH v4 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Topic: [PATCH v4 2/2] irqchip: Add support for Renesas RZ/N1 GPIO
 interrupt multiplexer
Thread-Index: AQHUyGuWxb9ZURok+kaTr7Tx2RFLP6XnkpEAgADP5VCAABQQAIAAFVzA
Date:   Wed, 20 Feb 2019 11:33:12 +0000
Message-ID: <TY1PR01MB1769C8ADD97861A57577853AF57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20190219155511.28507-1-phil.edworthy@renesas.com>
        <20190219155511.28507-3-phil.edworthy@renesas.com>
        <20190219202842.59bc7719@why.wild-wind.fr.eu.org>
        <TY1PR01MB17696D6C85CE6294B8C75F11F57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <86va1erd1n.wl-marc.zyngier@arm.com>
In-Reply-To: <86va1erd1n.wl-marc.zyngier@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79e98c61-3ca6-4a43-a87b-08d697273251
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1563;
x-ms-traffictypediagnostic: TY1PR01MB1563:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1563;20:coiu6uczEfE2uDQIW4v1U6mkKTb1CemFdzPFVLrRPmKBrKi4Ecq+Bq9O11BHJ7/qxlyvZnfFrzokQSXjflcR66TaOsCyaOk++kh1M402YMTt2Em8lzm2FPzd3POsFqTXa3q4Pxaj0qrp+D6sWtUqIyxU1Gpo9F+eJI+K9R4TPw8=
x-microsoft-antispam-prvs: <TY1PR01MB1563AAD8EEEBB58C988FE80BF57D0@TY1PR01MB1563.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(346002)(376002)(396003)(366004)(199004)(189003)(316002)(4326008)(25786009)(9686003)(55016002)(11346002)(6436002)(3846002)(71190400001)(305945005)(68736007)(54906003)(2906002)(6246003)(229853002)(6116002)(33656002)(71200400001)(93886005)(99286004)(7696005)(76176011)(53936002)(44832011)(7736002)(53546011)(8936002)(14444005)(66066001)(256004)(102836004)(486006)(6506007)(26005)(6916009)(74316002)(81166006)(446003)(5660300002)(97736004)(478600001)(186003)(8676002)(86362001)(106356001)(105586002)(81156014)(476003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1563;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m8zrWmjEL4X8V3RzpMPn5qPMiFNY2+mojOztXmTyHvAmXzV9N6yue9RHsyQA33GwYMq7HaLzkGW+al6+73wOJJ2AvMcsBGfn12dtWppNexC351mbhtCWSg/MYH4vcjVL/4ZhWO8XwKrCZ4N/cmfiqg2Cj2K3f3KUYlAs3RvNKCj+MF5p39WZOJ++GvQ35vHjFzFkhnRSgSCI1geAy0HCXJq7qL6o4VUxQZRAnm5mQKQqP2XIY1ugm4j6mH+lPxaNqBMKXJMdeQW9YxvIccQNcQPlMVUBBFhmxZAjGK9+MYLVqPZu1ZjWSDp6AJJnkkBgeCVa68N/wjDufR2dyGNKlKrxGU9tgc9Fb/VyZGfwkw5WY+IZyykD6TZtjbVlHc+pT4gQ46P9jvi5udIyX7epeoYBmule10uSANAsi9ecd8E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e98c61-3ca6-4a43-a87b-08d697273251
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 11:33:12.2354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1563
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 20 February 2019 10:05 Marc Zyngier wrote:
> On Wed, 20 Feb 2019 09:07:02 +0000, Phil Edworthy wrote:
> > On 19 February 2019 20:29 Marc Zyngier wrote:
>=20
> [...]
>=20
> > > > +	for (i =3D 0; i < MAX_NR_INPUT_IRQS; i++)
> > > > +		irq_create_mapping(priv->irq_domain, i);
> > >
> > > This should never happen. Mappings should be created from discovering
> the
> > > interrupt specifiers for devices in the DT, and not eagerly at probe =
time.
> >
> > The key issue here is that the mappings should not be dynamically
> > allocated.  On the device that has this hardware, there is a Cortex
> > M3 that is likely to use some of these GPIO interrupts.  Maybe it
> > would be better to limit the number of GPIO irqs that Linux can
> > configure dynamically.
>=20
> But whatever the M3 is going to use is known statically for a given
> instance of this platform, right? You can always tell from the device
> tree which pins are available for Linux and which are not. Or can't you?
Yes, you can tell what pins are available to Linux. You can't tell how
many pins have been setup as GPIO irqs for use by the M3 though.
I suppose the DT could describe the M3 as well, though I can imagine
that could get complicated. I've not seen a DT that covers different
cores running different software, esp. when the M3 firmware doesn't
use DT.
I was thinking that the DT could have a prop to tell this driver what
GPIO irqs are already in use.
=20
> > Looks like I've gone off in the wrong direction yet again.
>=20
> Nothing we can't help with. If you can explain all the constraints of
> the platform, we can come up with a fairly simple driver. And surely
> LinusW can chime in for the DT part, which seems to need some loving
> too.
Many thanks, I need some help here!

Phil
