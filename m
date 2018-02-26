Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752366AbeBZDYF (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:24:05 -0500
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:3742 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeBZDWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:22:35 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v5 5/9] watchdog/hpwdt: condition early return of NMI handler on iLO5
Date: Sun, 25 Feb 2018 20:22:23 -0700
Message-Id: <20180226032227.14615-6-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180226032227.14615-1-jerry.hoemann@hpe.com>
References: <20180226032227.14615-1-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify prior change to not claim an NMI unless originated
from iLO to apply only to iLO5 and later going forward.
This restores hpwdt traditional behavior of calling panic
if the NMI is NMI_IO_CHECK, NMI_SERR, or NMI_UNKNOWN for
legacy hardware.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 0e35bb735d8e..171d5033d7b5 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -32,6 +32,7 @@
 #define HPWDT_MAX_TIMER			TICKS_TO_SECS(65535)
 #define DEFAULT_MARGIN			30
 
+static bool ilo5;
 static unsigned int soft_margin = DEFAULT_MARGIN;	/* in seconds */
 static unsigned int reload;			/* the computed soft_margin */
 static bool nowayout = WATCHDOG_NOWAYOUT;
@@ -120,7 +121,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
 
-	if ((ulReason == NMI_UNKNOWN) && mynmi)
+	if (ilo5 && ulReason == NMI_UNKNOWN && mynmi)
 		return NMI_DONE;
 
 	if (allow_kdump)
@@ -277,6 +278,9 @@ static int hpwdt_init_one(struct pci_dev *dev,
 			", timer margin: %d seconds (nowayout=%d).\n",
 			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
+		ilo5 = true;
+
 	return 0;
 
 error_wd_register:
-- 
2.13.6
