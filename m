Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B6AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8182089F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="TAaHFqkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438134AbfBNSny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:43:54 -0500
Received: from mail-eopbgr800114.outbound.protection.outlook.com ([40.107.80.114]:11072
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404311AbfBNSnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/iZvJZ0npLWHyrqX2lglzmkVhySEUrE1uk/dAUCOHc=;
 b=TAaHFqkPd4CJNz5dMkhCp9tmC3czEqYzEYK/+otRd3sIfA089bGkc2f8lsW+q2V++WOQQ6aygjfkgk3NFZr9B76x2qigCwauhBf8MnK29sAK3AzVvMDyCOkzCShKsVHFETCSiJyE9tUvjETym25Z4PiW6HmUCqDP8+gYpzZ4rkQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1183.namprd22.prod.outlook.com (10.174.169.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 14 Feb 2019 18:43:11 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1601.023; Thu, 14 Feb 2019
 18:43:11 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tomli@tomli.me" <tomli@tomli.me>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: Re: [PATCH] irqchip/i8259: fix shutdown order by moving syscore_ops
 registration
Thread-Topic: [PATCH] irqchip/i8259: fix shutdown order by moving syscore_ops
 registration
Thread-Index: AQHUvsMOMJyeIl+QdU28dl9y0o/lHaXU0iYAgApUdgCAAIYggA==
Date:   Thu, 14 Feb 2019 18:43:10 +0000
Message-ID: <20190214184309.f3zklkhv55c4z4g6@pburton-laptop>
References: <20190206212608.27189-1-aaro.koskinen@iki.fi>
 <8492440b-b489-0ce1-865c-4505042cb061@arm.com>
 <20190207205812.GA11315@darkstar.musicnaut.iki.fi>
 <86r2caslad.wl-marc.zyngier@arm.com>
In-Reply-To: <86r2caslad.wl-marc.zyngier@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0036.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::49) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e81b5f6-5716-4361-c567-08d692ac44c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1183;
x-ms-traffictypediagnostic: MWHPR2201MB1183:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1183;23:0sBL8hIOlyn+oHGteY6xvUOoIIQ+oBUEJ0ji578?=
 =?us-ascii?Q?XkpOELhialGUcPt53tWB3nDe1rc28Cge3GpGX61Z3fmqbMzl2k/LCeZ2KpUf?=
 =?us-ascii?Q?v/OIH+0Vs9J09SM+wOGXWPKm+R6wa0kj+svN12y/k2fCsGy/WtU0et9w99jX?=
 =?us-ascii?Q?XBc8Wn91y+Fpbv+hEd/kl40e62zXgiVJBN29dkiFSi273swqasLEDCeRcDIu?=
 =?us-ascii?Q?VQvRQaSYFEou9KoPEsl1m7w8yEk5ikCoKUXs9FAV3gDfR9lHXiYb2yUizpGS?=
 =?us-ascii?Q?XYHSpy1QoRxZb4/7pmjUVaAgy2XA3gQ7N9inQ44VI/LOUBFjp0NcY+6JEl31?=
 =?us-ascii?Q?CcAq+1oK/GmD29EWcsL7VHR6Rquh2hjwBS+jFVU/bIcC50xwH44fQ+ptQRGH?=
 =?us-ascii?Q?jr1fCOv4D6KVx7wwsON67CHOZaKmDxKZ+/vMZVhh9jIAPHyuB7bb5qu3LZXu?=
 =?us-ascii?Q?q0nBPrZ5Zn4jwl+mtQFnZeY+O47jh1shSz4lMgl8XYOGclcSIFj6s5TrGl39?=
 =?us-ascii?Q?2C1srj3jvKVohg8A3dFwmXJCvjd/jeKs6nB827dc7khXBHew8HwgrxiIOQUS?=
 =?us-ascii?Q?ebtj9fkQOrNHqVNhEqYpK96X6NC4FeTz8eZHVjGg7lsDdqNgf7NRo9xr18Kt?=
 =?us-ascii?Q?143DIYXqT14dUIlcK8zf3HeKWOT0ZV6QKaPFKzRqygSXz5/y/drok1KNZgzK?=
 =?us-ascii?Q?PJHqh9+L+yhYCmIj+F4YZUAcCKBBMQhltGp++08ZyVdBiWO9f/IEv6V/iESR?=
 =?us-ascii?Q?NEWtgNEaU2YtDa3ZfoX2XEVijHb784zgpTGre/b9SiGW61h0ClwggtI5orJO?=
 =?us-ascii?Q?B2oq213/HDICRZMY5Mumh/9qeG3mmpcTcxbWUPQIRd3Jvs3ey+T1NJaxEosc?=
 =?us-ascii?Q?otU/bhvwf7Wo3LNPgqnUOCn8DR9AXQYsTDZ41bkDbYCagp/jGG8IHYKCYDnk?=
 =?us-ascii?Q?xYk46deytc7UYM1DHMXTtUEaXomm3TsfEfLSGPtBSEJFFmuL/N9ito2j6//0?=
 =?us-ascii?Q?OsdLt+ePsR3A88dsoy1pvH/vIUhVjwMx0WnDetSKfLTwX9cn4VzIsgmd5S3a?=
 =?us-ascii?Q?STJ5EyAL8ZipMzTpsETBAR5PyQVc6tvJC89YFFq3lcrqibOLYdYmHIrsDBRA?=
 =?us-ascii?Q?L10jstqKm6P3J8I2yW7nJbztCpA46x7hqx7gFyjZ5WhoitTIovb+I71dXTOO?=
 =?us-ascii?Q?0XToLjgX4LBLSK8dLyOQuW7/kQ09wlwWT0j8ym3USfMLslWmZD2DWEJ41qoL?=
 =?us-ascii?Q?y59uafKISKDf7qfyHiPYwvgMyrybgJ5oJF94auwtAulAWJgRCUCyeVzgunjd?=
 =?us-ascii?Q?NXsXB1ICjm8zOqvngiqenH/Ot0eIaJsgLWB9vnP6vLu15?=
x-microsoft-antispam-prvs: <MWHPR2201MB1183D657E74AF7DEBDB0B0CEC1670@MWHPR2201MB1183.namprd22.prod.outlook.com>
x-forefront-prvs: 09480768F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(346002)(366004)(136003)(39850400004)(199004)(189003)(6512007)(42882007)(97736004)(6436002)(9686003)(2906002)(6486002)(1076003)(66066001)(33716001)(229853002)(14454004)(486006)(33896004)(76176011)(106356001)(44832011)(105586002)(52116002)(99286004)(446003)(93886005)(26005)(81156014)(71190400001)(3846002)(6116002)(478600001)(25786009)(4326008)(6246003)(8676002)(102836004)(476003)(53936002)(6916009)(81166006)(256004)(6506007)(14444005)(71200400001)(53546011)(7736002)(305945005)(386003)(186003)(54906003)(11346002)(8936002)(316002)(58126008)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1183;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dFt3hPAisA98h5K3QklzPoi8iC072Mgyznb8EQMWbWSsCbxs/gLbpNIOow/IK/WE7dNSWfAc8+68xJk2PyuqYYEeo/583pCj8K1CVe6iXEjiqfHwUacMZ9turE4RMwWmRXyMOwWq+ut8d9pvoUZLiVJ/WSoHVfLd4ngap/ps/fAterLZQnIYQTIyBv8GS3xVhijzw4fQiC+6ExGn4Wm14VwmZGO2s/RE2h2NDVREduSquVWw1gHCue7i5vuV2V9I6FWnRyWLI6Q8ne3ZbJ32nW37IRmmzgV5AoYM3YK1U6SbuRRhOPogVp849f3Bf5b7i6EBvqefmcTHK6MqCxNvq2WujeD/G8JEhpgiKrWqnEdC3D3x98FQDCGkqAy3ipm8FT+xZOtQFXJHXG5pAJGR0Q47SRwjjV8QNkoRzGx+lSY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D5EEEE901C5C54F9F4FEE05B6848C62@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e81b5f6-5716-4361-c567-08d692ac44c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2019 18:43:10.4427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, Feb 14, 2019 at 10:43:06AM +0000, Marc Zyngier wrote:
> On Thu, 07 Feb 2019 20:58:12 +0000,
> Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > On Thu, Feb 07, 2019 at 08:56:37AM +0000, Marc Zyngier wrote:
> > > On 06/02/2019 21:26, Aaro Koskinen wrote:
> > > >  static void init_8259A(int auto_eoi)
> > > >  {
> > > >  	unsigned long flags;
> > > > @@ -332,6 +324,7 @@ struct irq_domain * __init __init_i8259_irqs(st=
ruct device_node *node)
> > > >  		panic("Failed to add i8259 IRQ domain");
> > > > =20
> > > >  	setup_irq(I8259A_IRQ_BASE + PIC_CASCADE_IR, &irq2);
> > > > +	register_syscore_ops(&i8259_syscore_ops);
> > > >  	return domain;
> > > >  }
> > > > =20
> > > >=20
> > >=20
> > > Given that this is a change of behaviour that is likely to affect oth=
er
> > > platforms (I see at least another 6 MIPS machines using the i8259),
> > > could someone make sure that this doesn't cause any regression? This =
is
> > > unlikely to affect the SGI boxes, as they predate any notion of power
> > > management, but something like Malta could potentially be affected.
> >=20
> > For shutdown, I don't think there are many syscore_ops users on these
> > platforms. Actually I could find only two that I think could be used:
> > 	- cpufreq (issue fixed by this patch, and Loongson is the only user
> > 	  anyway)
> > 	- leds-trigger
> >=20
> > Then suspend/resume: i8259 doesn't implement suspend, so there is no
> > change in behaviour. In resume it does PIC re-init, but syscore_resume(=
)
> > is done with interrupts disabled so the order shouldn't matter.
>=20
> In the absence of any comment from the MIPS guys over the past week,
> I've queued this. Please let me know should it break anything.

Apologies for my sluggish response, but for what it's worth the patch
looks reasonable at a glance. Malta is the only other I8259-using
hardware that I technically have access to, but at this point Malta
isn't actively used & it's really seen more as "the board QEMU defaults
to" than a useful real hardware platform.

Thanks,
    Paul
