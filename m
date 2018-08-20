Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A0BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9691421531
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q6e011Vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9691421531
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbeHUAwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:52:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44702 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:52:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so7406242pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7mCZOOPy7OmxeEVwiIf6hbaiSaHyxkuwgNP8dwHl4x8=;
        b=Q6e011VbutdL7HJBk9EvrWsq59Bu6ptTScOI/upBK/rjm4QpFvO8kjeYQ6I6Zo5ao2
         IK5Io7FIdrpFsEkoIE4K8hmQZKFpsVg6qUXhd7tJSvOS2qV9t8Rmn67o42j28pYMYswV
         NGgytzNJhA39Q+AhnhOZNwv/YQfORP6OncPQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7mCZOOPy7OmxeEVwiIf6hbaiSaHyxkuwgNP8dwHl4x8=;
        b=j7Uj/XgwbW9NLmflj8AQxZunzKxfH1UDI77w3N9UBmijQctvP8p7dhdg0j/EO78a/K
         GbidnKSRWpSLSj2G/lRIdaDDhgKLj8HW8LjdJFJct+ZQJLHjfsoFO0gPHhgeBt4GAMTN
         k+X2Jndv5UBgINZxxTEPEYwdW+mMrO3da9gF73B1jmFZVSwQ7dZGMNWNF8BcBIyLsPWA
         Z+iuExlTXCanHzYXFziIS01EXFEtXD7TKVDJWHdkcMo+CFTt/O1tSZU0sa9rJd2J1zLH
         WM29NOoOSho9c7J6SCiX7Gn1tuofPnpIaWnjjfaDwIkxxHUDUaf9xiM1bevkHFB8fYnT
         LlDw==
X-Gm-Message-State: AOUpUlEMFud6BUPBDPcKxvXgOcHih3BKyvjfPPu4EJ19P4eq2WFHbb13
        QicaRVb+cC64DwEYJQcbQpupGw==
X-Google-Smtp-Source: AA+uWPwFf7RvMowtBSfvn0RpaB0kf+UcAZjRDqAAzOKKGc3qi3Ok9eQXKWuCS8UJQqSYXwGQYv5gpQ==
X-Received: by 2002:a63:5b0f:: with SMTP id p15-v6mr6599803pgb.122.1534800904265;
        Mon, 20 Aug 2018 14:35:04 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id b76-v6sm21200315pfj.184.2018.08.20.14.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 Aug 2018 14:35:03 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH] scsi: ufs: Make sysfs flags writable
Date:   Mon, 20 Aug 2018 14:34:55 -0700
Message-Id: <20180820213455.15092-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes the UFS controller's sysfs flags writable. This
will enable users to provision unprovisioned devices, and experiment
with device features.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
This is a follow-on patch to another patch [1] that makes the UFS attributes
writable.

[1] https://lore.kernel.org/patchwork/patch/972959/

 Documentation/ABI/testing/sysfs-driver-ufs | 18 +++++++---
 drivers/scsi/ufs/ufs-sysfs.c               | 54 +++++++++++++++++++++++++-----
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 016724ec26d5..6df8ccbc94f3 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -619,7 +619,6 @@ Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the device init status. The full information
 		about the flag could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/permanent_wpe
 Date:		February 2018
@@ -627,7 +626,8 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether permanent write protection is enabled.
 		The full information about the flag could be found at
 		UFS specifications 2.1.
-		The file is read only.
+		Warning: This flag can only be written one time within the
+		lifetime of the device. Once set, it cannot be unset.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/power_on_wpe
 Date:		February 2018
@@ -636,7 +636,7 @@ Description:	This file shows whether write protection is enabled on all
 		logical units configured as power on write protected. The
 		full information about the flag could be found at
 		UFS specifications 2.1.
-		The file is read only.
+		Once set, this flag cannot be cleared without a device reset.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/bkops_enable
 Date:		February 2018
@@ -644,7 +644,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the device background operations are
 		enabled. The full information about the flag could be
 		found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/life_span_mode_enable
 Date:		February 2018
@@ -654,13 +653,22 @@ Description:	This file shows whether the device life span mode is enabled.
 		UFS specifications 2.1.
 		The file is read only.
 
+What:		/sys/bus/platform/drivers/ufshcd/*/flags/purge_enable
+Date:		August 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shall only be set when the command queue of all
+		logical units are empty and purge status is idle. This flag is
+		automatically cleared by the UFS device when the operation
+		completes or an error occurs. This flag is write-only, it
+		cannot be read. Complete information about the flag can be
+		found in the UFS specification 2.20A.
+
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/phy_resource_removal
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether physical resource removal is enable.
 		The full information about the flag could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/busy_rtc
 Date:		February 2018
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 8d9332bb7d0c..2da927f4b7ff 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -616,7 +616,7 @@ static const struct attribute_group ufs_sysfs_string_descriptors_group = {
 	.attrs = ufs_sysfs_string_descriptors,
 };
 
-#define UFS_FLAG(_name, _uname)						\
+#define UFS_FLAG_SHOW(_name, _uname)					\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
@@ -626,17 +626,52 @@ static ssize_t _name##_show(struct device *dev,				\
 		QUERY_FLAG_IDN##_uname, &flag))				\
 		return -EINVAL;						\
 	return sprintf(buf, "%s\n", flag ? "true" : "false");		\
+}
+
+#define UFS_FLAG_STORE(_name, _uname)					\
+static ssize_t _name##_store(struct device *dev,			\
+	struct device_attribute *attr, const char *buf,			\
+	size_t count)							\
+{									\
+	bool flag;							\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	enum query_opcode op;						\
+	if (kstrtobool(buf, &flag))					\
+		return -EINVAL;						\
+	op = flag ? UPIU_QUERY_OPCODE_SET_FLAG :			\
+		UPIU_QUERY_OPCODE_CLEAR_FLAG;				\
+	if (ufshcd_query_flag(hba, op, QUERY_FLAG_IDN##_uname, NULL))	\
+		return -EINVAL;						\
+	return count;							\
 }									\
+
+#define UFS_FLAG_RO(_name, _uname)	\
+UFS_FLAG_SHOW(_name, _uname)		\
 static DEVICE_ATTR_RO(_name)
 
-UFS_FLAG(device_init, _FDEVICEINIT);
-UFS_FLAG(permanent_wpe, _PERMANENT_WPE);
-UFS_FLAG(power_on_wpe, _PWR_ON_WPE);
-UFS_FLAG(bkops_enable, _BKOPS_EN);
-UFS_FLAG(life_span_mode_enable, _LIFE_SPAN_MODE_ENABLE);
-UFS_FLAG(phy_resource_removal, _FPHYRESOURCEREMOVAL);
-UFS_FLAG(busy_rtc, _BUSY_RTC);
-UFS_FLAG(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
+#define UFS_FLAG_WO(_name, _uname)					\
+UFS_FLAG_STORE(_name, _uname)						\
+static ssize_t _name##_show(struct device *dev,				\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	return -EOPNOTSUPP;						\
+}									\
+static DEVICE_ATTR_RW(_name)
+
+#define UFS_FLAG_RW(_name, _uname)					\
+UFS_FLAG_SHOW(_name, _uname)						\
+UFS_FLAG_STORE(_name, _uname)						\
+static DEVICE_ATTR_RW(_name)
+
+UFS_FLAG_RW(device_init, _FDEVICEINIT);
+UFS_FLAG_RW(permanent_wpe, _PERMANENT_WPE);
+UFS_FLAG_RW(power_on_wpe, _PWR_ON_WPE);
+UFS_FLAG_RW(bkops_enable, _BKOPS_EN);
+UFS_FLAG_RO(life_span_mode_enable, _LIFE_SPAN_MODE_ENABLE);
+UFS_FLAG_WO(purge_enable, _PURGE_ENABLE);
+UFS_FLAG_RW(phy_resource_removal, _FPHYRESOURCEREMOVAL);
+UFS_FLAG_RO(busy_rtc, _BUSY_RTC);
+UFS_FLAG_RO(disable_fw_update, _PERMANENTLY_DISABLE_FW_UPDATE);
 
 static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_device_init.attr,
@@ -644,6 +679,7 @@ static struct attribute *ufs_sysfs_device_flags[] = {
 	&dev_attr_power_on_wpe.attr,
 	&dev_attr_bkops_enable.attr,
 	&dev_attr_life_span_mode_enable.attr,
+	&dev_attr_purge_enable.attr,
 	&dev_attr_phy_resource_removal.attr,
 	&dev_attr_busy_rtc.attr,
 	&dev_attr_disable_fw_update.attr,
-- 
2.16.4

