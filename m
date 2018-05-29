Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933625AbeE2L5i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 07:57:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8201 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933395AbeE2L5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 07:57:35 -0400
From: YueHaibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <grygorii.strashko@ti.com>, <muvarov@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andrew@lunn.ch>, <fugang.duan@nxp.com>, <linux-omap@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: davinci_mdio: fix building error without CONFIG_OF
Date: Tue, 29 May 2018 19:56:51 +0800
Message-ID: <20180529115651.3420-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc report a build error when compiling without CONFIG_OF
drivers/net/ethernet/ti/davinci_mdio.c: In function ‘davinci_mdio_probe’:
drivers/net/ethernet/ti/davinci_mdio.c:380:9: error: implicit declaration of function ‘davinci_mdio_probe_dt’ [-Werror=implicit-function-declaration]
   ret = davinci_mdio_probe_dt(&data->pdata, pdev);
         ^
Fixes: 9eae9c7d0875 ("drivers: net: davinci_mdio: enable pm runtime auto for ti cpsw-mdio")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 8ac7283..6e544d9 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -339,9 +339,7 @@ static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
 
 	return 0;
 }
-#endif
 
-#if IS_ENABLED(CONFIG_OF)
 static const struct davinci_mdio_of_param of_cpsw_mdio_data = {
 	.autosuspend_delay_ms = 100,
 };
@@ -352,6 +350,12 @@ static const struct of_device_id davinci_mdio_of_mtable[] = {
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, davinci_mdio_of_mtable);
+#else
+static int davinci_mdio_probe_dt(struct mdio_platform_data *data,
+				 struct platform_device *pdev)
+{
+	return -EINVAL;
+}
 #endif
 
 static int davinci_mdio_probe(struct platform_device *pdev)
-- 
2.7.0
