Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933274AbeBVQWh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:22:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933243AbeBVQWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:22:33 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com,
        tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, geert@linux-m68k.org,
        alifm@linux.vnet.ibm.com
Subject: [PATCH v4 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Date: Thu, 22 Feb 2018 11:22:22 -0500
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022216-8235-0000-0000-00000D0E8843
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008577; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993504; UDB=6.00504833; IPR=6.00772844;
 MB=3.00019691; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 16:22:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022216-8236-0000-0000-00003FC8FB2F
Message-Id: <6e8ef238162df5be4462126be155975c722e9863.1519315352.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220205
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 drivers/video/Kconfig         | 5 ++++-
 drivers/video/console/Kconfig | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..4f950c6 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -3,7 +3,8 @@
 #
 
 menu "Graphics support"
-	depends on HAS_IOMEM
+
+if HAS_IOMEM
 
 config HAVE_FB_ATMEL
 	bool
@@ -36,6 +37,8 @@ config VIDEOMODE_HELPERS
 config HDMI
 	bool
 
+endif # HAS_IOMEM
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fb..9485857 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
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
