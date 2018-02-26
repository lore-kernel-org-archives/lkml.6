Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsWiQSCbuofVURNvG7XvENtDWu1b80GxWLue6LiDdAT+zjjslS0RkDWh+TlLr5Cmv0Faobl
ARC-Seal: i=1; a=rsa-sha256; t=1519676180; cv=none;
        d=google.com; s=arc-20160816;
        b=t8LXthP3XDYY6S1x4jU0rzkCYdpL4tmzjWxiWDw6IDMMGi4VW0bsOBpaeIa3U6zemC
         C9qNwQi8GLCOadA2AycNXfzXpkXwRdAvHO7CCP8m0Tp1aFNGx72X8VG/VSPPUFKfkW3b
         ERwpObtb7ByPJkYj5In6rCBIQ+hZlNNuSdwaJD86GH/aLw2Af4k+diRvlTMGCW0QDzgn
         I7E2sf4nQYxYaxo6VOUJXV9IzgW7nU+On4FYKg63n+Lfko8HduTGkEKKO2WPyJIAsWO8
         0ekn6xv9XtPk6oGwkv1T0rXGlgiFo0XOZjYdwCZWPM145nLmQTIAYH3eth7dcMGMvAI2
         /6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=C3XRljgzKToJR/mPVo0UsUhlEjTLOESL4bhiZxa4GMw=;
        b=fEXCdPIcPiVLqhEYRsxYquWNFcnHUL2d40tZSGMrnVE0IcWwNxaN52vJF58fPUELu9
         pFo7BU3wM7l+ZmtR6FQ0gjZyDaoSjYNLdPTzE0Y83hsolD46jzF+nMsYFr8pzRePSf17
         +M9KTHUfJjvfIqdBqen4wAEicUDSc7dono8iwhPk6ICIQ2hrVHANDiG/T2hc8arN12H1
         7q1MX3h0JkRpU/hAflbEXJ+i14AVl93y1eg/znX/JaazbqHfokFaQxIYSMHGiB/jguGZ
         KToLZf6mpoP/ugfbeVjwgazm0aNKbeXkuMR2T064/R646WuQq1w2SYXnaEFf/t2XnEjp
         jGqA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Robin Getz <Robin.Getz@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3.18 07/13] iio: adis_lib: Initialize trigger before requesting interrupt
Date: Mon, 26 Feb 2018 21:15:35 +0100
Message-Id: <20180226201527.555795884@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201527.242286068@linuxfoundation.org>
References: <20180226201527.242286068@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593495970626183407?=
X-GMAIL-MSGID: =?utf-8?q?1593495970626183407?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/imu/adis_trigger.c |    7 ++++---
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
