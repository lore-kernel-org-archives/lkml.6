Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x225m3kZDpHXe3YNZDGoyJfnsNEtDwY2mPQXLqgQzbwQSfM5Y8TarHvK5gWGYeamwyVpn6VyM
ARC-Seal: i=1; a=rsa-sha256; t=1517933209; cv=none;
        d=google.com; s=arc-20160816;
        b=VYj3kGxq22nZfnnIOTslAdiakXTzwEeMbsPnPL0CYd5okn4uwKTShZo+Vv9ZoSziv9
         LZsVM0n3RqYYajto1AfRElO80/X+Y/Tho4b+GhLxRo3BXY9IROsXyyDRmh/KYyhJbYcq
         ca17l8w06QPQSB0ub9iReoHQjDaGv1OBNjMADMzYcKmbC/Y779BHlOYNI73Z5LymbIjV
         jAaRDW6PNp5jz4zcItEd9ajL5/YMw7bhPwkdJ9Vx/3mOcxgjPv1x1JRzcIHbyyYTZvxY
         vAp80//MCLCK/NlMilWEAA5iArPF8kFBDSidRa9Zvn6NOG3pI9BIimDT74s7vBoatpvQ
         h2pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=5I7u7g5DHjAD5sRVk667HKhxNQbldzz/1BL6BWwimOI=;
        b=peWjEL/3W2wMo5NNB1j9lS5Dvil0MKD1Nh4NB8/ZgMoKB8tNaEQuWttL+AFFidJ14c
         tYIjnqXGf3nUQnl9ju+8RXnnoZhAUrJA3MopoBIhZu2YVkvXJ+b7z9xzGxTYh3PN7AOV
         LuZSbjG7CDklWE8ewnIcCxumNCPB4EQ+eCtrTApmT2Eq1B0FqEY9bHGV0BLqxkxXEfCf
         64nZVHjw9TKe6bUvdaSl6JBlnyBVwn7c1dPz3kYKhJDYn3D0ugrkImmqo7k0kiIXy/dM
         ar49KeNDQAtoqIXxy49EEc8YUu79Gvo8zRTdnFI3W4tKuh+kilO4xxXd9CdsNzbtyvG4
         fSMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=YPZay7cA;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=YPZay7cA;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144241"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 09/11] scsi: ufs: sysfs: unit descriptor
Date: Tue,  6 Feb 2018 18:06:21 +0200
Message-Id: <1517933183-30892-10-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668333127655928?=
X-GMAIL-MSGID: =?utf-8?q?1591668333127655928?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS unit descriptor
parameters. The group adds "unit_descriptor" folder under the corresponding
SCSI device sysfs entry (/sys/class/scsi_device/*/device/). The parameters
are shown as hexadecimal numbers. The full information about the parameters
could be found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 108 +++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               |  53 ++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.h               |   2 +
 drivers/scsi/ufs/ufs.h                     |  11 +++
 drivers/scsi/ufs/ufshcd.c                  |  23 ++----
 drivers/scsi/ufs/ufshcd.h                  |  15 ++++
 6 files changed, 196 insertions(+), 16 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index c17a968..57c6a90 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -490,3 +490,111 @@ Description:	This file contains a product revision string. The full
 		information about the descriptor could be found at
 		UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/boot_lun_id
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows boot LUN information. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/lun_write_protect
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows LUN write protection status. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/lun_queue_depth
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows LUN queue depth. This is one of the UFS
+		unit descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/psa_sensitive
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows PSA sensitivity. This is one of the UFS
+		unit descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/lun_memory_type
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows LUN memory type. This is one of the UFS
+		unit descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/data_reliability
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file defines the device behavior when a power failure
+		occurs during a write operation. This is one of the UFS
+		unit descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/logical_block_size
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the size of addressable logical blocks
+		(calculated as an exponent with base 2). This is one of
+		the UFS unit descriptor parameters. The full information about
+		the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/logical_block_count
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows total number of addressable logical blocks.
+		This is one of the UFS unit descriptor parameters. The full
+		information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/erase_block_size
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the erase block size. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/provisioning_type
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the thin provisioning type. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/physical_memory_resourse_count
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the total physical memory resources. This is
+		one of the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/context_capabilities
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the context capabilities. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/class/scsi_device/*/device/unit_descriptor/large_unit_granularity
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows the granularity of the LUN. This is one of
+		the UFS unit descriptor parameters. The full information
+		about the descriptor could be found at UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 7130e0d..fc43583 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -550,6 +550,59 @@ static const struct attribute_group *ufs_sysfs_groups[] = {
 	NULL,
 };
 
+#define UFS_LUN_DESC_PARAM(_pname, _puname, _duname, _size)		\
+static ssize_t _pname##_show(struct device *dev,			\
+	struct device_attribute *attr, char *buf)			\
+{									\
+	struct scsi_device *sdev = to_scsi_device(dev);			\
+	struct ufs_hba *hba = shost_priv(sdev->host);			\
+	u8 lun = ufshcd_scsi_to_upiu_lun(sdev->lun);			\
+	if (!ufs_is_valid_unit_desc_lun(lun))				\
+		return -EINVAL;						\
+	return ufs_sysfs_read_desc_param(hba, QUERY_DESC_IDN_##_duname,	\
+		lun, _duname##_DESC_PARAM##_puname, buf, _size);	\
+}									\
+static DEVICE_ATTR_RO(_pname)
+
+#define UFS_UNIT_DESC_PARAM(_name, _uname, _size)			\
+	UFS_LUN_DESC_PARAM(_name, _uname, UNIT, _size)
+
+UFS_UNIT_DESC_PARAM(boot_lun_id, _BOOT_LUN_ID, 1);
+UFS_UNIT_DESC_PARAM(lun_write_protect, _LU_WR_PROTECT, 1);
+UFS_UNIT_DESC_PARAM(lun_queue_depth, _LU_Q_DEPTH, 1);
+UFS_UNIT_DESC_PARAM(psa_sensitive, _PSA_SENSITIVE, 1);
+UFS_UNIT_DESC_PARAM(lun_memory_type, _MEM_TYPE, 1);
+UFS_UNIT_DESC_PARAM(data_reliability, _DATA_RELIABILITY, 1);
+UFS_UNIT_DESC_PARAM(logical_block_size, _LOGICAL_BLK_SIZE, 1);
+UFS_UNIT_DESC_PARAM(logical_block_count, _LOGICAL_BLK_COUNT, 8);
+UFS_UNIT_DESC_PARAM(erase_block_size, _ERASE_BLK_SIZE, 4);
+UFS_UNIT_DESC_PARAM(provisioning_type, _PROVISIONING_TYPE, 1);
+UFS_UNIT_DESC_PARAM(physical_memory_resourse_count, _PHY_MEM_RSRC_CNT, 8);
+UFS_UNIT_DESC_PARAM(context_capabilities, _CTX_CAPABILITIES, 2);
+UFS_UNIT_DESC_PARAM(large_unit_granularity, _LARGE_UNIT_SIZE_M1, 1);
+
+static struct attribute *ufs_sysfs_unit_descriptor[] = {
+	&dev_attr_boot_lun_id.attr,
+	&dev_attr_lun_write_protect.attr,
+	&dev_attr_lun_queue_depth.attr,
+	&dev_attr_psa_sensitive.attr,
+	&dev_attr_lun_memory_type.attr,
+	&dev_attr_data_reliability.attr,
+	&dev_attr_logical_block_size.attr,
+	&dev_attr_logical_block_count.attr,
+	&dev_attr_erase_block_size.attr,
+	&dev_attr_provisioning_type.attr,
+	&dev_attr_physical_memory_resourse_count.attr,
+	&dev_attr_context_capabilities.attr,
+	&dev_attr_large_unit_granularity.attr,
+	NULL,
+};
+
+const struct attribute_group ufs_sysfs_unit_descriptor_group = {
+	.name = "unit_descriptor",
+	.attrs = ufs_sysfs_unit_descriptor,
+};
+
 void ufs_sysfs_add_nodes(struct device *dev)
 {
 	int ret;
diff --git a/drivers/scsi/ufs/ufs-sysfs.h b/drivers/scsi/ufs/ufs-sysfs.h
index 4a984ca..dd2fadc 100644
--- a/drivers/scsi/ufs/ufs-sysfs.h
+++ b/drivers/scsi/ufs/ufs-sysfs.h
@@ -11,4 +11,6 @@
 
 void ufs_sysfs_add_nodes(struct device *dev);
 void ufs_sysfs_remove_nodes(struct device *dev);
+
+extern const struct attribute_group ufs_sysfs_unit_descriptor_group;
 #endif
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 6bfeedb..7387059 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -182,6 +182,7 @@ enum unit_desc_param {
 	UNIT_DESC_PARAM_BOOT_LUN_ID		= 0x4,
 	UNIT_DESC_PARAM_LU_WR_PROTECT		= 0x5,
 	UNIT_DESC_PARAM_LU_Q_DEPTH		= 0x6,
+	UNIT_DESC_PARAM_PSA_SENSITIVE		= 0x7,
 	UNIT_DESC_PARAM_MEM_TYPE		= 0x8,
 	UNIT_DESC_PARAM_DATA_RELIABILITY	= 0x9,
 	UNIT_DESC_PARAM_LOGICAL_BLK_SIZE	= 0xA,
@@ -592,4 +593,14 @@ struct ufs_dev_desc {
 	char model[MAX_MODEL_LEN + 1];
 };
 
+/**
+ * ufs_is_valid_unit_desc_lun - checks if the given LUN has a unit descriptor
+ * @lun: LU number to check
+ * @return: true if the lun has a matching unit descriptor, false otherwise
+ */
+static inline bool ufs_is_valid_unit_desc_lun(u8 lun)
+{
+	return lun == UFS_UPIU_RPMB_WLUN || (lun < UFS_UPIU_MAX_GENERAL_LUN);
+}
+
 #endif /* End of Header */
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9cfdd8e..ace3acd 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2222,21 +2222,6 @@ static int ufshcd_comp_scsi_upiu(struct ufs_hba *hba, struct ufshcd_lrb *lrbp)
 	return ret;
 }
 
-/*
- * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
- * @scsi_lun: scsi LUN id
- *
- * Returns UPIU LUN id
- */
-static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
-{
-	if (scsi_is_wlun(scsi_lun))
-		return (scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID)
-			| UFS_UPIU_WLUN_ID;
-	else
-		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;
-}
-
 /**
  * ufshcd_upiu_wlun_to_scsi_wlun - maps UPIU W-LUN id to SCSI W-LUN ID
  * @scsi_lun: UPIU W-LUN id
@@ -3171,7 +3156,7 @@ static inline int ufshcd_read_unit_desc_param(struct ufs_hba *hba,
 	 * Unit descriptors are only available for general purpose LUs (LUN id
 	 * from 0 to 7) and RPMB Well known LU.
 	 */
-	if (lun != UFS_UPIU_RPMB_WLUN && (lun >= UFS_UPIU_MAX_GENERAL_LUN))
+	if (!ufs_is_valid_unit_desc_lun(lun))
 		return -EOPNOTSUPP;
 
 	return ufshcd_read_desc_param(hba, QUERY_DESC_IDN_UNIT, lun,
@@ -6481,6 +6466,11 @@ static enum blk_eh_timer_return ufshcd_eh_timed_out(struct scsi_cmnd *scmd)
 	return found ? BLK_EH_NOT_HANDLED : BLK_EH_RESET_TIMER;
 }
 
+static const struct attribute_group *ufshcd_driver_groups[] = {
+	&ufs_sysfs_unit_descriptor_group,
+	NULL,
+};
+
 static struct scsi_host_template ufshcd_driver_template = {
 	.module			= THIS_MODULE,
 	.name			= UFSHCD,
@@ -6500,6 +6490,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.can_queue		= UFSHCD_CAN_QUEUE,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
+	.sdev_groups		= ufshcd_driver_groups,
 };
 
 static int ufshcd_config_vreg_load(struct device *dev, struct ufs_vreg *vreg,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 2dad9da..f4cb31b 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -1003,4 +1003,19 @@ static inline void ufshcd_vops_dbg_register_dump(struct ufs_hba *hba)
 
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
+/*
+ * ufshcd_scsi_to_upiu_lun - maps scsi LUN to UPIU LUN
+ * @scsi_lun: scsi LUN id
+ *
+ * Returns UPIU LUN id
+ */
+static inline u8 ufshcd_scsi_to_upiu_lun(unsigned int scsi_lun)
+{
+	if (scsi_is_wlun(scsi_lun))
+		return (scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID)
+			| UFS_UPIU_WLUN_ID;
+	else
+		return scsi_lun & UFS_UPIU_MAX_UNIT_NUM_ID;
+}
+
 #endif /* End of Header */
-- 
2.7.4
