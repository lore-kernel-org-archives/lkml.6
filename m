Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964832146F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391367AbfBRRn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:43:27 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3675 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387866AbfBRRn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:43:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D11F17895CA3EB9EB557;
        Tue, 19 Feb 2019 01:43:22 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.408.0; Tue, 19 Feb 2019 01:43:16 +0800
From:   John Garry <john.garry@huawei.com>
To:     <axboe@kernel.dk>
CC:     <linuxarm@huawei.com>, <linux-ide@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] ata: libahci: Only warn for AHCI_HFLAG_MULTI_MSI set when genuine custom irq handler implemented
Date:   Tue, 19 Feb 2019 01:43:33 +0800
Message-ID: <1550511813-133136-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For an AHCI controller with AHCI_HFLAG_MULTI_MSI flag set, we may get the
following log, regardless of whether a custom irq handler was implemented
or not:

[   14.700238] ahci 0000:74:03.0: both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented

This is because we can set hpriv->irq_handler to
ahci_single_level_irq_intr() if not already set, in
ahci_init_one()->ahci_pci_save_initial_config()->ahci_save_initial_config().

Stop having this warn being misleading by adding a check for
hpriv->irq_handler != ahci_single_level_irq_intr.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index b5f57c69c487..692782dddc0f 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2599,7 +2599,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 	int rc;
 
 	if (hpriv->flags & AHCI_HFLAG_MULTI_MSI) {
-		if (hpriv->irq_handler)
+		if (hpriv->irq_handler &&
+		    hpriv->irq_handler != ahci_single_level_irq_intr)
 			dev_warn(host->dev,
 			         "both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented\n");
 		if (!hpriv->get_irq_vector) {
-- 
2.17.1

