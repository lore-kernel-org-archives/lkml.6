Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D472C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFA52086B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ucijsis2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFA52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbeK2RMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:12:07 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42625 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbeK2RMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:12:06 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so483979pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 22:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HD8DFIpNCGhIwZVOyzdP+cSeTABmfi21GvFpnMD1Wuk=;
        b=Ucijsis2bA4z9B438v1jLgDFvKMk/ELbF0UgJffL+m9ahzQujlx2p5wZl3GvoIpG7u
         83Pp23fuPGkWgOLi5fBtV30UgqiYYxsi2iR1U4xR+qlp3A+VMd4nULhRwR/vOF10u/A3
         eEj9n58Z1TnWJ0ryPAjMaV5552TteSkCT9RhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HD8DFIpNCGhIwZVOyzdP+cSeTABmfi21GvFpnMD1Wuk=;
        b=AK+w1WwCyFJmLUk8EZcvyXnCUTHXSgWoxtCbsoN7AdS9gA/+Nf1847l1FXboHNfAnX
         droiFEluZJPyH7/GtxRoZtGzmN0kTZ6tyfx+eONlgsihBFgxflNWaHyQWWoQpl56vc6m
         spiWvTA0HiwANd/ebEEL7Nn2WB6/zV5W0oTY9Wrt2cTovlOWdxiQbp0HDX75uO/wYHat
         2dZeGNXhMUVW8frP0DQgutXWeSuw+01yoMPIKQvGB5YFdJkT14nNq/4nPtiq1L2RoWmz
         BiNHe5NLKKNFe/lLODZmElMOJc/hWYifSsuT/THci4/cDY0zmLc7VML2xKHwBSN/LVE4
         tbCA==
X-Gm-Message-State: AA+aEWZN/k/VipjuLxM7to7uvLmeH03XINouKk8ZrBnV0Dm1UcYIsVoC
        MlVjgo/QO8t4E/kRx1RuuLcU9Q==
X-Google-Smtp-Source: AFSGD/Uk5EuGQrUVRgqpj31YB17MDWnZ3uAqywuOBMr3mibT0zlu4UaVY8KofhNUURiDCOW//pBYaA==
X-Received: by 2002:a62:5c41:: with SMTP id q62mr188869pfb.171.1543471673421;
        Wed, 28 Nov 2018 22:07:53 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i193sm1069369pgc.22.2018.11.28.22.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 22:07:52 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V3 1/3] mmc: sdhci: add support for using external DMA devices
Date:   Thu, 29 Nov 2018 14:07:44 +0800
Message-Id: <1543471664-22856-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
References: <1542007566-9449-2-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some standard SD host controllers can support both external dma
controllers as well as ADMA/SDMA in which the SD host controller
acts as DMA master. TI's omap controller is the case as an example.

Currently the generic SDHCI code supports ADMA/SDMA integrated in
the host controller but does not have any support for external DMA
controllers implemented using dmaengine, meaning that custom code is
needed for any systems that use an external DMA controller with SDHCI.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/Kconfig |  14 ++++
 drivers/mmc/host/sdhci.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   8 ++
 3 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1b58739..4183f43 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
+	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
@@ -977,3 +978,16 @@ config MMC_SDHCI_OMAP
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_EXTERNAL_DMA
+        bool "Support external DMA in standard SD host controller"
+	depends on MMC_SDHCI
+	depends on DMA_ENGINE
+	help
+	  This is an option for using external DMA device via dmaengine
+	  framework.
+
+	  If you have a controller which support using external DMA device
+	  for data transfer, can say Y.
+
+	  If unsure, say N.
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae5..ad7cc80 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
@@ -1309,6 +1310,162 @@ static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 		del_timer(&host->timer);
 }
 
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+static int sdhci_external_dma_init(struct sdhci_host *host)
+{
+	int ret = 0;
+	struct mmc_host *mmc = host->mmc;
+
+	host->tx_chan = dma_request_chan(mmc->parent, "tx");
+	if (IS_ERR(host->tx_chan)) {
+		ret = PTR_ERR(host->tx_chan);
+		if (ret != -EPROBE_DEFER)
+			pr_warn("Failed to request TX DMA channel.\n");
+		host->tx_chan = NULL;
+		return ret;
+	}
+
+	host->rx_chan = dma_request_chan(mmc->parent, "rx");
+	if (IS_ERR(host->rx_chan)) {
+		if (host->tx_chan) {
+			dma_release_channel(host->tx_chan);
+			host->tx_chan = NULL;
+		}
+
+		ret = PTR_ERR(host->rx_chan);
+		if (ret != -EPROBE_DEFER)
+			pr_warn("Failed to request RX DMA channel.\n");
+		host->rx_chan = NULL;
+	}
+
+	return ret;
+}
+
+static inline struct dma_chan *
+sdhci_external_dma_channel(struct sdhci_host *host, struct mmc_data *data)
+{
+	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan;
+}
+
+static int sdhci_external_dma_setup(struct sdhci_host *host,
+				    struct mmc_command *cmd)
+{
+	int ret, i;
+	struct dma_async_tx_descriptor *desc;
+	struct mmc_data *data = cmd->data;
+	struct dma_chan *chan;
+	struct dma_slave_config cfg;
+	dma_cookie_t cookie;
+
+	if (!host->mapbase)
+		return -EINVAL;
+
+	if (!data)
+		return 0;
+
+	cfg.src_addr = host->mapbase + SDHCI_BUFFER;
+	cfg.dst_addr = host->mapbase + SDHCI_BUFFER;
+	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+	cfg.src_maxburst = data->blksz / 4;
+	cfg.dst_maxburst = data->blksz / 4;
+
+	/* Sanity check: all the SG entries must be aligned by block size. */
+	for (i = 0; i < data->sg_len; i++) {
+		if ((data->sg + i)->length % data->blksz)
+			return -EINVAL;
+	}
+
+	chan = sdhci_external_dma_channel(host, data);
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		return ret;
+
+	desc = dmaengine_prep_slave_sg(chan, data->sg, data->sg_len,
+				       mmc_get_dma_dir(data),
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc)
+		return -EINVAL;
+
+	desc->callback = NULL;
+	desc->callback_param = NULL;
+
+	cookie = dmaengine_submit(desc);
+	if (cookie < 0)
+		ret = cookie;
+
+	return ret;
+}
+
+static void sdhci_external_dma_release(struct sdhci_host *host)
+{
+	if (host->tx_chan) {
+		dma_release_channel(host->tx_chan);
+		host->tx_chan = NULL;
+	}
+
+	if (host->rx_chan) {
+		dma_release_channel(host->rx_chan);
+		host->rx_chan = NULL;
+	}
+
+	sdhci_switch_external_dma(host, false);
+}
+
+static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	if (sdhci_external_dma_setup(host, cmd)) {
+		sdhci_external_dma_release(host);
+		pr_err("%s: Failed to setup external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
+		       mmc_hostname(host->mmc));
+	} else {
+		/* Prepare for using external dma */
+		host->flags |= SDHCI_REQ_USE_DMA;
+	}
+
+	sdhci_prepare_data(host, cmd);
+}
+
+static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	struct dma_chan *chan;
+
+	if (cmd->opcode != MMC_SET_BLOCK_COUNT && cmd->data) {
+		sdhci_set_timeout(host, cmd);
+		chan = sdhci_external_dma_channel(host, cmd->data);
+		dma_async_issue_pending(chan);
+	}
+}
+#else
+static int sdhci_external_dma_init(struct sdhci_host *host)
+{
+	return -EOPNOTSUPP;
+}
+
+static void sdhci_external_dma_release(struct sdhci_host *host)
+{}
+
+static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	/* If MMC_SDHCI_EXTERNAL_DMA not supported, PIO will be used */
+	sdhci_prepare_data(host, cmd);
+}
+
+static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{}
+#endif
+
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
+{
+	host->use_external_dma = en;
+}
+EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
+
 void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	int flags;
@@ -1355,7 +1512,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		host->data_cmd = cmd;
 	}
 
-	sdhci_prepare_data(host, cmd);
+	if (host->use_external_dma)
+		sdhci_external_dma_prepare_data(host, cmd);
+	else
+		sdhci_prepare_data(host, cmd);
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
@@ -1397,6 +1557,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_pre_transfer(host, cmd);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -4133,6 +4296,19 @@ int sdhci_setup_host(struct sdhci_host *host)
 			return ret;
 	}
 
+	if (host->use_external_dma) {
+		ret = sdhci_external_dma_init(host);
+		if (ret == -EPROBE_DEFER)
+			goto unreg;
+
+		/*
+		 * Fall back to use the DMA/PIO integrated in standard SDHCI
+		 * instead of external DMA devices.
+		 */
+		if (ret)
+			sdhci_switch_external_dma(host, false);
+	}
+
 	return 0;
 
 unreg:
@@ -4161,6 +4337,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 		dma_free_coherent(mmc_dev(mmc), host->align_buffer_sz +
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
+
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
@@ -4295,6 +4475,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b001cf4..8e50a97 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -475,6 +475,7 @@ struct sdhci_host {
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
+	phys_addr_t mapbase;	/* physical address base */
 	char *bounce_buffer;	/* For packing SDMA reads/writes */
 	dma_addr_t bounce_addr;
 	unsigned int bounce_buffer_size;
@@ -524,6 +525,7 @@ struct sdhci_host {
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
 	bool v4_mode;		/* Host Version 4 Enable */
+	bool use_external_dma;
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -552,6 +554,11 @@ struct sdhci_host {
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
 
+#if IS_ENABLED(CONFIG_MMC_SDHCI_EXTERNAL_DMA)
+	struct dma_chan	*rx_chan;
+	struct dma_chan	*tx_chan;
+#endif
+
 	u32 caps;		/* CAPABILITY_0 */
 	u32 caps1;		/* CAPABILITY_1 */
 	bool read_caps;		/* Capability flags have been read */
@@ -785,5 +792,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

