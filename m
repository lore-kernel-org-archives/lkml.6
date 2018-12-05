Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD4C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799E52082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 01:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="SRkcwKeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799E52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeLEBl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 20:41:57 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58958 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbeLEBl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 20:41:56 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DCD6E86CE8;
        Wed,  5 Dec 2018 14:41:53 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1543974113;
        bh=jdiJ92Ea++W0GBPJUKe4Y9EqG0AIYeDfzWLhqy38Cu4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=SRkcwKeV902GmMEUWoGWGuuNw2tOAW4Q602AbaiuzV8HWuyj5MC5EuTvNfFrEFBPK
         Fp0JGq7TM0ApsGyUYcCI8iMR0KKHcBcfiaWFLywtplpRLBgX96MiCIHp4j8RAYwuG/
         fmrYy3eCny1V5QCsUszQkmIf8Y56lqrtnH7ey6S8ssfLIyYQDYQRgcokZ44fQj1I52
         pWRljaN13VkNtD/Cs7+A1p7yxcHIcQJ234Z+ws2EcytQJgwPx5O0v5/puCp2azDZTB
         Gdp4rd7AhRbhh8APNZSWoeQEnQBogWm5wofau4IlcUXwFcZWA0lKyJOnCoIJeEBv9o
         nRXax3GPrNGtQ==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c072ce20001>; Wed, 05 Dec 2018 14:41:54 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Wed, 5 Dec 2018 14:41:53 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Wed, 5 Dec 2018 14:41:53 +1300
From:   Darwin Dingel <Darwin.Dingel@alliedtelesis.co.nz>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] serial: 8250: Rate limit serial port rx interrupts
 during input overruns
Thread-Topic: [PATCH v2 2/2] serial: 8250: Rate limit serial port rx
 interrupts during input overruns
Thread-Index: AQHUjDSbIf4nXQ+uvkiDMLQsOWdB36VvXi6p
Date:   Wed, 5 Dec 2018 01:41:52 +0000
Message-ID: <1543974112674.96843@alliedtelesis.co.nz>
References: <20181205005058.14095-1-darwin.dingel@alliedtelesis.co.nz>,<20181205005058.14095-2-darwin.dingel@alliedtelesis.co.nz>
In-Reply-To: <20181205005058.14095-2-darwin.dingel@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.10]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So sorry for the premature "Reviewed-by" bits on the commit messages on the=
 previous patches=0A=
submitted. Please ignore these while I fix the patch up for v3.=0A=
=0A=
=0A=
Regards,=0A=
Darwin=0A=
________________________________________=0A=
From: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>=0A=
Sent: Wednesday, 5 December 2018 1:50 p.m.=0A=
To: andriy.shevchenko@linux.intel.com; gregkh@linuxfoundation.org; jslaby@s=
use.com; linux-serial@vger.kernel.org=0A=
Cc: linux-kernel@vger.kernel.org; Darwin Dingel=0A=
Subject: [PATCH v2 2/2] serial: 8250: Rate limit serial port rx interrupts =
during input overruns=0A=
=0A=
When a serial port gets faulty or gets flooded with inputs, its interrupt=
=0A=
handler starts to work double time to get the characters to the workqueue=
=0A=
for the tty layer to handle them. When this busy time on the serial/tty=0A=
subsystem happens during boot, where it is also busy on the userspace=0A=
trying to initialise, some processes can continuously get preempted=0A=
and will be on hold until the interrupts subside.=0A=
=0A=
The fix is to backoff on processing received characters for a specified=0A=
amount of time when an input overrun is seen (received a new character=0A=
before the previous one is processed). This only stops receive and will=0A=
continue to transmit characters to serial port. After the backoff period=0A=
is done, it receive will be re-enabled. This is optional and will only=0A=
be enabled by setting 'overrun-throttle-ms' in the dts.=0A=
=0A=
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>=0A=
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=0A=
Reviewed-by: Jiri Slaby <jslaby@suse.com>=0A=
Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>=0A=
---=0A=
 drivers/tty/serial/8250/8250_core.c | 25 +++++++++++++++++++++++++=0A=
 drivers/tty/serial/8250/8250_fsl.c  | 23 ++++++++++++++++++++++-=0A=
 drivers/tty/serial/8250/8250_of.c   |  5 +++++=0A=
 include/linux/serial_8250.h         |  4 ++++=0A=
 4 files changed, 56 insertions(+), 1 deletion(-)=0A=
=0A=
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/=
8250_core.c=0A=
index 94f3e1c64490..189ab1212d9a 100644=0A=
--- a/drivers/tty/serial/8250/8250_core.c=0A=
+++ b/drivers/tty/serial/8250/8250_core.c=0A=
@@ -942,6 +942,21 @@ static struct uart_8250_port *serial8250_find_match_or=
_unused(struct uart_port *=0A=
        return NULL;=0A=
 }=0A=
=0A=
+static void serial_8250_overrun_backoff_work(struct work_struct *work)=0A=
+{=0A=
+       struct uart_8250_port *up =3D=0A=
+           container_of(to_delayed_work(work), struct uart_8250_port,=0A=
+                        overrun_backoff);=0A=
+       struct uart_port *port =3D &up->port;=0A=
+       unsigned long flags;=0A=
+=0A=
+       spin_lock_irqsave(&port->lock, flags);=0A=
+       up->ier |=3D UART_IER_RLSI | UART_IER_RDI;=0A=
+       up->port.read_status_mask |=3D UART_LSR_DR;=0A=
+       serial_out(up, UART_IER, up->ier);=0A=
+       spin_unlock_irqrestore(&port->lock, flags);=0A=
+}=0A=
+=0A=
 /**=0A=
  *     serial8250_register_8250_port - register a serial port=0A=
  *     @up: serial port template=0A=
@@ -1056,6 +1071,16 @@ int serial8250_register_8250_port(struct uart_8250_p=
ort *up)=0A=
                        ret =3D 0;=0A=
                }=0A=
        }=0A=
+=0A=
+       /* Initialise interrupt backoff work if required */=0A=
+       if (up->overrun_backoff_time_ms > 0) {=0A=
+               uart->overrun_backoff_time_ms =3D up->overrun_backoff_time_=
ms;=0A=
+               INIT_DELAYED_WORK(&uart->overrun_backoff,=0A=
+                                 serial_8250_overrun_backoff_work);=0A=
+       } else {=0A=
+               uart->overrun_backoff_time_ms =3D 0;=0A=
+       }=0A=
+=0A=
        mutex_unlock(&serial_mutex);=0A=
=0A=
        return ret;=0A=
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8=
250_fsl.c=0A=
index 6640a4c7ddd1..bb9571eed275 100644=0A=
--- a/drivers/tty/serial/8250/8250_fsl.c=0A=
+++ b/drivers/tty/serial/8250/8250_fsl.c=0A=
@@ -45,8 +45,29 @@ int fsl8250_handle_irq(struct uart_port *port)=0A=
=0A=
        lsr =3D orig_lsr =3D up->port.serial_in(&up->port, UART_LSR);=0A=
=0A=
-       if (lsr & (UART_LSR_DR | UART_LSR_BI))=0A=
+       /* Process incoming characters first */=0A=
+       if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&=0A=
+           (up->ier & (UART_IER_RLSI | UART_IER_RDI))) {=0A=
                lsr =3D serial8250_rx_chars(up, lsr);=0A=
+       }=0A=
+=0A=
+       /* Stop processing interrupts on input overrun */=0A=
+       if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) =
{=0A=
+               unsigned long delay;=0A=
+=0A=
+               up->ier =3D port->serial_in(port, UART_IER);=0A=
+               if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {=0A=
+                       port->ops->stop_rx(port);=0A=
+               } else {=0A=
+                       /* Keep restarting the timer until=0A=
+                        * the input overrun subsides.=0A=
+                        */=0A=
+                       cancel_delayed_work(&up->overrun_backoff);=0A=
+               }=0A=
+=0A=
+               delay =3D msecs_to_jiffies(up->overrun_backoff_time_ms);=0A=
+               schedule_delayed_work(&up->overrun_backoff, delay);=0A=
+       }=0A=
=0A=
        serial8250_modem_status(up);=0A=
=0A=
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/82=
50_of.c=0A=
index 877fd7f8a8ed..a1a85805d010 100644=0A=
--- a/drivers/tty/serial/8250/8250_of.c=0A=
+++ b/drivers/tty/serial/8250/8250_of.c=0A=
@@ -240,6 +240,11 @@ static int of_platform_serial_probe(struct platform_de=
vice *ofdev)=0A=
        if (of_property_read_bool(ofdev->dev.of_node, "auto-flow-control"))=
=0A=
                port8250.capabilities |=3D UART_CAP_AFE;=0A=
=0A=
+       if (of_property_read_u32(ofdev->dev.of_node,=0A=
+                       "overrun-throttle-ms",=0A=
+                       &port8250.overrun_backoff_time_ms) !=3D 0)=0A=
+               port8250.overrun_backoff_time_ms =3D 0;=0A=
+=0A=
        ret =3D serial8250_register_8250_port(&port8250);=0A=
        if (ret < 0)=0A=
                goto err_dispose;=0A=
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h=0A=
index 18e21427bce4..5a655ba8d273 100644=0A=
--- a/include/linux/serial_8250.h=0A=
+++ b/include/linux/serial_8250.h=0A=
@@ -134,6 +134,10 @@ struct uart_8250_port {=0A=
        void                    (*dl_write)(struct uart_8250_port *, int);=
=0A=
=0A=
        struct uart_8250_em485 *em485;=0A=
+=0A=
+       /* Serial port overrun backoff */=0A=
+       struct delayed_work overrun_backoff;=0A=
+       u32 overrun_backoff_time_ms;=0A=
 };=0A=
=0A=
 static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up)=0A=
--=0A=
2.19.2=0A=
=0A=
changes in v2:=0A=
- separated dts binding to another patch=0A=
