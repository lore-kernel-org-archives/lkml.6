Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167514AbeBOXpK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:45:10 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:52529 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167453AbeBOXpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:45:05 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 10/11] watchdog/hpwdt: remove allow_kdump module parameter.
Date: Thu, 15 Feb 2018 16:43:59 -0700
Message-Id: <20180215234400.5022-11-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215234400.5022-1-jerry.hoemann@hpe.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
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
 drivers/watchdog/hpwdt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 654e22b84c80..6e71106f4e4c 100644
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
@@ -144,8 +143,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
 		return NMI_DONE;
 
-	if (allow_kdump)
-		hpwdt_stop(&hpwdt_dev);
+	hpwdt_stop(&hpwdt_dev);
 
 	hex_byte_pack(panic_msg, mynmi);
 	nmi_panic(regs, panic_msg);
@@ -184,10 +182,7 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 	if (retval)
 		goto error2;
 
-	dev_info(&dev->dev,
-			"HPE Watchdog Timer Driver: NMI decoding initialized"
-			", allow kernel dump: %s (default = 1/ON)\n",
-			(allow_kdump == 0) ? "OFF" : "ON");
+	dev_info(&dev->dev, "HPE Watchdog Timer Driver: NMI decoding initialized\n");
 	return 0;
 
 error2:
@@ -346,9 +341,6 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
 #ifdef CONFIG_HPWDT_NMI_DECODING	/* { */
-module_param(allow_kdump, int, 0);
-MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
-
 module_param(pretimeout, bool, 0);
 MODULE_PARM_DESC(pretimeout, "Watchdog pretimeout enabled");
 #endif					/* } */
-- 
2.13.6
