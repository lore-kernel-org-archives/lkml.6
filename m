Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932570AbeBLFWk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 00:22:40 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:56873 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751367AbeBLFW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 00:22:28 -0500
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        rwright@hpe.com, maurice.a.saldivar@hpe.com,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 09/11] watchdog/hpwdt: condition early return of NMI handler on iLO5
Date: Sun, 11 Feb 2018 22:21:09 -0700
Message-Id: <20180212052111.12010-10-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180212052111.12010-1-jerry.hoemann@hpe.com>
References: <20180212052111.12010-1-jerry.hoemann@hpe.com>
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
index e7355f72d883..e9e54fe20804 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -38,6 +38,7 @@ static bool pretimeout = 1;
 #else
 static bool pretimeout;
 #endif
+static bool iLO5;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
 static unsigned long __iomem *hpwdt_nmistat;
@@ -140,14 +141,14 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
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
 
@@ -280,6 +281,9 @@ static int hpwdt_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 			", timer margin: %d seconds (nowayout=%d).\n",
 			HPWDT_VERSION, hpwdt_dev.timeout, nowayout);
 
+	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR)
+		iLO5 = 1;
+
 	return 0;
 
 error_wd_register:
-- 
2.13.6
