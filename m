Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbeBASll (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:41:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752838AbeBASli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:41:38 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com,
        stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com,
        schwidefsky@de.ibm.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v2 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Date: Thu,  1 Feb 2018 13:41:28 -0500
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
References: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18020118-0008-0000-0000-000002CA855D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983595; UDB=6.00498855; IPR=6.00762873;
 BA=6.00005808; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019323; XFM=3.00000015;
 UTC=2018-02-01 18:41:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020118-0009-0000-0000-0000381D9310
Message-Id: <49ef903a791cbca658194c68932eb90450027774.1517508744.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
added the HAS_IOMEM dependecy for "Graphics support". This disabled the
"Graphics support" menu for S390. But if we enable VT layer for S390,
we would also need to enable the dummy console. So let's remove the
HAS_IOMEM dependency.

Move this dependency to Opencores framebuffer driver which would fail to build
with CONFIG_HAS_IOMEM disabled:

ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/video/Kconfig       | 1 -
 drivers/video/fbdev/Kconfig | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..41e7ba9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -3,7 +3,6 @@
 #
 
 menu "Graphics support"
-	depends on HAS_IOMEM
 
 config HAVE_FB_ATMEL
 	bool
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 2f615b7..ec9c9ce 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -966,7 +966,7 @@ config FB_PVR2
 
 config FB_OPENCORES
 	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
-	depends on FB && HAS_DMA
+	depends on FB && HAS_DMA && HAS_IOMEM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.7.4
