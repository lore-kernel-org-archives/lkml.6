Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1167524AbeBOXpd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:45:33 -0500
Received: from g2t2352.austin.hpe.com ([15.233.44.25]:52545 "EHLO
        g2t2352.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1167485AbeBOXpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:45:04 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com, mingo@kernel.org,
        marcus.folkesson@gmail.com, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v3 09/11] watchdog/hpwdt: condition early return of NMI handler on iLO5
Date: Thu, 15 Feb 2018 16:43:58 -0700
Message-Id: <20180215234400.5022-10-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180215234400.5022-1-jerry.hoemann@hpe.com>
References: <20180215234400.5022-1-jerry.hoemann@hpe.com>
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
 drivers/watchdog/hpwdt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index dc0ad20738ed..654e22b84c80 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -38,6 +38,7 @@ static bool pretimeout = 1;
 #else
 static bool pretimeout;
 #endif
+static bool iLO5;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
@@ -135,14 +136,14 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 		"3. OA Forward Progress Log\n"
 		"4. iLO Event Log";
 
-	if ((ulReason == NMI_UNKNOWN) && !mynmi)
-		return NMI_DONE;
-
 	pr_debug("nmi: ulReason=%d, mynmi=0x%0x\n", ulReason, mynmi);
 
 	if (!pretimeout)
 		return NMI_DONE;
 
+	if (iLO5 && (ulReason == NMI_UNKNOWN) && !mynmi)
+		return NMI_DONE;
+
 	if (allow_kdump)
 		hpwdt_stop(&hpwdt_dev);
 
@@ -275,6 +276,9 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 			", timer margin: %d seconds (nowayout=%d).\n",
 			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
+		iLO5 = 1;
+
 	return 0;
 
 error_wd_register:
-- 
2.13.6
