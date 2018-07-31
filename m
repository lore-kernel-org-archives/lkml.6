Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE19C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038E208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="LTkI5Ole";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="envMuXCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7038E208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbeGaLtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:49:17 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48492 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732045AbeGaLtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:49:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 20F6E60B1A; Tue, 31 Jul 2018 10:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031781;
        bh=BW0gx5Ym457x+FGMA3bD2LdtsHlaXGggxSw9ve8l0FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LTkI5OleTQFQ08RM4+Y/T79d9u6zMgtbQsLPdoh6LuM82RrIMTeG1XwK9qJ85ybLB
         y0nuVzrOAhNvp4FlnY1CjAO2Ry6RgBcNLdq19d0BUQQtO+71TWjzfB65H5Dtj+nnp7
         GvHVu23JnTJPoDh+1igIQ8MYYPVTpRHbfquSO9bs=
Received: from CANG02.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BB4060275;
        Tue, 31 Jul 2018 10:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533031780;
        bh=BW0gx5Ym457x+FGMA3bD2LdtsHlaXGggxSw9ve8l0FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=envMuXCe4eKkFVd8tef/RGV4r/FmVOzE4mWEufsFlmbW56KP4yFqvUOvMSGT5mZTx
         1VmsGWMPDZ54TvlDr61S0Yj+kDHdCZokx6f8IiB03E1BBsLMHD7tZ9YYhV+P3WzY4K
         kBW7BKqCWBG5wFP0ut0R6Zkh5ZkrWzChAw7iPo+k=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BB4060275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, mgautam@codeaurora.org, kishon@ti.com,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v8 4/5] scsi: ufs: Power on phy after it is initialized
Date:   Tue, 31 Jul 2018 18:09:13 +0800
Message-Id: <20180731100914.19856-5-cang@codeaurora.org>
X-Mailer: git-send-email 2.15.0.windows.1
In-Reply-To: <20180731100914.19856-1-cang@codeaurora.org>
References: <20180731100914.19856-1-cang@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before UFS PHY is initialized, powering on it has no effect but increases
the PHY's power on count. Then when power on PHY to enable it after phy
initialization where it is really needed, as PHY's power on count is not
zero, again it would do nothing but directly return and leaves the PHY
disabled. This change adds condition checks to phy power on calls which
happen before phy initialization.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufs-qcom.c | 4 +++-
 drivers/scsi/ufs/ufs-qcom.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufs-qcom.c b/drivers/scsi/ufs/ufs-qcom.c
index 2b38db2..4e9d526 100644
--- a/drivers/scsi/ufs/ufs-qcom.c
+++ b/drivers/scsi/ufs/ufs-qcom.c
@@ -288,6 +288,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 			__func__, ret);
 		goto out;
 	}
+	host->is_phy_init = true;
 
 	/* De-assert PHY reset and start serdes */
 	ufs_qcom_deassert_reset(hba);
@@ -1147,7 +1148,8 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
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

