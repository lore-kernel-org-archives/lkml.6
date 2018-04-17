Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeDQVa3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:30:29 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29975 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbeDQV2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:28:24 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <ssantosh@kernel.org>,
        <malat@debian.org>, <w-kwok2@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
Subject: [net-next PATCH v4 02/13] soc: ti: K2G: provide APIs to support driver probe deferral
Date: Tue, 17 Apr 2018 17:30:31 -0400
Message-ID: <1524000642-23944-3-git-send-email-m-karicheri2@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
References: <1524000642-23944-1-git-send-email-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provide APIs to allow client drivers to support
probe deferral. On K2G SoC, devices can be probed only
after the ti_sci_pm_domains driver is probed and ready.
As drivers may get probed at different order, any driver
that depends on knav dma and qmss drivers, for example
netcp network driver, needs to defer probe until
knav devices are probed and ready to service. To do this,
add an API to query the device ready status from the knav
dma and qmss devices.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/soc/ti/knav_dma.c        |  8 ++++++++
 drivers/soc/ti/knav_qmss_queue.c |  8 ++++++++
 include/linux/soc/ti/knav_dma.h  | 12 ++++++++++++
 include/linux/soc/ti/knav_qmss.h |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 026182d..224d7dd 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -134,6 +134,13 @@ struct knav_dma_chan {
 
 static struct knav_dma_pool_device *kdev;
 
+static bool device_ready;
+bool knav_dma_device_ready(void)
+{
+	return device_ready;
+}
+EXPORT_SYMBOL_GPL(knav_dma_device_ready);
+
 static bool check_config(struct knav_dma_chan *chan, struct knav_dma_cfg *cfg)
 {
 	if (!memcmp(&chan->cfg, cfg, sizeof(*cfg)))
@@ -773,6 +780,7 @@ static int knav_dma_probe(struct platform_device *pdev)
 	debugfs_create_file("knav_dma", S_IFREG | S_IRUGO, NULL, NULL,
 			    &knav_dma_debug_ops);
 
+	device_ready = true;
 	return ret;
 }
 
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 8526c8e..419365a 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -74,6 +74,13 @@
  */
 const char *knav_acc_firmwares[] = {"ks2_qmss_pdsp_acc48.bin"};
 
+static bool device_ready;
+bool knav_qmss_device_ready(void)
+{
+	return device_ready;
+}
+EXPORT_SYMBOL_GPL(knav_qmss_device_ready);
+
 /**
  * knav_queue_notify: qmss queue notfier call
  *
@@ -1849,6 +1856,7 @@ static int knav_queue_probe(struct platform_device *pdev)
 
 	debugfs_create_file("qmss", S_IFREG | S_IRUGO, NULL, NULL,
 			    &knav_queue_debug_ops);
+	device_ready = true;
 	return 0;
 
 err:
diff --git a/include/linux/soc/ti/knav_dma.h b/include/linux/soc/ti/knav_dma.h
index 66693bc..7127ec3 100644
--- a/include/linux/soc/ti/knav_dma.h
+++ b/include/linux/soc/ti/knav_dma.h
@@ -167,6 +167,8 @@ struct knav_dma_desc {
 void *knav_dma_open_channel(struct device *dev, const char *name,
 				struct knav_dma_cfg *config);
 void knav_dma_close_channel(void *channel);
+int knav_dma_get_flow(void *channel);
+bool knav_dma_device_ready(void);
 #else
 static inline void *knav_dma_open_channel(struct device *dev, const char *name,
 				struct knav_dma_cfg *config)
@@ -176,6 +178,16 @@ static inline void *knav_dma_open_channel(struct device *dev, const char *name,
 static inline void knav_dma_close_channel(void *channel)
 {}
 
+static inline int knav_dma_get_flow(void *channel)
+{
+	return -EINVAL;
+}
+
+static inline bool knav_dma_device_ready(void)
+{
+	return false;
+}
+
 #endif
 
 #endif /* __SOC_TI_KEYSTONE_NAVIGATOR_DMA_H__ */
diff --git a/include/linux/soc/ti/knav_qmss.h b/include/linux/soc/ti/knav_qmss.h
index 9f0ebb3b..9745df6 100644
--- a/include/linux/soc/ti/knav_qmss.h
+++ b/include/linux/soc/ti/knav_qmss.h
@@ -86,5 +86,6 @@ int knav_pool_desc_map(void *ph, void *desc, unsigned size,
 void *knav_pool_desc_unmap(void *ph, dma_addr_t dma, unsigned dma_sz);
 dma_addr_t knav_pool_desc_virt_to_dma(void *ph, void *virt);
 void *knav_pool_desc_dma_to_virt(void *ph, dma_addr_t dma);
+bool knav_qmss_device_ready(void);
 
 #endif /* __SOC_TI_KNAV_QMSS_H__ */
-- 
1.9.1
