Return-Path: <ukl@pengutronix.de>
X-Google-Smtp-Source: AB8JxZrucpTiLkrYRZzGZwHtLwjjpVkdWR+0zDuu2awcvoH+pkMdafa7xC4nsrTVc/+zaqphfc3d
ARC-Seal: i=1; a=rsa-sha256; t=1525341905; cv=none;
        d=google.com; s=arc-20160816;
        b=oIthdpCkGcIX/bALq6Ysqhfp8DRhu1UtllY1sL0Z8/6LhpNOfJ1UrZUBxfJXhoXpVD
         IaEwoPsMc2BNiyxDewcG5aV1FujgkDI6ZBS8eXno9t8mb1bJd/4W2WHRM1hih/CAY5kH
         gQ2JK3hOjmpq2QzlhPAgquBieIgBjmTubBPxM1Ywfej+PATiL1r8vxeBGVTp8FhbH07a
         TfYCFtqf033GesxdA4Kup9uZS39uzaJTrNC1qAMojr7Vao2LrgXZibK+SuZo+WW4tUNf
         PEPDP37jtJk4tWXmoeNq0QKGh2aw3KVY4KvTk2ezIVe1431jQclm7uubFYB3Aog/aKWf
         aiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=MYyiGGeTdzLk7yw+aNwDfDV8+kdtI7RDXbFeoBKlDSE=;
        b=rC+MgCv9OeCEQssf57bDdcYKtFohsXu4VvrrzEWl6ZOfmeI846h69ZNJML/sjjvo+B
         +89xr+5RuLuR8E1uXaIoPgSWAlBEVkLHKeB2vADn0pWVBtmp26INJVY1RMQCDvL+l4GB
         QCwXh1Wae8WpN6RN1M62AdoNPDrsZgXjN9/j/gNBf4lCxKk8aZusR/lBWJtmvJuv/nsI
         DeZ4s4xcItsCrTV0PqqP/9v9rRyDGHKno6XUEx5bBfpzsftcG21HNRyMoxwhnKtDcMfx
         tjj1ljdLR5RxIbEYPGm3Pd3Z7ygA9XvshxaN3lHkhn06TGs5vuK1VseJjLCP/IejyhYD
         HwdQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ukl@pengutronix.de designates 2001:67c:670:201:290:27ff:fe1d:cc33 as permitted sender) smtp.mailfrom=ukl@pengutronix.de
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-serial@vger.kernel.org
Cc: kernel@pengutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Pavel Machek <pavel@ucw.cz>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH] tty: implement a rx led trigger
Date: Thu,  3 May 2018 12:04:48 +0200
Message-Id: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599436913798772269?=
X-GMAIL-MSGID: =?utf-8?q?1599436913798772269?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The trigger fires when data is pushed to the ldisc. This is a bit later
than the actual receiving of data but has the nice benefit that it
doesn't need adaption for each driver and isn't in the hot path.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is actually v2 of the series "serial: Add LED trigger support" that
Sascha sent in November 2016.

For now this is only the RX part however that I'd like to use as a base
to get feedback. Once we got to an acceptable change the TX part should
be easy (once the right place to place the trigger is clear).

Other than that the trigger moved from a dedicated function in
serial_core that each driver is supposed to call on reception of data to
flush_to_ldisc().

Best regards
Uwe

 drivers/tty/tty_buffer.c |  4 ++++
 drivers/tty/tty_port.c   | 16 ++++++++++++++++
 include/linux/tty.h      |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
index c996b6859c5e..4d364b77b1a7 100644
--- a/drivers/tty/tty_buffer.c
+++ b/drivers/tty/tty_buffer.c
@@ -17,6 +17,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/ratelimit.h>
+#include <linux/leds.h>
 
 
 #define MIN_TTYB_SIZE	256
@@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
 		struct tty_buffer *head = buf->head;
 		struct tty_buffer *next;
 		int count;
+		unsigned long delay = 50 /* ms */;
 
 		/* Ldisc or user is trying to gain exclusive access */
 		if (atomic_read(&buf->priority))
@@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
 			continue;
 		}
 
+		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
+
 		count = receive_buf(port, head, count);
 		if (!count)
 			break;
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d736880013..51b78a585417 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/serdev.h>
 
@@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
 
 	tty_port_link_device(port, driver, index);
 
+	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
+					      driver->name, index);
+	if (!port->led_trigger_rx_name) {
+		pr_err("Failed to allocate trigger name for %s%d\n",
+		       driver->name, index);
+		goto skip_trigger;
+	}
+
+	led_trigger_register_simple(port->led_trigger_rx_name,
+				    &port->led_trigger_rx);
+
+skip_trigger:
 	dev = serdev_tty_port_register(port, device, driver, index);
 	if (PTR_ERR(dev) != -ENODEV) {
 		/* Skip creating cdev if we registered a serdev device */
@@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
 	if (ret == 0)
 		return;
 
+	led_trigger_unregister_simple(port->led_trigger_rx);
+	kfree(port->led_trigger_rx_name);
+
 	tty_unregister_device(driver, index);
 }
 EXPORT_SYMBOL_GPL(tty_port_unregister_device);
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 1dd587ba6d88..7e36ee1d2056 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -249,6 +249,9 @@ struct tty_port {
 						   set to size of fifo */
 	struct kref		kref;		/* Ref counter */
 	void 			*client_data;
+
+	struct led_trigger	*led_trigger_rx;
+	char			*led_trigger_rx_name;
 };
 
 /* tty_port::iflags bits -- use atomic bit ops */
-- 
2.17.0
