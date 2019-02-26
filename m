Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5BFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B5202173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vBe2K/s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfBZQNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:13:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40482 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbfBZQNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:13:05 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1QGCw2a096590;
        Tue, 26 Feb 2019 10:12:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1551197578;
        bh=/vJVpWkjIU5kSG48DJ/WemL0cUcEmIULzmvUU2/VqoQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vBe2K/s0SqEVM4Iu+0ArPzy5vq6NVtjzG9V42jKFM1Kc8CpPIrL5V/GQtk2DUECze
         1H2RWEr81qsxZvtN3blesZ7V76FDS1WRII3Lomykn2b3JVvDW26I5+cWjlfrPoo5Bt
         ClOWj/r5B7AHi7OCNlX1wZvGQvcsgUtpbx7woj14=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1QGCwnx090523
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Feb 2019 10:12:58 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 26
 Feb 2019 10:12:58 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 26 Feb 2019 10:12:57 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1QGCrY7024164;
        Tue, 26 Feb 2019 10:12:56 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <faiz_abbas@ti.com>
Subject: [PATCH 1/2] mmc: sdhci: Add platform_cmd_err() to sdhci_ops
Date:   Tue, 26 Feb 2019 21:46:05 +0530
Message-ID: <20190226161606.18569-2-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190226161606.18569-1-faiz_abbas@ti.com>
References: <20190226161606.18569-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some platforms might need a custom method for handling command error
interrupts. Add a callback to sdhci_ops to facilitate the same. Move
default command error handling to its own non-static function so it can
be called from platform drivers. Also make sdhci_finish_command()
non-static.

Fixes: 5b0d62108b46 ("mmc: sdhci-omap: Add platform specific reset
callback")
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 37 +++++++++++++++++++++++--------------
 drivers/mmc/host/sdhci.h |  4 ++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index eba9bcc92ad3..12302432605c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1440,7 +1440,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 }
 
-static void sdhci_finish_command(struct sdhci_host *host)
+void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
 
@@ -2772,6 +2772,25 @@ static void sdhci_timeout_data_timer(struct timer_list *t)
  *                                                                           *
 \*****************************************************************************/
 
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
+{
+		if (intmask & SDHCI_INT_TIMEOUT)
+			host->cmd->error = -ETIMEDOUT;
+		else
+			host->cmd->error = -EILSEQ;
+
+		/* Treat data command CRC error the same as data CRC error */
+		if (host->cmd->data &&
+		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
+		     SDHCI_INT_CRC) {
+			host->cmd = NULL;
+			*intmask_p |= SDHCI_INT_DATA_CRC;
+			return;
+		}
+
+		sdhci_finish_mrq(host, host->cmd->mrq);
+}
+
 static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 {
 	/* Handle auto-CMD12 error */
@@ -2805,21 +2824,11 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask, u32 *intmask_p)
 
 	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
 		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
-		if (intmask & SDHCI_INT_TIMEOUT)
-			host->cmd->error = -ETIMEDOUT;
+		if (host->ops->platform_cmd_err)
+			host->ops->platform_cmd_err(host, intmask, intmask_p);
 		else
-			host->cmd->error = -EILSEQ;
+			sdhci_cmd_err(host, intmask, intmask_p);
 
-		/* Treat data command CRC error the same as data CRC error */
-		if (host->cmd->data &&
-		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) ==
-		     SDHCI_INT_CRC) {
-			host->cmd = NULL;
-			*intmask_p |= SDHCI_INT_DATA_CRC;
-			return;
-		}
-
-		sdhci_finish_mrq(host, host->cmd->mrq);
 		return;
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6cc9a3c2ac66..523a47c4efa4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -639,6 +639,8 @@ struct sdhci_ops {
 	void	(*voltage_switch)(struct sdhci_host *host);
 	void	(*adma_write_desc)(struct sdhci_host *host, void **desc,
 				   dma_addr_t addr, int len, unsigned int cmd);
+	void	(*platform_cmd_err)(struct sdhci_host *host, u32 intmask,
+				    u32 *intmask_p);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
@@ -792,5 +794,7 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_cmd_err(struct sdhci_host *host, u32 intmask, u32 *intmask_p);
+void sdhci_finish_command(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.19.2

