Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_MIXED_ES,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673E1C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C86C20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 05:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dmPO0XjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C86C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLMFMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 00:12:02 -0500
Received: from mail-eopbgr690133.outbound.protection.outlook.com ([40.107.69.133]:11910
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbeLMFMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 00:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FUg/jZbx2tFa+Wy7mnVwbK88Kb/nPCFtxjWEJgjUhEo=;
 b=dmPO0XjXx12xUqF8FCuaf0M+ZmtwkEL7/yLJ2eZcNAf4/SWmxjDzKpGxIwkdOzwTSJIDIukddRdZVcWoULTanY0mT2zsP9jBHPe+II5Z2AdxralXLo5vmEOTgaps47raBuiBEjE51Fir60iyFjaAbzDuOfinbZkhnFGAsMa3+yI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1136.namprd22.prod.outlook.com (10.174.171.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.24; Thu, 13 Dec 2018 05:11:58 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 05:11:58 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Topic: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Index: AQHUknyRs52wg14NwUm+r/H2374buKV72ByAgAAOsoCAAAscgIAAEjWAgAAMqICAAA75AA==
Date:   Thu, 13 Dec 2018 05:11:57 +0000
Message-ID: <20181213051154.57h2ddfcbrgh65gy@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
 <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
 <117fda17-40e6-664b-2b8a-f1032610bf0b@denx.de>
 <20181213033301.febmn5qt3chn3vqb@pburton-laptop>
 <b8525991-f539-a180-2e88-a70b29319413@denx.de>
In-Reply-To: <b8525991-f539-a180-2e88-a70b29319413@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:74::16) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.188.29.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1136;6:Xa6aVGw2Q9G/nj2mSmGlQs8UguhyoKSCF/OJQQ8i7Omy6FgvQtfRP9nEGosuIyBfJ8BlfVtsJS6EsjQj2kG22/mncaBCmt1bC8d+DIL9XpcOPssKz8286oDP5EHIEWLyLMx8Ij3mX5S2jSr+d1s/qYi/SPMFKj8HMPq61izciA9CZ24Hy7zAw08/ussLd+TCG3PyspSXsq1w0BzlpYfjRnF940rG3ygTEwFSFMy6sk7xyMtXy80dvSkNuFjNKvfMU2xZWh/Hjnoc5k9wl/TJg53aMza3sxIwFvjNeAmw9Dj8cvGDDOaWPsgzstkrNLrQIuIPwLfY3wtVmnRM8ZQwDQxkxpwT+0iEBh5LLVRm9x7sIaTgOTCYomAkTmBN/KAKOj4Yb729pwS3dVzqG1SexwZcJecYcAEcX3pGKlLJ2VxeEmWFF1QBrOJOryFXTZEDmvgPNPD1rCKVpKAW6zgqRw==;5:LW3oAYYVVQ4bmpOBG5+AteWG9WkrhbmDGzZrpDDHIYlMPzxpsWt3c5uvX6YFjBwvrVi5lIF/16ghh7dlDRria/Ym1wE1sia4Vdqb0X/dsXNyIxvFaWKdvA9kAPf03ddWvecJZU78OUXQVlKsyP2PvY5zxNUZ4GOgpnP7CMxz2aQ=;7:4pfcD7ECFYGhUmeijoteHcA14nOVDjQ+0y0/myKhlADonatUT2d0gECHyqrutIiXNqFLY5WavLzU5jC6/JJTiJYVZniWNcCzXDrYRhotuPvqa0nMiSb61ckFDuTncPlISTx0ae7lk09Ve+5owES4VA==
x-ms-office365-filtering-correlation-id: fef0dd78-d636-4092-7ace-08d660b98148
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1136;
x-ms-traffictypediagnostic: MWHPR2201MB1136:
x-microsoft-antispam-prvs: <MWHPR2201MB11365AAB460B2A8A4D4E5015C1A00@MWHPR2201MB1136.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(8121501046)(5005006)(93006095)(10201501046)(3231475)(944501520)(52105112)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1136;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1136;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(136003)(366004)(39830400003)(396003)(189003)(199004)(66066001)(71200400001)(446003)(25786009)(102836004)(1076002)(42882007)(6306002)(68736007)(2906002)(6436002)(305945005)(6486002)(3846002)(256004)(4326008)(14444005)(486006)(186003)(11346002)(71190400001)(229853002)(476003)(44832011)(6116002)(316002)(966005)(106356001)(93886005)(33896004)(81156014)(26005)(33716001)(14454004)(97736004)(58126008)(7736002)(508600001)(386003)(8936002)(6506007)(52116002)(54906003)(53936002)(6916009)(9686003)(105586002)(6246003)(81166006)(6512007)(76176011)(8676002)(99286004)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1136;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +Q0x3IEA29j10kQksP7neAU/laEvn143pSZWIQ35GGxh/0XcpRDTW5eAzEYXaQG+j55CzYPhCm/Q2RPbByV7ZN4hJPijKIW7NoEeUyg7WJtfbkicFDtMl2qUJNx+eq9HoIwxXZpp9fHg3RVXYj2Eelc5qIvtzf+Z6Tqj2cVlGv8skLMobPGwy5jDRsw6f9iriLV7b9GFECaw5GmAOBGqqJHt6OSn8Z8RjqJp6UjPUZGVV07mDJXxZutlBAoTDunAAjtbDC5ApkVlyzQVNj5AhP1qB26YMNAf+pQFmxY1OWnQBoSsUaHf7BaLhWKoz3Tq
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EC999F2FC142B1459760CB868F247F06@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0dd78-d636-4092-7ace-08d660b98148
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 05:11:57.8985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 05:18:19AM +0100, Marek Vasut wrote:
> >>> I wonder whether the issue may be the JZ4780 UART not automatically
> >>> resetting the FIFOs when FCR[0] changes. This is a guess, but the man=
ual
> >>> doesn't explicitly say it'll happen & the programming example it give=
s
> >>> says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
> >>> the kernel has been doing for at least the whole git era I wouldn't b=
e
> >>> surprised if other devices are bitten by the change as people start
> >>> trying 4.20 on them.
> >>
> >> The patch you're complaining about is doing exactly that -- it sets
> >> UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT in FCR , and then clears it.
> >> Those two bits are exactly FCR[2:1]. It also explicitly does not touch
> >> any other bits in FCR.
> >=20
> > No - your patch does that *only* if the FIFO enable bit is set, and
> > presumes that clearing FIFOs is a no-op when they're disabled. I don't
> > believe that's true on my system. I also believe that not touching the
> > FIFO enable bit is problematic, since some callers clearly expect that
> > to be cleared.
>=20
> Why would you disable FIFO to clear it ? This doesn't make sense to me,
> the FIFO must be operational for it to be cleared. Moreover, it
> contradicts your previous statement, "the programming example it gives
> says to explicitly clear the FIFOs using FCR[2:1]" .

No, no, not at all... I'm saying that my theory is:

  - The JZ4780 requires that the FIFO be reset using FCR[2:1] in order
    to not read garbage.

  - Prior to your patch serial8250_clear_fifos() did this,
    unconditionally.

  - After your patch serial8250_clear_fifos() only clears the FIFOs if
    the FIFO is already enabled.

  - When called from serial8250_do_startup() during boot, the FIFO may
    not be enabled - for example if the bootloader didn't use the FIFO,
    or if the UART is used with 8250_early which zeroes FCR.

  - Therefore after your patch the FIFO reset bits are never set if the
    UART was used with 8250_early, or if it wasn't but the bootloader
    didn't enable the FIFO.

I suspect that you get away with that because according to the PC16550D
documentation the FIFOs should reset when the FIFO enable bit changes,
so when the FIFO is later enabled it gets reset. I suspect that in the
JZ4780 this does not happen, and the FIFO contains garbage. Our previous
behaviour (always set FCR[2:1] to reset the FIFO) has been around for a
long time, so I would not be surprised to find other devices relying
upon it.

I'm also saying that if the FIFOs are enabled during boot then your
patch will leave them enabled after serial8250_do_startup() calls
serial8250_clear_fifos(), which a comment in serial8250_do_startup()
clearly states is not the expected behaviour:

> Clear the FIFO buffers and disable them.
> (they will be reenabled in set_termios())

(From https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/drivers/tty/serial/8250/8250_port.c?h=3Dv4.20-rc6#n2209)

And further, with your patch serial8250_do_shutdown() will leave the
FIFO enabled which again does not match what comments suggest it expects
("Disable break condition and FIFOs").

> What exactly does your programming example for the JZ4780 say about the
> FIFO clearing ? And does it work in that example ?

It says to set FCR[2:1] to reset the FIFO after enabling it, which as
far as I can tell from the PC16550D documentation would not be necessary
there because when you enable the FIFO it would automatically be reset.
Linux did this until your patch.

> >>> @@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_=
8250_port *p)
> >>>  	if (p->capabilities & UART_CAP_FIFO) {
> >>>  		/*
> >>>  		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
> >>> -		 * In case ENABLE_FIFO is not set, there is nothing to flush
> >>> -		 * so just return. Furthermore, on certain implementations of
> >>> -		 * the 8250 core, the FCR[7:3] bits may only be changed under
> >>> -		 * specific conditions and changing them if those conditions
> >>> -		 * are not met can have nasty side effects. One such core is
> >>> -		 * the 8250-omap present in TI AM335x.
> >>> +		 * On certain implementations of the 8250 core, the FCR[7:3]
> >>> +		 * bits may only be changed under specific conditions and
> >>> +		 * changing them if those conditions are not met can have nasty
> >>> +		 * side effects. One such core is the 8250-omap present in TI
> >>> +		 * AM335x.
> >>>  		 */
> >>>  		fcr =3D serial_in(p, UART_FCR);
> >>> +		serial_out(p, UART_FCR, fcr | clr_mask);
> >>> +		serial_out(p, UART_FCR, fcr & ~clr);
> >>
> >> Note that, if I understand the patch correctly, this will _not_ restor=
e
> >> the original (broken) behavior. The original behavior cleared the enti=
re
> >> FCR at the end, which cleared even bits that were not supposed to be
> >> cleared .
> >=20
> > It will restore the original behaviour with regards to disabling the
> > FIFOs, so long as callers that expect that use
> > serial8250_clear_and_disable_fifos().
>=20
> Does your platform need the FIFO to be explicitly disabled for it to be
> cleared, can you confirm that ? And if so, does this apply to other
> platforms with 8250 UART or is this specific to JZ4780 implementation of
> the UART block ?
>=20
> I just remembered U-Boot has this patch for JZ4780 UART [1], which
> touches the FCR UME bit, so the FCR behavior on JZ4780 does differ from
> the generic 8250 core. Could it be that this is what you're hitting ?

No - we already set the UME bit & this has all worked fine until your
patch changed the FIFO reset behaviour.

Thanks,
    Paul
