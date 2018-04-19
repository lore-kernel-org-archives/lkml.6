Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753428AbeDSO1N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:27:13 -0400
Received: from sauhun.de ([88.99.104.3]:45272 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbeDSOGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:06:52 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Kukjin Kim <kgene@kernel.org>,
        Jamie Iles <jamie@jamieiles.com>, linux-crypto@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/61] crypto: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:05:36 +0200
Message-Id: <20180419140641.27926-7-wsa+renesas@sang-engineering.com>
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

 drivers/crypto/exynos-rng.c       | 6 ++----
 drivers/crypto/picoxcell_crypto.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/exynos-rng.c b/drivers/crypto/exynos-rng.c
index 86f5f459762e..2cfabb99cb6e 100644
--- a/drivers/crypto/exynos-rng.c
+++ b/drivers/crypto/exynos-rng.c
@@ -319,8 +319,7 @@ static int exynos_rng_remove(struct platform_device *pdev)
 
 static int __maybe_unused exynos_rng_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos_rng_dev *rng = platform_get_drvdata(pdev);
+	struct exynos_rng_dev *rng = dev_get_drvdata(dev);
 	int ret;
 
 	/* If we were never seeded then after resume it will be the same */
@@ -350,8 +349,7 @@ static int __maybe_unused exynos_rng_suspend(struct device *dev)
 
 static int __maybe_unused exynos_rng_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct exynos_rng_dev *rng = platform_get_drvdata(pdev);
+	struct exynos_rng_dev *rng = dev_get_drvdata(dev);
 	int ret;
 
 	/* Never seeded so nothing to do */
diff --git a/drivers/crypto/picoxcell_crypto.c b/drivers/crypto/picoxcell_crypto.c
index a4df966adbf6..321d5e2ac833 100644
--- a/drivers/crypto/picoxcell_crypto.c
+++ b/drivers/crypto/picoxcell_crypto.c
@@ -1169,8 +1169,7 @@ static void spacc_spacc_complete(unsigned long data)
 #ifdef CONFIG_PM
 static int spacc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spacc_engine *engine = platform_get_drvdata(pdev);
+	struct spacc_engine *engine = dev_get_drvdata(dev);
 
 	/*
 	 * We only support standby mode. All we have to do is gate the clock to
@@ -1184,8 +1183,7 @@ static int spacc_suspend(struct device *dev)
 
 static int spacc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct spacc_engine *engine = platform_get_drvdata(pdev);
+	struct spacc_engine *engine = dev_get_drvdata(dev);
 
 	return clk_enable(engine->clk);
 }
-- 
2.11.0
