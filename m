Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A029BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CCA24FAD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:30:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CCA24FAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753958AbeGBHa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:30:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52063 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeGBHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:30:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZtHz-0001yV-3c; Mon, 02 Jul 2018 07:30:23 +0000
From:   Colin King <colin.king@canonical.com>
To:     Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sata_nv: remove redundant pointers sdev0 and sdev1
Date:   Mon,  2 Jul 2018 08:30:22 +0100
Message-Id: <20180702073022.10000-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointers sdev0 and sdev1 are being assigned but are never used hence they
are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'sdev0' set but not used [-Wunused-but-set-variable]
warning: variable 'sdev1' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ata/sata_nv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/ata/sata_nv.c b/drivers/ata/sata_nv.c
index 10ae11aa1926..72c9b922a77b 100644
--- a/drivers/ata/sata_nv.c
+++ b/drivers/ata/sata_nv.c
@@ -675,7 +675,6 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 	struct ata_port *ap = ata_shost_to_port(sdev->host);
 	struct nv_adma_port_priv *pp = ap->private_data;
 	struct nv_adma_port_priv *port0, *port1;
-	struct scsi_device *sdev0, *sdev1;
 	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
 	unsigned long segment_boundary, flags;
 	unsigned short sg_tablesize;
@@ -736,8 +735,6 @@ static int nv_adma_slave_config(struct scsi_device *sdev)
 
 	port0 = ap->host->ports[0]->private_data;
 	port1 = ap->host->ports[1]->private_data;
-	sdev0 = ap->host->ports[0]->link.device[0].sdev;
-	sdev1 = ap->host->ports[1]->link.device[0].sdev;
 	if ((port0->flags & NV_ADMA_ATAPI_SETUP_COMPLETE) ||
 	    (port1->flags & NV_ADMA_ATAPI_SETUP_COMPLETE)) {
 		/*
-- 
2.17.1

