Return-Path: <vigneshr@ti.com>
X-Google-Smtp-Source: AIpwx49PbjD194nCCRaDLlnEBuZk/Wfkt1yDpW7YAo/Ho0lGLmcyvl+uiDfQLupYQSjWBS18bbxg
ARC-Seal: i=1; a=rsa-sha256; t=1522671592; cv=none;
        d=google.com; s=arc-20160816;
        b=cp5aNdu6TTt/hBBcdiF4C+HMXj3hSYxMXIM5OkI3T5QyhrrFRnCBs+5u7dBeqdURfv
         3auJY1kj4RjotbdEHK7WMEnjvLweWmVoPPnWpU2dTX7xxVBh+AyizQj8MpRFFgoVEaza
         A/3ajuj7QHzaxWdbCHGFAmY/CTMlctzXnJDzuRy6fwUWXpvDeanl5wH0jbGYyq9HGZRQ
         FJgwPWhNX2XHS4KdzI7oTSUtHG0HW0o+esIz3MoG/2Mmfum93rmErzTDF82tDpOsYU+a
         iNIJtrJC+nTS/Ql+LkhLXMAytiAZYiF0jykPnz7vNBjwyugaSfHV+AnNQ4bxmMnHjVAJ
         WRFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=rHSL7D8eoO66r657T2mGup/twGIfyJp76PPrrqkgpso=;
        b=nB8Xvwcg1XpQyowhPrRj3OMr+frn5doplHEr1iZpDU1PIfk6tnkNlpjjm5l8St0mse
         bsTOVeWopb1qEeEcA3dLWQRQQLXgyKg/6OA2gg8RwpFoqSv+fuNQ7gPqX/qi4ClnF4T0
         t3AtQQVQqrM9B5VJ3lf5QFH01YAa3ooW6j44aKqsCqdmMr3pL8bIrxm6qtwz9SqiP6ub
         RbnP0QBaf2HBhXeZ8AgwRIkizvbp/YaTyosV3NcuQocZok3Hfs1GX99R7VnlpezUH1dz
         TjtEHETsTIxaGBDVuL0msjjf72KJesadcmj8jRywVTe7QH3I2EP2kBAq6WohxWKs9SFK
         zvYg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Pnu2m7hw;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Pnu2m7hw;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vignesh R <vigneshr@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>,
        Vignesh R
	<vigneshr@ti.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH v2] serial: 8250: omap: Provide ability to enable/disable UART as wakeup source
Date: Mon, 2 Apr 2018 17:50:37 +0530
Message-ID: <20180402122037.2710-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596636887864240806?=
X-GMAIL-MSGID: =?utf-8?q?1596636887864240806?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
return value of device_may_wakeup() in .suspend(). This allows
userspace to use sysfs to control the ability of UART to wakeup the
system from deep sleep state. Register is restored back in .startup()
call that happens as part of resume sequence.

With this patch, userspace can control UART wakeup capability via sysfs:
To enable wakeup capability:
echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
For disabling wakeup capability:
echo disabled > /sys/class/tty/ttyXX/device/power/wakeup

Note that the UART wakeup events configured in the 8250 hardware only
work for idle modes that do not cut off power for the UART. For deeper
idle states, dedicated padconf wakeirqs must be used. Or in some cases
the UART RX pin can be remuxed to GPIO input if the GPIO block stays
powered.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---

v2: update commit log.

 drivers/tty/serial/8250/8250_omap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 624b501fd253..6aaa84355fd1 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1310,8 +1310,17 @@ static void omap8250_complete(struct device *dev)
 static int omap8250_suspend(struct device *dev)
 {
 	struct omap8250_priv *priv = dev_get_drvdata(dev);
+	struct uart_8250_port *up = serial8250_get_port(priv->line);
 
 	serial8250_suspend_port(priv->line);
+
+	pm_runtime_get_sync(dev);
+	if (!device_may_wakeup(dev))
+		priv->wer = 0;
+	serial_out(up, UART_OMAP_WER, priv->wer);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
 	flush_work(&priv->qos_work);
 	return 0;
 }
@@ -1403,6 +1412,8 @@ static int omap8250_runtime_suspend(struct device *dev)
 
 		/* Restore to UART mode after reset (for wakeup) */
 		omap8250_update_mdr1(up, priv);
+		/* Restore wakeup enable register */
+		serial_out(up, UART_OMAP_WER, priv->wer);
 	}
 
 	if (up->dma && up->dma->rxchan)
-- 
2.16.2
