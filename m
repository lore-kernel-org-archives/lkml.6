Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934961AbeE2OU5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:20:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934924AbeE2OUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:20:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1ADAC60261
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: architt@codeaurora.org, robdclark@gmail.com, jcrouse@codeaurora.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 1/3] drm/msm/dsi: add dsi host helper functions support
Date: Tue, 29 May 2018 19:50:31 +0530
Message-Id: <20180529142033.12989-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529142033.12989-1-sibis@codeaurora.org>
References: <20180529142033.12989-1-sibis@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dsi host helper functions support for DSI v2 and DSI 6G 1.x
controllers that are under version checks

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 drivers/gpu/drm/msm/dsi/dsi.h     |  1 +
 drivers/gpu/drm/msm/dsi/dsi_cfg.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 70d9a9a47acd..80be83e8fdec 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -149,6 +149,7 @@ static inline int msm_dsi_pll_set_usecase(struct msm_dsi_pll *pll,
 #endif
 
 /* dsi host */
+struct msm_dsi_host;
 int msm_dsi_host_xfer_prepare(struct mipi_dsi_host *host,
 					const struct mipi_dsi_msg *msg);
 void msm_dsi_host_xfer_restore(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.h b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
index 9cfdcf1c95d5..a795a062b779 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_cfg.h
+++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.h
@@ -40,10 +40,22 @@ struct msm_dsi_config {
 	const int num_dsi;
 };
 
+struct msm_dsi_host_cfg_ops {
+	int (*link_clk_enable)(struct msm_dsi_host *msm_host);
+	void (*link_clk_disable)(struct msm_dsi_host *msm_host);
+	int (*clk_init_ver)(struct msm_dsi_host *msm_host);
+	int (*tx_buf_alloc)(struct msm_dsi_host *msm_host, int size);
+	void* (*tx_buf_get)(struct msm_dsi_host *msm_host);
+	void (*tx_buf_put)(struct msm_dsi_host *msm_host);
+	int (*dma_base_get)(struct msm_dsi_host *msm_host, uint64_t *iova);
+	int (*calc_clk_rate)(struct msm_dsi_host *msm_host);
+};
+
 struct msm_dsi_cfg_handler {
 	u32 major;
 	u32 minor;
 	const struct msm_dsi_config *cfg;
+	const struct msm_dsi_host_cfg_ops *ops;
 };
 
 const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
