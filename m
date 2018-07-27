Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79C020857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 01:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="cU8RkSE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B79C020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbeG0CeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 22:34:25 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:54124 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731924AbeG0CeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 22:34:25 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id w6R1EE5L016228;
        Fri, 27 Jul 2018 10:14:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com w6R1EE5L016228
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1532654055;
        bh=2H+nobouSE4XXEuL2Mtb5sevx/LzGfBfNRcc/TcAn2Y=;
        h=From:To:Cc:Subject:Date:From;
        b=cU8RkSE6MZYeExmV0B9R+T7jUIVG98xaHh+6Cm6COK6l1eWkSrSdQkw6ifTazEWlg
         N6j8ey7SRhgjGLXpBpVA1KpJsUlb8vMx/GVC0OeQCw3TiEi6qzHWOzpbtU3yW9c6dg
         29oqN/dAc9ft5hJ1mvJpbYg3PZ0CPbu0HPlInO8PaB5UazNFcrZrPqUkUsiv2/eNHm
         4ritTZR8tWqmWLvIuwmLgfW8MF8Iv87Ci7ihSWPc2TJ85fBn3Ndr+bjZBquL5wGhXv
         qJhNIGfOFjKGMG5ULYUmTHDUSG7p38HHYbI7Utpx9NMEsBoy+DlTddB1YbSkgl0Qso
         eFubLKjnocecg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: tmio: allow DMA request hook to return error status
Date:   Fri, 27 Jul 2018 10:14:06 +0900
Message-Id: <1532654046-11901-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_request_chan() may return ERR_PTR(-EPROBE_DEFER), but
tmio_mmc_request_dma() cannot propagate it since it is a
void function.

Change the return type to int so that the driver can retry
probing later in case the DMA-engine driver is probed after
the TMIO MMC driver.

I moved the call for tmio_mmc_request_dma() up because it may
fail now.  I also removed unneeded clearing of host->chan_{tx,rx}
because (struct tmio_mmc_host) is allocated by kzalloc().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 +++-
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 14 ++++++++------
 drivers/mmc/host/tmio_mmc.h                   |  3 +--
 drivers/mmc/host/tmio_mmc_core.c              | 21 ++++++++++-----------
 4 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index d032bd6..f3475a5 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -230,7 +230,7 @@ static void renesas_sdhi_internal_dmac_complete_tasklet_fn(unsigned long arg)
 	spin_unlock_irq(&host->lock);
 }
 
-static void
+static int
 renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 				       struct tmio_mmc_data *pdata)
 {
@@ -245,6 +245,8 @@ renesas_sdhi_internal_dmac_request_dma(struct tmio_mmc_host *host,
 	tasklet_init(&host->dma_issue,
 		     renesas_sdhi_internal_dmac_issue_tasklet_fn,
 		     (unsigned long)host);
+
+	return 0;
 }
 
 static void
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 4bb46c4..3f806f5 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -359,15 +359,15 @@ static void renesas_sdhi_sys_dmac_issue_tasklet_fn(unsigned long priv)
 		dma_async_issue_pending(chan);
 }
 
-static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
-					      struct tmio_mmc_data *pdata)
+static int renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
+					     struct tmio_mmc_data *pdata)
 {
 	struct renesas_sdhi *priv = host_to_priv(host);
 
 	/* We can only either use DMA for both Tx and Rx or not use it at all */
 	if (!host->pdev->dev.of_node &&
 	    (!pdata->chan_priv_tx || !pdata->chan_priv_rx))
-		return;
+		return 0;
 
 	if (!host->chan_tx && !host->chan_rx) {
 		struct resource *res = platform_get_resource(host->pdev,
@@ -377,7 +377,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 		int ret;
 
 		if (!res)
-			return;
+			return 0;
 
 		dma_cap_zero(mask);
 		dma_cap_set(DMA_SLAVE, mask);
@@ -389,7 +389,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 			host->chan_tx);
 
 		if (!host->chan_tx)
-			return;
+			return 0;
 
 		cfg.direction = DMA_MEM_TO_DEV;
 		cfg.dst_addr = res->start +
@@ -433,7 +433,7 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 
 	renesas_sdhi_sys_dmac_enable_dma(host, true);
 
-	return;
+	return 0;
 
 ebouncebuf:
 ecfgrx:
@@ -443,6 +443,8 @@ static void renesas_sdhi_sys_dmac_request_dma(struct tmio_mmc_host *host,
 ecfgtx:
 	dma_release_channel(host->chan_tx);
 	host->chan_tx = NULL;
+
+	return 0;
 }
 
 static void renesas_sdhi_sys_dmac_release_dma(struct tmio_mmc_host *host)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e7d6513..d8383d4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -115,8 +115,7 @@ struct tmio_mmc_host;
 struct tmio_mmc_dma_ops {
 	void (*start)(struct tmio_mmc_host *host, struct mmc_data *data);
 	void (*enable)(struct tmio_mmc_host *host, bool enable);
-	void (*request)(struct tmio_mmc_host *host,
-			struct tmio_mmc_data *pdata);
+	int (*request)(struct tmio_mmc_host *host, struct tmio_mmc_data *pdata);
 	void (*release)(struct tmio_mmc_host *host);
 	void (*abort)(struct tmio_mmc_host *host);
 	void (*dataend)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3cb554c..09c2d0c 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -65,15 +65,13 @@ static inline void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 		host->dma_ops->enable(host, enable);
 }
 
-static inline void tmio_mmc_request_dma(struct tmio_mmc_host *host,
-					struct tmio_mmc_data *pdata)
+static inline int tmio_mmc_request_dma(struct tmio_mmc_host *host,
+				       struct tmio_mmc_data *pdata)
 {
-	if (host->dma_ops) {
-		host->dma_ops->request(host, pdata);
-	} else {
-		host->chan_tx = NULL;
-		host->chan_rx = NULL;
-	}
+	if (host->dma_ops)
+		return host->dma_ops->request(host, pdata);
+
+	return 0;
 }
 
 static inline void tmio_mmc_release_dma(struct tmio_mmc_host *host)
@@ -1218,6 +1216,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 			return ret;
 	}
 
+	ret = tmio_mmc_request_dma(_host, pdata);
+	if (ret)
+		return ret;
+
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
@@ -1286,9 +1288,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	INIT_DELAYED_WORK(&_host->delayed_reset_work, tmio_mmc_reset_work);
 	INIT_WORK(&_host->done, tmio_mmc_done_work);
 
-	/* See if we also get DMA */
-	tmio_mmc_request_dma(_host, pdata);
-
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev, 50);
 	pm_runtime_use_autosuspend(&pdev->dev);
-- 
2.7.4

