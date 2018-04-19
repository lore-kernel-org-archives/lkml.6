Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753881AbeDSOM5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:12:57 -0400
Received: from sauhun.de ([88.99.104.3]:45350 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753002AbeDSOHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:10 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 46/61] spi: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:16 +0200
Message-Id: <20180419140641.27926-47-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/spi/spi-cadence.c      | 6 ++----
 drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5c9516ae4942..de394422b611 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -686,8 +686,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
  */
 static int __maybe_unused cdns_spi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
 	return spi_master_suspend(master);
 }
@@ -702,8 +701,7 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
  */
 static int __maybe_unused cdns_spi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct cdns_spi *xspi = spi_master_get_devdata(master);
 
 	cdns_spi_init_hw(xspi);
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 18aeaceee286..3608db4ff368 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -918,8 +918,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
  */
 static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 
 	spi_master_suspend(master);
 
@@ -939,8 +938,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
  */
 static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spi_master *master = platform_get_drvdata(pdev);
+	struct spi_master *master = dev_get_drvdata(dev);
 	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
 	int ret = 0;
 
-- 
2.11.0
