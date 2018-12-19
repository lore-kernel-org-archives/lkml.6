Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718C72054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="PI7SG7d3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbeLSIfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:35:03 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40806 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbeLSIfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:35:03 -0500
Received: by mail-it1-f195.google.com with SMTP id h193so8197840ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MID6K3zlNafnqhw+JPETatblWskSFL3OkZpMGXmaXn0=;
        b=PI7SG7d3pWyEFGBedN5c0im/LYhUCv0gL/gwLbVznx55kKshPM9tXfaMA03CyVmLL9
         5+fgpMqtn3U7ZRD1NJleXswkj5Zcv03RPsaf6qYPzuChZOhOCmjW1F58QygNYLEQPHHn
         DN4DP7TtCWUeoFizeHof1dsRv62epeLd9T2/6slIrMtbfBpq2fOC1YJpm1VmLdJ7hfdy
         jfF3dviLlKG4G9gcvCAzHVfdOT30KpDYhFrJQHKNtLiuvk4kvJV9qznLn2MGMvim7AN7
         9LFP2+DaQ7t6oFct6mGCMMwE8DMtoO+sh1jRn8pYhkvWot/iXdpc+/9c/+lZGHVzcIrs
         AwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MID6K3zlNafnqhw+JPETatblWskSFL3OkZpMGXmaXn0=;
        b=kq1jiPW06dA5UxVcIcQwaVTyQedBBYpOGLcv9HQAHqaIO/TFBXwde5ciZA7TzQ6aV3
         J6abZu90j7gtJVcgDaUXJeWjG7v3v9Q9eol8H4B4ifbso+J4HooRyvD3n6n3F6LoFTjw
         a45b6JILmpxjXldxO1VuqhNL1f2eIoK99tqcINbzrEP1wUXLGIYaCLMBMm519esqaCXq
         B5LaXjgs14knVrBTqxhfoh4I+tAau9FPYZP5rEHuQbtV5UHLaWfv5dTBVeiwk7EaeB75
         sJC68pXmunBunmRAZ5mx2HrDkM+EHp8KiHbDLt1EFp9Bw8jav0IdFgARklF8ebM7ZA+j
         /ZVA==
X-Gm-Message-State: AA+aEWbpomXf1M7lTHeisSUbKO6pxbsBJCzaukCtAKRSVq5YTmessy8R
        rEOYwjP1gNbypG3R8/27RNN2/Q==
X-Google-Smtp-Source: AFSGD/WuXxOQTd3MV+V8jyoSBK/7haeNgLdfE4ds6aNj9UowJwhr9yGszuyWjW4CkQXSBXP1C9bnVA==
X-Received: by 2002:a02:a397:: with SMTP id y23mr19168193jak.9.1545208502020;
        Wed, 19 Dec 2018 00:35:02 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id l18sm2794133itb.32.2018.12.19.00.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:35:01 -0800 (PST)
Subject: [PATCH 4/12] scsi: arcmsr: Update arcmsr_alloc_ccb_pool for ccb
 buffer address can above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:34:58 +0800
Message-ID: <1545208498.4457.26.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update arcmsr_alloc_ccb_pool for ccb buffer address can above 4GB

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index 256fe9a..9041edc 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -747,6 +747,7 @@ struct AdapterControlBlock
 	uint32_t		outbound_int_enable;
 	uint32_t		cdb_phyaddr_hi32;
 	uint32_t		reg_mu_acc_handle0;
+	uint64_t		cdb_phyadd_hipart;
 	spinlock_t		eh_lock;
 	spinlock_t		ccblist_lock;
 	spinlock_t		postq_lock;
@@ -855,11 +856,11 @@ struct AdapterControlBlock
 *******************************************************************************
 */
 struct CommandControlBlock{
-	/*x32:sizeof struct_CCB=(32+60)byte, x64:sizeof struct_CCB=(64+60)byte*/
+	/*x32:sizeof struct_CCB=(64+60)byte, x64:sizeof struct_CCB=(64+60)byte*/
 	struct list_head		list;		/*x32: 8byte, x64: 16byte*/
 	struct scsi_cmnd		*pcmd;		/*8 bytes pointer of linux scsi command */
 	struct AdapterControlBlock	*acb;		/*x32: 4byte, x64: 8byte*/
-	uint32_t			cdb_phyaddr;	/*x32: 4byte, x64: 4byte*/
+	unsigned long			cdb_phyaddr;	/*x32: 4byte, x64: 8byte*/
 	uint32_t			arc_cdb_size;	/*x32:4byte,x64:4byte*/
 	uint16_t			ccb_flags;	/*x32: 2byte, x64: 2byte*/
 #define	CCB_FLAG_READ		0x0000
@@ -875,10 +876,10 @@ struct CommandControlBlock{
 	uint32_t			smid;
 #if BITS_PER_LONG == 64
 	/*  ======================512+64 bytes========================  */
-		uint32_t		reserved[4];	/*16 byte*/
+		uint32_t		reserved[3];	/*12 byte*/
 #else
 	/*  ======================512+32 bytes========================  */
-	//	uint32_t		reserved;	/*4  byte*/
+		uint32_t		reserved[8];	/*32  byte*/
 #endif
 	/*  =======================================================   */
 	struct ARCMSR_CDB		arcmsr_cdb;
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e1c75ca..5353dbb 100755
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -694,11 +694,11 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 	dma_addr_t dma_coherent_handle;
 	struct CommandControlBlock *ccb_tmp;
 	int i = 0, j = 0;
-	dma_addr_t cdb_phyaddr;
+	unsigned long cdb_phyaddr, next_ccb_phy;
 	unsigned long roundup_ccbsize;
 	unsigned long max_xfer_len;
 	unsigned long max_sg_entrys;
-	uint32_t  firm_config_version;
+	uint32_t  firm_config_version, curr_phy_upper32;
 
 	for (i = 0; i < ARCMSR_MAX_TARGETID; i++)
 		for (j = 0; j < ARCMSR_MAX_TARGETLUN; j++)
@@ -726,9 +726,10 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 	memset(dma_coherent, 0, acb->uncache_size);
 	acb->ccbsize = roundup_ccbsize;
 	ccb_tmp = dma_coherent;
+	curr_phy_upper32 = upper_32_bits(dma_coherent_handle);
 	acb->vir2phy_offset = (unsigned long)dma_coherent - (unsigned long)dma_coherent_handle;
 	for(i = 0; i < acb->maxFreeCCB; i++){
-		cdb_phyaddr = dma_coherent_handle + offsetof(struct CommandControlBlock, arcmsr_cdb);
+		cdb_phyaddr = (unsigned long)dma_coherent_handle + offsetof(struct CommandControlBlock, arcmsr_cdb);
 		switch (acb->adapter_type) {
 		case ACB_ADAPTER_TYPE_A:
 		case ACB_ADAPTER_TYPE_B:
@@ -744,9 +745,16 @@ static int arcmsr_alloc_ccb_pool(struct AdapterControlBlock *acb)
 		ccb_tmp->acb = acb;
 		ccb_tmp->smid = (u32)i << 16;
 		INIT_LIST_HEAD(&ccb_tmp->list);
-		list_add_tail(&ccb_tmp->list, &acb->ccb_free_list);
+		next_ccb_phy = dma_coherent_handle + roundup_ccbsize;
+		if (upper_32_bits(next_ccb_phy) != curr_phy_upper32) {
+			acb->maxFreeCCB = i;
+			acb->host->can_queue = i;
+			break;
+		}
+		else
+			list_add_tail(&ccb_tmp->list, &acb->ccb_free_list);
 		ccb_tmp = (struct CommandControlBlock *)((unsigned long)ccb_tmp + roundup_ccbsize);
-		dma_coherent_handle = dma_coherent_handle + roundup_ccbsize;
+		dma_coherent_handle = next_ccb_phy;
 	}
 	acb->dma_coherent_handle2 = dma_coherent_handle;
 	acb->dma_coherent2 = ccb_tmp;
@@ -3701,6 +3709,7 @@ static int arcmsr_iop_confirm(struct AdapterControlBlock *acb)
 	cdb_phyaddr = lower_32_bits(dma_coherent_handle);
 	cdb_phyaddr_hi32 = upper_32_bits(dma_coherent_handle);
 	acb->cdb_phyaddr_hi32 = cdb_phyaddr_hi32;
+	acb->cdb_phyadd_hipart = ((uint64_t)cdb_phyaddr_hi32) << 32;
 	/*
 	***********************************************************************
 	**    if adapter type B, set window of "post command Q"


