Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F638C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2213121104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdpbrKpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2213121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbeK3BWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:22:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:43900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729224AbeK3BWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:22:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0156C2133F;
        Thu, 29 Nov 2018 14:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501005;
        bh=4PzYO707HyDkFFZM6/hTM1cAQcWRo50kF3DgHGJJzgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MdpbrKpwD4uWnHIAItEvAZ/l0ygbTU2QKbjPwcFbjyiZpVLpf8gjDceUm4YfwTHdj
         CjWMCralklw8IKszZrZfiYNcVs4m5LoF1l+bjxoWnnRXp8QPsCsbiXb6DiVHPJd30J
         tHVLy41zblaBOIXQ1zTBbeXcN1Maggmmhlj9XvGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yaniv Gardi <ygardi@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 3.18 76/83] scsi: ufs: fix bugs related to null pointer access and array size
Date:   Thu, 29 Nov 2018 15:12:34 +0100
Message-Id: <20181129140142.335334269@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
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

From: Yaniv Gardi <ygardi@codeaurora.org>

commit e3ce73d69aff44421d7899b235fec5ac2c306ff4 upstream.

In this change there are a few fixes of possible NULL pointer access and
possible access to index that exceeds array boundaries.

Signed-off-by: Yaniv Gardi <ygardi@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufs.h    |    3 ++-
 drivers/scsi/ufs/ufshcd.c |   25 +++++++++++++++++++------
 2 files changed, 21 insertions(+), 7 deletions(-)

--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -45,6 +45,7 @@
 #define QUERY_DESC_MIN_SIZE       2
 #define QUERY_OSF_SIZE            (GENERAL_UPIU_REQUEST_SIZE - \
 					(sizeof(struct utp_upiu_header)))
+#define RESPONSE_UPIU_SENSE_DATA_LENGTH	18
 
 #define UPIU_HEADER_DWORD(byte3, byte2, byte1, byte0)\
 			cpu_to_be32((byte3 << 24) | (byte2 << 16) |\
@@ -383,7 +384,7 @@ struct utp_cmd_rsp {
 	__be32 residual_transfer_count;
 	__be32 reserved[4];
 	__be16 sense_data_len;
-	u8 sense_data[18];
+	u8 sense_data[RESPONSE_UPIU_SENSE_DATA_LENGTH];
 };
 
 /**
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -796,10 +796,14 @@ static inline void ufshcd_copy_sense_dat
 	int len;
 	if (lrbp->sense_buffer &&
 	    ufshcd_get_rsp_upiu_data_seg_len(lrbp->ucd_rsp_ptr)) {
+		int len_to_copy;
+
 		len = be16_to_cpu(lrbp->ucd_rsp_ptr->sr.sense_data_len);
+		len_to_copy = min_t(int, RESPONSE_UPIU_SENSE_DATA_LENGTH, len);
+
 		memcpy(lrbp->sense_buffer,
 			lrbp->ucd_rsp_ptr->sr.sense_data,
-			min_t(int, len, SCSI_SENSE_BUFFERSIZE));
+			min_t(int, len_to_copy, SCSI_SENSE_BUFFERSIZE));
 	}
 }
 
@@ -5161,7 +5165,10 @@ EXPORT_SYMBOL(ufshcd_system_suspend);
 
 int ufshcd_system_resume(struct ufs_hba *hba)
 {
-	if (!hba || !hba->is_powered || pm_runtime_suspended(hba->dev))
+	if (!hba)
+		return -EINVAL;
+
+	if (!hba->is_powered || pm_runtime_suspended(hba->dev))
 		/*
 		 * Let the runtime resume take care of resuming
 		 * if runtime suspended.
@@ -5182,7 +5189,10 @@ EXPORT_SYMBOL(ufshcd_system_resume);
  */
 int ufshcd_runtime_suspend(struct ufs_hba *hba)
 {
-	if (!hba || !hba->is_powered)
+	if (!hba)
+		return -EINVAL;
+
+	if (!hba->is_powered)
 		return 0;
 
 	return ufshcd_suspend(hba, UFS_RUNTIME_PM);
@@ -5212,10 +5222,13 @@ EXPORT_SYMBOL(ufshcd_runtime_suspend);
  */
 int ufshcd_runtime_resume(struct ufs_hba *hba)
 {
-	if (!hba || !hba->is_powered)
+	if (!hba)
+		return -EINVAL;
+
+	if (!hba->is_powered)
 		return 0;
-	else
-		return ufshcd_resume(hba, UFS_RUNTIME_PM);
+
+	return ufshcd_resume(hba, UFS_RUNTIME_PM);
 }
 EXPORT_SYMBOL(ufshcd_runtime_resume);
 


