Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeBYVd6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 16:33:58 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:37208 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeBYVdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 16:33:44 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v4 09/10] watchdog/hpwdt: Add dynamic debug
Date: Sun, 25 Feb 2018 14:32:58 -0700
Message-Id: <20180225213259.2861-10-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180225213259.2861-1-jerry.hoemann@hpe.com>
References: <20180225213259.2861-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a few dynamic debug messages to aid in module level debug.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index be7b3edac56c..b5fb2663c2a1 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -59,6 +59,7 @@ static int hpwdt_start(struct watchdog_device *wdd)
 	int control = 0x81 | (pretimeout ? 0x4 : 0);
 	int reload = SECS_TO_TICKS(wdd->timeout);
 
+	dev_dbg(wdd->parent, "start watchdog 0x%08x:0x%02x\n", reload, control);
 	iowrite16(reload, hpwdt_timer_reg);
 	iowrite8(control, hpwdt_timer_con);
 
@@ -69,6 +70,8 @@ static void hpwdt_stop(void)
 {
 	unsigned long data;
 
+	pr_debug("stop  watchdog\n");
+
 	data = ioread8(hpwdt_timer_con);
 	data &= 0xFE;
 	iowrite8(data, hpwdt_timer_con);
@@ -85,6 +88,7 @@ static int hpwdt_ping(struct watchdog_device *wdd)
 {
 	int reload = SECS_TO_TICKS(wdd->timeout);
 
+	dev_dbg(wdd->parent, "ping  watchdog 0x%08x\n", reload);
 	iowrite16(reload, hpwdt_timer_reg);
 
 	return 0;
@@ -98,8 +102,11 @@ static unsigned int hpwdt_gettimeleft(struct watchdog_device *wdd)
 
 static int hpwdt_settimeout(struct watchdog_device *wdd, unsigned int val)
 {
+	dev_dbg(wdd->parent, "set_timeout = %d\n", val);
+
 	wdd->timeout = val;
 	if (val <= wdd->pretimeout) {
+		dev_dbg(wdd->parent, "pretimeout < timeout. Setting to zero\n");
 		wdd->pretimeout = 0;
 		pretimeout = 0;
 		if (watchdog_active(wdd))
@@ -115,12 +122,16 @@ static int hpwdt_set_pretimeout(struct watchdog_device *wdd, unsigned int req)
 {
 	unsigned int val = 0;
 
+	dev_dbg(wdd->parent, "set_pretimeout = %d\n", req);
 	if (req) {
 		val = PRETIMEOUT_SEC;
 		if (val >= wdd->timeout)
 			return -EINVAL;
 	}
 
+	if (val != req)
+		dev_dbg(wdd->parent, "Rounding pretimeout to: %d\n", val);
+
 	wdd->pretimeout = val;
 	pretimeout = !!val;
 
-- 
2.13.6
