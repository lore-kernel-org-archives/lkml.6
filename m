Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x225jit+NaOT3Syxb15zJ8oP6PHJ7r+OD5j3uE1OdD6no00cs10IgT5dOGRddfRxAgXGDGZ36
ARC-Seal: i=1; a=rsa-sha256; t=1517933201; cv=none;
        d=google.com; s=arc-20160816;
        b=L0pwqujt+Gm3QZ9Zc6Yt/AldVF9FDVI+zRZ2+zlG1p9baZmxJTS4OHisr22f31L54t
         tg1bCcCoAyPT/fIMwrZTCE5h5tDFp873Wepy5cNLUo+ySHSDRINS9qZ6AORORUsAvaxO
         zaWViN5zxxooMFY4R3X2uC129uYHrnSFpSFvckrwkD99Q0kGzsTbBrc2RLjMTJ8yd8/C
         iq/cR0PzM5uN24fQE0rXX/ULZiyUOy+9cDYBZaw7fuVXenOZEvehUcVZ24e2AXmmZFw7
         Ssn1XVqPZ0PCto5IHvmujOKL4Yi0+LEr/5H7IA9R8bc/BLt6BleHYJ/j8SFUxNL1/0+I
         //TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=tKPUVxCWGQL0sun9Yi3OUqEjatJhaSsaH+CtFm7SuJc=;
        b=LWVkwN8v/J/B+qe1xh+6nmnQVMl2ygQTceN28zLxZgykmhjrX2xfn/484M5mZFrmDU
         iGTxu8467F6fbdULpiO0DLdrlOSFEidFn7aJQJWjMu+elJ6BH3flk950xbcMlvx5AT6T
         12KykKy4X3152UyDnuALWpranZxQG44TkPuraVlLGl8ekk9nbJGGor8WCfszX91GBM9o
         tGgqRjjuG7MfwuVwK5JRdrOiFjM0w5HpdE0YjOaM0IJ6AZ7i7OGOdeA5xPrYL8sId6M+
         EiRoADA3ph6QsJo3sXlH3DWiqwiODtdsVpyaqL5FbQOJNuMMyqMaKrBP+pfHdUwnaOtJ
         vUsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=VJ+9iNi7;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=VJ+9iNi7;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144218"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 05/11] scsi: ufs: sysfs: health descriptor
Date: Tue,  6 Feb 2018 18:06:17 +0200
Message-Id: <1517933183-30892-6-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668324236570217?=
X-GMAIL-MSGID: =?utf-8?q?1591668324236570217?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch introduces a sysfs group entry for the UFS health descriptor
parameters. The group adds "health_descriptor" folder under the UFS driver
sysfs entry (/sys/bus/platform/drivers/ufshcd/*). The parameters are shown
as hexadecimal numbers. The full information about the parameters could be
found at UFS specifications 2.1.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/ABI/testing/sysfs-driver-ufs | 28 ++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-sysfs.c               | 20 ++++++++++++++++++++
 drivers/scsi/ufs/ufs.h                     | 11 +++++++++++
 drivers/scsi/ufs/ufshcd.c                  |  8 ++++++++
 drivers/scsi/ufs/ufshcd.h                  |  1 +
 5 files changed, 68 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index 6ea7613..ddb012b 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -413,3 +413,31 @@ Description:	This file shows the memory capacity adjustment factor for
 		descriptor parameters. The full information about the
 		descriptor could be found at UFS specifications 2.1.
 		The file is read only.
+
+
+What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/eol_info
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows preend of life information. This is one
+		of the UFS health descriptor parameters. The full
+		information about the descriptor could be found at
+		UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/life_time_estimation_a
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows indication of the device life time
+		(method a). This is one of the UFS health descriptor
+		parameters. The full information about the descriptor
+		could be found at UFS specifications 2.1.
+		The file is read only.
+
+What:		/sys/bus/platform/drivers/ufshcd/*/health_descriptor/life_time_estimation_b
+Date:		February 2018
+Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
+Description:	This file shows indication of the device life time
+		(method b). This is one of the UFS health descriptor
+		parameters. The full information about the descriptor
+		could be found at UFS specifications 2.1.
+		The file is read only.
diff --git a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c
index 7dfa8fb..3279514 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -349,11 +349,31 @@ static const struct attribute_group ufs_sysfs_geometry_descriptor_group = {
 	.attrs = ufs_sysfs_geometry_descriptor,
 };
 
+#define UFS_HEALTH_DESC_PARAM(_name, _uname, _size)			\
+	UFS_DESC_PARAM(_name, _uname, HEALTH, _size)
+
+UFS_HEALTH_DESC_PARAM(eol_info, _EOL_INFO, 1);
+UFS_HEALTH_DESC_PARAM(life_time_estimation_a, _LIFE_TIME_EST_A, 1);
+UFS_HEALTH_DESC_PARAM(life_time_estimation_b, _LIFE_TIME_EST_B, 1);
+
+static struct attribute *ufs_sysfs_health_descriptor[] = {
+	&dev_attr_eol_info.attr,
+	&dev_attr_life_time_estimation_a.attr,
+	&dev_attr_life_time_estimation_b.attr,
+	NULL,
+};
+
+static const struct attribute_group ufs_sysfs_health_descriptor_group = {
+	.name = "health_descriptor",
+	.attrs = ufs_sysfs_health_descriptor,
+};
+
 static const struct attribute_group *ufs_sysfs_groups[] = {
 	&ufs_sysfs_default_group,
 	&ufs_sysfs_device_descriptor_group,
 	&ufs_sysfs_interconnect_descriptor_group,
 	&ufs_sysfs_geometry_descriptor_group,
+	&ufs_sysfs_health_descriptor_group,
 	NULL,
 };
 
diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 04d41c8..6bfeedb 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -154,6 +154,7 @@ enum desc_idn {
 	QUERY_DESC_IDN_RFU_1		= 0x6,
 	QUERY_DESC_IDN_GEOMETRY		= 0x7,
 	QUERY_DESC_IDN_POWER		= 0x8,
+	QUERY_DESC_IDN_HEALTH           = 0x9,
 	QUERY_DESC_IDN_MAX,
 };
 
@@ -169,6 +170,7 @@ enum ufs_desc_def_size {
 	QUERY_DESC_INTERCONNECT_DEF_SIZE	= 0x06,
 	QUERY_DESC_GEOMETRY_DEF_SIZE		= 0x44,
 	QUERY_DESC_POWER_DEF_SIZE		= 0x62,
+	QUERY_DESC_HEALTH_DEF_SIZE		= 0x25,
 };
 
 /* Unit descriptor parameters offsets in bytes*/
@@ -274,6 +276,15 @@ enum geometry_desc_param {
 	GEOMETRY_DESC_PARAM_OPT_LOG_BLK_SIZE	= 0x44,
 };
 
+/* Health descriptor parameters offsets in bytes*/
+enum health_desc_param {
+	HEALTH_DESC_PARAM_LEN			= 0x0,
+	HEALTH_DESC_PARAM_TYPE			= 0x1,
+	HEALTH_DESC_PARAM_EOL_INFO		= 0x2,
+	HEALTH_DESC_PARAM_LIFE_TIME_EST_A	= 0x3,
+	HEALTH_DESC_PARAM_LIFE_TIME_EST_B	= 0x4,
+};
+
 /*
  * Logical Unit Write Protect
  * 00h: LU not write protected
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 540a431..b88fcf7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -2966,6 +2966,9 @@ int ufshcd_map_desc_id_to_length(struct ufs_hba *hba,
 	case QUERY_DESC_IDN_STRING:
 		*desc_len = QUERY_DESC_MAX_SIZE;
 		break;
+	case QUERY_DESC_IDN_HEALTH:
+		*desc_len = hba->desc_size.hlth_desc;
+		break;
 	case QUERY_DESC_IDN_RFU_0:
 	case QUERY_DESC_IDN_RFU_1:
 		*desc_len = 0;
@@ -6277,6 +6280,10 @@ static void ufshcd_init_desc_sizes(struct ufs_hba *hba)
 		&hba->desc_size.geom_desc);
 	if (err)
 		hba->desc_size.geom_desc = QUERY_DESC_GEOMETRY_DEF_SIZE;
+	err = ufshcd_read_desc_length(hba, QUERY_DESC_IDN_HEALTH, 0,
+		&hba->desc_size.hlth_desc);
+	if (err)
+		hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
 static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
@@ -6287,6 +6294,7 @@ static void ufshcd_def_desc_sizes(struct ufs_hba *hba)
 	hba->desc_size.conf_desc = QUERY_DESC_CONFIGURATION_DEF_SIZE;
 	hba->desc_size.unit_desc = QUERY_DESC_UNIT_DEF_SIZE;
 	hba->desc_size.geom_desc = QUERY_DESC_GEOMETRY_DEF_SIZE;
+	hba->desc_size.hlth_desc = QUERY_DESC_HEALTH_DEF_SIZE;
 }
 
 /**
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 38c307d..515c6e6 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -229,6 +229,7 @@ struct ufs_desc_size {
 	int interc_desc;
 	int unit_desc;
 	int conf_desc;
+	int hlth_desc;
 };
 
 /**
-- 
2.7.4
