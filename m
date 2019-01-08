Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD662C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D72E2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d68FGu8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAHF00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:26:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39765 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfAHF0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:26:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so1335916pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 21:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFn/Y+47v0jJKJg7Gq5/S7izU51skALRwBbX7+OVooU=;
        b=d68FGu8nudeU2Pz1gN/IWTWnPNXtMCOQfjOhH33S0v9cykmsHDg0WWdLAf1zXU3w80
         kay0QW+cO66aNhabm8fcPKAkkDFFDrBPddJC88HfZMgmYRi0tlVFVJL/6k1B6QSpTUce
         XQCNAW/AHly9TvObBLUnK52YwqmtznQRXp0U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFn/Y+47v0jJKJg7Gq5/S7izU51skALRwBbX7+OVooU=;
        b=lCAKAqT6wlT4+Ujx+993Vfhl/3i5plazi0axu6AqEsizIaYYnuSBbGbo5y0LEqRfng
         g9ge34mAAi5OYK7GDZw3bq/WzmtLst8iCacN7VxlCGGxA59fgcSYtVqyLQPAQnkakWQ5
         luM1rZ//LP9Kd+w7gl2Q9negNAkFP+w8C0RjcQczJv1YFLSyTwOeqDGWQjh4aXhjarBt
         vWHN67pefu1JpdRR9/5pFiu28TPKvZpmuyaeTlZVWzaS2rUTNEOqc19KapYlxIJ8ppzh
         m4PFD/V+Dzlg4hC118JWXL+E/Msv62/EVAQu7/ZKi8AtAVKJySDimtrqKC8IYfejrCxy
         LP1A==
X-Gm-Message-State: AJcUukcCbuJ+wKGekRDE5AAFkgS1WCRWg6W7O3GJKFNKdTHOn51ag4sn
        Oc/7zJft4zPUgiejDKtyLRBfGQ==
X-Google-Smtp-Source: ALg8bN7UpVUmZ86x59OYTnXJge+QCWVOcG29mLAsfK1OlBumWVPGQ1GsEq+tw+jbH6aoQmUMia9Z7A==
X-Received: by 2002:a63:e950:: with SMTP id q16mr343555pgj.138.1546925184407;
        Mon, 07 Jan 2019 21:26:24 -0800 (PST)
Received: from pihsun-z840.tpe.corp.google.com ([2401:fa00:1:10:7889:7a43:f899:134c])
        by smtp.googlemail.com with ESMTPSA id 64sm88106874pff.101.2019.01.07.21.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 21:26:23 -0800 (PST)
From:   Pi-Hsun Shih <pihsun@chromium.org>
Cc:     Pi-Hsun Shih <pihsun@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Erin Lo <erin.lo@mediatek.com>,
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
Subject: [RFC v2 2/6] remoteproc/mediatek: add SCP support for mt8183
Date:   Tue,  8 Jan 2019 13:26:02 +0800
Message-Id: <20190108052606.59426-3-pihsun@chromium.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190108052606.59426-1-pihsun@chromium.org>
References: <20190108052606.59426-1-pihsun@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erin Lo <erin.lo@mediatek.com>

Provide a basic driver to control Cortex M4 co-processor

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
Changes from v1:
 - Extract functions and rename variables in mtk_scp.c.
---
 drivers/remoteproc/Kconfig            |   9 +
 drivers/remoteproc/Makefile           |   1 +
 drivers/remoteproc/mtk_scp.c          | 587 ++++++++++++++++++++++++++
 include/linux/platform_data/mtk_scp.h | 122 ++++++
 4 files changed, 719 insertions(+)
 create mode 100644 drivers/remoteproc/mtk_scp.c
 create mode 100644 include/linux/platform_data/mtk_scp.h

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index f0abd260804473..ee0bda23768938 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -22,6 +22,15 @@ config IMX_REMOTEPROC
 
 	  It's safe to say N here.
 
+config MTK_SCP
+        tristate "Mediatek SCP support"
+        depends on ARCH_MEDIATEK
+        help
+          Say y here to support Mediatek's SCP (Cortex M4
+          on MT8183) via the remote processor framework.
+
+          It's safe to say N here.
+
 config OMAP_REMOTEPROC
 	tristate "OMAP remoteproc support"
 	depends on ARCH_OMAP4 || SOC_OMAP5
diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index ce5d061e92be52..98e3498dbbe0e2 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -10,6 +10,7 @@ remoteproc-y				+= remoteproc_sysfs.o
 remoteproc-y				+= remoteproc_virtio.o
 remoteproc-y				+= remoteproc_elf_loader.o
 obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
+obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
new file mode 100644
index 00000000000000..6e2e17a227d018
--- /dev/null
+++ b/drivers/remoteproc/mtk_scp.c
@@ -0,0 +1,587 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2018 MediaTek Inc.
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_data/mtk_scp.h>
+#include <linux/platform_device.h>
+#include <linux/remoteproc.h>
+
+#include "remoteproc_internal.h"
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
+#define MAX_CODE_SIZE 0x500000
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
+	scp_ipi_handler_t handler;
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
+	struct scp_ipi_desc ipi_desc[SCP_IPI_MAX];
+	bool ipi_id_ack[SCP_IPI_MAX];
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
+int scp_ipi_register(struct platform_device *pdev,
+		     enum scp_ipi_id id,
+		     scp_ipi_handler_t handler,
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
+	if (WARN(id < 0 ||  id >= SCP_IPI_MAX || handler == NULL,
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
+		 enum scp_ipi_id id,
+		 void *buf,
+		 unsigned int len,
+		 unsigned int wait)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	struct share_obj *send_obj = scp->send_buf;
+	unsigned long timeout;
+	int ret;
+
+	if (WARN(id <= SCP_IPI_INIT || id >= SCP_IPI_MAX ||
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
+	timeout = jiffies + msecs_to_jiffies(2000);
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
+struct platform_device *scp_get_plat_device(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *scp_node;
+	struct platform_device *scp_pdev;
+
+	scp_node = of_parse_phandle(dev->of_node, "mediatek,scp", 0);
+	if (!scp_node) {
+		dev_err(dev, "can't get scp node\n");
+		return NULL;
+	}
+
+	scp_pdev = of_find_device_by_node(scp_node);
+	if (WARN_ON(!scp_pdev)) {
+		dev_err(dev, "scp pdev failed\n");
+		of_node_put(scp_node);
+		return NULL;
+	}
+
+	return scp_pdev;
+}
+EXPORT_SYMBOL_GPL(scp_get_plat_device);
+
+static void scp_wdt_handler(struct mtk_scp *scp)
+{
+	rproc_report_crash(scp->rproc, RPROC_WATCHDOG);
+}
+
+static void scp_init_ipi_handler(void *data, unsigned int len, void *priv)
+{
+	struct mtk_scp *scp = (struct mtk_scp *)priv;
+	struct scp_run *run = (struct scp_run *)data;
+
+	scp->run.signaled = run->signaled;
+	strncpy(scp->run.fw_ver, run->fw_ver, SCP_FW_VER_LEN);
+	scp->run.dec_capability = run->dec_capability;
+	scp->run.enc_capability = run->enc_capability;
+	wake_up_interruptible(&scp->run.wq);
+}
+
+static void scp_ipi_handler(struct mtk_scp *scp)
+{
+	struct share_obj *rcv_obj = scp->recv_buf;
+	struct scp_ipi_desc *ipi_desc = scp->ipi_desc;
+	u8 tmp_data[288];
+
+	if (rcv_obj->id < SCP_IPI_MAX && ipi_desc[rcv_obj->id].handler) {
+		memcpy_fromio(tmp_data, &rcv_obj->share_buf, rcv_obj->len);
+		ipi_desc[rcv_obj->id].handler(&tmp_data[0],
+					      rcv_obj->len,
+					      ipi_desc[rcv_obj->id].priv);
+		scp->ipi_id_ack[rcv_obj->id] = true;
+		wake_up(&scp->ack_wq);
+	} else {
+		dev_err(scp->dev, "No such ipi id = %d\n", rcv_obj->id);
+	}
+}
+
+static int scp_ipi_init(struct mtk_scp *scp)
+{
+	size_t send_offset = 0x800 - sizeof(struct share_obj);
+	size_t recv_offset = send_offset - sizeof(struct share_obj);
+
+	/* Disable SCP to host interrupt */
+	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
+
+	/* shared buffer initialization */
+	scp->recv_buf = (__force struct share_obj *)(scp->sram_base +
+						recv_offset);
+	scp->send_buf = (__force struct share_obj *)(scp->sram_base +
+						send_offset);
+	memset_io(scp->recv_buf, 0, sizeof(scp->recv_buf));
+	memset_io(scp->send_buf, 0, sizeof(scp->send_buf));
+
+	return 0;
+}
+
+static void mtk_scp_reset_assert(const struct mtk_scp *scp)
+{
+	u32 val;
+
+	val = readl(scp->reg_base + MT8183_SW_RSTN);
+	val &= ~MT8183_SW_RSTN_BIT;
+	writel(val, scp->reg_base + MT8183_SW_RSTN);
+}
+
+static void mtk_scp_reset_deassert(const struct mtk_scp *scp)
+{
+	u32 val;
+
+	val = readl(scp->reg_base + MT8183_SW_RSTN);
+	val |= MT8183_SW_RSTN_BIT;
+	writel(val, scp->reg_base + MT8183_SW_RSTN);
+}
+
+static irqreturn_t scp_irq_handler(int irq, void *priv)
+{
+	struct mtk_scp *scp = priv;
+	u32 scp_to_host;
+
+	scp_to_host = readl(scp->reg_base + MT8183_SCP_TO_HOST);
+	if (scp_to_host & MT8183_SCP_IPC_INT_BIT) {
+		scp_ipi_handler(scp);
+	} else {
+		dev_err(scp->dev, "scp watchdog timeout! 0x%x", scp_to_host);
+		scp_wdt_handler(scp);
+	}
+
+	/* SCP won't send another interrupt until we set SCP_TO_HOST to 0. */
+	writel(MT8183_SCP_IPC_INT_BIT | MT8183_SCP_WDT_INT_BIT,
+	       scp->reg_base + MT8183_SCP_TO_HOST);
+
+	return IRQ_HANDLED;
+}
+
+static int mtk_scp_load(struct rproc *rproc, const struct firmware *fw)
+{
+	const struct mtk_scp *scp = rproc->priv;
+	struct device *dev = scp->dev;
+	int ret;
+
+	/* Hold SCP in reset while loading FW. */
+	mtk_scp_reset_assert(scp);
+
+	ret = clk_prepare_enable(scp->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		return ret;
+	}
+
+	writel(0x0, scp->reg_base + MT8183_SCP_SRAM_PDN);
+
+	memcpy(scp->sram_base, fw->data, fw->size);
+	return ret;
+}
+
+static int mtk_scp_start(struct rproc *rproc)
+{
+	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+	struct device *dev = scp->dev;
+	struct scp_run *run;
+	int ret;
+
+	ret = clk_prepare_enable(scp->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		return ret;
+	}
+
+	mtk_scp_reset_deassert(scp);
+
+	run = &scp->run;
+
+	ret = wait_event_interruptible_timeout(
+					run->wq,
+					run->signaled,
+					msecs_to_jiffies(2000));
+
+	if (ret == 0) {
+		dev_err(dev, "wait scp initialization timeout!\n");
+		ret = -ETIME;
+		goto stop;
+	}
+	if (ret == -ERESTARTSYS) {
+		dev_err(dev, "wait scp interrupted by a signal!\n");
+		goto stop;
+	}
+	dev_info(dev, "scp is ready. Fw version %s\n", run->fw_ver);
+
+	return 0;
+
+stop:
+	mtk_scp_reset_assert(scp);
+	clk_disable_unprepare(scp->clk);
+	return ret;
+}
+
+static void *mtk_scp_da_to_va(struct rproc *rproc, u64 da, int len)
+{
+	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+	int offset;
+
+	if (da < scp->sram_size) {
+		offset = da;
+		if (offset >= 0 && ((offset + len) < scp->sram_size)) {
+			return (__force void *)(scp->sram_base + offset);
+		}
+	} else if (da >= scp->sram_size && da < (scp->sram_size + MAX_CODE_SIZE)) {
+		offset = da - scp->sram_size;
+		if (offset >= 0 && (offset + len) < MAX_CODE_SIZE) {
+			return scp->cpu_addr + offset;
+		}
+	} else {
+		offset = da - scp->phys_addr;
+		if (offset >= 0 && (offset + len) < (scp->dram_size - MAX_CODE_SIZE)) {
+			return scp->cpu_addr + offset;
+		}
+	}
+
+	return NULL;
+}
+
+static int mtk_scp_stop(struct rproc *rproc)
+{
+	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
+
+	mtk_scp_reset_assert(scp);
+	clk_disable_unprepare(scp->clk);
+
+	return 0;
+}
+
+static const struct rproc_ops mtk_scp_ops = {
+	.start		= mtk_scp_start,
+	.stop		= mtk_scp_stop,
+	.load		= mtk_scp_load,
+	.da_to_va	= mtk_scp_da_to_va,
+};
+
+unsigned int scp_get_vdec_hw_capa(struct platform_device *pdev)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+
+	return scp->run.dec_capability;
+}
+EXPORT_SYMBOL_GPL(scp_get_vdec_hw_capa);
+
+unsigned int scp_get_venc_hw_capa(struct platform_device *pdev)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+
+	return scp->run.enc_capability;
+}
+EXPORT_SYMBOL_GPL(scp_get_venc_hw_capa);
+
+void *scp_mapping_dm_addr(struct platform_device *pdev, u32 mem_addr)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+	void *ptr = NULL;
+
+	ptr = mtk_scp_da_to_va(scp->rproc, mem_addr, 0);
+
+	if (ptr)
+		return ptr;
+	else
+		return ERR_PTR(-EINVAL);
+}
+EXPORT_SYMBOL_GPL(scp_mapping_dm_addr);
+
+static int scp_map_memory_region(struct mtk_scp *scp)
+{
+	struct device_node *node;
+	struct resource r;
+	int ret;
+
+	node = of_parse_phandle(scp->dev->of_node, "memory-region", 0);
+	if (!node) {
+		dev_err(scp->dev, "no memory-region specified\n");
+		return -EINVAL;
+	}
+
+	ret = of_address_to_resource(node, 0, &r);
+	if (ret)
+		return ret;
+
+	scp->phys_addr = r.start;
+	scp->dram_size = resource_size(&r);
+	scp->cpu_addr = devm_ioremap_wc(scp->dev, scp->phys_addr, scp->dram_size);
+
+	if (!scp->cpu_addr) {
+		dev_err(scp->dev, "unable to map memory region: %pa+%zx\n",
+			&r.start, scp->dram_size);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int mtk_scp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct mtk_scp *scp;
+	struct rproc *rproc;
+	struct resource *res;
+	char *fw_name = "scp.img";
+	int ret;
+
+	rproc = rproc_alloc(dev,
+			    np->name,
+			    &mtk_scp_ops,
+			    fw_name,
+			    sizeof(*scp));
+	if (!rproc) {
+		dev_err(dev, "unable to allocate remoteproc\n");
+		return -ENOMEM;
+	}
+
+	scp = (struct mtk_scp *)rproc->priv;
+	scp->rproc = rproc;
+	scp->dev = dev;
+	platform_set_drvdata(pdev, scp);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
+	scp->sram_base = devm_ioremap_resource(dev, res);
+	scp->sram_size = resource_size(res);
+	if (IS_ERR((__force void *)scp->sram_base)) {
+		dev_err(dev, "Failed to parse and map sram memory\n");
+		ret = PTR_ERR((__force void *)scp->sram_base);
+		goto free_rproc;
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	scp->reg_base = devm_ioremap_resource(dev, res);
+	if (IS_ERR((__force void *)scp->reg_base)) {
+		dev_err(dev, "Failed to parse and map cfg memory\n");
+		ret = PTR_ERR((__force void *)scp->reg_base);
+		goto free_rproc;
+	}
+
+	ret = scp_map_memory_region(scp);
+	if (ret)
+		goto free_rproc;
+
+	scp->clk = devm_clk_get(dev, "main");
+	if (IS_ERR(scp->clk)) {
+		dev_err(dev, "Failed to get clock\n");
+		ret = PTR_ERR(scp->clk);
+		goto free_rproc;
+	}
+
+	ret = clk_prepare_enable(scp->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clocks\n");
+		goto free_rproc;
+	}
+
+	ret = scp_ipi_init(scp);
+	clk_disable_unprepare(scp->clk);
+	if (ret) {
+		dev_err(dev, "Failed to init ipi\n");
+		goto free_rproc;
+	}
+
+	/* register scp initialization IPI */
+	ret = scp_ipi_register(pdev,
+			       SCP_IPI_INIT,
+			       scp_init_ipi_handler,
+			       "scp_init",
+			       scp);
+	if (ret) {
+		dev_err(dev, "Failed to register IPI_SCP_INIT\n");
+		goto free_rproc;
+	}
+
+	ret = devm_request_irq(dev,
+			       platform_get_irq(pdev, 0),
+			       scp_irq_handler,
+			       0,
+			       pdev->name,
+			       scp);
+
+	if (ret) {
+		dev_err(dev, "failed to request irq\n");
+		goto free_rproc;
+	}
+
+	mutex_init(&scp->scp_mutex);
+
+	init_waitqueue_head(&scp->run.wq);
+	init_waitqueue_head(&scp->ack_wq);
+
+	ret = rproc_add(rproc);
+	if (ret)
+		goto destroy_mutex;
+
+	return ret;
+
+destroy_mutex:
+	mutex_destroy(&scp->scp_mutex);
+free_rproc:
+	rproc_free(rproc);
+
+	return ret;
+}
+
+static int mtk_scp_remove(struct platform_device *pdev)
+{
+	struct mtk_scp *scp = platform_get_drvdata(pdev);
+
+	rproc_del(scp->rproc);
+	rproc_free(scp->rproc);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_scp_of_match[] = {
+	{ .compatible = "mediatek,mt8183-scp"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mtk_scp_of_match);
+
+static struct platform_driver mtk_scp_driver = {
+	.probe = mtk_scp_probe,
+	.remove = mtk_scp_remove,
+	.driver = {
+		.name = "mtk-scp",
+		.of_match_table = of_match_ptr(mtk_scp_of_match),
+	},
+};
+
+module_platform_driver(mtk_scp_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("MediaTek scp control driver");
diff --git a/include/linux/platform_data/mtk_scp.h b/include/linux/platform_data/mtk_scp.h
new file mode 100644
index 00000000000000..23df7453eeacd0
--- /dev/null
+++ b/include/linux/platform_data/mtk_scp.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ */
+
+#ifndef _MTK_SCP_H
+#define _MTK_SCP_H
+
+#include <linux/platform_device.h>
+
+typedef void (*scp_ipi_handler_t) (void *data,
+				   unsigned int len,
+				   void *priv);
+
+/**
+ * enum ipi_id - the id of inter-processor interrupt
+ *
+ * @SCP_IPI_INIT:	 The interrupt from scp is to notfiy kernel
+ *			 SCP initialization completed.
+ *			 IPI_SCP_INIT is sent from SCP when firmware is
+ *			 loaded. AP doesn't need to send IPI_SCP_INIT
+ *			 command to SCP.
+ *			 For other IPI below, AP should send the request
+ *			 to SCP to trigger the interrupt.
+ * @IPI_MAX:		 The maximum IPI number
+ */
+
+enum scp_ipi_id {
+	SCP_IPI_INIT = 0,
+	SCP_IPI_CROS_HOST_CMD,
+	SCP_IPI_MDP,
+	SCP_IPI_MAX,
+};
+
+/**
+ * scp_ipi_register - register an ipi function
+ *
+ * @pdev:	SCP platform device
+ * @id:		IPI ID
+ * @handler:	IPI handler
+ * @name:	IPI name
+ * @priv:	private data for IPI handler
+ *
+ * Register an ipi function to receive ipi interrupt from SCP.
+ *
+ * Return: Return 0 if ipi registers successfully, otherwise it is failed.
+ */
+int scp_ipi_register(struct platform_device *pdev,
+		     enum scp_ipi_id id,
+		     scp_ipi_handler_t handler,
+		     const char *name,
+		     void *priv);
+
+/**
+ * scp_ipi_send - send data from AP to scp.
+ *
+ * @pdev:	SCP platform device
+ * @id:		IPI ID
+ * @buf:	the data buffer
+ * @len:	the data buffer length
+ * @wait:	1: need ack
+ *
+ * This function is thread-safe. When this function returns,
+ * SCP has received the data and starts the processing.
+ * When the processing completes, IPI handler registered
+ * by scp_ipi_register will be called in interrupt context.
+ *
+ * Return: Return 0 if sending data successfully, otherwise it is failed.
+ **/
+int scp_ipi_send(struct platform_device *pdev,
+		 enum scp_ipi_id id,
+		 void *buf,
+		 unsigned int len,
+		 unsigned int wait);
+
+/**
+ * scp_get_plat_device - get SCP's platform device
+ *
+ * @pdev:	the platform device of the module requesting SCP platform
+ *		device for using SCP API.
+ *
+ * Return: Return NULL if it is failed.
+ * otherwise it is SCP's platform device
+ **/
+struct platform_device *scp_get_plat_device(struct platform_device *pdev);
+
+/**
+ * scp_get_vdec_hw_capa - get video decoder hardware capability
+ *
+ * @pdev:	SCP platform device
+ *
+ * Return: video decoder hardware capability
+ **/
+unsigned int scp_get_vdec_hw_capa(struct platform_device *pdev);
+
+/**
+ * scp_get_venc_hw_capa - get video encoder hardware capability
+ *
+ * @pdev:	SCP platform device
+ *
+ * Return: video encoder hardware capability
+ **/
+unsigned int scp_get_venc_hw_capa(struct platform_device *pdev);
+
+/**
+ * scp_mapping_dm_addr - Mapping SRAM/DRAM to kernel virtual address
+ *
+ * @pdev:	SCP platform device
+ * @mem_addr:	SCP views memory address
+ *
+ * Mapping the SCP's SRAM address /
+ * DMEM (Data Extended Memory) memory address /
+ * Working buffer memory address to
+ * kernel virtual address.
+ *
+ * Return: Return ERR_PTR(-EINVAL) if mapping failed,
+ * otherwise the mapped kernel virtual address
+ **/
+void *scp_mapping_dm_addr(struct platform_device *pdev,
+			  u32 mem_addr);
+
+#endif /* _MTK_SCP_H */
-- 
2.20.1.97.g81188d93c3-goog

