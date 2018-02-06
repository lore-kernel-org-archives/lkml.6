Return-Path: <prvs=568516f6c=stanislav.nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224fkdKQIbW1Dv7HmdrObU6z/T+a6gXXtCF5/S1zlh4Gj/R9g8slgcTe6A//lLZGRlVr0K2o
ARC-Seal: i=1; a=rsa-sha256; t=1517933207; cv=none;
        d=google.com; s=arc-20160816;
        b=j19es/LS7HEy7wEhvHGsRQfIaitjKvtjy73YBGvfzZLD9pfdzlQ4sgdB9Vi1eA/2pb
         WVjqwhTBaV5eE44WoKBOGgCYuhmn7TmP3cky4XraMZxZEanVJSQ/R6TLlsKLrLhv5Teo
         Ek0DKLb94c4qEmtFo/PkqlDMOfTHwFnzPURl8s6x3H0G9FM8MU0dHcmeugh/sdvh/cYw
         a44yGLQj7a8MjD+dIDo4IqrzYq8D/PilsfPy8jocEVJl6MGu9F2LFm2XtvIA+om5cJUj
         VMq0s46q75dOu0EERr+L8u4tVTGRqQPyIjXUU2acPYIXeUz+KtqsL6rfzyXYky1sVVIe
         MEoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4cU88MDpoPBtSIMcWlHT7f0S5PIvGlj2rhzhUAdS0mk=;
        b=zUF/kUVjKQpW2WNyUmHpI2LRWvP3fcg0GmCHadJMnwrf3vpChgWDq0IsnxP1ozkmd3
         I3fao8Df8aUtVKtXYIQDze8iTEA8d8nhAKo/EctnQE21o8WNXthaTzI5ij5BdXtZhMb8
         /j4mQUc/cPoHAZ4AjeAeD2bHZSnjhmsQTp0o1Mv0STVEwRHDfC0Syl3mGygjeuw6Nc3J
         /Hri2X0RYlaLDyiZ7wT8JF22qlM0+9Mbvb05QTfo47xGIJgHEPH1yg1FLXSKf5RedNRm
         hh7IJMcD7ivHq+No4l/C/1iAwiLraIkcfN1txzpa0s6rb5B4XO1anFLoolczfYIXXOuM
         iY5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=SXbsTyfX;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=SXbsTyfX;
       spf=pass (google.com: domain of prvs=568516f6c=stanislav.nijnikov@wdc.com designates 68.232.143.124 as permitted sender) smtp.mailfrom=prvs=568516f6c=stanislav.nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,469,1511798400";
   d="scan'208";a="167144235"
From: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jaegeuk@kernel.org
Cc: alex.lemberg@wdc.com,
	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
Subject: [PATCH v5 08/11] scsi: host template attribute groups
Date: Tue,  6 Feb 2018 18:06:20 +0200
Message-Id: <1517933183-30892-9-git-send-email-stanislav.nijnikov@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
References: <1517933183-30892-1-git-send-email-stanislav.nijnikov@wdc.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591668330658484083?=
X-GMAIL-MSGID: =?utf-8?q?1591668330658484083?=
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
index cbc0fe2..fe5d1cb 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1309,6 +1309,13 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 		}
 	}
 
+	if (sdev->host->hostt->sdev_groups) {
+		error = sysfs_create_groups(&sdev->sdev_gendev.kobj,
+			sdev->host->hostt->sdev_groups);
+			if (error)
+				return error;
+	}
+
 	scsi_autopm_put_device(sdev);
 	return error;
 }
@@ -1326,6 +1333,11 @@ void __scsi_remove_device(struct scsi_device *sdev)
 	if (sdev->sdev_state == SDEV_DEL)
 		return;
 
+	if (sdev->host->hostt->sdev_groups) {
+		sysfs_remove_groups(&sdev->sdev_gendev.kobj,
+			sdev->host->hostt->sdev_groups);
+	}
+
 	if (sdev->is_visible) {
 		/*
 		 * If scsi_internal_target_block() is running concurrently,
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
