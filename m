Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B2EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F380D2084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGVL6y0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F380D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbeLKJNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:13:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42287 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:13:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so6822654pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bDHNZdQwRueTgEuC0DgZv88Onbk6IzsYFDHYWSgQwv4=;
        b=iGVL6y0w1YsBxlKFjxp6Za7SektYipl9w50s6Uv4bs6bd8BfnCh3LKNp3oUTgRXNTs
         MpsWf/xqsx16vu5np/kLY23krYbVwKfChdqZ9PWHz20QyvoR6Ou3SxssN83/wAEMCbSC
         CGIN9MqFd+KLPoKwdHq8NWA3q5Rm+JpSeXcA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bDHNZdQwRueTgEuC0DgZv88Onbk6IzsYFDHYWSgQwv4=;
        b=OT4Nl2OORnG/FuiVylezqqP4jOr6ZeZqaNbBmCGzPx0IBJJdF8AP1mfkrXu+Kk+vKs
         O6oUTVvAJcpN6WATDhbItZwAdS5xpiqqK0qZ2iVTz1maOGDQqQiXoGGOqC6LzmJZ9lpN
         qEuvKh3KHSYxtsED+R6KFDUgvdCgDYf2DiuLqtu3GGDNCfWCxEHyuioBd7B4Eke0GYmy
         gSUlqoMRS5C9uhfEYHfK1whmT7AY0WCc3qRbvRd46nCbkmmGSqtNUT0YZPqJEmQ56uM/
         5pJ9BQNZxv/N2GKuuks3LadbhImP642YdnpMeFxVZ3yBWvAfjb0EGFjhIX8YhTmnBu3h
         W0Lw==
X-Gm-Message-State: AA+aEWbtc7JH3Nb1Pvm8w4Su/xPz72kSpecagCQmz3ye81xynZLi/7h6
        ENBGQEokHHRPbjeRUgP/ozbOkA==
X-Google-Smtp-Source: AFSGD/Uu8CfUz5dsHla4qhAWVThfIb+DLViSTFNi+SCl+PsVcdktSegj2JDARxkMVuXESXz+obvgtQ==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr14180956pge.433.1544519590357;
        Tue, 11 Dec 2018 01:13:10 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a90sm27202214pfj.109.2018.12.11.01.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 01:13:09 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V4 1/3] mmc: sdhci: add support for using external DMA devices
Date:   Tue, 11 Dec 2018 17:12:50 +0800
Message-Id: <1544519572-21921-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/Kconfig |   3 +
 drivers/mmc/host/sdhci.c | 250 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   8 ++
 3 files changed, 260 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 1b58739..3101da6 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -977,3 +977,6 @@ config MMC_SDHCI_OMAP
 	  If you have a controller with this interface, say Y or M here.
 
 	  If unsure, say N.
+
+config MMC_SDHCI_EXTERNAL_DMA
+        bool
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 99bdae5..3162e60 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -14,6 +14,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/ktime.h>
 #include <linux/highmem.h>
 #include <linux/io.h>
@@ -1097,6 +1098,221 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
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
+static int __sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					     struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+	int sg_cnt;
+
+	host->data_timeout = 0;
+
+	if (sdhci_data_line_cmd(cmd))
+		sdhci_set_timeout(host, cmd);
+
+	WARN_ON(host->data);
+
+	/* Sanity checks */
+	WARN_ON(data->blksz * data->blocks > 524288);
+	WARN_ON(data->blksz > host->mmc->max_blk_size);
+	WARN_ON(data->blocks > 65535);
+
+	host->flags |= SDHCI_REQ_USE_DMA;
+	host->data = data;
+	host->data_early = 0;
+	host->data->bytes_xfered = 0;
+
+	sg_cnt = sdhci_pre_dma_transfer(host, data, COOKIE_MAPPED);
+	if (sg_cnt <= 0)
+		return -EINVAL;
+
+	sdhci_set_transfer_irqs(host);
+
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
+	 * can be supported, in that case 16-bit block count register must be 0.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
+
+	return 0;
+}
+
+static void sdhci_external_dma_prepare_data(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	if (!data)
+		return;
+
+	if (sdhci_external_dma_setup(host, cmd) ||
+	    __sdhci_external_dma_prepare_data(host, cmd)) {
+		sdhci_external_dma_release(host);
+		pr_err("%s: Cannot use external DMA, switch to the DMA/PIO which standard SDHCI provides.\n",
+		       mmc_hostname(host->mmc));
+		sdhci_prepare_data(host, cmd);
+	}
+}
+
+static void sdhci_external_dma_pre_transfer(struct sdhci_host *host,
+					    struct mmc_command *cmd)
+{
+	struct dma_chan *chan = sdhci_external_dma_channel(host, cmd->data);
+
+	if (cmd->data && chan)
+		dma_async_issue_pending(chan);
+}
+
+static int sdhci_external_dma_cleanup(struct sdhci_host *host,
+				    struct mmc_data *data)
+{
+	struct dma_chan *chan = sdhci_external_dma_channel(host, data);
+	int ret = 0;
+
+	if (chan)
+		ret = dmaengine_terminate_sync(chan);
+
+	return ret;
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
+
+static int sdhci_external_dma_cleanup(struct sdhci_host *host,
+				    struct mmc_data *data)
+{
+	return 0;
+}
+#endif
+
+void sdhci_switch_external_dma(struct sdhci_host *host, bool en)
+{
+	host->use_external_dma = en;
+}
+EXPORT_SYMBOL_GPL(sdhci_switch_external_dma);
+
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 				    struct mmc_request *mrq)
 {
@@ -1273,6 +1489,9 @@ static void sdhci_finish_data(struct sdhci_host *host)
 			if (!host->cmd || host->cmd == data_cmd)
 				sdhci_do_reset(host, SDHCI_RESET_CMD);
 			sdhci_do_reset(host, SDHCI_RESET_DATA);
+
+			if (host->use_external_dma)
+				sdhci_external_dma_cleanup(host, data);
 		}
 
 		/*
@@ -1355,7 +1574,10 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		host->data_cmd = cmd;
 	}
 
-	sdhci_prepare_data(host, cmd);
+	if (host->use_external_dma)
+		sdhci_external_dma_prepare_data(host, cmd);
+	else
+		sdhci_prepare_data(host, cmd);
 
 	sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
 
@@ -1397,6 +1619,9 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		timeout += 10 * HZ;
 	sdhci_mod_timer(host, cmd->mrq, timeout);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_pre_transfer(host, cmd);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
@@ -2635,6 +2860,8 @@ static bool sdhci_request_done(struct sdhci_host *host)
 				dma_unmap_sg(mmc_dev(host->mmc), data->sg,
 					     data->sg_len,
 					     mmc_get_dma_dir(data));
+				if (host->use_external_dma)
+					sdhci_external_dma_cleanup(host, data);
 			}
 			data->host_cookie = COOKIE_UNMAPPED;
 		}
@@ -3742,6 +3969,19 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
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
 	/*
 	 * If we use DMA, then it's up to the caller to set the DMA
 	 * mask, but PIO does not need the hw shim so we set a new
@@ -4161,6 +4401,10 @@ void sdhci_cleanup_host(struct sdhci_host *host)
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
@@ -4207,6 +4451,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 
 	pr_info("%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
+		host->use_external_dma ? "External DMA" :
 		(host->flags & SDHCI_USE_ADMA) ?
 		(host->flags & SDHCI_USE_64_BIT_DMA) ? "ADMA 64-bit" : "ADMA" :
 		(host->flags & SDHCI_USE_SDMA) ? "DMA" : "PIO");
@@ -4295,6 +4540,9 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 				  host->adma_table_sz, host->align_buffer,
 				  host->align_addr);
 
+	if (host->use_external_dma)
+		sdhci_external_dma_release(host);
+
 	host->adma_table = NULL;
 	host->align_buffer = NULL;
 }
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b001cf4..98d3953 100644
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
+	bool use_external_dma; /* Host selects to use external DMA */
 
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

