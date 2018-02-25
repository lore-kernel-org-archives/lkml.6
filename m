Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752109AbeBYVeI (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 16:34:08 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:42263 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751930AbeBYVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 16:33:43 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v4 07/10] watchdog/hpwdt: remove allow_kdump module parameter.
Date: Sun, 25 Feb 2018 14:32:56 -0700
Message-Id: <20180225213259.2861-8-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180225213259.2861-1-jerry.hoemann@hpe.com>
References: <20180225213259.2861-1-jerry.hoemann@hpe.com>
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
 drivers/watchdog/hpwdt.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index e60c689ebdb2..a584ccf05202 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -36,9 +36,6 @@ static bool iLO5;
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static unsigned int reload;			/* the computed soft_margin */
 static bool nowayout = WATCHDOG_NOWAYOUT;
-#ifdef CONFIG_HPWDT_NMI_DECODING
-static unsigned int allow_kdump = 1;
-#endif
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
@@ -125,8 +122,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (iLO5 && ulReason == NMI_UNKNOWN && mynmi)
 		return NMI_DONE;
 
-	if (allow_kdump)
-		hpwdt_stop();
+	hpwdt_stop();
 
 	hex_byte_pack(panic_msg, mynmi);
 	nmi_panic(regs, panic_msg);
@@ -188,9 +184,8 @@ static int hpwdt_init_nmi_decoding(struct pci_dev *dev)
 		goto error2;
 
 	dev_info(&dev->dev,
-			"HPE Watchdog Timer Driver: NMI decoding initialized"
-			", allow kernel dump: %s (default = 1/ON)\n",
-			(allow_kdump == 0) ? "OFF" : "ON");
+		"HPE Watchdog Timer Driver: NMI decoding initialized\n");
+
 	return 0;
 
 error2:
@@ -324,9 +319,4 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
 
-#ifdef CONFIG_HPWDT_NMI_DECODING
-module_param(allow_kdump, int, 0);
-MODULE_PARM_DESC(allow_kdump, "Start a kernel dump after NMI occurs");
-#endif /* CONFIG_HPWDT_NMI_DECODING */
-
 module_pci_driver(hpwdt_driver);
-- 
2.13.6
