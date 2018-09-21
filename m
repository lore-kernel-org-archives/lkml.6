Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC8ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA37421533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA37421533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbeIUKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:16:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50132 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeIUKQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:16:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D965560F40; Fri, 21 Sep 2018 04:29:19 +0000 (UTC)
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 840A860F72;
        Fri, 21 Sep 2018 04:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 840A860F72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=quic_cang@quicinc.com
From:   Can Guo <quic_cang@quicinc.com>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com
Cc:     Can Guo <cang@codeaurora.org>,
        linux-scsi@vger.kernel.org (open list:UNIVERSAL FLASH STORAGE HOST
        CONTROLLER DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 5/7] scsi: ufs: Power on phy after it is initialized
Date:   Thu, 20 Sep 2018 21:27:58 -0700
Message-Id: <1537504081-29976-6-git-send-email-quic_cang@quicinc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
References: <1537504081-29976-1-git-send-email-quic_cang@quicinc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

Before UFS PHY is initialized, powering on it has no effect but increases
the PHY's power on count. Then when power on PHY to enable it after phy
initialization where it is really needed, as PHY's power on count is not
zero, again it would do nothing but directly return and leaves the PHY
disabled. This change adds condition checks to phy power on calls which
happen before phy initialization.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Evan Green <evgreen@chromium.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 4 +++-
 drivers/scsi/ufs/ufs-qcom.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 698b92d..fa20de4 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -288,6 +288,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out;
 	}
+	host->is_phy_init = true;
 
 	/* De-assert PHY reset and start serdes */
 	ufs_qcom_deassert_reset(hba);
@@ -1176,7 +1177,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
 		return 0;
 
 	if (on && (status == POST_CHANGE)) {
-		phy_power_on(host->generic_phy);
+		if (host->is_phy_init)
+			phy_power_on(host->generic_phy);
 
 		/* enable the device ref clock for HS mode*/
 		if (ufshcd_is_hs_mode(&hba->pwr_info))
diff --git a/drivers/scsi/ufs/ufs-qcom.h b/drivers/scsi/ufs/ufs-qcom.h
index 295f4be..5747aa3 100644
--- a/drivers/scsi/ufs/ufs-qcom.h
+++ b/drivers/scsi/ufs/ufs-qcom.h
@@ -242,6 +242,7 @@ struct ufs_qcom_host {
 	/* Bitmask for enabling debug prints */
 	u32 dbg_print_en;
 	struct ufs_qcom_testbus testbus;
+	bool is_phy_init;
 };
 
 static inline u32
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

