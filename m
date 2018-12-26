Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D3AC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE59217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 07:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aN+RpUig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLZHyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 02:54:09 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44366 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbeLZHyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 02:54:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so7565583pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 23:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xXrvrFItBnRDxfG7z70Hu3FSZdgB97kZ5QNipXXX2BU=;
        b=aN+RpUig6MAXm9bqE+RIGDCVy4BNT/31Lx2/JoZ1nqd6TicW10OCNcRP8vkYGQyeKE
         kOjhKH5YGggLHgrRs/ny8baFHBuQmZEVj7EMfdMOs67G3uyEoAOOe2Xt3HOw5k3E0m1F
         YXYVr8cjJGH3fdgsRbFpfxq9VQjP0hlF6S+oI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xXrvrFItBnRDxfG7z70Hu3FSZdgB97kZ5QNipXXX2BU=;
        b=G7gQ+QubFvnwEd7Dsj+ZAans2ECIFqtd6+rK4GXDUI0R6K1PWji1a0laVGTosluStt
         f4ntNq1Mt6OdB/fW/c1LvQp9tnnhkvEqmgNYjeJJSi6tbIMcju3ilcD+naX4IFjA2xSg
         BgZ/s8jmbxDAHtETHQoDpyqNHIS70Gi+/h+q8rUJcUKBqXk7HsKngfO8Z/YR1en6+ns1
         sIow/NjMGlsyiiMi5z8w+dbZ9wvaEK88VAJ8P0WWeAljdZ2atJIrxhMUancyV2tl81+2
         3VQCECCoHjX+VZxKwLyuZDVs51+iIbI4EAP30HPkSit2Krr7z5bLEAGiC9jBTNeF03oG
         GMEA==
X-Gm-Message-State: AJcUukdixghKz/uHP+zVltsPfFSz96HPVaoFIdq9P88053J3wUyMjpQO
        ylHPQ0ySOwCa6I51xshQpAQAKg==
X-Google-Smtp-Source: ALg8bN5rMi9W8XlxnwP+m4dol26KacFQKQ6UEekDaZzYrzBBKvEIEDUAFkhKfTSusDTNsG6C4vVAGw==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr18054501pga.237.1545810847787;
        Tue, 25 Dec 2018 23:54:07 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 84sm107392395pfa.115.2018.12.25.23.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Dec 2018 23:54:07 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-remoteproc@vger.kernel.org (open list:REMOTE PROCESSOR
        (REMOTEPROC) SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support)
Subject: [RFC,3/5] remoteproc: move IPI interface into separate file.
Date:   Wed, 26 Dec 2018 15:53:11 +0800
Message-Id: <20181226075330.82462-4-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181226075330.82462-1-pihsun@chromium.org>
References: <20181226075330.82462-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the IPI interface into a separate file mtk_scp_ipi.c, so the things
that use the interface only can depend on the module only.

Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
---
 drivers/remoteproc/Makefile      |   2 +-
 drivers/remoteproc/mtk_common.h  |  73 +++++++++++++++
 drivers/remoteproc/mtk_scp.c     | 153 +------------------------------
 drivers/remoteproc/mtk_scp_ipi.c | 109 ++++++++++++++++++++++
 4 files changed, 184 insertions(+), 153 deletions(-)
 create mode 100644 drivers/remoteproc/mtk_common.h
 create mode 100644 drivers/remoteproc/mtk_scp_ipi.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 98e3498dbbe0e..16b3e5e7a81c8 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,7 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
-obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o
+obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
new file mode 100644
index 0000000000000..ae55fca2ce2d7
--- /dev/null
+++ b/drivers/remoteproc/mtk_common.h
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+
+#ifndef __RPROC_MTK_COMMON_H
+#define __RPROC_MTK_COMMON_H
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#define MT8183_SW_RSTN			0x0
+#define MT8183_SW_RSTN_BIT		BIT(0)
+#define MT8183_SCP_TO_HOST		0x1C
+#define MT8183_SCP_IPC_INT_BIT		BIT(0)
+#define MT8183_SCP_WDT_INT_BIT		BIT(8)
+#define MT8183_HOST_TO_SCP		0x28
+#define MT8183_HOST_IPC_INT_BIT		BIT(0)
+#define MT8183_SCP_SRAM_PDN		0x402C
+
+#define SCP_FW_VER_LEN		32
+
+struct scp_run {
+	u32 signaled;
+	s8 fw_ver[SCP_FW_VER_LEN];
+	u32 dec_capability;
+	u32 enc_capability;
+	wait_queue_head_t wq;
+};
+
+struct scp_ipi_desc {
+	ipi_handler_t handler;
+	const char *name;
+	void *priv;
+};
+
+struct mtk_scp {
+	struct device *dev;
+	struct rproc *rproc;
+	struct clk *clk;
+	void __iomem *reg_base;
+	void __iomem *sram_base;
+	size_t sram_size;
+
+	struct share_obj *recv_buf;
+	struct share_obj *send_buf;
+	struct scp_run run;
+	struct mutex scp_mutex; /* for protecting mtk_scp data structure */
+	struct scp_ipi_desc ipi_desc[IPI_MAX];
+	bool ipi_id_ack[IPI_MAX];
+	wait_queue_head_t ack_wq;
+
+	void __iomem *cpu_addr;
+	phys_addr_t phys_addr;
+	size_t dram_size;
+};
+
+/**
+ * struct share_obj - SRAM buffer shared with
+ *		      AP and SCP
+ *
+ * @id:		IPI id
+ * @len:	share buffer length
+ * @share_buf:	share buffer data
+ */
+struct share_obj {
+	s32 id;
+	u32 len;
+	u8 share_buf[288];
+};
+
+#endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 7a1a8fe53b54a..aaebe96bcfd66 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -14,163 +14,12 @@
 #include <linux/remoteproc.h>
 
 #include "remoteproc_internal.h"
-
-#define MT8183_SW_RSTN			0x0
-#define MT8183_SW_RSTN_BIT		BIT(0)
-#define MT8183_SCP_TO_HOST		0x1C
-#define MT8183_SCP_IPC_INT_BIT		BIT(0)
-#define MT8183_SCP_WDT_INT_BIT		BIT(8)
-#define MT8183_HOST_TO_SCP		0x28
-#define MT8183_HOST_IPC_INT_BIT		BIT(0)
-#define MT8183_SCP_SRAM_PDN		0x402C
+#include "mtk_common.h"
 
 #define INIT_TIMEOUT_MS		2000
-#define IPI_TIMEOUT_MS		2000
-#define SCP_FW_VER_LEN		32
 
 #define MAX_CODE_SIZE 0x500000
 
-struct scp_run {
-	u32 signaled;
-	s8 fw_ver[SCP_FW_VER_LEN];
-	u32 dec_capability;
-	u32 enc_capability;
-	wait_queue_head_t wq;
-};
-
-struct scp_ipi_desc {
-	ipi_handler_t handler;
-	const char *name;
-	void *priv;
-};
-
-struct mtk_scp {
-	struct device *dev;
-	struct rproc *rproc;
-	struct clk *clk;
-	void __iomem *reg_base;
-	void __iomem *sram_base;
-	size_t sram_size;
-
-	struct share_obj *recv_buf;
-	struct share_obj *send_buf;
-	struct scp_run run;
-	struct mutex scp_mutex; /* for protecting mtk_scp data structure */
-	struct scp_ipi_desc ipi_desc[IPI_MAX];
-	bool ipi_id_ack[IPI_MAX];
-	wait_queue_head_t ack_wq;
-
-	void __iomem *cpu_addr;
-	phys_addr_t phys_addr;
-	size_t dram_size;
-};
-
-/**
- * struct share_obj - SRAM buffer shared with
- *		      AP and SCP
- *
- * @id:		IPI id
- * @len:	share buffer length
- * @share_buf:	share buffer data
- */
-struct share_obj {
-	s32 id;
-	u32 len;
-	u8 share_buf[288];
-};
-
-int scp_ipi_register(struct platform_device *pdev,
-		     enum ipi_id id,
-		     ipi_handler_t handler,
-		     const char *name,
-		     void *priv)
-{
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	struct scp_ipi_desc *ipi_desc;
-
-	if (!scp) {
-		dev_err(&pdev->dev, "scp device is not ready\n");
-		return -EPROBE_DEFER;
-	}
-
-	if (WARN(id < 0 ||  id >= IPI_MAX || handler == NULL,
-	    "register scp ipi id %d with invalid arguments\n", id))
-		return -EINVAL;
-
-	ipi_desc = scp->ipi_desc;
-	ipi_desc[id].name = name;
-	ipi_desc[id].handler = handler;
-	ipi_desc[id].priv = priv;
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(scp_ipi_register);
-
-int scp_ipi_send(struct platform_device *pdev,
-		 enum ipi_id id, void *buf,
-		 unsigned int len,
-		 unsigned int wait)
-{
-	struct mtk_scp *scp = platform_get_drvdata(pdev);
-	struct share_obj *send_obj = scp->send_buf;
-	unsigned long timeout;
-	int ret;
-
-	if (WARN(id <= IPI_SCP_INIT || id >= IPI_MAX ||
-	    len > sizeof(send_obj->share_buf) || !buf,
-	    "failed to send ipi message\n"))
-		return -EINVAL;
-
-	ret = clk_prepare_enable(scp->clk);
-	if (ret) {
-		dev_err(scp->dev, "failed to enable clock\n");
-		return ret;
-	}
-
-	mutex_lock(&scp->scp_mutex);
-
-	 /* Wait until SCP receives the last command */
-	timeout = jiffies + msecs_to_jiffies(IPI_TIMEOUT_MS);
-	do {
-		if (time_after(jiffies, timeout)) {
-			dev_err(scp->dev, "scp_ipi_send: IPI timeout!\n");
-			ret = -EIO;
-			mutex_unlock(&scp->scp_mutex);
-			goto clock_disable;
-		}
-	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
-
-	memcpy(send_obj->share_buf, buf, len);
-	send_obj->len = len;
-	send_obj->id = id;
-
-	scp->ipi_id_ack[id] = false;
-	/* send the command to SCP */
-	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
-
-	mutex_unlock(&scp->scp_mutex);
-
-	if (wait) {
-		/* wait for SCP's ACK */
-		timeout = msecs_to_jiffies(wait);
-		ret = wait_event_timeout(scp->ack_wq,
-					 scp->ipi_id_ack[id],
-					 timeout);
-		scp->ipi_id_ack[id] = false;
-		if (WARN(!ret,
-			 "scp ipi %d ack time out !", id))
-			ret = -EIO;
-		else
-			ret = 0;
-	}
-
-clock_disable:
-	clk_disable_unprepare(scp->clk);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(scp_ipi_send);
-
 struct platform_device *scp_get_plat_device(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
diff --git a/drivers/remoteproc/mtk_scp_ipi.c b/drivers/remoteproc/mtk_scp_ipi.c
new file mode 100644
index 0000000000000..6923066869874
--- /dev/null
+++ b/drivers/remoteproc/mtk_scp_ipi.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/mtk_scp.h>
+#include <linux/platform_device.h>
+
+#include "mtk_common.h"
+
+#define IPI_TIMEOUT_MS		2000
+
+int scp_ipi_register(struct platform_device *pdev,
+		     enum ipi_id id,
+		     ipi_handler_t handler,
+		     const char *name,
+		     void *priv)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct scp_ipi_desc *ipi_desc;
+
+	if (!scp) {
+		dev_err(&pdev->dev, "scp device is not ready\n");
+		return -EPROBE_DEFER;
+	}
+
+	if (WARN(id < 0 || id >= IPI_MAX || handler == NULL,
+	    "register scp ipi id %d with invalid arguments\n", id))
+		return -EINVAL;
+
+	ipi_desc = scp->ipi_desc;
+	ipi_desc[id].name = name;
+	ipi_desc[id].handler = handler;
+	ipi_desc[id].priv = priv;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(scp_ipi_register);
+
+int scp_ipi_send(struct platform_device *pdev,
+		 enum ipi_id id, void *buf,
+		 unsigned int len,
+		 unsigned int wait)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct share_obj *send_obj = scp->send_buf;
+	unsigned long timeout;
+	int ret;
+
+	if (WARN(id <= IPI_SCP_INIT || id >= IPI_MAX ||
+	    len > sizeof(send_obj->share_buf) || !buf,
+	    "failed to send ipi message\n"))
+		return -EINVAL;
+
+	ret = clk_prepare_enable(scp->clk);
+	if (ret) {
+		dev_err(scp->dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	mutex_lock(&scp->scp_mutex);
+
+	 /* Wait until SCP receives the last command */
+	timeout = jiffies + msecs_to_jiffies(IPI_TIMEOUT_MS);
+	do {
+		if (time_after(jiffies, timeout)) {
+			dev_err(scp->dev, "scp_ipi_send: IPI timeout!\n");
+			ret = -EIO;
+			mutex_unlock(&scp->scp_mutex);
+			goto clock_disable;
+		}
+	} while (readl(scp->reg_base + MT8183_HOST_TO_SCP));
+
+	memcpy(send_obj->share_buf, buf, len);
+	send_obj->len = len;
+	send_obj->id = id;
+
+	scp->ipi_id_ack[id] = false;
+	/* send the command to SCP */
+	writel(MT8183_HOST_IPC_INT_BIT, scp->reg_base + MT8183_HOST_TO_SCP);
+
+	mutex_unlock(&scp->scp_mutex);
+
+	if (wait) {
+		/* wait for SCP's ACK */
+		timeout = msecs_to_jiffies(wait);
+		ret = wait_event_timeout(scp->ack_wq,
+					 scp->ipi_id_ack[id],
+					 timeout);
+		scp->ipi_id_ack[id] = false;
+		if (WARN(!ret,
+			 "scp ipi %d ack time out !", id))
+			ret = -EIO;
+		else
+			ret = 0;
+	}
+
+clock_disable:
+	clk_disable_unprepare(scp->clk);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(scp_ipi_send);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek scp IPI interface");
-- 
2.20.1.415.g653613c723-goog

