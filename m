Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128FAC67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05BC020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 04:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="a0JHVY0s";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="D4v1/dVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BC020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbeJWM6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 08:58:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49108 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeJWM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 08:58:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 96F866132B; Tue, 23 Oct 2018 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269383;
        bh=FgJDUGMeaUPWcw+tJm0St9McTokToUFgufDMY3GxVko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0JHVY0sLA+BY0J0ang8Dm761GVOao4Kei1J5ww6+bzmfFk1wpvNCDBNz/buBHT20
         O0BwJLfpspXkcylNr1jQYfTqJQV3xyy9sbVAxAnAkXZyssESU5cqbsCAk13cEYyAgN
         9urFBfhPcHwnVj7EMiUE7mNZhOUCONCiOIXOsm8g=
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 243A061324;
        Tue, 23 Oct 2018 04:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540269382;
        bh=FgJDUGMeaUPWcw+tJm0St9McTokToUFgufDMY3GxVko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4v1/dVEnnwiYLN5niAEUNxX9V2ltPBSRuLlRfDn+VkXuhcB7ZOJBwVWtd3eVUqlm
         xgYB519jROlcGkFayhk95qvaqhpC6uK7+vg6m0J/XtRgTwHlOY5fUz/ukAUYI+gdCk
         C5j8NEqC+AEPRuIPChKcFsFBoux6quSWOni5w2nA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 243A061324
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     subhashj@codeaurora.org, asutoshd@codeaurora.org,
        vivek.gautam@codeaurora.org, evgreen@chromium.org,
        mgautam@codeaurora.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Can Guo <cang@codeaurora.org>
Subject: [PATCH v10 5/6] scsi: ufs: Power on phy after it is initialized
Date:   Mon, 22 Oct 2018 21:36:00 -0700
Message-Id: <1540269361-28185-6-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
References: <1540269361-28185-1-git-send-email-cang@codeaurora.org>
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
Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
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

