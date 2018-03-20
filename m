Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeCTIgw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 04:36:52 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42325 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeCTIgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 04:36:47 -0400
X-Google-Smtp-Source: AG47ELs+R34uFNPL1Gr84dAAMQ70SHe86tW3XBUfW2mtVoDvEkGzn63ZT0xodrLE1suPZYJ4YTHbyQ==
From: Chunyan Zhang <zhang.chunyan@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH 1/3] mmc: sdhci: add sd host v4 mode
Date: Tue, 20 Mar 2018 16:36:24 +0800
Message-Id: <1521534986-21907-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduces a flag to record this.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 drivers/mmc/host/sdhci.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2020e57..da4d91e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3289,6 +3289,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
+	if (host->version >= SDHCI_SPEC_400) {
+		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+			SDHCI_CTRL_V4_MODE)
+			host->v4_mode = true;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c95b0a4..128b0ba 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -270,6 +271,8 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
 
 /*
  * End of controller registers.
@@ -551,6 +554,9 @@ struct sdhci_host {
 	u32			sdma_boundary;
 
 	unsigned long private[0] ____cacheline_aligned;
+
+	/* Host Version 4 Enable */
+	bool			v4_mode;
 };
 
 struct sdhci_ops {
-- 
2.7.4
