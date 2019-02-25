Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED38213A2
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 10:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="iYY/JY/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfBYKQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 05:16:04 -0500
Received: from mail-eopbgr1400111.outbound.protection.outlook.com ([40.107.140.111]:62496
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726621AbfBYKQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 05:16:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1V5+6waLMmTmglaXMhQ6iHq6WAALWbShzAlX7/Wn2g=;
 b=iYY/JY/hNIzjHFXkXoyQDuyVwmyXIUxv8gioO8AOeYqpQEbYBCx5fual8PxGk8imctYanZDsqUMnq0c9AByJ+vhrJzfcJ49VoMRnNSXUcEIMBR5iPPIFpkFFk6CaWdNFQL5g6qgR//ellcEuGlFt99mZZikreRLYWHLkLB8Lfw8=
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com (52.133.163.146) by
 TY1PR01MB1787.jpnprd01.prod.outlook.com (52.133.164.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Mon, 25 Feb 2019 10:15:59 +0000
Received: from TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::441b:7f9a:44b2:d1d2]) by TY1PR01MB1769.jpnprd01.prod.outlook.com
 ([fe80::441b:7f9a:44b2:d1d2%3]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 10:15:59 +0000
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
Thread-Index: AQHUyGuWxb9ZURok+kaTr7Tx2RFLP6XnkpEAgADP5VCAABQQAIAAFVzAgAfIuLA=
Date:   Mon, 25 Feb 2019 10:15:59 +0000
Message-ID: <TY1PR01MB1769CB8244F448BE07F030BCF57A0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
References: <20190219155511.28507-1-phil.edworthy@renesas.com>
        <20190219155511.28507-3-phil.edworthy@renesas.com>
        <20190219202842.59bc7719@why.wild-wind.fr.eu.org>
        <TY1PR01MB17696D6C85CE6294B8C75F11F57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <86va1erd1n.wl-marc.zyngier@arm.com>
 <TY1PR01MB1769C8ADD97861A57577853AF57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB1769C8ADD97861A57577853AF57D0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=phil.edworthy@renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e9289a4-d4b0-42ab-7331-08d69b0a3d13
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TY1PR01MB1787;
x-ms-traffictypediagnostic: TY1PR01MB1787:
x-microsoft-exchange-diagnostics: 1;TY1PR01MB1787;20:SUh0k/mGbOedjYpOgAg4ADjuQr9UbOoE447TAs+uDOE6Fk9tur04kDfTVTD+c0kisRdgkIuOYiRk16ObP2LeCssX7CYgg1geaTW+V4xWpXpdzKGCR6TCV/XNbHx4NVzjG7D/sgrFrUz+BpHLkOv0IWNYLUDrVFiObyCTNUYG1GA=
x-microsoft-antispam-prvs: <TY1PR01MB178762B4B3D67650E9E89C81F57A0@TY1PR01MB1787.jpnprd01.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(136003)(39860400002)(396003)(189003)(199004)(52536013)(9686003)(86362001)(5660300002)(7696005)(76176011)(305945005)(7736002)(99286004)(229853002)(81156014)(81166006)(33656002)(8936002)(8676002)(6916009)(6436002)(74316002)(53936002)(102836004)(55016002)(97736004)(6506007)(105586002)(53546011)(106356001)(3846002)(68736007)(26005)(14444005)(93886005)(66066001)(25786009)(316002)(256004)(6116002)(4326008)(54906003)(71190400001)(44832011)(71200400001)(2906002)(6246003)(478600001)(476003)(486006)(446003)(186003)(11346002)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1787;H:TY1PR01MB1769.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QrgsAcf1coKsiq7Cgq0VaSkO1236xFJ+DBd5o+r0GiJbYCRNveOnXJV/Nglnuxuf5ksF8zK38v7NufU3BalDjiCgdt+boL+0515f2bsOW+vzrqGcNwipT64SWG3szWI7/9YLULMxw2QifB5/B05IHsEOONIaaN3mgYHYXIjpt77U/62C/m4VlgFaEKC/zgssu0RnFLnNvPWx7UAKJ9sxBi4pQ2buUAIXSPhsyBN+fR2xmUy+LY+Oz8zZjwyqHVBuUX2vyH2MgXZzYcUvvgxfzMb2a56U7ssyLwJrhkLEZYLAI8jxjlOab9Ui5J26VF8R1RLGgPWdswybsB7M8vG0hhZ3pU6x21Zr4eC4F69ZbMTHPyayfXPm+OuKiC+WyNyvbonWlSLwr+rynY7dfwKPmIGzhZoDk284TdLA0OxZWIk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e9289a4-d4b0-42ab-7331-08d69b0a3d13
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 10:15:59.4255
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 20 February 2019 11:33 Phil Edworthy wrote:
> On 20 February 2019 10:05 Marc Zyngier wrote:
> > On Wed, 20 Feb 2019 09:07:02 +0000, Phil Edworthy wrote:
> > > On 19 February 2019 20:29 Marc Zyngier wrote:
> >
> > [...]
> >
> > > > > +	for (i =3D 0; i < MAX_NR_INPUT_IRQS; i++)
> > > > > +		irq_create_mapping(priv->irq_domain, i);
> > > >
> > > > This should never happen. Mappings should be created from
> > > > discovering
> > the
> > > > interrupt specifiers for devices in the DT, and not eagerly at prob=
e time.
> > >
> > > The key issue here is that the mappings should not be dynamically
> > > allocated.  On the device that has this hardware, there is a Cortex
> > > M3 that is likely to use some of these GPIO interrupts.  Maybe it
> > > would be better to limit the number of GPIO irqs that Linux can
> > > configure dynamically.
> >
> > But whatever the M3 is going to use is known statically for a given
> > instance of this platform, right? You can always tell from the device
> > tree which pins are available for Linux and which are not. Or can't you=
?
> Yes, you can tell what pins are available to Linux. You can't tell how ma=
ny pins
> have been setup as GPIO irqs for use by the M3 though.
> I suppose the DT could describe the M3 as well, though I can imagine that
> could get complicated. I've not seen a DT that covers different cores run=
ning
> different software, esp. when the M3 firmware doesn't use DT.
> I was thinking that the DT could have a prop to tell this driver what GPI=
O irqs
> are already in use.
I've just realised that it doesn't matter if we don't know how many interru=
pts
are used by the M3, as Linux will not claim more than the remaining interru=
pts.

Thanks
Phil

> > > Looks like I've gone off in the wrong direction yet again.
> >
> > Nothing we can't help with. If you can explain all the constraints of
> > the platform, we can come up with a fairly simple driver. And surely
> > LinusW can chime in for the DT part, which seems to need some loving
> > too.
> Many thanks, I need some help here!
>=20
> Phil
