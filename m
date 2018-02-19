Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeBSPsW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:48:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753229AbeBSPrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:47:35 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        thuth@redhat.com, b.zolnierkie@samsung.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Date: Mon, 19 Feb 2018 10:47:25 -0500
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021915-0020-0000-0000-00000D7A00BD
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992052; UDB=6.00503963; IPR=6.00771398;
 MB=3.00019637; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 15:47:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021915-0021-0000-0000-0000602F9B60
Message-Id: <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
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

The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
added the HAS_IOMEM dependecy for "Graphics support". This disabled the
"Graphics support" menu for S390. But if we enable VT layer for S390,
we would also need to enable the dummy console. So let's remove the
HAS_IOMEM dependency.

Move this dependency to sub menu items and console drivers that use
io memory.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
---
 drivers/video/Kconfig         | 21 +++++++++++----------
 drivers/video/console/Kconfig |  4 ++--
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..8f10915 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -3,7 +3,6 @@
 #
 
 menu "Graphics support"
-	depends on HAS_IOMEM
 
 config HAVE_FB_ATMEL
 	bool
@@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
 config SH_LCD_MIPI_DSI
 	bool
 
-source "drivers/char/agp/Kconfig"
+if HAS_IOMEM
+	source "drivers/char/agp/Kconfig"
 
-source "drivers/gpu/vga/Kconfig"
+	source "drivers/gpu/vga/Kconfig"
 
-source "drivers/gpu/host1x/Kconfig"
-source "drivers/gpu/ipu-v3/Kconfig"
+	source "drivers/gpu/host1x/Kconfig"
+	source "drivers/gpu/ipu-v3/Kconfig"
 
-source "drivers/gpu/drm/Kconfig"
+	source "drivers/gpu/drm/Kconfig"
 
-menu "Frame buffer Devices"
-source "drivers/video/fbdev/Kconfig"
-endmenu
+	menu "Frame buffer Devices"
+	source "drivers/video/fbdev/Kconfig"
+	endmenu
 
-source "drivers/video/backlight/Kconfig"
+        source "drivers/video/backlight/Kconfig"
+endif
 
 config VGASTATE
        tristate
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fb..0023b16 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -85,7 +85,7 @@ config MDA_CONSOLE
 
 config SGI_NEWPORT_CONSOLE
         tristate "SGI Newport Console support"
-        depends on SGI_IP22 
+        depends on SGI_IP22 && HAS_IOMEM
         select FONT_SUPPORT
         help
           Say Y here if you want the console on the Newport aka XL graphics
@@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
 
 config STI_CONSOLE
         bool "STI text console"
-        depends on PARISC
+        depends on PARISC && HAS_IOMEM
         select FONT_SUPPORT
         default y
         help
-- 
2.7.4
