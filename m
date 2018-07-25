Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D54C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85EE20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:14:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nf8x0TJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B85EE20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbeGYV2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:28:12 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbeGYV2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:28:12 -0400
Received: by mail-pg1-f195.google.com with SMTP id z8-v6so5996906pgu.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=p1nstl7xYbpCtM+k7lf0qOT22eq1KmNR/GKfM6PTs54=;
        b=nf8x0TJYIIWGHGaCmEJM4nc7hmDfaWpATx1cu3OR7Cu1/HDwrvCo9/CiHtQ4i1hb4j
         s3l6w+KifI5sSKcSoPY9tQTfmkPLBwpzaKdfRUfQCmCJJWlvumhEU6mghwHAU26TCqdG
         G/iOgZf2t3euH+jRMXpUuK7k4o+86qHGjxZrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=p1nstl7xYbpCtM+k7lf0qOT22eq1KmNR/GKfM6PTs54=;
        b=b+Mbhxbh+aauvQH+q95sLEzsPBM7ptkiFW1W017ImQ405GdUlUsLJCj0WCS9nvKDKh
         uQ3ijyfMv75ghH/f4PcOCDBCxe5YRc71jIH0kgKBn1wOF9RAoZOgmSwubhfAtpLXQc3W
         9rGlxybLBf6r7U2Lt2ppUlRTv9YsXC+FAsM6yRGyS00E9Ylc5LMq3xBH1UtAGOpeEJQY
         FdbZFT7mOMrmsCjFy84XNBSkWYMhYrXrr0AzCZlaDoWqI4e1PpBP2N2pldQLSm+oLb/M
         bEXDrlXCNKcCUMs3kLsX0V/uUsx5h6OD+TxguP7YZ7fk9LYlu9/51UdEeJBX+P7MGfbS
         jtLg==
X-Gm-Message-State: AOUpUlGpWbQqnTfYbyqpTyrHVqkp6doH+lJ/Q/pgWrNtcaiAAJVAK/Ep
        P86PLrmJtDun1hSLq5xzyUf7IDQcw34=
X-Google-Smtp-Source: AAOMgpfHulzk/EVR9dlQV9FKtWJX5KhEWxJWd2mWWqddZAyfO0AMFbGdMvBi1K+YYbawA3mF2/Lhaw==
X-Received: by 2002:a65:608b:: with SMTP id t11-v6mr21930967pgu.259.1532549696715;
        Wed, 25 Jul 2018 13:14:56 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id o21-v6sm23634739pfa.54.2018.07.25.13.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jul 2018 13:14:55 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanislav Nijnikov <stanislav.nijnikov@wdc.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH v3] scsi: ufs: Make sysfs attributes writable
Date:   Wed, 25 Jul 2018 13:14:52 -0700
Message-Id: <20180725201452.81235-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change makes the UFS controller's sysfs attributes writable, which
will enable users to modify attributes. This can be useful during factory
provisioning for setting up critical attributes like the reference clock
frequency.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
Configfs was determined to be the preferred mechanism for writing the
config descriptor, but attributes also need to be written during setup,
and are already present in sysfs. Making these attributes writable is
also helpful for debugging and experimentation.

Changes since v2:
	- Removed the configuration descriptor changes from the series,
since configfs was the preferred way to write to that, leaving only
this change.

Changes since v1:
	- Reworked the interface to show each unit of the config
descriptor as a separate directory, rather than the previous method I
had of a file for selecting the unit, and then a common set of files
that interacted with whichever unit was selected. I did some kobject
magic to accomplish this. I noticed from Greg KH's reply to Sayali's
patches [1] that configfs might be the preferred method. Let me know
if I should abandon this series in favor of Sayali's, with the
possible exception of "Make sysfs attributes writable".
	- Squashed documentation changes into their respective code
changes.
	- I decided to keep the config descriptor attributes as their
own files, rather than hiding writes behind device descriptor and unit
descriptor, as I think that's more future proof and true to the UFS spec.

[1] https://lkml.org/lkml/2018/6/8/210

 Documentation/ABI/testing/sysfs-driver-ufs | 17 +--------
 drivers/scsi/ufs/ufs-sysfs.c               | 58 ++++++++++++++++++++----------
 2 files changed, 40 insertions(+), 35 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 016724ec26d5..44f3b9691e59 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -685,7 +685,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the boot lun enabled UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/current_power_mode
 Date:		February 2018
@@ -693,7 +692,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the current power mode UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/active_icc_level
 Date:		February 2018
@@ -701,7 +699,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the active icc level UFS device attribute.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ooo_data_enabled
 Date:		February 2018
@@ -709,7 +706,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the out of order data transfer enabled UFS
 		device attribute. The full information about the attribute
 		could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/bkops_status
 Date:		February 2018
@@ -717,7 +713,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the background operations status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/purge_status
 Date:		February 2018
@@ -725,7 +720,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the purge operation status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_in_size
 Date:		February 2018
@@ -733,7 +727,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum data size in a DATA IN
 		UPIU. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/max_data_out_size
 Date:		February 2018
@@ -741,7 +734,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file shows the maximum number of bytes that can be
 		requested with a READY TO TRANSFER UPIU. The full information
 		about the attribute could be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/reference_clock_frequency
 Date:		February 2018
@@ -749,14 +741,13 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
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
@@ -765,7 +756,6 @@ Description:	This file provides the maximum current number of
 		outstanding RTTs in device that is allowed. The full
 		information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_control
 Date:		February 2018
@@ -773,7 +763,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event control UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/exception_event_status
 Date:		February 2018
@@ -781,7 +770,6 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
 Description:	This file provides the exception event status UFS device
 		attribute. The full information about the attribute could
 		be found at UFS specifications 2.1.
-		The file is read only.
 
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/ffu_status
 Date:		February 2018
@@ -789,14 +777,12 @@ Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
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
@@ -805,7 +791,6 @@ Description:	This file shows the amount of data that the host plans to
 		load to all logical units in pre-soldering state.
 		The full information about the attribute could be found at
 		UFS specifications 2.1.
-		The file is read only.
 
 
 What:		/sys/class/scsi_device/*/device/dyn_cap_needed
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 8d9332bb7d0c..5e286b9d1aea 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -655,7 +655,7 @@ static const struct attribute_group ufs_sysfs_flags_group = {
 	.attrs = ufs_sysfs_device_flags,
 };
 
-#define UFS_ATTRIBUTE(_name, _uname)					\
+#define UFS_ATTRIBUTE_SHOW(_name, _uname)				\
 static ssize_t _name##_show(struct device *dev,				\
 	struct device_attribute *attr, char *buf)			\
 {									\
@@ -665,25 +665,45 @@ static ssize_t _name##_show(struct device *dev,				\
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
2.16.4

