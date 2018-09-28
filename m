Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28574C004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26B72073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R1YB7QOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26B72073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeI2F2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:28:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36801 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbeI2F2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:28:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id b7-v6so5254986pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KyihPjb1FWQhos9va6fsdnqJQMM3IguQJD7USGfF4RY=;
        b=R1YB7QOAn1AFH3Axmg48fq81Dhx7hdu9BIOVIoB65l4jgFxRc0F/vRfc0/8lUF+nlY
         Ze95rl2rd8aHpMLQ7FiBMDKjUcH+5fA7AOhgsj2W+InUxv0mGidd3iUBh/eWRB5CwTxf
         BQfs1m2tvcAaI8R+jPz+YN7tluAEtMsTjCxII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KyihPjb1FWQhos9va6fsdnqJQMM3IguQJD7USGfF4RY=;
        b=HP8T1AjIicHJVZ66WC5fe8VAWou7EbjWfMRO1Vo4W3vKCzxTYKUaYM8swIlrGmDF3v
         K/J2j60Ei8TCjK0Q0jetLQVQdgJW53wQDt1TysyEB+gWahPUSbXL72LZCPk55aqk0Mgl
         +SFZZfY5m6kYZI8ECpgLoG+ScESq+Cu6SqlcCVGahgvFfLaVc3wMPln+oKdA8LmOBOAT
         zgAfRPddUVWvj90wBW15KR/hla2YvcTPVdE3KPKvTFXKW4UztouRJ9GhDnU41nT9pPVT
         BC3pK/uKinQkGxa0cN9TGwvK9vhAaYWzf7C52X7ztJa329xyLP8PGBBxTiQ3QPBJXqsF
         M39Q==
X-Gm-Message-State: ABuFfoiGRsGLnqJEkQOEFtSalGj53hXpnD9PLIY9ROJAl13ulBi+CxTC
        o9EjNo9lbV2Gsw52sMxkve2xRA==
X-Google-Smtp-Source: ACcGV622YVrTkRnxNBwqhAGk4hi2idL3AksztNNCEtF8v4vSEwsoPNNBnZKq+2vdEvIfC83bR66mmw==
X-Received: by 2002:a17:902:263:: with SMTP id 90-v6mr677799plc.190.1538175746755;
        Fri, 28 Sep 2018 16:02:26 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id a2-v6sm7303802pgc.68.2018.09.28.16.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Sep 2018 16:02:25 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2 2/2] scsi: ufs: Execute START_STOP_UNIT during init
Date:   Fri, 28 Sep 2018 16:02:03 -0700
Message-Id: <20180928230203.905-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180928230203.905-1-evgreen@chromium.org>
References: <20180928230203.905-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For UFS devices that are provisioned to have an initial power mode
(bInitPowerMode) of "sleep", Linux will currently fail to enumerate
the device. This is because the UFS specification says that the
device must get a START_STOP_UNIT SCSI command to wake the unit
up before other common initialization features like the device
descriptor will be available to be read.

This script executes a TEST UNIT READY and a START STOP UNIT SCSI
command to bring the device out of sleep mode before performing
additional low-level initialization.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Changes since v1:
	* Refactored into two patches.
	* Converted a leftover raw printk into dev_err.

 drivers/scsi/ufs/ufshcd.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/ufs/ufshcd.h | 11 +++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d5c9ca581905..f19c44c7c2e5 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -243,6 +243,9 @@ static int ufshcd_reset_and_restore(struct ufs_hba *hba);
 static int ufshcd_eh_host_reset_handler(struct scsi_cmnd *cmd);
 static int ufshcd_clear_tm_cmd(struct ufs_hba *hba, int tag);
 static void ufshcd_hba_exit(struct ufs_hba *hba);
+static int ufshcd_set_dev_pwr_mode(struct ufs_hba *hba,
+				   enum ufs_dev_pwr_mode pwr_mode);
+
 static int ufshcd_probe_hba(struct ufs_hba *hba);
 static int __ufshcd_setup_clocks(struct ufs_hba *hba, bool on,
 				 bool skip_ref_clk);
@@ -4221,6 +4224,35 @@ static int ufshcd_complete_dev_init(struct ufs_hba *hba)
 	return err;
 }
 
+/**
+ * ufshcd_power_on() - checks device power state, and sends START STOP UNIT
+ * if needed to bring the device out of sleep mode.
+ * @hba: per-adapter instance
+ *
+ */
+static int ufshcd_power_on(struct ufs_hba *hba)
+{
+	uint32_t current_pwr_mode;
+	int rc;
+
+	rc = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
+		QUERY_ATTR_IDN_POWER_MODE, 0, 0,
+		&current_pwr_mode);
+
+	if (rc) {
+		dev_err(hba->dev, "Failed to get bCurrentPowerMode: %d\n", rc);
+		return rc;
+	}
+
+	if (current_pwr_mode != UFS_PWR_SLEEP)
+		return 0;
+
+	rc = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
+	if (rc)
+		dev_err(hba->dev, "Failed to set power mode: %d\n", rc);
+
+	return rc;
+}
 /**
  * ufshcd_make_hba_operational - Make UFS controller operational
  * @hba: per adapter instance
@@ -6687,6 +6719,17 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	if (ret)
 		goto out;
 
+	/*
+	 * Unit Attention will need to be cleared after a reset and before
+	 * the device can be told to come out of sleep mode.
+	 */
+	hba->wlun_dev_clr_ua = true;
+	ret = ufshcd_power_on(hba);
+	if (ret) {
+		dev_err(hba->dev, "Failed to start unit. err = %d\n", ret);
+		goto out;
+	}
+
 	/* Init check for device descriptor sizes */
 	ufshcd_init_desc_sizes(hba);
 
@@ -6708,7 +6751,6 @@ static int ufshcd_probe_hba(struct ufs_hba *hba)
 	/* UFS device is also active now */
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
-	hba->wlun_dev_clr_ua = true;
 
 	if (ufshcd_get_max_pwr_mode(hba)) {
 		dev_err(hba->dev,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 33fdd3f281ae..7c340a4b6873 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -128,6 +128,17 @@ enum uic_link_state {
 #define ufshcd_set_link_hibern8(hba) ((hba)->uic_link_state = \
 				    UIC_LINK_HIBERN8_STATE)
 
+/* Values for the bCurrentPowerMode attribute */
+enum ufs_pwr_mode {
+	UFS_PWR_IDLE = 0x0,
+	UFS_PWR_PRE_ACTIVE = 0x1,
+	UFS_PWR_ACTIVE = 0x11,
+	UFS_PWR_PRE_SLEEP = 0x20,
+	UFS_PWR_SLEEP = 0x22,
+	UFS_PWR_PRE_PWR_DOWN = 0x30,
+	UFS_PWR_DOWN = 0x33,
+};
+
 /*
  * UFS Power management levels.
  * Each level is in increasing order of power savings.
-- 
2.16.4

