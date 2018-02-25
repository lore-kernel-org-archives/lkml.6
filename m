Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeBYVdy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 16:33:54 -0500
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:39188 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeBYVdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 16:33:44 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v4 08/10] watchdog/hpwdt: Programable Pretimeout NMI
Date: Sun, 25 Feb 2018 14:32:57 -0700
Message-Id: <20180225213259.2861-9-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180225213259.2861-1-jerry.hoemann@hpe.com>
References: <20180225213259.2861-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make whether or not the hpwdt watchdog delivers a pretimeout NMI
programable by the user.

The underlying iLO hardware is programmable as to whether or not
a pre-timeout NMI is delivered to the system before the iLO resets
the system.  However, the iLO does not allow for programming the
length of time that NMI is delivered before the system is reset.

By watchdog API, in hpwdt_set_pretimeout a val == 0 disables the NMI.
When val != 0, hpwdt_set_pretimeout will enable the pretimeout NMI
provided the current timeout is greator than the HW specified
pretimeout length. Otherwise an error is returned.

In set_timeout, if the new timeout is <= an already established pretimeout,
the pretimeout is canceled.  This matches the action watchdog_set_timeout
in the watchdog core would do if an hpwdt specific set_timeout
function wasn't specified.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 53 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index a584ccf05202..be7b3edac56c 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -31,11 +31,12 @@
 #define TICKS_TO_SECS(ticks)		((ticks) * 128 / 1000)
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
 #define DEFAULT_MARGIN			30
+#define PRETIMEOUT_SEC			9
 
 static bool iLO5;
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
-static unsigned int reload;			/* the computed soft_margin */
 static bool nowayout = WATCHDOG_NOWAYOUT;
+static bool pretimeout = IS_ENABLED(CONFIG_HPWDT_NMI_DECODING);
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
@@ -55,10 +56,11 @@ MODULE_DEVICE_TABLE(pci, hpwdt_devices);
  */
 static int hpwdt_start(struct watchdog_device *wdd)
 {
-	reload = SECS_TO_TICKS(wdd->timeout);
+	int control = 0x81 | (pretimeout ? 0x4 : 0);
+	int reload = SECS_TO_TICKS(wdd->timeout);
 
 	iowrite16(reload, hpwdt_timer_reg);
-	iowrite8(0x85, hpwdt_timer_con);
+	iowrite8(control, hpwdt_timer_con);
 
 	return 0;
 }
@@ -81,7 +83,10 @@ static int hpwdt_stop_core(struct watchdog_device *wdd)
 
 static int hpwdt_ping(struct watchdog_device *wdd)
 {
+	int reload = SECS_TO_TICKS(wdd->timeout);
+
 	iowrite16(reload, hpwdt_timer_reg);
+
 	return 0;
 }
 
@@ -94,12 +99,37 @@ static unsigned int hpwdt_gettimeleft(struct watchdog_device *wdd)
 static int hpwdt_settimeout(struct watchdog_device *wdd, unsigned int val)
 {
 	wdd->timeout = val;
+	if (val <= wdd->pretimeout) {
+		wdd->pretimeout = 0;
+		pretimeout = 0;
+		if (watchdog_active(wdd))
+			hpwdt_start(wdd);
+	}
 	hpwdt_ping(wdd);
 
 	return 0;
 }
 
 #ifdef CONFIG_HPWDT_NMI_DECODING
+static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
+{
+	unsigned int val = 0;
+
+	if (req) {
+		val = PRETIMEOUT_SEC;
+		if (val >= wdd->timeout)
+			return -EINVAL;
+	}
+
+	wdd->pretimeout = val;
+	pretimeout = !!val;
+
+	if (watchdog_active(wdd))
+		hpwdt_start(wdd);
+
+	return 0;
+}
+
 static int hpwdt_my_nmi(void)
 {
 	return ioread8(hpwdt_nmistat) & 0x6;
@@ -122,6 +152,9 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (iLO5 && ulReason == NMI_UNKNOWN && mynmi)
 		return NMI_DONE;
 
+	if (iLO5 && !pretimeout)
+		return NMI_DONE;
+
 	hpwdt_stop();
 
 	hex_byte_pack(panic_msg, mynmi);
@@ -133,7 +166,8 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 
 
 static const struct watchdog_info ident = {
-	.options = WDIOF_SETTIMEOUT |
+	.options = WDIOF_PRETIMEOUT    |
+		   WDIOF_SETTIMEOUT    |
 		   WDIOF_KEEPALIVEPING |
 		   WDIOF_MAGICCLOSE,
 	.identity = "HPE iLO2+ HW Watchdog Timer",
@@ -150,6 +184,9 @@ static const struct watchdog_ops hpwdt_ops = {
 	.ping		= hpwdt_ping,
 	.set_timeout	= hpwdt_settimeout,
 	.get_timeleft	= hpwdt_gettimeleft,
+#ifdef CONFIG_HPWDT_NMI_DECODING
+	.set_pretimeout	= hpwdt_set_pretimeout,
+#endif
 };
 
 static struct watchdog_device hpwdt_dev = {
@@ -158,6 +195,9 @@ static struct watchdog_device hpwdt_dev = {
 	.min_timeout	= 1,
 	.max_timeout	= HPWDT_MAX_TIMER,
 	.timeout	= DEFAULT_MARGIN,
+#ifdef CONFIG_HPWDT_NMI_DECODING
+	.pretimeout	= PRETIMEOUT_SEC,
+#endif
 };
 
 
@@ -319,4 +359,9 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
+module_param(pretimeout, bool, 0);
+MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
+#endif
+
 module_pci_driver(hpwdt_driver);
-- 
2.13.6
