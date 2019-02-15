Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63066C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE1C222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yXuhGidM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbfBOTRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:17:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59558 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHc22128854;
        Fri, 15 Feb 2019 13:17:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258258;
        bh=/ynRED+G/AlzXI8FgUXdAnqvGNMXBcTF9KHVM60UjJ4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yXuhGidMPgpXBtXBVMf50+oza7q25aOWjGeAFGMZC+B9+ixN6EdwY82IQLQ+8rkIv
         DBWJOomDELGmJIE0gwNkbJ5BqeKRMFNPcSbOa0dIbQoUWQJhI2DHcdPQHkPyWfxJnI
         Evawa8huymStKfK7Xr8eavkiO4ENISJy3+epQQH8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHc36015657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:38 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:38 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:38 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV0v025256;
        Fri, 15 Feb 2019 13:17:35 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 1/8] mmc: sdhci: Get rid of finish_tasklet
Date:   Sat, 16 Feb 2019 00:50:26 +0530
Message-ID: <20190215192033.24203-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci.c has two bottom halves implemented. A threaded_irq for handling
card insert/remove operations and a tasklet for finishing mmc requests.
With the addition of external dma support, dmaengine APIs need to
terminate in non-atomic context before unmapping the dma buffers.

To facilitate this, remove the finish_tasklet and move the call of
sdhci_request_done() to the threaded_irq() callback. Also move the
interrupt result variable to sdhci_host so it can be populated from
anywhere inside the sdhci_irq handler.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 43 +++++++++++++++-------------------------
 drivers/mmc/host/sdhci.h |  2 +-
 2 files changed, 17 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eba9bcc92ad3..20ed09b896d7 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1232,7 +1232,7 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 
-	tasklet_schedule(&host->finish_tasklet);
+	host->result = IRQ_WAKE_THREAD;
 }
 
 static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
@@ -2705,14 +2705,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
 	return false;
 }
 
-static void sdhci_tasklet_finish(unsigned long param)
-{
-	struct sdhci_host *host = (struct sdhci_host *)param;
-
-	while (!sdhci_request_done(host))
-		;
-}
-
 static void sdhci_timeout_timer(struct timer_list *t)
 {
 	struct sdhci_host *host;
@@ -2995,11 +2987,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 
 static irqreturn_t sdhci_irq(int irq, void *dev_id)
 {
-	irqreturn_t result = IRQ_NONE;
 	struct sdhci_host *host = dev_id;
 	u32 intmask, mask, unexpected = 0;
 	int max_loops = 16;
 
+	host->result = IRQ_NONE;
+
 	spin_lock(&host->lock);
 
 	if (host->runtime_suspended && !sdhci_sdio_irq_enabled(host)) {
@@ -3009,7 +3002,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 	intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 	if (!intmask || intmask == 0xffffffff) {
-		result = IRQ_NONE;
+		host->result = IRQ_NONE;
 		goto out;
 	}
 
@@ -3054,7 +3047,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 
 			host->thread_isr |= intmask & (SDHCI_INT_CARD_INSERT |
 						       SDHCI_INT_CARD_REMOVE);
-			result = IRQ_WAKE_THREAD;
+			host->result = IRQ_WAKE_THREAD;
 		}
 
 		if (intmask & SDHCI_INT_CMD_MASK)
@@ -3074,7 +3067,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		    (host->ier & SDHCI_INT_CARD_INT)) {
 			sdhci_enable_sdio_irq_nolock(host, false);
 			host->thread_isr |= SDHCI_INT_CARD_INT;
-			result = IRQ_WAKE_THREAD;
+			host->result = IRQ_WAKE_THREAD;
 		}
 
 		intmask &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
@@ -3087,8 +3080,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 			sdhci_writel(host, intmask, SDHCI_INT_STATUS);
 		}
 cont:
-		if (result == IRQ_NONE)
-			result = IRQ_HANDLED;
+		if (host->result == IRQ_NONE)
+			host->result = IRQ_HANDLED;
 
 		intmask = sdhci_readl(host, SDHCI_INT_STATUS);
 	} while (intmask && --max_loops);
@@ -3101,7 +3094,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
 		sdhci_dumpregs(host);
 	}
 
-	return result;
+	return host->result;
 }
 
 static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
@@ -3131,6 +3124,12 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
 		spin_unlock_irqrestore(&host->lock, flags);
 	}
 
+	if (!isr) {
+		do {
+			isr = !sdhci_request_done(host);
+		} while (isr);
+	}
+
 	return isr ? IRQ_HANDLED : IRQ_NONE;
 }
 
@@ -4212,12 +4211,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 	struct mmc_host *mmc = host->mmc;
 	int ret;
 
-	/*
-	 * Init tasklets.
-	 */
-	tasklet_init(&host->finish_tasklet,
-		sdhci_tasklet_finish, (unsigned long)host);
-
 	timer_setup(&host->timer, sdhci_timeout_timer, 0);
 	timer_setup(&host->data_timer, sdhci_timeout_data_timer, 0);
 
@@ -4230,7 +4223,7 @@ int __sdhci_add_host(struct sdhci_host *host)
 	if (ret) {
 		pr_err("%s: Failed to request IRQ %d: %d\n",
 		       mmc_hostname(mmc), host->irq, ret);
-		goto untasklet;
+		return ret;
 	}
 
 	ret = sdhci_led_register(host);
@@ -4263,8 +4256,6 @@ int __sdhci_add_host(struct sdhci_host *host)
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 	sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
 	free_irq(host->irq, host);
-untasklet:
-	tasklet_kill(&host->finish_tasklet);
 
 	return ret;
 }
@@ -4326,8 +4317,6 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	del_timer_sync(&host->timer);
 	del_timer_sync(&host->data_timer);
 
-	tasklet_kill(&host->finish_tasklet);
-
 	if (!IS_ERR(mmc->supply.vqmmc))
 		regulator_disable(mmc->supply.vqmmc);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..624d5aa01995 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -554,7 +554,7 @@ struct sdhci_host {
 
 	unsigned int desc_sz;	/* ADMA descriptor size */
 
-	struct tasklet_struct finish_tasklet;	/* Tasklet structures */
+	irqreturn_t result;	/* Result of IRQ handler */
 
 	struct timer_list timer;	/* Timer for timeouts */
 	struct timer_list data_timer;	/* Timer for data timeouts */
-- 
2.19.2

