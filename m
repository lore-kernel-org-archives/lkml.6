Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDDDWQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 23:22:16 -0400
Received: from m12-11.163.com ([220.181.12.11]:43917 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752834AbeDDDWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 23:22:15 -0400
From: Xidong Wang <wangxidong_97@163.com>
To: Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc: Xidong Wang <wangxidong_97@163.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] dmaengine:jz4740:fix memory leak
Date: Wed,  4 Apr 2018 11:21:58 +0800
Message-Id: <1522812118-25763-1-git-send-email-wangxidong_97@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: C8CowACXLLzdRMRa_gBeNQ--.8596S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFyDKF13ZryxJw4UKF17Jrb_yoW3Xrc_C3
        WUuryrZrsYkFnxKr1jyrnxZryI9FZ29FZxWwsrt34fKrWrJr15W3y2vr1kGw42grW8GFZ8
        A3Wjgr4xCF45JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5c2-UUUUUU==
X-Originating-IP: [106.120.213.14]
X-CM-SenderInfo: pzdqw5xlgr0wrbzxqiywtou0bp/1tbi8AEe81UMDaLPWwAAs+
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function jz4740_dma_probe(), the memory allocated by
clk_get() is not released on the error path that ret, which holds
the return value of dma_async_device_register(), is not NULL.
This will result in a memory leak bug.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/dma/dma-jz4740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/dma-jz4740.c b/drivers/dma/dma-jz4740.c
index afd5e10..082c158 100644
--- a/drivers/dma/dma-jz4740.c
+++ b/drivers/dma/dma-jz4740.c
@@ -570,6 +570,7 @@ static int jz4740_dma_probe(struct platform_device *pdev)
 	dma_async_device_unregister(dd);
 err_clk:
 	clk_disable_unprepare(dmadev->clk);
+	clk_put(dmadev->clk);
 	return ret;
 }
 
-- 
2.7.4
