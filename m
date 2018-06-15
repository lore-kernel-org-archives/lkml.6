Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB71AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634FD208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ir8pDYGm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 634FD208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756633AbeFOVC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:02:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33235 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756463AbeFOVCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:02:19 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so5397775plb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6rVGZkeqg7JOQwIe0jgS80EjvVJAXUTljpQy9U9qcf8=;
        b=Ir8pDYGmpLfNcc6hkqyFCr0LioaN2HO/UyLZTXUp5BKrQrFBVX8vViR7znTEXXWzzF
         7KKJyVb3KSDrXMD2Lx8n+zOdELbl4YE4Q1bUvwQvBCsjlg7Tr+/GYcc7j2P+PrfzGsp4
         QySfXwD+eR2CnEl5yhuo2jXYd9p4Cer0nYBpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6rVGZkeqg7JOQwIe0jgS80EjvVJAXUTljpQy9U9qcf8=;
        b=oZcRHgpN1tEOuxxh+nqFKAGkxOjNrhFAXhOPTIgNTvQQ2Nc55JeNhva2+tmwQihGdh
         4awB16Iesfx3DtAzrsBVV3quebCnkZtyctolabCNIlfhh+Havez2+LgnnyFtDt6Pf6e9
         wl+dX6sVb23W5nKAIQjNppUxYRyWOjmiv2YJG0ghQ56kblvu4EsWQ06Whxsvlwpub8Nz
         6jxUCsi7xm7OqJv2MpYkrrGSpVm+vUAPfpO2B3cP/DdlzCokbtM95oU8KVg1sfyvF555
         vJ6U0MNk3br+sSEdgTPGsglvBH/Uz+dWAwJq1ytdrayE02kQRK/X3fr6me+y3ZjDvyrY
         15QA==
X-Gm-Message-State: APt69E1GVLbbAf0Pn9NGF/qSu9/hs+1BcU7grVmEsvKwZPJEBAfFVy8/
        y+C6mnyur2dJrb0sXUkDx1K+NQ==
X-Google-Smtp-Source: ADUXVKKXSslKn73vJ/UyCW3S+v8JhsNPctYzq4vrLYw/QjVMZqrJ4vTlN3JfLZKdJjGvPYAo7c8iLw==
X-Received: by 2002:a17:902:5a87:: with SMTP id r7-v6mr3740337pli.78.1529096539388;
        Fri, 15 Jun 2018 14:02:19 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id v13-v6sm17664346pfa.131.2018.06.15.14.02.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 15 Jun 2018 14:02:18 -0700 (PDT)
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
Subject: [PATCH v2 2/4] scsi: ufs: Make sysfs attributes writable
Date:   Fri, 15 Jun 2018 14:00:47 -0700
Message-Id: <20180615210049.126123-3-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180615210049.126123-1-evgreen@chromium.org>
References: <20180615210049.126123-1-evgreen@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes the UFS controller's sysfs attributes writable, which
will enable users to provision unprovisioned UFS devices, or
re-provision unlocked UFS devices.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Changes since v1:
	- Fixed u32 cast in _store function as suggested by Bart.
	- Squashed documentation change into this change.

 Documentation/ABI/testing/sysfs-driver-ufs | 17 +--------
 drivers/scsi/ufs/ufs-sysfs.c               | 58 ++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index eebd95fb1db5..d7477fffe0d1 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -841,7 +841,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the boot lun enabled UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/current_power_mode
 Date:		February 2018
@@ -849,7 +848,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the current power mode UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/active_icc_level
 Date:		February 2018
@@ -857,7 +855,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the active icc level UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ooo_data_enabled
 Date:		February 2018
@@ -865,7 +862,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the out of order data transfer enabled UFS
 		device attribute. The full information about the attribute
 		could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/bkops_status
 Date:		February 2018
@@ -873,7 +869,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the background operations status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/purge_status
 Date:		February 2018
@@ -881,7 +876,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the purge operation status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_in_size
 Date:		February 2018
@@ -889,7 +883,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum data size in a DATA IN
 		UPIU. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_out_size
 Date:		February 2018
@@ -897,7 +890,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of bytes that can be
 		requested with a READY TO TRANSFER UPIU. The full information
 		about the attribute could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/reference_clock_frequency
 Date:		February 2018
@@ -905,14 +897,13 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the reference clock frequency UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/configuration_descriptor_lock
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows whether the configuration descriptor is locked.
 		The full information about the attribute could be found at
-		UFS specifications 2.1. The file is read only.
+		UFS specifications 2.1.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_number_of_rtt
 Date:		February 2018
@@ -921,7 +912,6 @@ Description:	This file provides the maximum current number of
 		outstanding RTTs in device that is allowed. The full
 		information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_control
 Date:		February 2018
@@ -929,7 +919,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event control UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_status
 Date:		February 2018
@@ -937,7 +926,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ffu_status
 Date:		February 2018
@@ -945,14 +933,12 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the ffu status UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_state
 Date:		February 2018
 Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file show the PSA feature status. The full information
 		about the attribute could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/psa_data_size
 Date:		February 2018
@@ -961,7 +947,6 @@ Description:	This file shows the amount of data that the host plans to
 		load to all logical units in pre-soldering state.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 
 What:		/sys/class/scsi_device/*/device/dyn_cap_needed
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 7ac1440c82eb..4726c05bb085 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -781,7 +781,7 @@ static const struct attribute_group ufs_sysfs_flags_group = {
 	.attrs = ufs_sysfs_device_flags,
 };
 
-#define UFS_ATTRIBUTE(_name, _uname)					\
+#define UFS_ATTRIBUTE_SHOW(_name, _uname)				\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
@@ -791,25 +791,45 @@ static ssize_t _name##_show(struct device *dev,				\
 		QUERY_ATTR_IDN##_uname, 0, 0, &value))			\
 		return -EINVAL;						\
 	return sprintf(buf, "0x%08X\n", value);				\
-}									\
-static DEVICE_ATTR_RO(_name)
+}
 
-UFS_ATTRIBUTE(boot_lun_enabled, _BOOT_LU_EN);
-UFS_ATTRIBUTE(current_power_mode, _POWER_MODE);
-UFS_ATTRIBUTE(active_icc_level, _ACTIVE_ICC_LVL);
-UFS_ATTRIBUTE(ooo_data_enabled, _OOO_DATA_EN);
-UFS_ATTRIBUTE(bkops_status, _BKOPS_STATUS);
-UFS_ATTRIBUTE(purge_status, _PURGE_STATUS);
-UFS_ATTRIBUTE(max_data_in_size, _MAX_DATA_IN);
-UFS_ATTRIBUTE(max_data_out_size, _MAX_DATA_OUT);
-UFS_ATTRIBUTE(reference_clock_frequency, _REF_CLK_FREQ);
-UFS_ATTRIBUTE(configuration_descriptor_lock, _CONF_DESC_LOCK);
-UFS_ATTRIBUTE(max_number_of_rtt, _MAX_NUM_OF_RTT);
-UFS_ATTRIBUTE(exception_event_control, _EE_CONTROL);
-UFS_ATTRIBUTE(exception_event_status, _EE_STATUS);
-UFS_ATTRIBUTE(ffu_status, _FFU_STATUS);
-UFS_ATTRIBUTE(psa_state, _PSA_STATE);
-UFS_ATTRIBUTE(psa_data_size, _PSA_DATA_SIZE);
+#define UFS_ATTRIBUTE_RO(_name, _uname)					\
+UFS_ATTRIBUTE_SHOW(_name, _uname)					\
+DEVICE_ATTR_RO(_name)
+
+#define UFS_ATTRIBUTE_RW(_name, _uname)					\
+UFS_ATTRIBUTE_SHOW(_name, _uname)					\
+static ssize_t _name##_store(struct device *dev,			\
+		struct device_attribute *attr, const char *buf,		\
+		size_t count)						\
+{									\
+	struct ufs_hba *hba = dev_get_drvdata(dev);			\
+	u32 value;							\
+	if (kstrtou32(buf, 0, &value))					\
+		return -EINVAL;						\
+	if (ufshcd_query_attr(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,	\
+		QUERY_ATTR_IDN##_uname, 0, 0, &value))			\
+		return -EINVAL;						\
+	return count;							\
+}									\
+static DEVICE_ATTR_RW(_name)
+
+UFS_ATTRIBUTE_RW(boot_lun_enabled, _BOOT_LU_EN);
+UFS_ATTRIBUTE_RO(current_power_mode, _POWER_MODE);
+UFS_ATTRIBUTE_RW(active_icc_level, _ACTIVE_ICC_LVL);
+UFS_ATTRIBUTE_RW(ooo_data_enabled, _OOO_DATA_EN);
+UFS_ATTRIBUTE_RO(bkops_status, _BKOPS_STATUS);
+UFS_ATTRIBUTE_RO(purge_status, _PURGE_STATUS);
+UFS_ATTRIBUTE_RW(max_data_in_size, _MAX_DATA_IN);
+UFS_ATTRIBUTE_RW(max_data_out_size, _MAX_DATA_OUT);
+UFS_ATTRIBUTE_RW(reference_clock_frequency, _REF_CLK_FREQ);
+UFS_ATTRIBUTE_RW(configuration_descriptor_lock, _CONF_DESC_LOCK);
+UFS_ATTRIBUTE_RW(max_number_of_rtt, _MAX_NUM_OF_RTT);
+UFS_ATTRIBUTE_RW(exception_event_control, _EE_CONTROL);
+UFS_ATTRIBUTE_RW(exception_event_status, _EE_STATUS);
+UFS_ATTRIBUTE_RO(ffu_status, _FFU_STATUS);
+UFS_ATTRIBUTE_RO(psa_state, _PSA_STATE);
+UFS_ATTRIBUTE_RO(psa_data_size, _PSA_DATA_SIZE);
 
 static struct attribute *ufs_sysfs_attributes[] = {
 	&dev_attr_boot_lun_enabled.attr,
-- 
2.13.5

