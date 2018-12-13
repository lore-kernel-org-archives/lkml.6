Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09976C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE39E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="compUjoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE39E20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbeLMBsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:48:52 -0500
Received: from mail-eopbgr740099.outbound.protection.outlook.com ([40.107.74.99]:9240
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbeLMBsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:48:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcN5hT6kr/3zuL8js7CR/9/onR9ccCZEnsckteNApHs=;
 b=compUjoSvrtC5aqivMaeNihmU8GmIAb8ECulocOI4bXYkiTMzNxwlgRErNdjCBUS1Roitf9PnAiuM7qtOAIrMZROrQtj9KMGW6bPce+r9+V5kEJMGZTScMVS3iWMwoHluZxaK4kj4zGoqbRRfa8C+9y3QPS0rtCGVc7Mznyx5l4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1742.namprd22.prod.outlook.com (10.164.206.160) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Thu, 13 Dec 2018 01:48:07 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 01:48:06 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Topic: [PATCH] serial: 8250: Fix clearing FIFOs in RS485 mode again
Thread-Index: AQHUknyRs52wg14NwUm+r/H2374buKV72ByAgAAOsoA=
Date:   Thu, 13 Dec 2018 01:48:06 +0000
Message-ID: <20181213014805.77u5dzydo23cm6fq@pburton-laptop>
References: <20181213004120.yn35mzfo4skffabv@pburton-laptop>
 <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
In-Reply-To: <cd3e2787-48e1-ce70-0fa7-94df6dc81794@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0034.namprd12.prod.outlook.com
 (2603:10b6:301:2::20) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1742;6:A6oxlC8ZJ0efUThg/Prun82eyPr7ZIb0kixvBzxnyB7vuJI1FwNWbNV4JdriHSR8QwpCe0+4v1g8YRcSkAKxMgH9HA2Spn4qDwjUEKtUUy92HbAOX9WI2uqpJprWhPrjs3bsC4f2imWwueM3v0CBiyKzjuUu8YNkt7bYBCkTvPsfhklj6d/+rCMK9EePuy19N5mklzIDwpe4OvUkcf8wIwytoPTH5pjc8draNkeXt5cVSPMDa9sp+uk4hpFK4vsCFZfO4YqzzOSVx1SfojXvoW4xzgnvw6i14rHboZeSBR+1VOM3nIPqnDRHFhh6ZvjLNq/RuHhBYE+NLnX0rTxYhrOQmBCkFTmi5fhMnAZDUR2grqyBxDWkj6mK4fT1K0t3YeSSXIfdPInTB4NP/KXzmTZtSRHhB3xli8Rr+aFqfQD3YbfDkOAt8bnIJfnxcDQz0xcstqArH82GxQgWteTMIw==;5:PL4cfCs/s/Oupu6OLBmzH5FYxiAvgzG+GxszzJvqW8dvqlMNwExfUjodbi4SHpilo8/vQc4ggq6Y4sRES6qiy1cDJRrbqjUV6C3Bi83+5bvRs6EkGvoBPdHFe1TrLBTU942NWbY39EBgTGivtXD+ubl24B1hnmqBnWOGnBxfy3c=;7:kZVRdTFwQ5z+iINUYVDpGYauK9mlFPQXoAKzw62tQS1YjvGZAYfPk71Jk7j7U4cYB1049y8pJrqmiKECMyHJ/ef6fYMoyflGwNhD7Z8tMZpodt2KAaWwpwRB4ORFRz8iOTzw7tZr8evs8x9EgrwcuQ==
x-ms-office365-filtering-correlation-id: be674ff2-28dd-4b78-72f4-08d6609d071b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1742;
x-ms-traffictypediagnostic: MWHPR2201MB1742:
x-microsoft-antispam-prvs: <MWHPR2201MB1742E8BBC4805E4DCB20280AC1A00@MWHPR2201MB1742.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(20161123560045)(2016111802025)(20161123564045)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1742;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1742;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(396003)(136003)(39850400004)(346002)(189003)(199004)(508600001)(42882007)(11346002)(8676002)(486006)(6486002)(44832011)(106356001)(81156014)(81166006)(446003)(6436002)(8936002)(97736004)(71200400001)(7736002)(2906002)(186003)(71190400001)(476003)(105586002)(6916009)(25786009)(4326008)(229853002)(575784001)(33896004)(6246003)(52116002)(316002)(6512007)(26005)(3846002)(305945005)(33716001)(53546011)(102836004)(66066001)(5660300001)(53936002)(386003)(256004)(6506007)(14444005)(9686003)(6116002)(99286004)(1076002)(58126008)(54906003)(68736007)(14454004)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1742;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RKgA57IYgwXPnV2RqP1lWhbpGibzl6QjTuOjeSdq9eA09TikYO4BwnQyIWiDh4aa3hshKmKh1JDnQQev7SRWJis0HCupQn7l03xU4GA/3KhdWT1+AFxeASm+dq6inR3WAJWkPB1tko4qu4xfb6eKTru3T7tpTqQ9s83aryR4z/SKJji6ykmZbXxF5DujMEXvPaNw9Ibf9euC2FmPDdCmHj9ekHk4MWnscWHdSJgn0aeHZG1xobsJ7oUzrAmhLpD+4SB+FgwHbQVvdC8c6bUfSCtAQKy5d9bMBDpf5UKAta7+kDKdoxF++IQKwPC1VlW6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B8E5467926761B41AD6C0D8AC2F48197@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be674ff2-28dd-4b78-72f4-08d6609d071b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 01:48:06.7375
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1742
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On Thu, Dec 13, 2018 at 01:55:29AM +0100, Marek Vasut wrote:
> On 12/13/2018 01:41 AM, Paul Burton wrote:
> > This patch has broken the UART on my Ingenic JZ4780 based MIPS Creator
> > Ci20 board. After this patch the system seems to detect garbage input
> > that is recognized as SysRq triggers which spam the console & eventuall=
y
> > reset the system.
> >=20
> > One thing of note is that both serial8250_do_startup() &
> > serial8250_do_shutdown() contain comments that explicitly state their
> > expectation that the FIFOs will be disabled by serial8250_clear_fifos()=
,
> > which is no longer true after this patch.
> >=20
> > I found that restoring the old behaviour for serial8250_do_startup() is
> > enough to make my system work again, but this is obviously a hack:
>%
> > Any ideas? Given the mismatch between this patch & comments that clearl=
y
> > expect the old behaviour I think the __do_stop_tx_rs485() case probably
> > needs something different to other callers.
>=20
> The problem the original patch fixed was that too many bits were cleared
> in the FCR on OMAP3/AM335x . If you have such a system (a beaglebone or
> similar), you can come up with a solution which can accommodate both the
> JZ4780 and AM335x. Can you take a look ? The datasheet for both should
> be public too.

I don't have such a system, but hey - the Ingenic JZ4780 manual is
public too [1] so you have just as much opportunity to fix it :)

I wonder whether the issue may be the JZ4780 UART not automatically
resetting the FIFOs when FCR[0] changes. This is a guess, but the manual
doesn't explicitly say it'll happen & the programming example it gives
says to explicitly clear the FIFOs using FCR[2:1]. Since this is what
the kernel has been doing for at least the whole git era I wouldn't be
surprised if other devices are bitten by the change as people start
trying 4.20 on them.

So I think the safest option might be to restore the original behaviour
& just keep your change for the __do_stop_tx_rs485() path specifically,
something like the below. Could you test it on your system?

Assuming it works I'll clean it up & submit. Otherwise your patch is a
regression so I think a revert would make sense until the problem is
found.

Thanks,
    Paul

[1] ftp://ftp.ingenic.cn/SOC/JZ4780/JZ4780_pm.pdf

---
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/=
8250_port.c
index f776b3eafb96..0df0ed437a87 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -550,7 +550,7 @@ static unsigned int serial_icr_read(struct uart_8250_po=
rt *up, int offset)
 /*
  * FIFO support.
  */
-static void serial8250_clear_fifos(struct uart_8250_port *p)
+static void __serial8250_clear_fifos(struct uart_8250_port *p, int clr)
 {
 	unsigned char fcr;
 	unsigned char clr_mask =3D UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT;
@@ -558,25 +558,26 @@ static void serial8250_clear_fifos(struct uart_8250_p=
ort *p)
 	if (p->capabilities & UART_CAP_FIFO) {
 		/*
 		 * Make sure to avoid changing FCR[7:3] and ENABLE_FIFO bits.
-		 * In case ENABLE_FIFO is not set, there is nothing to flush
-		 * so just return. Furthermore, on certain implementations of
-		 * the 8250 core, the FCR[7:3] bits may only be changed under
-		 * specific conditions and changing them if those conditions
-		 * are not met can have nasty side effects. One such core is
-		 * the 8250-omap present in TI AM335x.
+		 * On certain implementations of the 8250 core, the FCR[7:3]
+		 * bits may only be changed under specific conditions and
+		 * changing them if those conditions are not met can have nasty
+		 * side effects. One such core is the 8250-omap present in TI
+		 * AM335x.
 		 */
 		fcr =3D serial_in(p, UART_FCR);
+		serial_out(p, UART_FCR, fcr | clr_mask);
+		serial_out(p, UART_FCR, fcr & ~clr);
+	}
+}
=20
-		/* FIFO is not enabled, there's nothing to clear. */
-		if (!(fcr & UART_FCR_ENABLE_FIFO))
-			return;
-
-		fcr |=3D clr_mask;
-		serial_out(p, UART_FCR, fcr);
+static void serial8250_clear_fifos(struct uart_8250_port *p)
+{
+	__serial8250_clear_fifos(p, 0);
+}
=20
-		fcr &=3D ~clr_mask;
-		serial_out(p, UART_FCR, fcr);
-	}
+static void serial8250_clear_and_disable_fifos(struct uart_8250_port *p)
+{
+	__serial8250_clear_fifos(p, UART_FCR_ENABLE_FIFO);
 }
=20
 static inline void serial8250_em485_rts_after_send(struct uart_8250_port *=
p)
@@ -595,7 +596,7 @@ static enum hrtimer_restart serial8250_em485_handle_sto=
p_tx(struct hrtimer *t);
=20
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p)
 {
-	serial8250_clear_fifos(p);
+	serial8250_clear_and_disable_fifos(p);
 	serial_out(p, UART_FCR, p->fcr);
 }
 EXPORT_SYMBOL_GPL(serial8250_clear_and_reinit_fifos);
@@ -1364,7 +1365,7 @@ static void autoconfig(struct uart_8250_port *up)
 		serial_out(up, UART_RSA_FRR, 0);
 #endif
 	serial8250_out_MCR(up, save_mcr);
-	serial8250_clear_fifos(up);
+	serial8250_clear_and_disable_fifos(up);
 	serial_in(up, UART_RX);
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
@@ -2210,7 +2211,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
 	 */
-	serial8250_clear_fifos(up);
+	serial8250_clear_and_disable_fifos(up);
=20
 	/*
 	 * Clear the interrupt registers.
@@ -2460,7 +2461,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 */
 	serial_port_out(port, UART_LCR,
 			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
-	serial8250_clear_fifos(up);
+	serial8250_clear_and_disable_fifos(up);
=20
 #ifdef CONFIG_SERIAL_8250_RSA
 	/*
