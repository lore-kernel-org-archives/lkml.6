Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D4C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1FE20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C1FE20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeI2N5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:57:47 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59230 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbeI2N5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:57:47 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5F95520006E;
        Sat, 29 Sep 2018 09:30:23 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5621820000D;
        Sat, 29 Sep 2018 09:30:18 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id ED9FD402B9;
        Sat, 29 Sep 2018 15:30:11 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [v2, 1/5] net: dpaa2: move DPAA2 PTP driver out of staging/
Date:   Sat, 29 Sep 2018 15:26:41 +0800
Message-Id: <20180929072645.20027-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.14.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to move DPAA2 PTP driver out of staging/
since the dpaa2-eth had been moved out.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Renamed files rtc.* as dpaa2-ptp.*.
---
 drivers/net/ethernet/freescale/Kconfig             |    9 +--------
 drivers/net/ethernet/freescale/dpaa2/Kconfig       |   15 +++++++++++++++
 drivers/net/ethernet/freescale/dpaa2/Makefile      |    6 ++++--
 .../ethernet/freescale/dpaa2/dpaa2-ptp.c}          |    2 +-
 .../ethernet/freescale/dpaa2/dpaa2-ptp.h}          |    0
 .../ethernet/freescale/dpaa2}/dprtc-cmd.h          |    0
 .../rtc => net/ethernet/freescale/dpaa2}/dprtc.c   |    0
 .../rtc => net/ethernet/freescale/dpaa2}/dprtc.h   |    0
 drivers/staging/fsl-dpaa2/Kconfig                  |    8 --------
 drivers/staging/fsl-dpaa2/Makefile                 |    1 -
 drivers/staging/fsl-dpaa2/rtc/Makefile             |    7 -------
 11 files changed, 21 insertions(+), 27 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/dpaa2/Kconfig
 rename drivers/{staging/fsl-dpaa2/rtc/rtc.c => net/ethernet/freescale/dpaa2/dpaa2-ptp.c} (99%)
 rename drivers/{staging/fsl-dpaa2/rtc/rtc.h => net/ethernet/freescale/dpaa2/dpaa2-ptp.h} (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc-cmd.h (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.c (100%)
 rename drivers/{staging/fsl-dpaa2/rtc => net/ethernet/freescale/dpaa2}/dprtc.h (100%)
 delete mode 100644 drivers/staging/fsl-dpaa2/rtc/Makefile

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 7a30276..d3a62bc 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -96,13 +96,6 @@ config GIANFAR
 	  on the 8540.
 
 source "drivers/net/ethernet/freescale/dpaa/Kconfig"
-
-config FSL_DPAA2_ETH
-	tristate "Freescale DPAA2 Ethernet"
-	depends on FSL_MC_BUS && FSL_MC_DPIO
-	depends on NETDEVICES && ETHERNET
-	---help---
-	  Ethernet driver for Freescale DPAA2 SoCs, using the
-	  Freescale MC bus driver
+source "drivers/net/ethernet/freescale/dpaa2/Kconfig"
 
 endif # NET_VENDOR_FREESCALE
diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
new file mode 100644
index 0000000..44c5c3a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
@@ -0,0 +1,15 @@
+config FSL_DPAA2_ETH
+	tristate "Freescale DPAA2 Ethernet"
+	depends on FSL_MC_BUS && FSL_MC_DPIO
+	depends on NETDEVICES && ETHERNET
+	help
+	  Ethernet driver for Freescale DPAA2 SoCs, using the
+	  Freescale MC bus driver
+
+config FSL_DPAA2_PTP_CLOCK
+	tristate "Freescale DPAA2 PTP Clock"
+	depends on FSL_DPAA2_ETH && POSIX_TIMERS
+	select PTP_1588_CLOCK
+	help
+	  This driver adds support for using the DPAA2 1588 timer module
+	  as a PTP clock.
diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
index 9315ecd..2f424e0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/Makefile
+++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
@@ -3,9 +3,11 @@
 # Makefile for the Freescale DPAA2 Ethernet controller
 #
 
-obj-$(CONFIG_FSL_DPAA2_ETH) += fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
+obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
 
-fsl-dpaa2-eth-objs    := dpaa2-eth.o dpaa2-ethtool.o dpni.o
+fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o
+fsl-dpaa2-ptp-objs	:= dpaa2-ptp.o dprtc.o
 
 # Needed by the tracing framework
 CFLAGS_dpaa2-eth.o := -I$(src)
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
similarity index 99%
rename from drivers/staging/fsl-dpaa2/rtc/rtc.c
rename to drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
index 0d52cb8..2e90d5a 100644
--- a/drivers/staging/fsl-dpaa2/rtc/rtc.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c
@@ -9,7 +9,7 @@
 #include <linux/ptp_clock_kernel.h>
 #include <linux/fsl/mc.h>
 
-#include "rtc.h"
+#include "dpaa2-ptp.h"
 
 struct ptp_dpaa2_priv {
 	struct fsl_mc_device *rtc_mc_dev;
diff --git a/drivers/staging/fsl-dpaa2/rtc/rtc.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/rtc.h
rename to drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.h
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h b/drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc-cmd.h
rename to drivers/net/ethernet/freescale/dpaa2/dprtc-cmd.h
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc.c b/drivers/net/ethernet/freescale/dpaa2/dprtc.c
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc.c
rename to drivers/net/ethernet/freescale/dpaa2/dprtc.c
diff --git a/drivers/staging/fsl-dpaa2/rtc/dprtc.h b/drivers/net/ethernet/freescale/dpaa2/dprtc.h
similarity index 100%
rename from drivers/staging/fsl-dpaa2/rtc/dprtc.h
rename to drivers/net/ethernet/freescale/dpaa2/dprtc.h
diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
index 59aaae7..991e154 100644
--- a/drivers/staging/fsl-dpaa2/Kconfig
+++ b/drivers/staging/fsl-dpaa2/Kconfig
@@ -16,11 +16,3 @@ config FSL_DPAA2_ETHSW
 	---help---
 	Driver for Freescale DPAA2 Ethernet Switch. Select
 	BRIDGE to have support for bridge tools.
-
-config FSL_DPAA2_PTP_CLOCK
-	tristate "Freescale DPAA2 PTP Clock"
-	depends on FSL_DPAA2_ETH && POSIX_TIMERS
-	select PTP_1588_CLOCK
-	help
-	  This driver adds support for using the DPAA2 1588 timer module
-	  as a PTP clock.
diff --git a/drivers/staging/fsl-dpaa2/Makefile b/drivers/staging/fsl-dpaa2/Makefile
index 464f242..c92ab98 100644
--- a/drivers/staging/fsl-dpaa2/Makefile
+++ b/drivers/staging/fsl-dpaa2/Makefile
@@ -3,4 +3,3 @@
 #
 
 obj-$(CONFIG_FSL_DPAA2_ETHSW)		+= ethsw/
-obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= rtc/
diff --git a/drivers/staging/fsl-dpaa2/rtc/Makefile b/drivers/staging/fsl-dpaa2/rtc/Makefile
deleted file mode 100644
index 5468da0..0000000
--- a/drivers/staging/fsl-dpaa2/rtc/Makefile
+++ /dev/null
@@ -1,7 +0,0 @@
-#
-# Makefile for the Freescale DPAA2 PTP clock
-#
-
-obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK) += dpaa2-rtc.o
-
-dpaa2-rtc-objs := rtc.o dprtc.o
-- 
1.7.1

