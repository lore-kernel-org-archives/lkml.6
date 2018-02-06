Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeBFXAs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 18:00:48 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:13050 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753704AbeBFXAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 18:00:17 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 10/10] watchdog/hpwdt: remove allow_kdump module parameter.
Date: Tue,  6 Feb 2018 15:58:55 -0700
Message-Id: <20180206225855.30582-11-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180206225855.30582-1-jerry.hoemann@hpe.com>
References: <20180206225855.30582-1-jerry.hoemann@hpe.com>
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
index 9bfb668115f8..f767ea4dba86 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -32,7 +32,6 @@
 
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static bool nowayout = WATCHDOG_NOWAYOUT;
-static unsigned int allow_kdump = 1;
 static bool iLO5;
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
 static bool pretimeout = 1;
@@ -149,8 +148,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
 		return NMI_DONE;
 
-	if (allow_kdump)
-		hpwdt_stop(&hpwdt_dev);
+	hpwdt_stop(&hpwdt_dev);
 
 	panic_msg[0] = hexdigit((mynmi>>4)&0xf);
 	panic_msg[1] = hexdigit(mynmi&0xf);
@@ -347,9 +345,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
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
