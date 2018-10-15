Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F47EC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81E6420644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E6420644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=piap.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJOQEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:04:39 -0400
Received: from ni.piap.pl ([195.187.100.4]:54236 "EHLO ni.piap.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbeJOQEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:04:39 -0400
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
        by ni.piap.pl (Postfix) with ESMTP id 52ADC442ECA;
        Mon, 15 Oct 2018 10:20:22 +0200 (CEST)
From:   khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: net/wan: hostess_sv11 + z85230 problems
References: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org>
Date:   Mon, 15 Oct 2018 10:20:21 +0200
In-Reply-To: <1468d110-4f92-da7a-21b5-36afcec3c94e@infradead.org> (Randy
        Dunlap's message of "Sun, 14 Oct 2018 11:09:19 -0700")
Message-ID: <m34ldnd3ju.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-KLMS-Rule-ID: 4
X-KLMS-Message-Action: skipped
X-KLMS-AntiSpam-Status: not scanned, whitelist
X-KLMS-AntiPhishing: not scanned, whitelist
X-KLMS-AntiVirus: Kaspersky Security 8.0 for Linux Mail Server, version 8.0.1.721, not scanned, whitelist
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Randy Dunlap <rdunlap@infradead.org> writes:

> kernel 4.19-rc7, on i386, with NO wan/hdlc/hostess/z85230 hardware:
>
> modprobe hostess_sv11 + autoload of z85230 give:

BTW Hostess SV11 is apparently an ISA card, with all those problems.

> [ 3162.511877] Call Trace:
> [ 3162.511877]  <IRQ>
> [ 3162.511877]  dump_stack+0x58/0x7d
> [ 3162.511877]  register_lock_class+0x4a3/0x4b0
> [ 3162.511877]  ? native_sched_clock+0x2f/0x110
> [ 3162.511877]  __lock_acquire.isra.26+0x46/0x770
> [ 3162.511877]  ? sched_clock+0x8/0x10
> [ 3162.511877]  lock_acquire+0x5c/0x80
> [ 3162.511877]  ? z8530_interrupt+0x35/0x180 [z85230]
> [ 3162.511877]  _raw_spin_lock+0x28/0x70
> [ 3162.511877]  ? z8530_interrupt+0x35/0x180 [z85230]
> [ 3162.511877]  z8530_interrupt+0x35/0x180 [z85230]
> [ 3162.511877]  __handle_irq_event_percpu+0x35/0xe0
> [ 3162.511877]  handle_irq_event_percpu+0x26/0x70
> [ 3162.511877]  handle_irq_event+0x29/0x42
> [ 3162.511877]  handle_fasteoi_irq+0x9b/0x170
> [ 3162.511877]  ? handle_simple_irq+0x90/0x90
> [ 3162.511877]  handle_irq+0xc3/0xee
> [ 3162.511877]  </IRQ>
> [ 3162.511877]  do_IRQ+0x51/0xe0
> [ 3162.511877]  common_interrupt+0xe7/0xec

Look's like something triggered an IRQ, and the z8530 driver got
confused given the lack of z8530 hardware.

> [ 3162.511877] EAX: 00000246 EBX: 00000246 ECX: 00000002 EDX: 00000058
> [ 3162.511877] ESI: f400d8e4 EDI: 00000000 EBP: efbf9d74 ESP: efbf9d6c
> [ 3162.511877] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00000246
> [ 3162.511877]  __setup_irq+0x2f0/0x620
> [ 3162.511877]  request_threaded_irq+0xcd/0x170
> [ 3162.511877]  init_module+0xb0/0x270 [hostess_sv11]

I think the IRQ came as soon as it was requested (enabled).

Now the code does:
static struct z8530_dev *sv11_init(int iobase, int irq)
{
...
        if (request_irq(irq, z8530_interrupt, 0,
                        "Hostess SV11", sv) < 0) {
                pr_warn("IRQ %d already in use\n", irq);
                goto err_irq;
        }
...
        disable_irq(irq);

and only then:
        if (z8530_init(sv)) {
                pr_err("Z8530 series device not found\n");
                enable_irq(irq);
                goto free_dma; (including free_irq())
        }

Not sure about z8530 internals (driver and hw), but I guess the sv11
driver should initialize the hw first, and only then request_irq().
Perhaps there should be no "default address" either? The user would
have to provide the hardware parameters explicitly.

How about this (totally untested):
Fix the Hostess SV11 driver trying to use the hardware before its
existence is detected.

Signed-off-by: Krzysztof Halasa <khalasa@piap.pl>

diff --git a/drivers/net/wan/hostess_sv11.c b/drivers/net/wan/hostess_sv11.c
index 4de0737fbf8a..e8808449c9e5 100644
--- a/drivers/net/wan/hostess_sv11.c
+++ b/drivers/net/wan/hostess_sv11.c
@@ -216,15 +216,6 @@ static struct z8530_dev *sv11_init(int iobase, int irq)
 
 	outb(0, iobase + 4);		/* DMA off */
 
-	/* We want a fast IRQ for this device. Actually we'd like an even faster
-	   IRQ ;) - This is one driver RtLinux is made for */
-
-	if (request_irq(irq, z8530_interrupt, 0,
-			"Hostess SV11", sv) < 0) {
-		pr_warn("IRQ %d already in use\n", irq);
-		goto err_irq;
-	}
-
 	sv->irq = irq;
 	sv->chanA.private = sv;
 	sv->chanA.dev = sv;
@@ -246,17 +237,12 @@ static struct z8530_dev *sv11_init(int iobase, int irq)
 				goto err_rxdma;
 	}
 
-	/* Kill our private IRQ line the hostess can end up chattering
-	   until the configuration is set */
-	disable_irq(irq);
-
 	/*
 	 *	Begin normal initialise
 	 */
 
 	if (z8530_init(sv)) {
 		pr_err("Z8530 series device not found\n");
-		enable_irq(irq);
 		goto free_dma;
 	}
 	z8530_channel_load(&sv->chanB, z8530_dead_port);
@@ -265,12 +251,6 @@ static struct z8530_dev *sv11_init(int iobase, int irq)
 	else
 		z8530_channel_load(&sv->chanA, z8530_hdlc_kilostream_85230);
 
-	enable_irq(irq);
-
-	/*
-	 *	Now we can take the IRQ
-	 */
-
 	sv->chanA.netdevice = netdev = alloc_hdlcdev(sv);
 	if (!netdev)
 		goto free_dma;
@@ -288,9 +268,21 @@ static struct z8530_dev *sv11_init(int iobase, int irq)
 	}
 
 	z8530_describe(sv, "I/O", iobase);
+
+	/* We want a fast IRQ for this device. Actually we'd like an even faster
+	   IRQ ;) - This is one driver RtLinux is made for */
+
+	if (request_irq(irq, z8530_interrupt, 0,
+			"Hostess SV11", sv) < 0) {
+		pr_warn("IRQ %d already in use\n", irq);
+		goto err_irq;
+	}
+
 	sv->active = 1;
 	return sv;
 
+err_irq:
+	unregister_hdlc_device(netdev);
 free_dma:
 	if (dma == 1)
 		free_dma(sv->chanA.rxdma);
@@ -298,8 +290,6 @@ static struct z8530_dev *sv11_init(int iobase, int irq)
 	if (dma)
 		free_dma(sv->chanA.txdma);
 err_txdma:
-	free_irq(irq, sv);
-err_irq:
 	kfree(sv);
 err_kzalloc:
 	release_region(iobase, 8);

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
