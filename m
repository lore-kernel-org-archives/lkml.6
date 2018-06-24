Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A68C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8A6C250AE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:47:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A6C250AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933726AbeFXPrE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:47:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33122 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:47:01 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4AED49F;
        Sun, 24 Jun 2018 15:46:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.17 63/70] iwlwifi: fw: harden page loading code
Date:   Sun, 24 Jun 2018 23:22:55 +0800
Message-Id: <20180624142744.420941452@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Coelho <luciano.coelho@intel.com>

commit 9039d985811d5b109b58b202b7594fd24e433fed upstream.

The page loading code trusts the data provided in the firmware images
a bit too much and may cause a buffer overflow or copy unknown data if
the block sizes don't match what we expect.

To prevent potential problems, harden the code by checking if the
sizes we are copying are what we expect.

Cc: stable@vger.kernel.org
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/fw/paging.c |   49 ++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 8 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/fw/paging.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/paging.c
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -30,6 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018        Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -163,7 +165,7 @@ static int iwl_alloc_fw_paging_mem(struc
 static int iwl_fill_paging_mem(struct iwl_fw_runtime *fwrt,
 			       const struct fw_img *image)
 {
-	int sec_idx, idx;
+	int sec_idx, idx, ret;
 	u32 offset = 0;
 
 	/*
@@ -190,17 +192,23 @@ static int iwl_fill_paging_mem(struct iw
 	 */
 	if (sec_idx >= image->num_sec - 1) {
 		IWL_ERR(fwrt, "Paging: Missing CSS and/or paging sections\n");
-		iwl_free_fw_paging(fwrt);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err;
 	}
 
 	/* copy the CSS block to the dram */
 	IWL_DEBUG_FW(fwrt, "Paging: load paging CSS to FW, sec = %d\n",
 		     sec_idx);
 
+	if (image->sec[sec_idx].len > fwrt->fw_paging_db[0].fw_paging_size) {
+		IWL_ERR(fwrt, "CSS block is larger than paging size\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
 	memcpy(page_address(fwrt->fw_paging_db[0].fw_paging_block),
 	       image->sec[sec_idx].data,
-	       fwrt->fw_paging_db[0].fw_paging_size);
+	       image->sec[sec_idx].len);
 	dma_sync_single_for_device(fwrt->trans->dev,
 				   fwrt->fw_paging_db[0].fw_paging_phys,
 				   fwrt->fw_paging_db[0].fw_paging_size,
@@ -221,6 +229,14 @@ static int iwl_fill_paging_mem(struct iw
 	for (idx = 1; idx < fwrt->num_of_paging_blk; idx++) {
 		struct iwl_fw_paging *block = &fwrt->fw_paging_db[idx];
 
+		if (block->fw_paging_size > image->sec[sec_idx].len - offset) {
+			IWL_ERR(fwrt,
+				"Paging: paging size is larger than remaining data in block %d\n",
+				idx);
+			ret = -EINVAL;
+			goto err;
+		}
+
 		memcpy(page_address(block->fw_paging_block),
 		       image->sec[sec_idx].data + offset,
 		       block->fw_paging_size);
@@ -231,19 +247,32 @@ static int iwl_fill_paging_mem(struct iw
 
 		IWL_DEBUG_FW(fwrt,
 			     "Paging: copied %d paging bytes to block %d\n",
-			     fwrt->fw_paging_db[idx].fw_paging_size,
-			     idx);
+			     block->fw_paging_size, idx);
+
+		offset += block->fw_paging_size;
 
-		offset += fwrt->fw_paging_db[idx].fw_paging_size;
+		if (offset > image->sec[sec_idx].len) {
+			IWL_ERR(fwrt,
+				"Paging: offset goes over section size\n");
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
 	/* copy the last paging block */
 	if (fwrt->num_of_pages_in_last_blk > 0) {
 		struct iwl_fw_paging *block = &fwrt->fw_paging_db[idx];
 
+		if (image->sec[sec_idx].len - offset > block->fw_paging_size) {
+			IWL_ERR(fwrt,
+				"Paging: last block is larger than paging size\n");
+			ret = -EINVAL;
+			goto err;
+		}
+
 		memcpy(page_address(block->fw_paging_block),
 		       image->sec[sec_idx].data + offset,
-		       FW_PAGING_SIZE * fwrt->num_of_pages_in_last_blk);
+		       image->sec[sec_idx].len - offset);
 		dma_sync_single_for_device(fwrt->trans->dev,
 					   block->fw_paging_phys,
 					   block->fw_paging_size,
@@ -255,6 +284,10 @@ static int iwl_fill_paging_mem(struct iw
 	}
 
 	return 0;
+
+err:
+	iwl_free_fw_paging(fwrt);
+	return ret;
 }
 
 static int iwl_save_fw_paging(struct iwl_fw_runtime *fwrt,


