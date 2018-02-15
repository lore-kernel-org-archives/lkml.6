Return-Path: <prvs=57756532b=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x2278+fNFeUlAKsh1yk0d6idUqaenShRo/8MUMtMjo94r4kpW61nZ/P52tShlTR/IXd1U8bUX
ARC-Seal: i=1; a=rsa-sha256; t=1518696877; cv=none;
        d=google.com; s=arc-20160816;
        b=ho45AweALuO7KA7xVIr7ZAmzmXkSqEQ21Fe8BXYU7bczUSAfOGrDIcWnBNjBZXedwG
         ubtciiSYRbzvK+DKaCzrrgkL66p4yA+yqSDgLiPPwQNIK/r4ymd81DxtiiZr3CtbeviV
         +FafeCioeIWCBzS5jHEMbMbZG0zGybfBZ86fIfCv/RcBxoGtWpOP84VXGW2GzhgHiRtM
         nccGFFaQeeGL8ilSMQ0V2+8DM2uPascqpN/CPoB1dmyjCVpIcSZ2DYGEf6zr6EflEv8h
         +PSAeybMVqDlQuneHtnRLXmJSKcp7sfTnERKhXNdb/4Rd6pqj30t9d2PojoPCNE3K85l
         bXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=tsZLctGcPE4egIrwUY+9geg/9/1On4JtHla/AL/Adi0=;
        b=ioFeiWiEWN2mUC3u3Vzx4qOEJyvC29Yny8Vu2/41NvreR2C0IE7phLL4KmUyixY9SF
         0DosMYEBNgEzn8DReRQpO26NQrUbfjvrtmNW6KmCfMqKnvbh/auVqAj3TlN8m16gQl2V
         nTrD5mEPgy2hGRKSP2CGfNucsezyWOEtwbjq3A0CV3z8ZIyrhP3TiZDaNN997qyo+bmE
         KnjqxaOOH1lRaIZJscbKbRGFANnRAwCEYCe+CCAwz+xKTOxhRZ04FiFAa4bQIw3ehke1
         Efjah/jo7EbF/ZC1XpnwZkTFa8d0XGHWXWcn8OOFRopWAwsOfNDDEzL54OySX0Eefzys
         4i2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=pkguWhMB;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=pkguWhMB;
       spf=pass (google.com: domain of prvs=57756532b=stanislav.nijnikov@wdc.com designates 216.71.154.45 as permitted sender) smtp.mailfrom=prvs=57756532b=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,517,1511798400";
   d="scan'208";a="71975467"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org,
	Bart.VanAssche@wdc.com
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v6 08/11] scsi: host template attribute groups
Date: Thu, 15 Feb 2018 14:14:08 +0200
Message-Id: <1518696851-6730-9-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1518696851-6730-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592469096844336176?=
X-GMAIL-MSGID: =?utf-8?q?1592469096844336176?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch introduces an additional field in the scsi_host_template
structure - struct attribute_group **sdev_group.
This field allows to define groups of attributes. It will provide an
ability to use binary attributes as well as device attributes and
to group them under subfolders if necessary.

Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/scsi_sysfs.c | 12 ++++++++++++
 include/scsi/scsi_host.h  |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index cbc0fe2..d608759 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1309,6 +1309,13 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 		}
 	}
 
+	if (sdev->host->hostt->sdev_groups) {
+		error = sysfs_create_groups(&sdev->sdev_gendev.kobj,
+				sdev->host->hostt->sdev_groups);
+		if (error)
+			return error;
+	}
+
 	scsi_autopm_put_device(sdev);
 	return error;
 }
@@ -1326,6 +1333,7 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	if (sdev->sdev_state == SDEV_DEL)
 		return;
 
+
 	if (sdev->is_visible) {
 		/*
 		 * If scsi_internal_target_block() is running concurrently,
@@ -1348,6 +1356,10 @@ void __scsi_remove_device(struct scsi_device *sdev)
 		if (res != 0)
 			return;
 
+		if (sdev->host->hostt->sdev_groups)
+			sysfs_remove_groups(&sdev->sdev_gendev.kobj,
+					sdev->host->hostt->sdev_groups);
+
 		bsg_unregister_queue(sdev->request_queue);
 		device_unregister(&sdev->sdev_dev);
 		transport_remove_device(dev);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 1a1df0d..1931758 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -477,6 +477,12 @@ struct scsi_host_template {
 	struct device_attribute **sdev_attrs;
 
 	/*
+	 * Pointer to the SCSI device attribute groups for this host,
+	 * NULL terminated.
+	 */
+	const struct attribute_group **sdev_groups;
+
+	/*
 	 * List of hosts per template.
 	 *
 	 * This is only for use by scsi_module.c for legacy templates.
-- 
2.7.4
