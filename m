Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57EDC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75D912083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1SpvNGch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75D912083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeJYXLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:11:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbeJYWtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:49:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212A020848;
        Thu, 25 Oct 2018 14:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476970;
        bh=v9oMGK6tbQcy8dlqzdnuNGvX8Ry6/GQmHFr91XwwCx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1SpvNGchSLbJhXPbymWThatOTjOXW+R/Q+wQ6rLlOEErJogLn3we2NLzDgJfOQt7T
         fgYQJFvEhsd3KpizY1V49vm0bgbUYfykiZ0A2ebHi5mnsDOLRYX1/fFUBHWSwDo1jS
         vWvqplbExka7v6X7liPAnZgwwx7YgM63J0Ph6FUE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anjali Singhai Jain <anjali.singhai@intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 72/98] i40e: avoid NVM acquire deadlock during NVM update
Date:   Thu, 25 Oct 2018 10:13:57 -0400
Message-Id: <20181025141423.213774-72-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anjali Singhai Jain <anjali.singhai@intel.com>

[ Upstream commit 09f79fd49d94cda5837e9bfd0cb222232b3b6d9f ]

X722 devices use the AdminQ to access the NVM, and this requires taking
the AdminQ lock. Because of this, we lock the AdminQ during
i40e_read_nvm(), which is also called in places where the lock is
already held, such as the firmware update path which wants to lock once
and then unlock when finished after performing several tasks.

Although this should have only affected X722 devices, commit
96a39aed25e6 ("i40e: Acquire NVM lock before reads on all devices",
2016-12-02) added locking for all NVM reads, regardless of device
family.

This resulted in us accidentally causing NVM acquire timeouts on all
devices, causing failed firmware updates which left the eeprom in
a corrupt state.

Create unsafe non-locked variants of i40e_read_nvm_word and
i40e_read_nvm_buffer, __i40e_read_nvm_word and __i40e_read_nvm_buffer
respectively. These variants will not take the NVM lock and are expected
to only be called in places where the NVM lock is already held if
needed.

Since the only caller of i40e_read_nvm_buffer() was in such a path,
remove it entirely in favor of the unsafe version. If necessary we can
always add it back in the future.

Additionally, we now need to hold the NVM lock in i40e_validate_checksum
because the call to i40e_calc_nvm_checksum now assumes that the NVM lock
is held. We can further move the call to read I40E_SR_SW_CHECKSUM_WORD
up a bit so that we do not need to acquire the NVM lock twice.

This should resolve firmware updates and also fix potential raise that
could have caused the driver to report an invalid NVM checksum upon
driver load.

Reported-by: Stefan Assmann <sassmann@kpanic.de>
Fixes: 96a39aed25e6 ("i40e: Acquire NVM lock before reads on all devices", 2016-12-02)
Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 98 ++++++++++++-------
 .../net/ethernet/intel/i40e/i40e_prototype.h  |  2 -
 2 files changed, 60 insertions(+), 40 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index abe290bfc638..8408682efd86 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -266,7 +266,7 @@ static i40e_status i40e_read_nvm_aq(struct i40e_hw *hw, u8 module_pointer,
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
- * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
+ * Reads one 16 bit word from the Shadow RAM using the AdminQ
  **/
 static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 					 u16 *data)
@@ -280,27 +280,49 @@ static i40e_status i40e_read_nvm_word_aq(struct i40e_hw *hw, u16 offset,
 }
 
 /**
- * i40e_read_nvm_word - Reads Shadow RAM
+ * __i40e_read_nvm_word - Reads nvm word, assumes called does the locking
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
  * @data: word read from the Shadow RAM
  *
- * Reads one 16 bit word from the Shadow RAM using the GLNVM_SRCTL register.
+ * Reads one 16 bit word from the Shadow RAM.
+ *
+ * Do not use this function except in cases where the nvm lock is already
+ * taken via i40e_acquire_nvm().
+ **/
+static i40e_status __i40e_read_nvm_word(struct i40e_hw *hw,
+					u16 offset, u16 *data)
+{
+	i40e_status ret_code = 0;
+
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_read_nvm_word_aq(hw, offset, data);
+	else
+		ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
+	return ret_code;
+}
+
+/**
+ * i40e_read_nvm_word - Reads nvm word and acquire lock if necessary
+ * @hw: pointer to the HW structure
+ * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF)
+ * @data: word read from the Shadow RAM
+ *
+ * Reads one 16 bit word from the Shadow RAM.
  **/
 i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 			       u16 *data)
 {
-	enum i40e_status_code ret_code = 0;
+	i40e_status ret_code = 0;
 
 	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-	if (!ret_code) {
-		if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
-			ret_code = i40e_read_nvm_word_aq(hw, offset, data);
-		} else {
-			ret_code = i40e_read_nvm_word_srctl(hw, offset, data);
-		}
-		i40e_release_nvm(hw);
-	}
+	if (ret_code)
+		return ret_code;
+
+	ret_code = __i40e_read_nvm_word(hw, offset, data);
+
+	i40e_release_nvm(hw);
+
 	return ret_code;
 }
 
@@ -393,31 +415,25 @@ static i40e_status i40e_read_nvm_buffer_aq(struct i40e_hw *hw, u16 offset,
 }
 
 /**
- * i40e_read_nvm_buffer - Reads Shadow RAM buffer
+ * __i40e_read_nvm_buffer - Reads nvm buffer, caller must acquire lock
  * @hw: pointer to the HW structure
  * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF).
  * @words: (in) number of words to read; (out) number of words actually read
  * @data: words read from the Shadow RAM
  *
  * Reads 16 bit words (data buffer) from the SR using the i40e_read_nvm_srrd()
- * method. The buffer read is preceded by the NVM ownership take
- * and followed by the release.
+ * method.
  **/
-i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
-				 u16 *words, u16 *data)
+static i40e_status __i40e_read_nvm_buffer(struct i40e_hw *hw,
+					  u16 offset, u16 *words,
+					  u16 *data)
 {
-	enum i40e_status_code ret_code = 0;
+	i40e_status ret_code = 0;
 
-	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE) {
-		ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
-		if (!ret_code) {
-			ret_code = i40e_read_nvm_buffer_aq(hw, offset, words,
-							   data);
-			i40e_release_nvm(hw);
-		}
-	} else {
+	if (hw->flags & I40E_HW_FLAG_AQ_SRCTL_ACCESS_ENABLE)
+		ret_code = i40e_read_nvm_buffer_aq(hw, offset, words, data);
+	else
 		ret_code = i40e_read_nvm_buffer_srctl(hw, offset, words, data);
-	}
 	return ret_code;
 }
 
@@ -499,15 +515,15 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 	data = (u16 *)vmem.va;
 
 	/* read pointer to VPD area */
-	ret_code = i40e_read_nvm_word(hw, I40E_SR_VPD_PTR, &vpd_module);
+	ret_code = __i40e_read_nvm_word(hw, I40E_SR_VPD_PTR, &vpd_module);
 	if (ret_code) {
 		ret_code = I40E_ERR_NVM_CHECKSUM;
 		goto i40e_calc_nvm_checksum_exit;
 	}
 
 	/* read pointer to PCIe Alt Auto-load module */
-	ret_code = i40e_read_nvm_word(hw, I40E_SR_PCIE_ALT_AUTO_LOAD_PTR,
-				      &pcie_alt_module);
+	ret_code = __i40e_read_nvm_word(hw, I40E_SR_PCIE_ALT_AUTO_LOAD_PTR,
+					&pcie_alt_module);
 	if (ret_code) {
 		ret_code = I40E_ERR_NVM_CHECKSUM;
 		goto i40e_calc_nvm_checksum_exit;
@@ -521,7 +537,7 @@ static i40e_status i40e_calc_nvm_checksum(struct i40e_hw *hw,
 		if ((i % I40E_SR_SECTOR_SIZE_IN_WORDS) == 0) {
 			u16 words = I40E_SR_SECTOR_SIZE_IN_WORDS;
 
-			ret_code = i40e_read_nvm_buffer(hw, i, &words, data);
+			ret_code = __i40e_read_nvm_buffer(hw, i, &words, data);
 			if (ret_code) {
 				ret_code = I40E_ERR_NVM_CHECKSUM;
 				goto i40e_calc_nvm_checksum_exit;
@@ -593,14 +609,19 @@ i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 	u16 checksum_sr = 0;
 	u16 checksum_local = 0;
 
+	/* We must acquire the NVM lock in order to correctly synchronize the
+	 * NVM accesses across multiple PFs. Without doing so it is possible
+	 * for one of the PFs to read invalid data potentially indicating that
+	 * the checksum is invalid.
+	 */
+	ret_code = i40e_acquire_nvm(hw, I40E_RESOURCE_READ);
+	if (ret_code)
+		return ret_code;
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum_local);
+	__i40e_read_nvm_word(hw, I40E_SR_SW_CHECKSUM_WORD, &checksum_sr);
+	i40e_release_nvm(hw);
 	if (ret_code)
-		goto i40e_validate_nvm_checksum_exit;
-
-	/* Do not use i40e_read_nvm_word() because we do not want to take
-	 * the synchronization semaphores twice here.
-	 */
-	i40e_read_nvm_word(hw, I40E_SR_SW_CHECKSUM_WORD, &checksum_sr);
+		return ret_code;
 
 	/* Verify read checksum from EEPROM is the same as
 	 * calculated checksum
@@ -612,7 +633,6 @@ i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 	if (checksum)
 		*checksum = checksum_local;
 
-i40e_validate_nvm_checksum_exit:
 	return ret_code;
 }
 
@@ -986,6 +1006,7 @@ static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
 		break;
 
 	case I40E_NVMUPD_CSUM_CON:
+		/* Assumes the caller has acquired the nvm */
 		status = i40e_update_nvm_checksum(hw);
 		if (status) {
 			*perrno = hw->aq.asq_last_status ?
@@ -1000,6 +1021,7 @@ static i40e_status i40e_nvmupd_state_writing(struct i40e_hw *hw,
 		break;
 
 	case I40E_NVMUPD_CSUM_LCB:
+		/* Assumes the caller has acquired the nvm */
 		status = i40e_update_nvm_checksum(hw);
 		if (status) {
 			*perrno = hw->aq.asq_last_status ?
diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 4660c5abc855..6b364118badd 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -311,8 +311,6 @@ i40e_status i40e_acquire_nvm(struct i40e_hw *hw,
 void i40e_release_nvm(struct i40e_hw *hw);
 i40e_status i40e_read_nvm_word(struct i40e_hw *hw, u16 offset,
 					 u16 *data);
-i40e_status i40e_read_nvm_buffer(struct i40e_hw *hw, u16 offset,
-					   u16 *words, u16 *data);
 i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw);
 i40e_status i40e_validate_nvm_checksum(struct i40e_hw *hw,
 						 u16 *checksum);
-- 
2.17.1

