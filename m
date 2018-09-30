Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F309C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:18:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C0520666
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 23:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C0520666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbeJAFxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 01:53:07 -0400
Received: from smtprelay0063.hostedemail.com ([216.40.44.63]:60026 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbeJAFxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 01:53:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9DCAC1278F;
        Sun, 30 Sep 2018 23:18:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: brick57_477cad92d7a03
X-Filterd-Recvd-Size: 4150
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 23:18:11 +0000 (UTC)
Message-ID: <bd6313064c790b1db5806245b8c3d00e2f82c8f7.camel@perches.com>
Subject: Re: [PATCH] scsi: arcmsr: clean up clang warning on extraneous
 parentheses
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ching Huang <ching2048@areca.com.tw>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 30 Sep 2018 16:18:10 -0700
In-Reply-To: <20180930230307.18664-1-colin.king@canonical.com>
References: <20180930230307.18664-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-01 at 00:03 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are extraneous parantheses that are causing clang to produce a
> warning so remove these.
> 
> Clean up 3 clang warnings:
> equality comparison with extraneous parentheses [-Wparentheses-equality]
[]
> diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
[]
> @@ -4135,9 +4135,9 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
>  		pci_read_config_byte(acb->pdev, i, &value[i]);
>  	}
>  	/* hardware reset signal */
> -	if ((acb->dev_id == 0x1680)) {
> +	if (acb->dev_id == 0x1680) {
>  		writel(ARCMSR_ARC1680_BUS_RESET, &pmuA->reserved1[0]);
> -	} else if ((acb->dev_id == 0x1880)) {
> +	} else if (acb->dev_id == 0x1880) {
>  		do {
>  			count++;
>  			writel(0xF, &pmuC->write_sequence);
> @@ -4161,7 +4161,7 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
>  		} while (((readl(&pmuE->host_diagnostic_3xxx) &
>  			ARCMSR_ARC1884_DiagWrite_ENABLE) == 0) && (count < 5));
>  		writel(ARCMSR_ARC188X_RESET_ADAPTER, &pmuE->host_diagnostic_3xxx);
> -	} else if ((acb->dev_id == 0x1214)) {
> +	} else if (acb->dev_id == 0x1214) {
>  		writel(0x20, pmuD->reset_request);
>  	} else {
>  		pci_write_config_byte(acb->pdev, 0x84, 0x20);

It'd probably read better using a switch/case like the below:
---
 drivers/scsi/arcmsr/arcmsr_hba.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 12316ef4c893..ad45583f5ae0 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -4135,9 +4135,11 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		pci_read_config_byte(acb->pdev, i, &value[i]);
 	}
 	/* hardware reset signal */
-	if ((acb->dev_id == 0x1680)) {
+	switch (acb->dev_id) {
+	case 0x1680:
 		writel(ARCMSR_ARC1680_BUS_RESET, &pmuA->reserved1[0]);
-	} else if ((acb->dev_id == 0x1880)) {
+		break;
+	case 0x1880:
 		do {
 			count++;
 			writel(0xF, &pmuC->write_sequence);
@@ -4148,7 +4150,8 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 			writel(0xD, &pmuC->write_sequence);
 		} while (((readl(&pmuC->host_diagnostic) & ARCMSR_ARC1880_DiagWrite_ENABLE) == 0) && (count < 5));
 		writel(ARCMSR_ARC1880_RESET_ADAPTER, &pmuC->host_diagnostic);
-	} else if (acb->dev_id == 0x1884) {
+		break;
+	case 0x1884:
 		struct MessageUnit_E __iomem *pmuE = acb->pmuE;
 		do {
 			count++;
@@ -4161,10 +4164,13 @@ static void arcmsr_hardware_reset(struct AdapterControlBlock *acb)
 		} while (((readl(&pmuE->host_diagnostic_3xxx) &
 			ARCMSR_ARC1884_DiagWrite_ENABLE) == 0) && (count < 5));
 		writel(ARCMSR_ARC188X_RESET_ADAPTER, &pmuE->host_diagnostic_3xxx);
-	} else if ((acb->dev_id == 0x1214)) {
+		break;
+	case 0x1214:
 		writel(0x20, pmuD->reset_request);
-	} else {
+		break;
+	default:
 		pci_write_config_byte(acb->pdev, 0x84, 0x20);
+		break;
 	}
 	msleep(2000);
 	/* write back pci config data */

