Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FE5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D44F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="aBQAJ/QG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfAQDkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:40:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37081 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbfAQDky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:40:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so4116127pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=073snM5C8tLLsyr5QOcJderOjEQwtrw46iKbrgLbkBY=;
        b=aBQAJ/QGLLKeo/Sh+bpsPimJwKkiCu2r3sZxYeYZ65oJioO+i2hR2KE3guTBs45W7N
         D8xiYLt0kmMU+A4sh05qf34za0WEN86EdKbp/rB4VND/1CJfWoeUFlqT8samKtLVC+Ca
         cFVKtXpNEYQh77/9bXgYnbhW3bObFRTHp0ckbMW2codGcuNXT8ndKo+TuSGVNSdXan8r
         9ES5/yAZsHvvm10cixoBcegaBxgKaSF3F5nB8HFRWiC/pzQcJjHXMAEwi8asiGIXGuri
         qSWdxPtcpw33LOjNN61J/LuQSPfYVLjR4fqkENX9XxRIyPwrx8bBcTKLXWIzGPdyHRjb
         92+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=073snM5C8tLLsyr5QOcJderOjEQwtrw46iKbrgLbkBY=;
        b=r5ooTos3uRoZYtsAeA4u9wwlReGccnRcy2x4IgO7fJrUyzAOAV0IgJvjnejCrajj7V
         1NwgwtrzwLuzuTOunxgqKQjUT3yLzHVTWzTRDY9ylIL7rLL0UZvERBoQygx5xuPot7nE
         7/eLAbC0SAUm/b+yrYtCMGEPwecmT2LYmBZKFDiUYjGRRG/eg/60QumQVh7yeZZY0EeX
         yANdh++wEF2JkLXsWB5PM9xgYYmwlZnIGsKMTsBAwfuhfLLI6OTH7Tf8ybThTpFaNoDo
         vUnn70r9vqANCo6m/7rjHt7y7RSpR+EVLTZWrUpezFv6Xb/TYJgsvRwALe3FRiJoy80a
         bhlQ==
X-Gm-Message-State: AJcUuke/9ShLvzoa9x5grSVZkVR1CBohcoM7lZs+oJbz5D+bGRHQily3
        Fo4dw01OImA3bKe8ejB8ZxXh0A==
X-Google-Smtp-Source: ALg8bN62ewq3wexhbsp9rdT0SIBdLBjJT6A30XdieuHDlDSqzl+LFvZBuLmzqtSsfC5tG8ppM8RhPw==
X-Received: by 2002:a62:4641:: with SMTP id t62mr13092128pfa.141.1547696453925;
        Wed, 16 Jan 2019 19:40:53 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id f67sm360605pff.29.2019.01.16.19.40.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 19:40:53 -0800 (PST)
Subject: [PATCH 1/3] scsi: arcmsr: Use dma_alloc_coherent to replace
 dma_zalloc_coherent
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 11:40:50 +0800
Message-ID: <1547696450.4339.17.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Due to dma_zalloc_coherent will be phase out, so use dma_alloc_coherent to replace
 it.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index 9f85d5a..5736434 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -642,7 +642,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 	switch (acb->adapter_type) {
 	case ACB_ADAPTER_TYPE_B: {
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_B), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -656,7 +656,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		break;
 	case ACB_ADAPTER_TYPE_D: {
 		acb->ioqueue_size = roundup(sizeof(struct MessageUnit_D), 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent) {
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);
@@ -672,7 +672,7 @@ static bool arcmsr_alloc_io_queue(struct AdapterControlBlock *acb)
 		uint32_t completeQ_size;
 		completeQ_size = sizeof(struct deliver_completeQ) * ARCMSR_MAX_HBE_DONEQUEUE + 128;
 		acb->ioqueue_size = roundup(completeQ_size, 32);
-		dma_coherent = dma_zalloc_coherent(&pdev->dev, acb->ioqueue_size,
+		dma_coherent = dma_alloc_coherent(&pdev->dev, acb->ioqueue_size,
 			&dma_coherent_handle, GFP_KERNEL);
 		if (!dma_coherent){
 			pr_notice("arcmsr%d: DMA allocation failed\n", acb->host->host_no);


