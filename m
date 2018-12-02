Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C82DC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33ED20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:16:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D33ED20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m3y3r.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbeLBVQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:16:04 -0500
Received: from www17.your-server.de ([213.133.104.17]:57720 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeLBVQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:16:02 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlp-00015z-Dz; Sun, 02 Dec 2018 21:55:17 +0100
Received: from [2a02:908:4c28:3f60:fff6:43c5:695c:41d6] (helo=localhost.localdomain)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1gTYlp-0002e9-8B; Sun, 02 Dec 2018 21:55:17 +0100
Subject: [PATCH] scsi: megaraid_sas: NULL check before some freeing
 functions is not needed.
From:   Thomas Meyer <thomas@m3y3r.de>
To:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, megaraidlinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1543760930052-918941928-10-diffsplit-thomas@m3y3r.de>
References: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1543760930050-1499171309-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 10
Date:   Sun, 02 Dec 2018 21:52:11 +0100
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.2/25173/Sun Dec  2 15:13:44 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NULL check before some freeing functions is not needed.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1243,8 +1243,7 @@ megaraid_mbox_teardown_dma_pools(adapter
 		dma_pool_free(raid_dev->sg_pool_handle, sg_pci_blk[i].vaddr,
 			sg_pci_blk[i].dma_addr);
 	}
-	if (raid_dev->sg_pool_handle)
-		dma_pool_destroy(raid_dev->sg_pool_handle);
+	dma_pool_destroy(raid_dev->sg_pool_handle);
 
 
 	epthru_pci_blk = raid_dev->epthru_pool;
@@ -1252,8 +1251,7 @@ megaraid_mbox_teardown_dma_pools(adapter
 		dma_pool_free(raid_dev->epthru_pool_handle,
 			epthru_pci_blk[i].vaddr, epthru_pci_blk[i].dma_addr);
 	}
-	if (raid_dev->epthru_pool_handle)
-		dma_pool_destroy(raid_dev->epthru_pool_handle);
+	dma_pool_destroy(raid_dev->epthru_pool_handle);
 
 
 	mbox_pci_blk = raid_dev->mbox_pool;
@@ -1261,8 +1259,7 @@ megaraid_mbox_teardown_dma_pools(adapter
 		dma_pool_free(raid_dev->mbox_pool_handle,
 			mbox_pci_blk[i].vaddr, mbox_pci_blk[i].dma_addr);
 	}
-	if (raid_dev->mbox_pool_handle)
-		dma_pool_destroy(raid_dev->mbox_pool_handle);
+	dma_pool_destroy(raid_dev->mbox_pool_handle);
 
 	return;
 }
diff -u -p a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -1017,8 +1017,7 @@ memalloc_error:
 	kfree(adapter->kioc_list);
 	kfree(adapter->mbox_list);
 
-	if (adapter->pthru_dma_pool)
-		dma_pool_destroy(adapter->pthru_dma_pool);
+	dma_pool_destroy(adapter->pthru_dma_pool);
 
 	kfree(adapter);
 
diff -u -p a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -807,10 +807,8 @@ megasas_free_rdpq_fusion(struct megasas_
 
 	}
 
-	if (fusion->reply_frames_desc_pool)
-		dma_pool_destroy(fusion->reply_frames_desc_pool);
-	if (fusion->reply_frames_desc_pool_align)
-		dma_pool_destroy(fusion->reply_frames_desc_pool_align);
+	dma_pool_destroy(fusion->reply_frames_desc_pool);
+	dma_pool_destroy(fusion->reply_frames_desc_pool_align);
 
 	if (fusion->rdpq_virt)
 		dma_free_coherent(&instance->pdev->dev,
@@ -830,8 +828,7 @@ megasas_free_reply_fusion(struct megasas
 			fusion->reply_frames_desc[0],
 			fusion->reply_frames_desc_phys[0]);
 
-	if (fusion->reply_frames_desc_pool)
-		dma_pool_destroy(fusion->reply_frames_desc_pool);
+	dma_pool_destroy(fusion->reply_frames_desc_pool);
 
 }
 
@@ -1627,8 +1624,7 @@ static inline void megasas_free_ioc_init
 				  fusion->ioc_init_cmd->frame,
 				  fusion->ioc_init_cmd->frame_phys_addr);
 
-	if (fusion->ioc_init_cmd)
-		kfree(fusion->ioc_init_cmd);
+	kfree(fusion->ioc_init_cmd);
 }
 
 /**
