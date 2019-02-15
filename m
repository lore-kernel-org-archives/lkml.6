Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB20C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C91121900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D4iDSriz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfBOTSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:18:02 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47170 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387593AbfBOTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:56 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHqaA130945;
        Fri, 15 Feb 2019 13:17:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258272;
        bh=1rRHsOSwUREh47oMGjYjj6bHkzl9zbDqAbQeI2oFC2I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D4iDSrizEfQfgaYzzIfxGfVJpHHyuJfYr0ezVk+KqNhPyPB7Of47Mhg2e8WT+HwOu
         P3kJfSX+CX09vNGLmoGqyZr/OZmOHcgo5O/MCtOs4laG4/OODCVxM29U65DiBfFtHB
         UmKDkIEAuDfsGuFSaNvP2rBMk+awWIam2/bxn/GE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHqSm097221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:52 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:51 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:51 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV11025256;
        Fri, 15 Feb 2019 13:17:48 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 5/8] mmc: sdhci: Add quirk for disabling DTO during erase command
Date:   Sat, 16 Feb 2019 00:50:30 +0530
Message-ID: <20190215192033.24203-6-faiz_abbas@ti.com>
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

Some controllers might prematurely issue a data timeout during an erase
command. Add a quirk to disable the interrupt when an erase command is
issued.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci.c | 5 +++++
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2f5f64efad16..608f7306742c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1522,6 +1522,11 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Initially, a command has no error */
 	cmd->error = 0;
 
+	if (cmd->opcode == MMC_ERASE &&
+	    (host->quirks2 & SDHCI_QUIRK2_DISABLE_DTO_FOR_ERASE)) {
+		sdhci_set_data_timeout_irq(host, false);
+	}
+
 	if ((host->quirks2 & SDHCI_QUIRK2_STOP_WITH_TC) &&
 	    cmd->opcode == MMC_STOP_TRANSMISSION)
 		cmd->flags |= MMC_RSP_BUSY;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 6ff3e29791ee..60282721f827 100644
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

