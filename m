Return-Path: <prvs=563541312=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x226ZMoV67VVMQHr+eo5wn0U7nOfab50Od20MWTLqdfisXZ/rKLcHbEkLVOLp+oZjUde1AVOA
ARC-Seal: i=1; a=rsa-sha256; t=1517501760; cv=none;
        d=google.com; s=arc-20160816;
        b=DcLfDhaNkd+Ed7lmZEuVDSEZoOCMvlAMA/Mw0KQDghP2+txksA5KYZUeBkXCNREtMM
         kOYAepzvovZ4N/blYSKQl8gu0QJXbpyrGI5Sf1S9HOdbeZZNhq3TMAnXvBpC17mUqDDL
         HrF+abuWSqrPnGj/t7Wobp5o+9c/iV7nN8NbcgaNvXk6Z1su90XB0JEcDO4oI8n2bKKR
         adb3dANG5QuyOKZxc32P4MZUa0x8Ih+zXHWh7O8Wkt/tMKWBCewBJYFmdCbuc+Q851Af
         wR59LFZKQgBqyK2qr86M5rOaE0OFy9oO6zvmCkGGpBLurRuJ8GcG6TMwdTi5sROr9iij
         Apew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=nc+ds8soCc97kL+hVEDy3kBzp6EDaeiv9Cwmg9nnSrY=;
        b=kXDeyaOC+1rKLJO53bEvGYp7yebc/iNk0Jvyw29/ZbJSNPio61HDw0pGz+s7T/j9ON
         Q9xwPb2a1stNarGN7WQACiKDvrmEgJOAN3+iMj3Y/be+4wHeOsjCWQhfd9fWivI/fXoX
         +Pep/bIzIQjYeFk2fkAKEYLSY/0Oh6pB98odfQF7IdFZBkps6JBCbT1O4JuvOYiA/rdy
         8NsGyBND29BXG10tx+CnJraat24zqF6AxTkirK2Xv0GkWTBywPcsRWDDujdzJJI/ic5o
         BfsNR9zFRFy/YRtq5CQR05VTbuw2V5PbNnujzdzf31l9gIFLaSrslZZFAaTGTj5DZGUi
         1F/A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Z4GmvRxW;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=Z4GmvRxW;
       spf=pass (google.com: domain of prvs=563541312=stanislav.nijnikov@wdc.com designates 68.232.141.245 as permitted sender) smtp.mailfrom=prvs=563541312=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,444,1511798400";
   d="scan'208";a="173298248"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v4 05/10] ufs: sysfs: health descriptor
Date: Thu,  1 Feb 2018 18:15:41 +0200
Message-Id: <1517501746-19075-6-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215926144929110?=
X-GMAIL-MSGID: =?utf-8?q?1591215926144929110?=
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
index 6427804..1c89009 100644
--- a/drivers/scsi/ufs/ufs-sysfs.c
+++ b/drivers/scsi/ufs/ufs-sysfs.c
@@ -364,11 +364,31 @@ static const struct attribute_group ufs_sysfs_geometry_descriptor_group = {
 	.attrs = ufs_sysfs_geometry_descriptor,
 };
 
+#define UFS_HEALTH_DESC_PARAM(_name, _uname, _size)                     \
+	UFS_DESC_PARAM(_name, _uname, HEALTH, _size)
+
+UFS_HEALTH_DESC_PARAM(eol_info, _EOL_INFO, BYTE);
+UFS_HEALTH_DESC_PARAM(life_time_estimation_a, _LIFE_TIME_EST_A, BYTE);
+UFS_HEALTH_DESC_PARAM(life_time_estimation_b, _LIFE_TIME_EST_B, BYTE);
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
