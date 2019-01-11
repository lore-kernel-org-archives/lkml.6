Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAACC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8782177B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KGnVx3nA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbfAKLGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:06:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730987AbfAKLGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:06:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BB6F1P075092;
        Fri, 11 Jan 2019 05:06:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547204775;
        bh=BEnPQFhax64Og/c5c4caRoYtVP88OtvDRiQ9NsO7jx8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KGnVx3nAtJ+cpfwapvqeviUAvUSQemi4G8E5FIIIcpxgWb2cgB7AXBIQlbM01ymaF
         jZK+4fDebSH5xpQbowOR//avE/52xBuHcHs5wFSFwPxZgbWDcHssBXINHX9/fPJnzE
         y7b9OkPDvBVOkcr0+G5HNvpqJ8pFuxlKhpevE274=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BB6Fmq119337
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 05:06:15 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 05:06:15 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 05:06:15 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BB5xEu024503;
        Fri, 11 Jan 2019 05:06:12 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhang.chunyan@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH 4/7] mmc: sdhci: Add quirk for disabling DTO during erase command
Date:   Fri, 11 Jan 2019 16:38:48 +0530
Message-ID: <20190111110851.6805-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers might prematurely issue a data timeout during an erase
command. Add a quirk to disable the interrupt when an erase command is
issued.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 8 ++++++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4a9044c06e21..cfd716aee552 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1560,6 +1560,14 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
+	if (cmd->opcode == MMC_ERASE &&
+	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
+		mask = sdhci_readl(host, SDHCI_INT_ENABLE);
+		mask &= ~SDHCI_INT_DATA_TIMEOUT;
+		sdhci_writel(host, mask, SDHCI_INT_ENABLE);
+		sdhci_writel(host, mask, SDHCI_SIGNAL_ENABLE);
+	}
+
 	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
 	    cmd->opcode == MMC_STOP_TRANSMISSION)
 		cmd->flags |= MMC_RSP_BUSY;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7a52823ebef4..d0c6d4fe5371 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -479,6 +479,8 @@ struct sdhci_host {
  * block count.
  */
 #define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
+/* Controller needs to disable DTO for erase command */
+#define SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE		(1<<19)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.19.2

