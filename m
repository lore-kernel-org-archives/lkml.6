Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBC1C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAB620850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="buHRKhCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAB620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbeLEAvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:51:14 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:58692 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeLEAvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:51:10 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9384986CE8;
        Wed,  5 Dec 2018 13:51:07 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1543971067;
        bh=e5X8bqi/uctihY2dx4Y4VYS/udTr+xsBZl3L2wBVtxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=buHRKhCoAsINTli6xbiBW5sLRuXd5V53eYsKdBkqOdJtxwH7zO00iLEEYSNfhQjQD
         RkpqMblY7werkisBAsfo5gOsDhIH353nsc7Q++h2yCftnEYVNNZFBl4F/YZxlofYnq
         rtDTy6SpSB7mLBzJ3GN3XLx/wLq09Z7+/NQNBYGIggdFDnzG4tfq25Z0Xqws19b4Y5
         74oDei3L6vfBBvCjazJmxKR0WYbXgpKYFlYDzY+VMB4ma1asa9utsqXtStUdkyO5V8
         yHPHNHIqbn5WsSobr8L2GYRC9OM3TUAkOYqhHFnOxVfYiaExb54gCFzvxuzJGMN3rF
         m7GoPk5DEdx3Q==
Received-SPF: Fail (domain alliedtelesis.co.nz does not designate 10.32.16.33 as a permitted sender),
        client-ip=<10.32.16.33>; identity=<darwind@alliedtelesis.co.nz>; helo=<smtp>;
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c0720fb0000>; Wed, 05 Dec 2018 13:51:07 +1300
Received: from darwind-dl.ws.atlnz.lc (darwind-dl.ws.atlnz.lc [10.33.23.22])
        by smtp (Postfix) with ESMTP id E1DEA13EF01;
        Wed,  5 Dec 2018 13:51:12 +1300 (NZDT)
Received: by darwind-dl.ws.atlnz.lc (Postfix, from userid 1665)
        id 528F93422D0; Wed,  5 Dec 2018 13:51:07 +1300 (NZDT)
From:   Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        jslaby@suse.com, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] serial: 8250: Rate limit serial port rx interrupts during input overruns
Date:   Wed,  5 Dec 2018 13:50:58 +1300
Message-Id: <20181205005058.14095-2-darwin.dingel@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205005058.14095-1-darwin.dingel@alliedtelesis.co.nz>
References: <20181205005058.14095-1-darwin.dingel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a serial port gets faulty or gets flooded with inputs, its interrupt=

handler starts to work double time to get the characters to the workqueue=

for the tty layer to handle them. When this busy time on the serial/tty
subsystem happens during boot, where it is also busy on the userspace
trying to initialise, some processes can continuously get preempted
and will be on hold until the interrupts subside.

The fix is to backoff on processing received characters for a specified
amount of time when an input overrun is seen (received a new character
before the previous one is processed). This only stops receive and will
continue to transmit characters to serial port. After the backoff period
is done, it receive will be re-enabled. This is optional and will only
be enabled by setting 'overrun-throttle-ms' in the dts.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>
---
=20drivers/tty/serial/8250/8250_core.c | 25 +++++++++++++++++++++++++
=20drivers/tty/serial/8250/8250_fsl.c  | 23 ++++++++++++++++++++++-
=20drivers/tty/serial/8250/8250_of.c   |  5 +++++
=20include/linux/serial_8250.h         |  4 ++++
=204 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/825=
0/8250_core.c
index 94f3e1c64490..189ab1212d9a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -942,6 +942,21 @@ static struct uart_8250_port *serial8250_find_match_=
or_unused(struct uart_port *
=20	return NULL;
=20}
=20
+static void serial_8250_overrun_backoff_work(struct work_struct *work)
+{
+	struct uart_8250_port *up =3D
+	    container_of(to_delayed_work(work), struct uart_8250_port,
+			 overrun_backoff);
+	struct uart_port *port =3D &up->port;
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	up->ier |=3D UART_IER_RLSI | UART_IER_RDI;
+	up->port.read_status_mask |=3D UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
=20/**
=20 *	serial8250_register_8250_port - register a serial port
=20 *	@up: serial port template
@@ -1056,6 +1071,16 @@ int serial8250_register_8250_port(struct uart_8250=
_port *up)
=20			ret =3D 0;
=20		}
=20	}
+
+	/* Initialise interrupt backoff work if required */
+	if (up->overrun_backoff_time_ms > 0) {
+		uart->overrun_backoff_time_ms =3D up->overrun_backoff_time_ms;
+		INIT_DELAYED_WORK(&uart->overrun_backoff,
+				  serial_8250_overrun_backoff_work);
+	} else {
+		uart->overrun_backoff_time_ms =3D 0;
+	}
+
=20	mutex_unlock(&serial_mutex);
=20
=20	return ret;
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250=
/8250_fsl.c
index 6640a4c7ddd1..bb9571eed275 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -45,8 +45,29 @@ int fsl8250_handle_irq(struct uart_port *port)
=20
=20	lsr =3D orig_lsr =3D up->port.serial_in(&up->port, UART_LSR);
=20
-	if (lsr & (UART_LSR_DR | UART_LSR_BI))
+	/* Process incoming characters first */
+	if ((lsr & (UART_LSR_DR | UART_LSR_BI)) &&
+	    (up->ier & (UART_IER_RLSI | UART_IER_RDI))) {
=20		lsr =3D serial8250_rx_chars(up, lsr);
+	}
+
+	/* Stop processing interrupts on input overrun */
+	if ((orig_lsr & UART_LSR_OE) && (up->overrun_backoff_time_ms > 0)) {
+		unsigned long delay;
+
+		up->ier =3D port->serial_in(port, UART_IER);
+		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
+			port->ops->stop_rx(port);
+		} else {
+			/* Keep restarting the timer until
+			 * the input overrun subsides.
+			 */
+			cancel_delayed_work(&up->overrun_backoff);
+		}
+
+		delay =3D msecs_to_jiffies(up->overrun_backoff_time_ms);
+		schedule_delayed_work(&up->overrun_backoff, delay);
+	}
=20
=20	serial8250_modem_status(up);
=20
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/=
8250_of.c
index 877fd7f8a8ed..a1a85805d010 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -240,6 +240,11 @@ static int of_platform_serial_probe(struct platform_=
device *ofdev)
=20	if (of_property_read_bool(ofdev->dev.of_node, "auto-flow-control"))
=20		port8250.capabilities |=3D UART_CAP_AFE;
=20
+	if (of_property_read_u32(ofdev->dev.of_node,
+			"overrun-throttle-ms",
+			&port8250.overrun_backoff_time_ms) !=3D 0)
+		port8250.overrun_backoff_time_ms =3D 0;
+
=20	ret =3D serial8250_register_8250_port(&port8250);
=20	if (ret < 0)
=20		goto err_dispose;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 18e21427bce4..5a655ba8d273 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -134,6 +134,10 @@ struct uart_8250_port {
=20	void			(*dl_write)(struct uart_8250_port *, int);
=20
=20	struct uart_8250_em485 *em485;
+
+	/* Serial port overrun backoff */
+	struct delayed_work overrun_backoff;
+	u32 overrun_backoff_time_ms;
=20};
=20
=20static inline struct uart_8250_port *up_to_u8250p(struct uart_port *up=
)
--=20
2.19.2

changes in v2:
- separated dts binding to another patch
