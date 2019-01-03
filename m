Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 623F7C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381E720883
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbfACKRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:17:32 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22291 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730757AbfACKR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:17:28 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x03AC9K7023336;
        Thu, 3 Jan 2019 11:17:16 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2pnxxbtska-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 03 Jan 2019 11:17:16 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5437D3A;
        Thu,  3 Jan 2019 10:17:15 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 348C22A85;
        Thu,  3 Jan 2019 10:17:15 +0000 (GMT)
Received: from localhost (10.75.127.44) by SFHDAG5NODE2.st.com (10.75.127.14)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 3 Jan 2019 11:17:14
 +0100
From:   Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <dmaengine@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [RESEND PATCH v1 3/3] dmaengine: stm32-mdma: Add PM Runtime support
Date:   Thu, 3 Jan 2019 11:17:10 +0100
Message-ID: <1546510630-16555-4-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
References: <1546510630-16555-1-git-send-email-pierre-yves.mordret@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-03_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use pm_runtime engine for clock management purpose

Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/dma/stm32-mdma.c | 52 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 390e4ca..ac0301b 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -37,6 +37,7 @@
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
 
@@ -1456,15 +1457,13 @@ static int stm32_mdma_alloc_chan_resources(struct dma_chan *c)
 		return -ENOMEM;
 	}
 
-	ret = clk_prepare_enable(dmadev->clk);
-	if (ret < 0) {
-		dev_err(chan2dev(chan), "clk_prepare_enable failed: %d\n", ret);
+	ret = pm_runtime_get_sync(dmadev->ddev.dev);
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = stm32_mdma_disable_chan(chan);
 	if (ret < 0)
-		clk_disable_unprepare(dmadev->clk);
+		pm_runtime_put(dmadev->ddev.dev);
 
 	return ret;
 }
@@ -1484,7 +1483,7 @@ static void stm32_mdma_free_chan_resources(struct dma_chan *c)
 		spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	}
 
-	clk_disable_unprepare(dmadev->clk);
+	pm_runtime_put(dmadev->ddev.dev);
 	vchan_free_chan_resources(to_virt_chan(c));
 	dmam_pool_destroy(chan->desc_pool);
 	chan->desc_pool = NULL;
@@ -1597,6 +1596,12 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "clk_prep_enable error: %d\n", ret);
+		return ret;
+	}
+
 	dmadev->rst = devm_reset_control_get(&pdev->dev, NULL);
 	if (!IS_ERR(dmadev->rst)) {
 		reset_control_assert(dmadev->rst);
@@ -1668,6 +1673,10 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, dmadev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 
 	dev_info(&pdev->dev, "STM32 MDMA driver registered\n");
 
@@ -1677,11 +1686,42 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+static int stm32_mdma_runtime_suspend(struct device *dev)
+{
+	struct stm32_mdma_device *dmadev = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(dmadev->clk);
+
+	return 0;
+}
+
+static int stm32_mdma_runtime_resume(struct device *dev)
+{
+	struct stm32_mdma_device *dmadev = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(dmadev->clk);
+	if (ret) {
+		dev_err(dev, "failed to prepare_enable clock\n");
+		return ret;
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops stm32_mdma_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_mdma_runtime_suspend,
+			   stm32_mdma_runtime_resume, NULL)
+};
+
 static struct platform_driver stm32_mdma_driver = {
 	.probe = stm32_mdma_probe,
 	.driver = {
 		.name = "stm32-mdma",
 		.of_match_table = stm32_mdma_of_match,
+		.pm = &stm32_mdma_pm_ops,
 	},
 };
 
-- 
2.7.4

