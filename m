Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3B4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3051C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Omh8zB5c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3051C208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756648AbeFOVCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:02:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38404 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756628AbeFOVC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:02:27 -0400
Received: by mail-pl0-f68.google.com with SMTP id b14-v6so5934025pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QxtKXFNNaqGsLNq5JYuUkp0oYbby3/meJCCXJwsi+Zw=;
        b=Omh8zB5cMZFMky+SVhDKblWqo08jnnas09NQWr8uiP6+BLGOpimbTU1KYRs6kBWG5B
         jOCAyXw9wJiLvxHJ8op/+bQlOp+I1qe5kmx99R7KmnrHkhHDFLarnIcS5XOAP8IWs0c4
         Pb9hmsEoP3itehAKgWi/5D1CEGnmk0MAlYpnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QxtKXFNNaqGsLNq5JYuUkp0oYbby3/meJCCXJwsi+Zw=;
        b=D7fLmW6aUwj0dggKBJTf8ZiJQHp/Z4Ow99D6UQ3qV6msR8Uvt/KcndhtopbLuzb/zE
         a9qTxUVCpTZrwCjhJ9VUAse/BJ1AA9Nfro2HqrKmBuoJj6C8dpoZQFmQWQf254v/ynzV
         xzAvHivfR03LBcusQtyJ91I2XCccovqbacbY3TAT443v6G1JH1Gtee9ozo+4oyw/iNT0
         FHsnIShEBLRAPeDhPUbJzQYrWCPg6lVeCPMY4gyBtP2wtNmnKngXCpDPpGO1ViawlHi4
         eBiBnFHTBwBl93m6/XGGwKJl0R99X8NhNWjTWiy54tRAwh8hDAjeD5sp+40C2HMqtx2X
         BmiQ==
X-Gm-Message-State: APt69E0oe1N/vP4gJqoEhl9AHMH/d+CbNecCW26GgEHTztZnoxeeIVZS
        6l40HwomSXt84R00AiqPqur+7A==
X-Google-Smtp-Source: ADUXVKLLBfacaB5kIfmPyx4oeyz6XIzS3j55VlourtMhYqr4sfGOwjpTtqxZRxas8puQx2yaCKjniQ==
X-Received: by 2002:a17:902:b195:: with SMTP id s21-v6mr3769629plr.202.1529096546460;
        Fri, 15 Jun 2018 14:02:26 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id v13-v6sm17664346pfa.131.2018.06.15.14.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 14:02:25 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bart Van Assche <Bart.VanAssche@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v2 3/4] scsi: ufs: Refactor descriptor read for write
Date:   Fri, 15 Jun 2018 14:00:48 -0700
Message-Id: <20180615210049.126123-4-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180615210049.126123-1-evgreen@chromium.org>
References: <20180615210049.126123-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change refactors the ufshcd_read_desc_param function into
one that can both read and write descriptors. Most of the low-level
plumbing for writing to descriptors was already there, this change
simply enables that code path, and manages the incoming data buffer
appropriately.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Changes since v1:
	- Fail if requesting a region fully outside the descriptor.
	- Clear the remaining buffer if requesting a region partially
outside the descriptor.
	- Add a mutex around the read-modify-write operation as
suggested by Bart.
	- Fixed comment style in this function as suggested by Bart.
	- Refactored error prints to the end of the function, which I
think addresses the appearance that the function is nested too deeply
(as it only actually has 3 levels of nesting).

 drivers/scsi/ufs/ufs-sysfs.c |   4 +-
 drivers/scsi/ufs/ufshcd.c    | 109 +++++++++++++++++++++++++++++++------------
 drivers/scsi/ufs/ufshcd.h    |  15 +++---
 3 files changed, 90 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 4726c05bb085..d0365e8bf839 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -227,8 +227,8 @@ static ssize_t ufs_sysfs_read_desc_param(struct ufs_hba *hba,
 	if (param_size > 8)
 		return -EINVAL;
 
-	ret = ufshcd_read_desc_param(hba, desc_id, desc_index,
-				param_offset, desc_buf, param_size);
+	ret = ufshcd_rw_desc_param(hba, UPIU_QUERY_OPCODE_READ_DESC, desc_id,
+				desc_index, param_offset, desc_buf, param_size);
 	if (ret)
 		return -EINVAL;
 	switch (param_size) {
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 0baba3fdb112..110157877823 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -3092,22 +3092,24 @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba,
 EXPORT_SYMBOL(ufshcd_map_desc_id_to_length);
 
 /**
- * ufshcd_read_desc_param - read the specified descriptor parameter
+ * ufshcd_rw_desc_param - read or write the specified descriptor parameter
  * @hba: Pointer to adapter instance
+ * @opcode: indicates whether to read or write
  * @desc_id: descriptor idn value
  * @desc_index: descriptor index
- * @param_offset: offset of the parameter to read
- * @param_read_buf: pointer to buffer where parameter would be read
- * @param_size: sizeof(param_read_buf)
+ * @param_offset: offset of the parameter to read or write
+ * @param_buf: pointer to buffer to be read or written
+ * @param_size: sizeof(param_buf)
  *
  * Return 0 in case of success, non-zero otherwise
  */
-int ufshcd_read_desc_param(struct ufs_hba *hba,
-			   enum desc_idn desc_id,
-			   int desc_index,
-			   u8 param_offset,
-			   u8 *param_read_buf,
-			   u8 param_size)
+int ufshcd_rw_desc_param(struct ufs_hba *hba,
+			 enum query_opcode opcode,
+			 enum desc_idn desc_id,
+			 int desc_index,
+			 u8 param_offset,
+			 u8 *param_buf,
+			 u8 param_size)
 {
 	int ret;
 	u8 *desc_buf;
@@ -3118,7 +3120,8 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 	if (desc_id >= QUERY_DESC_IDN_MAX || !param_size)
 		return -EINVAL;
 
-	/* Get the max length of descriptor from structure filled up at probe
+	/*
+	 * Get the max length of descriptor from structure filled up at probe
 	 * time.
 	 */
 	ret = ufshcd_map_desc_id_to_length(hba, desc_id, &buff_len);
@@ -3130,26 +3133,53 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		return ret;
 	}
 
+	if (param_offset > buff_len)
+		return -EINVAL;
+
+	/* Lock the descriptor mutex to prevent simultaneous changes. */
+	mutex_lock(&hba->desc_mutex);
+
 	/* Check whether we need temp memory */
 	if (param_offset != 0 || param_size < buff_len) {
-		desc_buf = kmalloc(buff_len, GFP_KERNEL);
-		if (!desc_buf)
-			return -ENOMEM;
+		desc_buf = kzalloc(buff_len, GFP_KERNEL);
+		if (!desc_buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		/*
+		 * If it's a write, first read the complete descriptor, then
+		 * copy in the parts being changed.
+		 */
+		if (opcode == UPIU_QUERY_OPCODE_WRITE_DESC) {
+			if (param_offset + param_size > buff_len) {
+				ret = -EINVAL;
+				goto out;
+			}
+
+			ret = ufshcd_query_descriptor_retry(hba,
+						UPIU_QUERY_OPCODE_READ_DESC,
+						desc_id, desc_index, 0,
+						desc_buf, &buff_len);
+
+			if (ret)
+				goto out;
+
+			memcpy(desc_buf + param_offset, param_buf, param_size);
+		}
+
 	} else {
-		desc_buf = param_read_buf;
+		desc_buf = param_buf;
 		is_kmalloc = false;
 	}
 
-	/* Request for full descriptor */
-	ret = ufshcd_query_descriptor_retry(hba, UPIU_QUERY_OPCODE_READ_DESC,
+	/* Read or write the entire descriptor. */
+	ret = ufshcd_query_descriptor_retry(hba, opcode,
 					desc_id, desc_index, 0,
 					desc_buf, &buff_len);
 
-	if (ret) {
-		dev_err(hba->dev, "%s: Failed reading descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
-			__func__, desc_id, desc_index, param_offset, ret);
+	if (ret)
 		goto out;
-	}
 
 	/* Sanity check */
 	if (desc_buf[QUERY_DESC_DESC_TYPE_OFFSET] != desc_id) {
@@ -3159,13 +3189,29 @@ int ufshcd_read_desc_param(struct ufs_hba *hba,
 		goto out;
 	}
 
-	/* Check wherher we will not copy more data, than available */
-	if (is_kmalloc && param_size > buff_len)
-		param_size = buff_len;
+	/*
+	 * Copy data to the output. The offset is already validated to be
+	 * within the buffer.
+	 */
+	if (is_kmalloc && (opcode == UPIU_QUERY_OPCODE_READ_DESC)) {
+		if (param_offset + param_size > buff_len) {
+			memset(param_buf + buff_len - param_offset, 0,
+			       param_offset + param_size - buff_len);
+
+			param_size = buff_len - param_offset;
+		}
+
+		memcpy(param_buf, &desc_buf[param_offset], param_size);
+	}
 
-	if (is_kmalloc)
-		memcpy(param_read_buf, &desc_buf[param_offset], param_size);
 out:
+	mutex_unlock(&hba->desc_mutex);
+	if (ret)
+		dev_err(hba->dev, "Failed %s descriptor. desc_id %d, desc_index %d, param_offset %d, ret %d",
+			opcode == UPIU_QUERY_OPCODE_READ_DESC ?
+			"reading" : "writing",
+			desc_id, desc_index, param_offset, ret);
+
 	if (is_kmalloc)
 		kfree(desc_buf);
 	return ret;
@@ -3177,7 +3223,8 @@ static inline int ufshcd_read_desc(struct ufs_hba *hba,
 				   u8 *buf,
 				   u32 size)
 {
-	return ufshcd_read_desc_param(hba, desc_id, desc_index, 0, buf, size);
+	return ufshcd_rw_desc_param(hba, UPIU_QUERY_OPCODE_READ_DESC, desc_id,
+					desc_index, 0, buf, size);
 }
 
 static inline int ufshcd_read_power_desc(struct ufs_hba *hba,
@@ -3283,8 +3330,9 @@ static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
 	if (!ufs_is_valid_unit_desc_lun(lun))
 		return -EOPNOTSUPP;
 
-	return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun,
-				      param_offset, param_read_buf, param_size);
+	return ufshcd_rw_desc_param(hba, UPIU_QUERY_OPCODE_READ_DESC,
+				    QUERY_DESC_IDN_UNIT, lun, param_offset,
+				    param_read_buf, param_size);
 }
 
 /**
@@ -8019,8 +8067,9 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	INIT_WORK(&hba->eh_work, ufshcd_err_handler);
 	INIT_WORK(&hba->eeh_work, ufshcd_exception_event_handler);
 
-	/* Initialize UIC command mutex */
+	/* Initialize UIC command and descriptor mutexes */
 	mutex_init(&hba->uic_cmd_mutex);
+	mutex_init(&hba->desc_mutex);
 
 	/* Initialize mutex for device management commands */
 	mutex_init(&hba->dev_cmd.lock);
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index bb540a3fd8de..c6305a458100 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -513,6 +513,7 @@ struct ufs_cfg_object {
  * @scsi_block_reqs_cnt: reference counting for scsi block requests
  * @cfg_objects: Stores the array of kobjects created for the config descriptor.
  * @cfg_object_count: Stores the number of elements in cfg_objects.
+ * @desc_mutex: Mutex to serialize modifications to UFS descriptors.
  */
 struct ufs_hba {
 	void __iomem *mmio_base;
@@ -717,6 +718,7 @@ struct ufs_hba {
 
 	struct ufs_cfg_object **cfg_objects;
 	size_t cfg_object_count;
+	struct mutex desc_mutex;
 };
 
 /* Returns true if clocks can be gated. Otherwise false */
@@ -886,12 +888,13 @@ int ufshcd_query_descriptor_retry(struct ufs_hba *hba,
 				  enum desc_idn idn, u8 index,
 				  u8 selector,
 				  u8 *desc_buf, int *buf_len);
-int ufshcd_read_desc_param(struct ufs_hba *hba,
-			   enum desc_idn desc_id,
-			   int desc_index,
-			   u8 param_offset,
-			   u8 *param_read_buf,
-			   u8 param_size);
+int ufshcd_rw_desc_param(struct ufs_hba *hba,
+			 enum query_opcode opcode,
+			 enum desc_idn desc_id,
+			 int desc_index,
+			 u8 param_offset,
+			 u8 *param_buf,
+			 u8 param_size);
 int ufshcd_query_attr(struct ufs_hba *hba, enum query_opcode opcode,
 		      enum attr_idn idn, u8 index, u8 selector, u32 *attr_val);
 int ufshcd_query_flag(struct ufs_hba *hba, enum query_opcode opcode,
-- 
2.13.5

