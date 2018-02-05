Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeBEMzV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 07:55:21 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:29250 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeBEMvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 07:51:36 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 11/16] mmc: sdhci: Program a relatively accurate SW timeout value
Date: Mon, 5 Feb 2018 18:20:24 +0530
Message-ID: <20180205125029.21570-12-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci has a 10 second timeout to catch devices that stop responding.
Instead of programming 10 second arbitrary value, calculate the total time
it would take for the entire transfer to happen and program the timeout
value accordingly.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h | 10 ++++++++++
 2 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0489572d1892..d52f9e7eabe2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -673,6 +673,37 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
+static void sdhci_calc_sw_timeout(struct sdhci_host *host,
+				  struct mmc_command *cmd,
+				  unsigned int target_timeout)
+{
+	struct mmc_data *data = cmd->data;
+	struct mmc_host *mmc = host->mmc;
+	unsigned long long transfer_time;
+	struct mmc_ios *ios = &mmc->ios;
+	unsigned char bus_width = ios->bus_width;
+	unsigned int blksz;
+	unsigned int freq;
+
+	if (data) {
+		blksz = data->blksz;
+		freq = host->mmc->actual_clock ? host->mmc->actual_clock :
+						host->clock;
+		transfer_time = (unsigned long long)(blksz * NSEC_PER_SEC *
+						     (8 / bus_width)) / freq;
+		/* multiply by '2' to account for any unknowns */
+		transfer_time = transfer_time * 2;
+		/* calculate timeout for the entire data */
+		host->data_timeout = (data->blocks * ((target_timeout *
+						       NSEC_PER_USEC) +
+						       transfer_time));
+	} else {
+		host->data_timeout = target_timeout * NSEC_PER_USEC;
+	}
+
+	host->data_timeout += MMC_CMD_TRANSFER_TIME;
+}
+
 static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -742,6 +773,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 			host->hw_timeout_disabled = true;
 		}
 	}
+	sdhci_calc_sw_timeout(host, cmd, target_timeout);
 
 	return count;
 }
@@ -1130,13 +1162,6 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		mdelay(1);
 	}
 
-	timeout = jiffies;
-	if (!cmd->data && cmd->busy_timeout > 9000)
-		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
-	else
-		timeout += 10 * HZ;
-	sdhci_mod_timer(host, cmd, timeout);
-
 	host->cmd = cmd;
 	if (sdhci_data_line_cmd(cmd)) {
 		WARN_ON(host->data_cmd);
@@ -1176,6 +1201,13 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	    cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200)
 		flags |= SDHCI_CMD_DATA;
 
+	timeout = jiffies;
+	if (sdhci_data_line_cmd(cmd))
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, cmd, timeout);
+
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 3a967a56fcc3..b73577d77856 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -332,6 +332,14 @@ struct sdhci_adma2_64_desc {
 /* Allow for a a command request and a data request at the same time */
 #define SDHCI_MAX_MRQS		2
 
+/*
+ * 48bit command and 136 bit response in 400KHz clock should take 0.46ms.
+ * However since the start time of the command, the time between
+ * command and response, and the time between response and start of data is
+ * not known, set the command transfer time to 2ms.
+ */
+#define MMC_CMD_TRANSFER_TIME	(2 * NSEC_PER_MSEC) /* max 2 ms */
+
 enum sdhci_cookie {
 	COOKIE_UNMAPPED,
 	COOKIE_PRE_MAPPED,	/* mapped by sdhci_pre_req() */
@@ -554,6 +562,8 @@ struct sdhci_host {
 	/* Host SDMA buffer boundary. */
 	u32			sdma_boundary;
 
+	unsigned long long	data_timeout;
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 
-- 
2.11.0
