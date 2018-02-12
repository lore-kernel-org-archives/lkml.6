Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932812AbeBLFXW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:23:22 -0500
Received: from g9t5009.houston.hpe.com ([15.241.48.73]:36678 "EHLO
        g9t5009.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbeBLFW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:27 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 10/11] watchdog/hpwdt: remove allow_kdump module parameter.
Date: Sun, 11 Feb 2018 22:21:10 -0700
Message-Id: <20180212052111.12010-11-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212052111.12010-1-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent of this parameter is unclear and it sets up a
race between the reset of the system by ASR and crashdump.

The length of time between receipt of the pretimeout NMI
and the ASR reset of the system is fixed by hardware.

Turning the parameter off doesn't necessairly prevent a crash dump.
Also, having the ASR reset occur while the system is crash dumping
doesn't imply that the dump was hung given the short duration
between the NMI and the reset.

This parameter is not a substitute for having a architected watchdog
crashdump hang detection paridigm.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e9e54fe20804..bb0dcc8709b8 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -33,7 +33,6 @@
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
 #ifdef CONFIG_HPWDT_NMI_DECODING
-static unsigned int allow_kdump = 1;
 static bool pretimeout = 1;
 #else
 static bool pretimeout;
@@ -149,8 +148,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
 		return NMI_DONE;
 
-	if (allow_kdump)
-		hpwdt_stop(&hpwdt_dev);
+	hpwdt_stop(&hpwdt_dev);
 
 	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
 	panic_msg[1] = hexdigit(mynmi&0xf);
@@ -351,9 +349,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
-module_param(allow_kdump, int, 0444);
-MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
-
 module_param(pretimeout, bool, 0444);
 MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
 #endif					/* } */
-- 
2.13.6
