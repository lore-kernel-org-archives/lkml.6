Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B80C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B23720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="AJzWl2BU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B23720811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeLMRsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:48:41 -0500
Received: from mail-eopbgr730117.outbound.protection.outlook.com ([40.107.73.117]:42832
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728033AbeLMRsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RnU91v+sdMHXbx4Z/pDle/5BeQK4RQAED/Vd25XyRA=;
 b=AJzWl2BUFappkRLXtOJRN615SEJWuEe9IHuGIGxyckQ9qG+PfL9BrwZRDkqlbmPi/ASIDAW2zSI7LYyToiKpAQK8Bhgw4ArD1UBcOH9kT3c86Doc9RE3av0LmsYntba6sLcRzLF2sls0DO/Isc3RXKEOwhYyP+vLnhu3tAVONY0=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1581.namprd22.prod.outlook.com (10.174.167.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.20; Thu, 13 Dec 2018 17:48:36 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 17:48:36 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Topic: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Index: AQHUknyRs52wg14NwUm+r/H2374buKV72ByAgAAOsoCAAAscgIAAEjWAgAAMqICAAA75AIAAoc8AgAAxmgA=
Date:   Thu, 13 Dec 2018 17:48:35 +0000
Message-ID: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
 <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
 <b8525991-f539-a180-2e88-a70b29319413@denx.de>
 <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
 <372cccd7-a175-2737-5af8-3072606c6b1c@denx.de>
In-Reply-To: <372cccd7-a175-2737-5af8-3072606c6b1c@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1581;6:Hwr8lH6lm6EbG27b4bCXJRBMJwYiGoXh++I7e2DgkFsEupS/k4rc4YuHr0jvT9q/Jz7Z7bR0oVc3U4xnNjK/fUnBQp1z/Ii+SaEBhB8eJhzoxgXCIRXKUA52eqaKr1obQlIdyQa0qlnYiLZzo5yP0A5fcTXCqpdPgzqUZgq7tfu3A0i9DLa/XjUFDTLm8Gagl8P5g9XuWIGjIskzSj61wRH4WuxgmN4/GccjYvZhqJvdXKgISktHZxMATR1dwds1cwy+TeMgcLHZnvTqksPwqnxl3sY/i0Q/VjG9AeqP0Z+8iWfi2ZnZ8NzvA8g/qu0JrDBbVFhsYS64T7t+Cy/lasm4NDEmGEtavaDQ2Pz6GTlNodjH8yVmxBxGHvmtlqq4fovrOMFXA6rBIujCbNTtPbAQHScBL+x4MbI82UVutWU2wOC1iWVEWQaVFfPcJTeyDzRr/C6fzCccRxEJq616jg==;5:iWLt1Pf4rqHXFkrRLPtiGa5SpYbmgr4jHVPrhDGV21NrulPCWEXY9a86zuB+Yt+OE5ha8tKwq1JBGIq/g1A3IiOuGXZ1eCLWfXB+PmiVmYNkApp4XeIDVOqvNJ/BZ50o4gJ0tJoXQ8i7Ob8sWLEytqB9nTV9ehKNpSfyxV1aOKg=;7:mbqYnIJK/zG2l6qSllSz+s2LRhQor0qd368q0L32fzGzGv4I9JWkoa4EltfdfltC8DA5Qk8I3Pg5+Gi1l1Nycbjvvh83jA+s3lIf7pg9uJ+bSBnM/Y6iTl7/JeOhQCbkDZvcH78jhLV13CiBcXjw2A==
x-ms-office365-filtering-correlation-id: d17d6600-8468-4fec-af59-08d6612334b7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1581;
x-ms-traffictypediagnostic: MWHPR2201MB1581:
x-microsoft-antispam-prvs: <MWHPR2201MB1581A11CE3D7F37B24E8C80DC1A00@MWHPR2201MB1581.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231475)(944501520)(52105112)(93006095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1581;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1581;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(39850400004)(366004)(136003)(346002)(189003)(199004)(316002)(256004)(7736002)(25786009)(44832011)(71190400001)(71200400001)(1076002)(33716001)(486006)(97736004)(305945005)(476003)(5660300001)(14444005)(68736007)(6116002)(8936002)(99286004)(8676002)(106356001)(81166006)(105586002)(81156014)(2906002)(52116002)(76176011)(33896004)(93886005)(6506007)(54906003)(386003)(14454004)(6486002)(229853002)(6436002)(6246003)(6916009)(102836004)(42882007)(508600001)(53936002)(4326008)(6306002)(11346002)(9686003)(446003)(6512007)(186003)(966005)(58126008)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1581;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: eDWqRQ04E9m+OIf2WhuyJm5WtfDftseTv3BGsRnOxae+CSz1/9PYpTzYvXYI3+3KNtQwF6sTZO1eUi2qKssdcJAub1cvNKB65TkhCvYZSC9tzSCsW1VFRP+BoYtlp2f0s7rgRXtz0udGtiitzEMkR7kFPAtMDmgs3hzkADwzvEfoG84+qUyZ69+RJrxlG8/KB50K6vTgXBbwwMsRJf89eGgQNuE1Hv210549/rXakTkXsfbaw9jcu3ml9fH8nuU3lG3X6/KOCRNlalqN4Jox+HT1/33+ol5NbyuzMUu8wMLgW4Z97ePeBVY9orDqcKBC
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4DF80A75FF67744BCC104FA99B52294@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d17d6600-8468-4fec-af59-08d6612334b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 17:48:35.8885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1581
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 03:51:02PM +0100, Marek Vasut wrote:
> >>>>> I wonder whether the issue may be the JZ4780 UART not automatically
> >>>>> resetting the FIFOs when FCR[0] changes. This is a guess, but the m=
anual
> >>>>> doesn't explicitly say it'll happen & the programming example it gi=
ves
> >>>>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is wh=
at
> >>>>> the kernel has been doing for at least the whole git era I wouldn't=
 be
> >>>>> surprised if other devices are bitten by the change as people start
> >>>>> trying 4.20 on them.
> >>>>
> >>>> The patch you're complaining about is doing exactly that -- it sets
> >>>> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears i=
t.
> >>>> Those two bits are exactly FCR[2:1]. It also explicitly does not tou=
ch
> >>>> any other bits in FCR.
> >>>
> >>> No - your patch does that *only* if the FIFO enable bit is set, and
> >>> presumes that clearing FIFOs is a no-op when they're disabled. I don'=
t
> >>> believe that's true on my system. I also believe that not touching th=
e
> >>> FIFO enable bit is problematic, since some callers clearly expect tha=
t
> >>> to be cleared.
> >>
> >> Why would you disable FIFO to clear it ? This doesn't make sense to me=
,
> >> the FIFO must be operational for it to be cleared. Moreover, it
> >> contradicts your previous statement, "the programming example it gives
> >> says to explicitly clear the FIFOs using FCR[2:1]" .
> >=20
> > No, no, not at all... I'm saying that my theory is:
> >=20
> >   - The JZ4780 requires that the FIFO be reset using FCR[2:1] in order
> >     to not read garbage.
>=20
> Which we do

No - we don't... We used to, but your patch stops that from happening if
the FIFO enable bit is clear.... And the FIFO enable bit is clear during
serial8250_do_startup() if the UART was used with earlycon, otherwise it
depends on state left behind by the bootloader. I don't know how many
ways I can say this.

> >   - Prior to your patch serial8250_clear_fifos() did this,
> >     unconditionally.
>=20
> btw originally, this also cleared the UME bit. Could this be what made
> the difference on the JZ4780 ?

It did not, you are wrong. serial_out() calls ingenic_uart_serial_out()
which unconditionally or's in the UME bit for writes to FCR.

> >   - After your patch serial8250_clear_fifos() only clears the FIFOs if
> >     the FIFO is already enabled.
>=20
> I'd suppose this is OK, since clearing a disabled FIFO makes no sense ?

This is where the brokenness seems to come from. As I said, this would
be fine according to the PC16550D documentation but I can say based on
experimentation that it is *not* fine on the JZ4780.

Resetting a disabled FIFO makes perfect sense if it's going to be
enabled later. That used to happen, and after your patch it doesn't.

> >   - When called from serial8250_do_startup() during boot, the FIFO may
> >     not be enabled - for example if the bootloader didn't use the FIFO,
> >     or if the UART is used with 8250_early which zeroes FCR.
>=20
> If it's not enabled, do you need to clear it ?
>=20
> >   - Therefore after your patch the FIFO reset bits are never set if the
> >     UART was used with 8250_early, or if it wasn't but the bootloader
> >     didn't enable the FIFO.
>=20
> Hence my question above, do you need to clear the FIFO even if it was
> not enabled ?

Yes.

What you asked before though was whether we need to disable the FIFO in
order to clear it, which is a different question.

> > I suspect that you get away with that because according to the PC16550D
> > documentation the FIFOs should reset when the FIFO enable bit changes,
> > so when the FIFO is later enabled it gets reset. I suspect that in the
> > JZ4780 this does not happen, and the FIFO contains garbage. Our previou=
s
> > behaviour (always set FCR[2:1] to reset the FIFO) has been around for a
> > long time, so I would not be surprised to find other devices relying
> > upon it.
>=20
> It is well possible, but I'd like to understand what really happens
> here, not just guess.

I can only tell you what little the JZ4780 manual says & what actually
works when I run it on my system. I used the word supect to explain my
theory, but that's the best we can do with the documentation available.

> > I'm also saying that if the FIFOs are enabled during boot then your
> > patch will leave them enabled after serial8250_do_startup() calls
> > serial8250_clear_fifos(), which a comment in serial8250_do_startup()
> > clearly states is not the expected behaviour:
>=20
> In that case, that needs to be fixed. But serial8250_clear_fifos()
> should only do what the name says -- clear FIFOs -- not disable them.

...which is why I effectively renamed it
serial8250_clear_and_disable_fifos() in my suggested patch. Did you test
it? I have no OMAP3 system to check that I didn't break your setup, and
at this point if I can't be sure it works I'll be submitting a revert of
your broken patch.

> >> Clear the FIFO buffers and disable them.
> >> (they will be reenabled in set_termios())
> >=20
> > (From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t/tree/drivers/tty/serial/8250/8250_port.c?h=3Dv4.20-rc6#n2209)
> >=20
> > And further, with your patch serial8250_do_shutdown() will leave the
> > FIFO enabled which again does not match what comments suggest it expect=
s
> > ("Disable break condition and FIFOs").
> >=20
> >> What exactly does your programming example for the JZ4780 say about th=
e
> >> FIFO clearing ? And does it work in that example ?
> >=20
> > It says to set FCR[2:1] to reset the FIFO after enabling it, which as
> > far as I can tell from the PC16550D documentation would not be necessar=
y
> > there because when you enable the FIFO it would automatically be reset.
> > Linux did this until your patch.
>=20
> Linux sets the FCR[2:1] if the FIFO is enabled even now.

Correct, but not when the FIFO is disabled in serial8250_do_startup(),
nor when the FIFO is later enabled in serial8250_do_set_termios().

> >> I just remembered U-Boot has this patch for JZ4780 UART [1], which
> >> touches the FCR UME bit, so the FCR behavior on JZ4780 does differ fro=
m
> >> the generic 8250 core. Could it be that this is what you're hitting ?
> >=20
> > No - we already set the UME bit & this has all worked fine until your
> > patch changed the FIFO reset behaviour.
>=20
> The UME bit is in the FCR, serial8250_clear_fifos() originally cleared
> it, cfr:
> -               serial_out(p, UART_FCR, 0);
> in f6aa5beb45be27968a4df90176ca36dfc4363d37 . So the code was originally
> completely disabling the UART on JZ4780 .

Again, wrong. Look at what serial_out() actually does & see
ingenic_uart_serial_out(). Again, the Ingenic UARTs have worked fine
until your patch, and work with mainline after reverting it - the
problem is *entirely* with the change you made & the UME bit has nothing
to do with it.

Thanks,
    Paul
