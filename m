Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA80ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DF820868
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VUIMCljK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87DF820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbeJYWwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeJYWwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:10 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B32EF20834;
        Thu, 25 Oct 2018 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477152;
        bh=FWABHLHHRkZeqCr26W1zkfxud6/AlP/YdrEaEFFjyy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VUIMCljK/j0kD38iQH4MtqgbqY1SIWS7k01egVMXYPMVNIZAmA5+Wq3WRNU1JchEN
         ybyz9woN4g9yZ7dhWkknv8GNuJCc28zIOScnUH29KDrAl7Ta1jQreZYJOww/O4Qf7U
         I5R9iCUjeoIWXbKcgQHF3PdLNKxvFubKJ5NlGKWs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Suman Tripathi <stripathi@apm.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 10/98] ahci_xgene: Fix the DMA state machine lockup for the ATA_CMD_PACKET PIO mode command.
Date:   Thu, 25 Oct 2018 10:17:25 -0400
Message-Id: <20181025141853.214051-10-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Tripathi <stripathi@apm.com>

[ Upstream commit 1102407bb714dcebb43f385335bcb72f6b8843bc ]

This patch addresses the issue with ATA_CMD_PACKET pio mode
command for enumeration and device detection with ATAPI devices.
The X-Gene AHCI controller has an errata in which it cannot clear
the BSY bit after the PIO setup FIS. The dma state machine enters
CMFatalErrorUpdate state and locks up.

Signed-off-by: Suman Tripathi <stripathi@apm.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ata/ahci_xgene.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
index 0ffd3c930bed..d33216155827 100644
--- a/drivers/ata/ahci_xgene.c
+++ b/drivers/ata/ahci_xgene.c
@@ -125,10 +125,11 @@ static int xgene_ahci_restart_engine(struct ata_port *ap)
  * xgene_ahci_qc_issue - Issue commands to the device
  * @qc: Command to issue
  *
- * Due to Hardware errata for IDENTIFY DEVICE command, the controller cannot
- * clear the BSY bit after receiving the PIO setup FIS. This results in the dma
- * state machine goes into the CMFatalErrorUpdate state and locks up. By
- * restarting the dma engine, it removes the controller out of lock up state.
+ * Due to Hardware errata for IDENTIFY DEVICE command and PACKET
+ * command of ATAPI protocol set, the controller cannot clear the BSY bit
+ * after receiving the PIO setup FIS. This results in the DMA state machine
+ * going into the CMFatalErrorUpdate state and locks up. By restarting the
+ * DMA engine, it removes the controller out of lock up state.
  */
 static unsigned int xgene_ahci_qc_issue(struct ata_queued_cmd *qc)
 {
@@ -137,7 +138,8 @@ static unsigned int xgene_ahci_qc_issue(struct ata_queued_cmd *qc)
 	struct xgene_ahci_context *ctx = hpriv->plat_data;
 	int rc = 0;
 
-	if (unlikely(ctx->last_cmd[ap->port_no] == ATA_CMD_ID_ATA))
+	if (unlikely((ctx->last_cmd[ap->port_no] == ATA_CMD_ID_ATA) ||
+	    (ctx->last_cmd[ap->port_no] == ATA_CMD_PACKET)))
 		xgene_ahci_restart_engine(ap);
 
 	rc = ahci_qc_issue(qc);
-- 
2.17.1

