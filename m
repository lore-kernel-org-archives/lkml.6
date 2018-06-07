Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D7ijAu1CGVusAwAAmS7hNA
	; Thu, 07 Jun 2018 14:36:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ED940607DC; Thu,  7 Jun 2018 14:36:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 53208601D2;
	Thu,  7 Jun 2018 14:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 53208601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934118AbeFGOg0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:36:26 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40412 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934091AbeFGOgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:36:19 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvba-0005Zp-Jj; Thu, 07 Jun 2018 15:09:34 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb8-00035O-KM; Thu, 07 Jun 2018 15:09:06 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Robin Getz" <Robin.Getz@analog.com>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.555588060@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 259/410] iio: adis_lib: Initialize trigger before
 requesting interrupt
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

commit f027e0b3a774e10302207e91d304bbf99e3a8b36 upstream.

The adis_probe_trigger() creates a new IIO trigger and requests an
interrupt associated with the trigger. The interrupt uses the generic
iio_trigger_generic_data_rdy_poll() function as its interrupt handler.

Currently the driver initializes some fields of the trigger structure after
the interrupt has been requested. But an interrupt can fire as soon as it
has been requested. This opens up a race condition.

iio_trigger_generic_data_rdy_poll() will access the trigger data structure
and dereference the ops field. If the ops field is not yet initialized this
will result in a NULL pointer deref.

It is not expected that the device generates an interrupt at this point, so
typically this issue did not surface unless e.g. due to a hardware
misconfiguration (wrong interrupt number, wrong polarity, etc.).

But some newer devices from the ADIS family start to generate periodic
interrupts in their power-on reset configuration and unfortunately the
interrupt can not be masked in the device.  This makes the race condition
much more visible and the following crash has been observed occasionally
when booting a system using the ADIS16460.

	Unable to handle kernel NULL pointer dereference at virtual address 00000008
	pgd = c0004000
	[00000008] *pgd=00000000
	Internal error: Oops: 5 [#1] PREEMPT SMP ARM
	Modules linked in:
	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.0-04126-gf9739f0-dirty #257
	Hardware name: Xilinx Zynq Platform
	task: ef04f640 task.stack: ef050000
	PC is at iio_trigger_notify_done+0x30/0x68
	LR is at iio_trigger_generic_data_rdy_poll+0x18/0x20
	pc : [<c042d868>]    lr : [<c042d924>]    psr: 60000193
	sp : ef051bb8  ip : 00000000  fp : ef106400
	r10: c081d80a  r9 : ef3bfa00  r8 : 00000087
	r7 : ef051bec  r6 : 00000000  r5 : ef3bfa00  r4 : ee92ab00
	r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : ee97e400
	Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
	Control: 18c5387d  Table: 0000404a  DAC: 00000051
	Process swapper/0 (pid: 1, stack limit = 0xef050210)
	[<c042d868>] (iio_trigger_notify_done) from [<c0065b10>] (__handle_irq_event_percpu+0x88/0x118)
	[<c0065b10>] (__handle_irq_event_percpu) from [<c0065bbc>] (handle_irq_event_percpu+0x1c/0x58)
	[<c0065bbc>] (handle_irq_event_percpu) from [<c0065c30>] (handle_irq_event+0x38/0x5c)
	[<c0065c30>] (handle_irq_event) from [<c0068e28>] (handle_level_irq+0xa4/0x130)
	[<c0068e28>] (handle_level_irq) from [<c0064e74>] (generic_handle_irq+0x24/0x34)
	[<c0064e74>] (generic_handle_irq) from [<c021ab7c>] (zynq_gpio_irqhandler+0xb8/0x13c)
	[<c021ab7c>] (zynq_gpio_irqhandler) from [<c0064e74>] (generic_handle_irq+0x24/0x34)
	[<c0064e74>] (generic_handle_irq) from [<c0065370>] (__handle_domain_irq+0x5c/0xb4)
	[<c0065370>] (__handle_domain_irq) from [<c000940c>] (gic_handle_irq+0x48/0x8c)
	[<c000940c>] (gic_handle_irq) from [<c0013e8c>] (__irq_svc+0x6c/0xa8)

To fix this make sure that the trigger is fully initialized before
requesting the interrupt.

Fixes: ccd2b52f4ac6 ("staging:iio: Add common ADIS library")
Reported-by: Robin Getz <Robin.Getz@analog.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/iio/imu/adis_trigger.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -47,6 +47,10 @@ int adis_probe_trigger(struct adis *adis
 	if (adis->trig == NULL)
 		return -ENOMEM;
 
+	adis->trig->dev.parent = &adis->spi->dev;
+	adis->trig->ops = &adis_trigger_ops;
+	iio_trigger_set_drvdata(adis->trig, adis);
+
 	ret = request_irq(adis->spi->irq,
 			  &iio_trigger_generic_data_rdy_poll,
 			  IRQF_TRIGGER_RISING,
@@ -55,9 +59,6 @@ int adis_probe_trigger(struct adis *adis
 	if (ret)
 		goto error_free_trig;
 
-	adis->trig->dev.parent = &adis->spi->dev;
-	adis->trig->ops = &adis_trigger_ops;
-	iio_trigger_set_drvdata(adis->trig, adis);
 	ret = iio_trigger_register(adis->trig);
 
 	indio_dev->trig = iio_trigger_get(adis->trig);
