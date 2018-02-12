Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbeBLFWl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:22:41 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:56871 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeBLFW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:28 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 08/11] watchdog/hpwdt: Programable Pretimeout NMI
Date: Sun, 11 Feb 2018 22:21:08 -0700
Message-Id: <20180212052111.12010-9-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212052111.12010-1-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make whether or not the hpwdt watchdog delivers a pretimeout NMI
programable by the user.

The underlying iLO hardware is programmable as to whether or not
a pre-timeout NMI is delivered to the system before the iLO resets
the system.  However, the iLO does not allow for programming the
length of time that NMI is delivered before the system is reset.

Hence, in hpwdt_set_pretimeout, val == 0 disables the NMI. Any
non-zero value sets the pretimeout length to what the hardware
supports.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 740d0c633204..e7355f72d883 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -28,12 +28,15 @@
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
 #define DEFAULT_MARGIN			30
+#define PRETIMEOUT_SEC			9
 
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
-static unsigned int reload;			/* the computed soft_margin */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 #ifdef CONFIG_HPWDT_NMI_DECODING
 static unsigned int allow_kdump = 1;
+static bool pretimeout = 1;
+#else
+static bool pretimeout;
 #endif
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
@@ -55,10 +58,12 @@ static struct watchdog_device hpwdt_dev;
  */
 static int hpwdt_start(struct watchdog_device *dev)
 {
-	reload = SECS_TO_TICKS(dev->timeout);
+	int control = 0x81 | (pretimeout ? 0x4 : 0);
+	int reload = SECS_TO_TICKS(dev->timeout);
 
+	pr_debug("start watchdog 0x%08x:0x%02x\n", reload, control);
 	iowrite16(reload, hpwdt_timer_reg);
-	iowrite8(0x85, hpwdt_timer_con);
+	iowrite8(control, hpwdt_timer_con);
 
 	return 0;
 }
@@ -67,6 +72,8 @@ static int hpwdt_stop(struct watchdog_device *dev)
 {
 	unsigned long data;
 
+	pr_debug("stop  watchdog\n");
+
 	data = ioread8(hpwdt_timer_con);
 	data &= 0xFE;
 	iowrite8(data, hpwdt_timer_con);
@@ -75,8 +82,9 @@ static int hpwdt_stop(struct watchdog_device *dev)
 
 static int hpwdt_ping(struct watchdog_device *dev)
 {
-	reload = SECS_TO_TICKS(dev->timeout);
+	int reload = SECS_TO_TICKS(dev->timeout);
 
+	pr_debug("ping  watchdog 0x%08x\n", reload);
 	iowrite16(reload, hpwdt_timer_reg);
 
 	return 0;
@@ -98,6 +106,16 @@ static int hpwdt_settimeout(struct watchdog_device *dev, unsigned int val)
 }
 
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
+static int hpwdt_set_pretimeout(struct watchdog_device *dev, unsigned int val)
+{
+	if (val && (val != PRETIMEOUT_SEC)) {
+		pr_info("Setting pretimeout to %d\n", PRETIMEOUT_SEC);
+		val = PRETIMEOUT_SEC;
+	}
+	dev->pretimeout = val;
+	pretimeout = val ? 1 : 0;
+	return 0;
+}
 
 static unsigned int hpwdt_my_nmi(void)
 {
@@ -108,7 +126,6 @@ static inline int hexdigit(int v)
 {
 	return (v > 9) ? (v-9+'A') : (v+'0');
 }
-
 /*
  *	NMI Handler
  */
@@ -128,6 +145,9 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 
 	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
 
+	if (!pretimeout)
+		return NMI_DONE;
+
 	if (allow_kdump)
 		hpwdt_stop(&hpwdt_dev);
 
@@ -144,7 +164,8 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 static const struct watchdog_info hpwdt_info = {
 	.options	= WDIOF_SETTIMEOUT    |
 			  WDIOF_KEEPALIVEPING |
-			  WDIOF_MAGICCLOSE,
+			  WDIOF_MAGICCLOSE    |
+			  WDIOF_PRETIMEOUT,
 	.identity	= "HPE iLO2+ HW Watchdog Timer",
 };
 
@@ -296,6 +317,9 @@ static const struct watchdog_ops hpwdt_ops = {
 	.ping		= hpwdt_ping,
 	.set_timeout	= hpwdt_settimeout,
 	.get_timeleft	= hpwdt_gettimeleft,
+#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
+	.set_pretimeout	= hpwdt_set_pretimeout,
+#endif					/* } */
 };
 
 static struct watchdog_device hpwdt_dev = {
@@ -304,6 +328,9 @@ static struct watchdog_device hpwdt_dev = {
 	.min_timeout	= 1,
 	.max_timeout	= HPWDT_MAX_TIMER,
 	.timeout	= DEFAULT_MARGIN,
+#ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
+	.pretimeout	= PRETIMEOUT_SEC,
+#endif					/* } */
 };
 
 
@@ -322,6 +349,9 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
 module_param(allow_kdump, int, 0444);
 MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
+
+module_param(pretimeout, bool, 0444);
+MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
 #endif					/* } */
 
 module_pci_driver(hpwdt_driver);
-- 
2.13.6
