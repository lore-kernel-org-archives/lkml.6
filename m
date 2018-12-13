Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57FEC6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E82E20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="U1ZpprjA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E82E20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeLMAmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:42:09 -0500
Received: from mail-eopbgr770107.outbound.protection.outlook.com ([40.107.77.107]:28895
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbeLMAmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKrfGGoqgnbe7kVjuyIkvj2H4OXMvSVOqG1d6ar5GJg=;
 b=U1ZpprjAL0fhz6+lEmntCpyn6Aj4byX6QYcSE3gDhEXC4p9pbzWXnxYVpDBkHUY749Grwvx7YpcKmafscDglPMXdF6PvnTgzPRVuNCsdqNtYNpNH322dGxUqN5uEC0elpaqkrozHtKuQGrxTk1kZm3+LzBQTcjq5kfjLEp5DbbQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1565.namprd22.prod.outlook.com (10.172.63.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.22; Thu, 13 Dec 2018 00:41:23 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 00:41:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Topic: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Index: AQHUknyRs52wg14NwUm+r/H2374buA==
Date:   Thu, 13 Dec 2018 00:41:22 +0000
Message-ID: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1701CA0024.namprd17.prod.outlook.com
 (2603:10b6:301:14::34) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1565;6:netpb+2fVTF4gd8pbDogmxkVocsq4Gzsz/QpiI4GUbiz75QyE8H1vOyRIvbObrDLcmAN/EQ7+8cGNFlkpKlI0gnTOIAwLB0zxCQIYwdz1VPMC+Wqp2nBraSr2nQTDmz+dMfrY5T8i8MYGMh2HJGinVJ/rbVc19gDIF0QMLzFXLmdxTSk9MvBpDMMzDw63xIZd+9NfAW28e8n6ery1471+EBVA456ylQiQ5i4+iVXoexG3Ldv9hQXkYEqMNGoePTUo0TWB7JdeEjsSwH+nmaHzmzBeVtx0SgewfN6IvcIpx/uhH/dHTuvELH6Q6jRfPMXL+q6ORJM0vMnJMTtVMZv934TNG91TKatAOUUTGP9nqMkdpA6k9LuxoL7VtwL0ON+1wFHXN/pltuOeH2MbRVP6kszkNDWQ++sbvt+z6BI6OwwasSUOP3wsUGmCItXdSD2Zl0udx37jKLZNSSSMyKIQQ==;5:9o2QAefyTdb6g3UqwJwK0egh6Ectlq7urfHFO2ULqoUJCdIWRD478tL/Z5t22zdr0KQeEdVMOtraHq8jd3fIj7dysTz3+ceybjSebXrF8tApEma5U4v6GYcF9y0XVwzr3IF9KHSilPVxo/DQXNfh77h+VzFr8aA9c1s1VM8sH8A=;7:n606wdYYeiOGUxh3hmAkhuGPF3aThvCT05miMoUOB9wCeHXKLBsbGyDwHwH2J1wj8pg3ac3lnaxhHD5pTjo6tow3LBiet4cPuOHAv4vn453QJH16fGnOj72Q8gS3bPn86Pva7/j4kLj2sr8lroJFMA==
x-ms-office365-filtering-correlation-id: edd1535f-acae-4d5c-8f60-08d66093b43e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1565;
x-ms-traffictypediagnostic: MWHPR2201MB1565:
x-microsoft-antispam-prvs: <MWHPR2201MB15653D22F44C3CA367961B86C1A00@MWHPR2201MB1565.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230020)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(10201501046)(93006095)(3002001)(148016)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123564045)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1565;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1565;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(136003)(366004)(396003)(39850400004)(199004)(189003)(52116002)(14454004)(229853002)(186003)(6506007)(1076002)(66066001)(102836004)(6246003)(54906003)(26005)(71190400001)(6436002)(99286004)(6116002)(68736007)(110136005)(33896004)(3846002)(42882007)(7736002)(71200400001)(14444005)(53936002)(5660300001)(316002)(6486002)(256004)(8676002)(4326008)(8936002)(33716001)(9686003)(508600001)(2906002)(6512007)(58126008)(25786009)(106356001)(97736004)(476003)(486006)(44832011)(305945005)(81156014)(81166006)(105586002)(386003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1565;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 9HS9YA+e/3h15FPq0dSi6sQHHm5KlPHSu/9K8D40m4X7puJgu54QggAeIaavIMBOZzIFUdX3LVJjSF9BGUHorfi5EBkLnHkw1HhiCcJhayyo2a3SSglBz+CBf3S85v8Nty6XGhwAK7Gai1BUMgvTNTzuqNemZlxK64B6hurvb+Ixe0MHNL356fqQ3fFwSdkOscwz+x5/K+YFtsPNqXHIGj5rWpIPibRy+Pi5aIfdaMT7J7vvQ7NchLyIRsozKUdFpoQqN3mrPNxVSiXzcvxxMOcxK+IJH7q1Sn/MCsFUYrEHX/fb1M4v59VaCLRmLDrR
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <211D3890AA0E0543B59BC94DFAD83100@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd1535f-acae-4d5c-8f60-08d66093b43e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 00:41:22.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1565
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek / Greg / all,

On Mon, Sep 03, 2018 at 12:44:52AM +0000, Marek Vasut wrote:
> The 8250 FIFOs indeed need to be cleared after stopping transmission in
> RS485 mode without SER_RS485_RX_DURING_TX flag set. But there are two
> problems with the approach taken by the previous patch from Fixes tag.
>=20
> First, serial8250_clear_fifos() should clear fifos, but what it really
> does is it enables the FIFOs unconditionally if present, clears them
> and then sets the FCR register to zero, which effectively disables the
> FIFOs. In case the FIFO is disabled, enabling it and clearing it makes
> no sense and in fact can trigger misbehavior of the 8250 core. Moreover,
> the FCR register may contain other FIFO configuration bits which may not
> be writable unconditionally and writing them incorrectly can trigger
> misbehavior of the 8250 core too. (ie. AM335x UART swallows the first
> byte and retransmits the last byte twice because of this FCR write).
>=20
> Second, serial8250_clear_and_reinit_fifos() completely reloads the FCR,
> but what really has to happen at the end of the RS485 transmission is
> clearing of the FIFOs and nothing else.
>=20
> This patch repairs serial8250_clear_fifos() so that it really only
> clears the FIFOs by operating on FCR[2:1] bits and leaves all the
> other bits alone. It also undoes serial8250_clear_and_reinit_fifos()
> from __do_stop_tx_rs485() as serial8250_clear_fifos() is sufficient.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Fixes: 2bed8a8e7072 ("Clearing FIFOs in RS485 emulation mode causes subse=
quent transmits to break")
> Cc: Daniel Jedrychowski <avistel@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> NOTE: I am not entirely certain this won't break some other hardware,
>       esp. since there might be dependencies on the weird previous
>       behavior of the serial8250_clear_fifos() somewhere.

This patch has broken the UART on my Ingenic JZ4780 based MIPS Creator
Ci20 board. After this patch the system seems to detect garbage input
that is recognized as SysRq triggers which spam the console & eventually
reset the system.

One thing of note is that both serial8250_do_startup() &
serial8250_do_shutdown() contain comments that explicitly state their
expectation that the FIFOs will be disabled by serial8250_clear_fifos(),
which is no longer true after this patch.

I found that restoring the old behaviour for serial8250_do_startup() is
enough to make my system work again, but this is obviously a hack:

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..8def02933d19 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2210,7 +2210,11 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
-	serial8250_clear_fifos(up);
+	if (up->capabilities & UART_CAP_FIFO) {
+		serial_port_out(port, UART_FCR, UART_FCR_ENABLE_FIFO);
+		serial8250_clear_fifos(up);
+		serial_port_out(port, UART_FCR, 0);
+	}
=20
 	/*
 	 * Clear the interrupt registers.

Any ideas? Given the mismatch between this patch & comments that clearly
expect the old behaviour I think the __do_stop_tx_rs485() case probably
needs something different to other callers.

Thanks,
    Paul
