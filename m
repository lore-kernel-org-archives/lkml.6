Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934988AbeE2OVF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:21:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45024 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeE2OU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:20:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45C2C60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: architt@codeaurora.org, robdclark@gmail.com, jcrouse@codeaurora.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 2/3] drm/msm/dsi: add implementation for helper functions
Date: Tue, 29 May 2018 19:50:32 +0530
Message-Id: <20180529142033.12989-3-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529142033.12989-1-sibis@codeaurora.org>
References: <20180529142033.12989-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsi host helper function implementation for DSI v2
DSI 6G 1.x and DSI 6G v2.0+ controllers

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h      |  15 ++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  |  56 ++++++--
 drivers/gpu/drm/msm/dsi/dsi_host.c | 218 ++++++++++++++++++++++++++++-
 3 files changed, 278 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 80be83e8fdec..dfa049d876bd 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -183,6 +183,21 @@ int msm_dsi_host_modeset_init(struct mipi_dsi_host *host,
 int msm_dsi_host_init(struct msm_dsi *msm_dsi);
 int msm_dsi_runtime_suspend(struct device *dev);
 int msm_dsi_runtime_resume(struct device *dev);
+int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host);
+int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host);
+void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host);
+void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host);
+int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size);
+int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size);
+void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host);
+void *dsi_tx_buf_get_v2(struct msm_dsi_host *msm_host);
+void dsi_tx_buf_put_6g(struct msm_dsi_host *msm_host);
+int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *iova);
+int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *iova);
+int dsi_clk_init_v2(struct msm_dsi_host *msm_host);
+int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host);
+int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host);
+int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host);
 
 /* dsi phy */
 struct msm_dsi_phy;
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
index 0327bb54b01b..dcdfb1bb54f9 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
@@ -136,20 +136,58 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
 	.num_dsi = 2,
 };
 
+const static struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
+	.link_clk_enable = dsi_link_clk_enable_v2,
+	.link_clk_disable = dsi_link_clk_disable_v2,
+	.clk_init_ver = dsi_clk_init_v2,
+	.tx_buf_alloc = dsi_tx_buf_alloc_v2,
+	.tx_buf_get = dsi_tx_buf_get_v2,
+	.tx_buf_put = NULL,
+	.dma_base_get = dsi_dma_base_get_v2,
+	.calc_clk_rate = dsi_calc_clk_rate_v2,
+};
+
+const static struct msm_dsi_host_cfg_ops msm_dsi_6g_host_ops = {
+	.link_clk_enable = dsi_link_clk_enable_6g,
+	.link_clk_disable = dsi_link_clk_disable_6g,
+	.clk_init_ver = NULL,
+	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
+	.tx_buf_get = dsi_tx_buf_get_6g,
+	.tx_buf_put = dsi_tx_buf_put_6g,
+	.dma_base_get = dsi_dma_base_get_6g,
+	.calc_clk_rate = dsi_calc_clk_rate_6g,
+};
+
+const static struct msm_dsi_host_cfg_ops msm_dsi_6g_v2_host_ops = {
+	.link_clk_enable = dsi_link_clk_enable_6g,
+	.link_clk_disable = dsi_link_clk_disable_6g,
+	.clk_init_ver = dsi_clk_init_6g_v2,
+	.tx_buf_alloc = dsi_tx_buf_alloc_6g,
+	.tx_buf_get = dsi_tx_buf_get_6g,
+	.tx_buf_put = dsi_tx_buf_put_6g,
+	.dma_base_get = dsi_dma_base_get_6g,
+	.calc_clk_rate = dsi_calc_clk_rate_6g,
+};
+
 static const struct msm_dsi_cfg_handler dsi_cfg_handlers[] = {
-	{MSM_DSI_VER_MAJOR_V2, MSM_DSI_V2_VER_MINOR_8064, &apq8064_dsi_cfg},
+	{MSM_DSI_VER_MAJOR_V2, MSM_DSI_V2_VER_MINOR_8064,
+		&apq8064_dsi_cfg, &msm_dsi_v2_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_0,
-						&msm8974_apq8084_dsi_cfg},
+		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_1,
-						&msm8974_apq8084_dsi_cfg},
+		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_1_1,
-						&msm8974_apq8084_dsi_cfg},
+		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
 	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_2,
-						&msm8974_apq8084_dsi_cfg},
-	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_3, &msm8994_dsi_cfg},
-	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_3_1, &msm8916_dsi_cfg},
-	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_4_1, &msm8996_dsi_cfg},
-	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_1, &sdm845_dsi_cfg},
+		&msm8974_apq8084_dsi_cfg, &msm_dsi_6g_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_3,
+		&msm8994_dsi_cfg, &msm_dsi_6g_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_3_1,
+		&msm8916_dsi_cfg, &msm_dsi_6g_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V1_4_1,
+		&msm8996_dsi_cfg, &msm_dsi_6g_host_ops},
+	{MSM_DSI_VER_MAJOR_6G, MSM_DSI_6G_VER_MINOR_V2_2_1,
+		&sdm845_dsi_cfg, &msm_dsi_6g_v2_host_ops},
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index b916f464f4ec..1f42c891142f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -332,6 +332,54 @@ static int dsi_regulator_init(struct msm_dsi_host *msm_host)
 	return 0;
 }
 
+int dsi_clk_init_v2(struct msm_dsi_host *msm_host)
+{
+	struct platform_device *pdev = msm_host->pdev;
+	int ret = 0;
+
+	msm_host->src_clk = msm_clk_get(pdev, "src");
+
+	if (IS_ERR(msm_host->src_clk)) {
+		ret = PTR_ERR(msm_host->src_clk);
+		pr_err("%s: can't find src clock. ret=%d\n",
+			__func__, ret);
+		msm_host->src_clk = NULL;
+		return ret;
+	}
+
+	msm_host->esc_clk_src = clk_get_parent(msm_host->esc_clk);
+	if (!msm_host->esc_clk_src) {
+		ret = -ENODEV;
+		pr_err("%s: can't get esc clock parent. ret=%d\n",
+			__func__, ret);
+		return ret;
+	}
+
+	msm_host->dsi_clk_src = clk_get_parent(msm_host->src_clk);
+	if (!msm_host->dsi_clk_src) {
+		ret = -ENODEV;
+		pr_err("%s: can't get src clock parent. ret=%d\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+
+int dsi_clk_init_6g_v2(struct msm_dsi_host *msm_host)
+{
+	struct platform_device *pdev = msm_host->pdev;
+	int ret = 0;
+
+	msm_host->byte_intf_clk = msm_clk_get(pdev, "byte_intf");
+	if (IS_ERR(msm_host->byte_intf_clk)) {
+		ret = PTR_ERR(msm_host->byte_intf_clk);
+		pr_err("%s: can't find byte_intf clock. ret=%d\n",
+			__func__, ret);
+	}
+
+	return ret;
+}
+
 static int dsi_clk_init(struct msm_dsi_host *msm_host)
 {
 	struct platform_device *pdev = msm_host->pdev;
@@ -498,7 +546,7 @@ int msm_dsi_runtime_resume(struct device *dev)
 	return dsi_bus_clk_enable(msm_host);
 }
 
-static int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
+int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
@@ -566,7 +614,7 @@ static int dsi_link_clk_enable_6g(struct msm_dsi_host *msm_host)
 	return ret;
 }
 
-static int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
+int dsi_link_clk_enable_v2(struct msm_dsi_host *msm_host)
 {
 	int ret;
 
@@ -644,6 +692,23 @@ static int dsi_link_clk_enable(struct msm_dsi_host *msm_host)
 		return dsi_link_clk_enable_v2(msm_host);
 }
 
+void dsi_link_clk_disable_6g(struct msm_dsi_host *msm_host)
+{
+	clk_disable_unprepare(msm_host->esc_clk);
+	clk_disable_unprepare(msm_host->pixel_clk);
+	if (msm_host->byte_intf_clk)
+		clk_disable_unprepare(msm_host->byte_intf_clk);
+	clk_disable_unprepare(msm_host->byte_clk);
+}
+
+void dsi_link_clk_disable_v2(struct msm_dsi_host *msm_host)
+{
+	clk_disable_unprepare(msm_host->pixel_clk);
+	clk_disable_unprepare(msm_host->src_clk);
+	clk_disable_unprepare(msm_host->esc_clk);
+	clk_disable_unprepare(msm_host->byte_clk);
+}
+
 static void dsi_link_clk_disable(struct msm_dsi_host *msm_host)
 {
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
@@ -662,6 +727,84 @@ static void dsi_link_clk_disable(struct msm_dsi_host *msm_host)
 	}
 }
 
+int dsi_calc_clk_rate_6g(struct msm_dsi_host *msm_host)
+{
+	struct drm_display_mode *mode = msm_host->mode;
+	u8 lanes = msm_host->lanes;
+	u32 bpp = dsi_get_bpp(msm_host->format);
+	u32 pclk_rate;
+
+	pclk_rate = mode->clock * 1000;
+	if (lanes > 0) {
+		msm_host->byte_clk_rate = (pclk_rate * bpp) / (8 * lanes);
+	} else {
+		pr_err("%s: forcing mdss_dsi lanes to 1\n", __func__);
+		msm_host->byte_clk_rate = (pclk_rate * bpp) / 8;
+	}
+
+	DBG("pclk=%d, bclk=%d", pclk_rate, msm_host->byte_clk_rate);
+
+	msm_host->esc_clk_rate = clk_get_rate(msm_host->esc_clk);
+
+	return 0;
+}
+
+int dsi_calc_clk_rate_v2(struct msm_dsi_host *msm_host)
+{
+	struct drm_display_mode *mode = msm_host->mode;
+	u8 lanes = msm_host->lanes;
+	u32 bpp = dsi_get_bpp(msm_host->format);
+	u32 pclk_rate;
+	unsigned int esc_mhz, esc_div;
+	unsigned long byte_mhz;
+
+	pclk_rate = mode->clock * 1000;
+	if (lanes > 0) {
+		msm_host->byte_clk_rate = (pclk_rate * bpp) / (8 * lanes);
+	} else {
+		pr_err("%s: forcing mdss_dsi lanes to 1\n", __func__);
+		msm_host->byte_clk_rate = (pclk_rate * bpp) / 8;
+	}
+
+	DBG("pclk=%d, bclk=%d", pclk_rate, msm_host->byte_clk_rate);
+
+	msm_host->src_clk_rate = (pclk_rate * bpp) / 8;
+
+	/*
+	 * esc clock is byte clock followed by a 4 bit divider,
+	 * we need to find an escape clock frequency within the
+	 * mipi DSI spec range within the maximum divider limit
+	 * We iterate here between an escape clock frequencey
+	 * between 20 Mhz to 5 Mhz and pick up the first one
+	 * that can be supported by our divider
+	 */
+
+	byte_mhz = msm_host->byte_clk_rate / 1000000;
+
+	for (esc_mhz = 20; esc_mhz >= 5; esc_mhz--) {
+		esc_div = DIV_ROUND_UP(byte_mhz, esc_mhz);
+
+		/*
+		 * TODO: Ideally, we shouldn't know what sort of divider
+		 * is available in mmss_cc, we're just assuming that
+		 * it'll always be a 4 bit divider. Need to come up with
+		 * a better way here.
+		 */
+		if (esc_div >= 1 && esc_div <= 16)
+			break;
+	}
+
+	if (esc_mhz < 5)
+		return -EINVAL;
+
+	msm_host->esc_clk_rate = msm_host->byte_clk_rate / esc_div;
+
+	DBG("esc=%d, src=%d", msm_host->esc_clk_rate,
+		msm_host->src_clk_rate);
+
+	return 0;
+}
+
 static int dsi_calc_clk_rate(struct msm_dsi_host *msm_host)
 {
 	struct drm_display_mode *mode = msm_host->mode;
@@ -1015,6 +1158,41 @@ static void dsi_wait4video_eng_busy(struct msm_dsi_host *msm_host)
 	}
 }
 
+int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
+{
+	struct drm_device *dev = msm_host->dev;
+	struct msm_drm_private *priv = dev->dev_private;
+	uint64_t iova;
+	u8 *data;
+
+	data = msm_gem_kernel_new(dev, size, MSM_BO_UNCACHED,
+					priv->kms->aspace,
+					&msm_host->tx_gem_obj, &iova);
+
+	if (IS_ERR(data)) {
+		msm_host->tx_gem_obj = NULL;
+		return PTR_ERR(data);
+	}
+
+	msm_host->tx_size = msm_host->tx_gem_obj->size;
+
+	return 0;
+}
+
+int dsi_tx_buf_alloc_v2(struct msm_dsi_host *msm_host, int size)
+{
+	struct drm_device *dev = msm_host->dev;
+
+	msm_host->tx_buf = dma_alloc_coherent(dev->dev, size,
+					&msm_host->tx_buf_paddr, GFP_KERNEL);
+	if (!msm_host->tx_buf)
+		return -ENOMEM;
+
+	msm_host->tx_size = size;
+
+	return 0;
+}
+
 /* dsi_cmd */
 static int dsi_tx_buf_alloc(struct msm_dsi_host *msm_host, int size)
 {
@@ -1079,6 +1257,21 @@ static void dsi_tx_buf_free(struct msm_dsi_host *msm_host)
 			msm_host->tx_buf_paddr);
 }
 
+void *dsi_tx_buf_get_6g(struct msm_dsi_host *msm_host)
+{
+	return msm_gem_get_vaddr(msm_host->tx_gem_obj);
+}
+
+void *dsi_tx_buf_get_v2(struct msm_dsi_host *msm_host)
+{
+	return msm_host->tx_buf;
+}
+
+void dsi_tx_buf_put_6g(struct msm_dsi_host *msm_host)
+{
+	msm_gem_put_vaddr(msm_host->tx_gem_obj);
+}
+
 /*
  * prepare cmd buffer to be txed
  */
@@ -1180,6 +1373,27 @@ static int dsi_long_read_resp(u8 *buf, const struct mipi_dsi_msg *msg)
 	return msg->rx_len;
 }
 
+int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *dma_base)
+{
+	struct drm_device *dev = msm_host->dev;
+	struct msm_drm_private *priv = dev->dev_private;
+
+	if (!dma_base)
+		return -EINVAL;
+
+	return msm_gem_get_iova(msm_host->tx_gem_obj,
+				priv->kms->aspace, dma_base);
+}
+
+int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *dma_base)
+{
+	if (!dma_base)
+		return -EINVAL;
+
+	*dma_base = msm_host->tx_buf_paddr;
+	return 0;
+}
+
 static int dsi_cmd_dma_tx(struct msm_dsi_host *msm_host, int len)
 {
 	const struct msm_dsi_cfg_handler *cfg_hnd = msm_host->cfg_hnd;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
