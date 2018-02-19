Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753337AbeBSPrp (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:47:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753336AbeBSPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:47:41 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        thuth@redhat.com, b.zolnierkie@samsung.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v3 3/3] s390/setup : enable display support for KVM guest
Date: Mon, 19 Feb 2018 10:47:27 -0500
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021915-0008-0000-0000-00000958B0AF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992052; UDB=6.00503963; IPR=6.00771398;
 MB=3.00019637; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 15:47:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021915-0009-0000-0000-000046161822
Message-Id: <8a6103fcc2b05f4426dcf6573a2175ffe6211403.1519053920.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The S390 architecture does not support any graphics hardware,
but with the latest support for Virtio GPU in Linux and Virtio
GPU emulation in QEMU, it's possible to enable graphics for
S390 using the Virtio GPU device.

To enable display we need to enable the Linux Virtual Terminal (VT)
layer for S390. But the VT subsystem initializes quite early
at boot so we need a dummy console driver till the Virtio GPU
driver is initialized and we can run the framebuffer console.

The framebuffer console over a Virtio GPU device can be run
in combination with the serial SCLP console (default on S390).
The SCLP console can still be accessed by management applications
(eg: via Libvirt's virsh console).

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/setup.c      | 2 ++
 drivers/tty/Kconfig           | 2 +-
 drivers/video/console/Kconfig | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index a6a91f0..f98a0f3 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -221,6 +221,8 @@ static void __init conmode_default(void)
 		SET_CONSOLE_SCLP;
 #endif
 	}
+	if (IS_ENABLED(CONFIG_VT) && IS_ENABLED(CONFIG_DUMMY_CONSOLE))
+		conswitchp = &dummy_con;
 }
 
 #ifdef CONFIG_CRASH_DUMP
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b811442..5ca53fa 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -11,7 +11,7 @@ if TTY
 
 config VT
 	bool "Virtual terminal" if EXPERT
-	depends on !S390 && !UML
+	depends on !UML
 	select INPUT
 	default y
 	---help---
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 0023b16..7aa721e 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && !S390
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
-- 
2.7.4
