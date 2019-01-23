Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5519C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EEA218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bliD08X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAWWMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:12:25 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38314 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbfAWWMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:12:22 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so1880250pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 14:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vS86dMbXk9T821Y98+ooO7myBGM/mG2+gS6GyL4dBDg=;
        b=bliD08X7NZvOT4YWNl9juy+HOHW0BdPKqOWy9ghyZb9oDS/EDXDcEmsKhecnAIERYl
         MBlN0zdYCyvkr7vG9BsQJf2BhcsbkLqqK2+P+1caCwXKLjzD9ebAwnQGpuJaVkCGUsw3
         9PXA60fnQwyu9nybXIj/4i2YoQO5MD8bilcxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vS86dMbXk9T821Y98+ooO7myBGM/mG2+gS6GyL4dBDg=;
        b=PtI1VQRsqgPpaAlnaiIwYuKfxG9PM2fcV+a8rzKswih5y58ucP8+Pc1JwoqvJ5ZU4R
         FH1wCPbrnwgdcQOC63q02tQ8cuHaRqrAMsQnnm1jC5VgIwQyj7TLAJXqnodA1XrEgS41
         nvlGnCk8Z4LiZOauLZtsVRnX4bi4hBoMNixZNsNZMkTpdIGDQfiyBjbvAUGadH+oEH4D
         dCuTqWn4iZVwpzRIRNuKZ8jnVqBbo7vlNv0CgxV7n7emRT2UjMvr/2UzvsJhDL7KBhNp
         ggs19ToAb6GtND6zGM1KhwitB0kaMXffguLL1aznZjotMDiivb6E6tDl+Y6VyM0fOJSP
         FOLQ==
X-Gm-Message-State: AJcUukdLUBAmWPbHk3UXXb1S3exyxYpDqLWbixnnCxDEF01BRxvMiyIo
        IxL4/iChLXM9GoFo0SyPK3AM+Q==
X-Google-Smtp-Source: ALg8bN5WDn8iE/oA1ncQhdifOVtN0iT8IvSPhYjb5PqfXVUlivZbHEBCqYFgrZLsQQ7Lr3+tNSGHPQ==
X-Received: by 2002:a63:4611:: with SMTP id t17mr3624501pga.119.1548281541187;
        Wed, 23 Jan 2019 14:12:21 -0800 (PST)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:ffda:7716:9afc:1301])
        by smtp.gmail.com with ESMTPSA id d18sm27927943pfj.47.2019.01.23.14.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Jan 2019 14:12:20 -0800 (PST)
From:   Evan Green <evgreen@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Can Guo <cang@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        linux-kernel@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>
Subject: [PATCH v2 7/9] phy: qcom-qmp: Utilize UFS reset controller
Date:   Wed, 23 Jan 2019 14:11:35 -0800
Message-Id: <20190123221137.41722-8-evgreen@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190123221137.41722-1-evgreen@chromium.org>
References: <20190123221137.41722-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request the newly minted reset controller from the Qualcomm UFS
controller, and use it to toggle the PHY reset line from within
the PHY. This will allow us to merge the two phases of UFS PHY
initialization.

Signed-off-by: Evan Green <evgreen@chromium.org>

---
Note: this change is dependent on the previous changes, including
the DT changes, in order to expose the reset controller from UFS.

Changes in v2:
- Use devm_* to get the reset (Stephen)
- Clear ufs_reset on error getting it
- Remove needless error print (Stephen)

 drivers/phy/qualcomm/phy-qcom-qmp.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index daf751500232f..721af5706fbb1 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -849,6 +849,9 @@ struct qmp_phy_cfg {
 
 	/* true, if PCS block has no separate SW_RESET register */
 	bool no_pcs_sw_reset;
+
+	/* true if the PHY has a UFS reset control to toggle */
+	bool has_ufsphy_reset;
 };
 
 /**
@@ -897,6 +900,7 @@ struct qmp_phy {
  * @init_count: phy common block initialization count
  * @phy_initialized: indicate if PHY has been initialized
  * @mode: current PHY mode
+ * @ufs_reset: optional UFS PHY reset handle
  */
 struct qcom_qmp {
 	struct device *dev;
@@ -914,6 +918,8 @@ struct qcom_qmp {
 	int init_count;
 	bool phy_initialized;
 	enum phy_mode mode;
+
+	struct reset_control *ufs_reset;
 };
 
 static inline void qphy_setbits(void __iomem *base, u32 offset, u32 val)
@@ -1144,6 +1150,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
 
 	.is_dual_lane_phy	= true,
 	.no_pcs_sw_reset	= true,
+
+	.has_ufsphy_reset	= true,
 };
 
 static const struct qmp_phy_cfg msm8998_usb3phy_cfg = {
@@ -1314,6 +1322,9 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
 		return 0;
 	}
 
+	if (qmp->ufs_reset)
+		reset_control_assert(qmp->ufs_reset);
+
 	if (cfg->has_phy_com_ctrl) {
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_START_CONTROL],
 			     SERDES_START | PCS_START);
@@ -1351,6 +1362,33 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	dev_vdbg(qmp->dev, "Initializing QMP phy\n");
 
+	if (cfg->has_ufsphy_reset) {
+		/*
+		 * Get UFS reset, which is delayed until now to avoid a
+		 * circular dependency where UFS needs its PHY, but the PHY
+		 * needs this UFS reset.
+		 */
+		if (!qmp->ufs_reset) {
+			qmp->ufs_reset =
+				devm_reset_control_get_exclusive(qmp->dev,
+								 "ufsphy");
+
+			if (IS_ERR(qmp->ufs_reset)) {
+				dev_err(qmp->dev,
+					"failed to get UFS reset: %d\n",
+					PTR_ERR(qmp->ufs_reset));
+
+				ret = PTR_ERR(qmp->ufs_reset);
+				qmp->ufs_reset = NULL;
+				return ret;
+			}
+		}
+
+		ret = reset_control_assert(qmp->ufs_reset);
+		if (ret)
+			goto err_lane_rst;
+	}
+
 	ret = qcom_qmp_phy_com_init(qphy);
 	if (ret)
 		return ret;
@@ -1384,6 +1422,12 @@ static int qcom_qmp_phy_init(struct phy *phy)
 
 	qcom_qmp_phy_configure(pcs, cfg->regs, cfg->pcs_tbl, cfg->pcs_tbl_num);
 
+	if (qmp->ufs_reset) {
+		ret = reset_control_deassert(qmp->ufs_reset);
+		if (ret)
+			goto err_lane_rst;
+	}
+
 	/*
 	 * UFS PHY requires the deassert of software reset before serdes start.
 	 * For UFS PHYs that do not have software reset control bits, defer
-- 
2.18.1

