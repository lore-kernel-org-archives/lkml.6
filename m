Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2A0C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD920840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9X72djX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFD920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbeKIIWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:22:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbeKIHc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:32:27 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 195CE20892;
        Thu,  8 Nov 2018 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714101;
        bh=Wv5C4/9J57HibnB6FS45m89Pd66su5xULS6J4GG+6Uw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s9X72djXDfC3C/5ajJBPy7Qxn367LS5HXHtBcs5jE3bkXQPKZQd7efzQbYcuJQ4SU
         eNEMr/7TW2OCEUp+B0x9a2TaAEAYK0Gs6qArmBNczIo64+m6IqTATR4INgOuciTkCX
         QRM0Qm8v8y3+xZyvl2qNfdEUbh7Jk71RaSKMZsP4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Tripathi <stripathi@apm.com>,
        Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 040/144] ahci_xgene: Fix the DMA state machine lockup for the ATA_CMD_PACKET PIO mode command.
Date:   Thu,  8 Nov 2018 13:50:11 -0800
Message-Id: <20181108215057.767584746@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



