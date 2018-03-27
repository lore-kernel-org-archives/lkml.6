Return-Path: <vigneshr@ti.com>
X-Google-Smtp-Source: AG47ELtXvAGg3bCIRInGlB0t21m1ulIl8OWU9DXwaPoJxopHFJ0dqKd65ury/YIEYGgNyLEPaQks
ARC-Seal: i=1; a=rsa-sha256; t=1522152120; cv=none;
        d=google.com; s=arc-20160816;
        b=X6JpcvZtI2OgGvM0zSNnd6aujN5BPVqI5ay+2CjM6q1yzAiBCy4NCAnyDW0ylvogGL
         4L+2TAy9IztZ49jbpskTLLCFS9eRHxtgBu+VCuTeEZJZjobOBV5k+PqPwPHIQOVKB1UC
         08uIKxEeGQfmXy3M4MQ4CUOsbULGEWNr8WZl1lu3kTeZbydVeyvwoeFOvXlvcljU9Wcz
         PCNTXLIA6fzXf94HPvvLLOb8C+E2S/LChao1jnqF10/7tGJ/DsMo82KKmNygwUaLMiSK
         XOq+uSc5YziyGXcBiNwuf6hDfwq7oYIz/G7sQgfTzLbChrSa03jPd7Elj45fzt2OPkmF
         nICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UR4HEoRX34Owe68V/vFHVNFW826e17/Um9OHNzkPjJ4=;
        b=0NfL3eEfD+8riJ42/VH0O3MgIwZqWcnNqsC0WFLY1+S9RN45HpSpD9/pwZ/QALbQ75
         ZPsoWu75uT2vi8T9OnMg5ICvx7wQsvKco1WJue+6nLsUxHHfhq+w4mh0Ft6RcqVif1X5
         dZAt5BcK/i3Noe/dsQ/yALWLYYbweOKFzLi6rOU8sgKLc43G3JRxJyqC6yRgWuNWp/rr
         9IDvgHqD2MocAdHyUD9fNHw60C4l0a/GfPQfRp58YaNbU7dx6NetCftKP9DuvERiIs9k
         Y6pQxPam5V3/XClEGS0Z6r2ybKmhyUYEKNAAII2jeGmXIfcO23MjVw1YpD7cJhw4VvgP
         ngfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=xeoxAHHr;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=xeoxAHHr;
       spf=pass (google.com: domain of vigneshr@ti.com designates 198.47.19.17 as permitted sender) smtp.mailfrom=vigneshr@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
From: Vignesh R <vigneshr@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jslaby@suse.com>, Tony Lindgren <tony@atomide.com>,
        Vignesh R
	<vigneshr@ti.com>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: [PATCH] serial: 8250: omap: Provide ability to enable/disable UART as wakeup source
Date: Tue, 27 Mar 2018 17:32:17 +0530
Message-ID: <20180327120217.4749-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596092181415045913?=
X-GMAIL-MSGID: =?utf-8?q?1596092181415045913?=
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

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
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
