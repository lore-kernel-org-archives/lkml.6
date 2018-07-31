Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15960208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15960208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeGaIQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:16:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:59929 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeGaIQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:16:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:37:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="scan'208";a="61154191"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.48])
  by orsmga008.jf.intel.com with ESMTP; 30 Jul 2018 23:37:27 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 04/12] mei: restrict dma ring support to hbm version 2.1
Date:   Tue, 31 Jul 2018 09:35:36 +0300
Message-Id: <20180731063544.25540-5-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180731063544.25540-1-tomas.winkler@intel.com>
References: <20180731063544.25540-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only a firmware with version 2.1 and above supports dma ring feature.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
---
 drivers/misc/mei/debugfs.c | 2 ++
 drivers/misc/mei/hbm.c     | 6 ++++++
 drivers/misc/mei/hw.h      | 6 ++++++
 drivers/misc/mei/mei_dev.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index c815da91089c..7b5df8fd6c5a 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -183,6 +183,8 @@ static ssize_t mei_dbgfs_read_devstate(struct file *fp, char __user *ubuf,
 				 dev->hbm_f_fa_supported);
 		pos += scnprintf(buf + pos, bufsz - pos, "\tOS: %01d\n",
 				 dev->hbm_f_os_supported);
+		pos += scnprintf(buf + pos, bufsz - pos, "\tDR: %01d\n",
+				 dev->hbm_f_dr_supported);
 	}
 
 	pos += scnprintf(buf + pos, bufsz - pos, "pg:  %s, %s\n",
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index b0086c4aefe4..09e233d4c0de 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1007,6 +1007,12 @@ static void mei_hbm_config_features(struct mei_device *dev)
 	/* OS ver message Support */
 	if (dev->version.major_version >= HBM_MAJOR_VERSION_OS)
 		dev->hbm_f_os_supported = 1;
+
+	/* DMA Ring Support */
+	if (dev->version.major_version > HBM_MAJOR_VERSION_DR ||
+	    (dev->version.major_version == HBM_MAJOR_VERSION_DR &&
+	     dev->version.minor_version >= HBM_MINOR_VERSION_DR))
+		dev->hbm_f_dr_supported = 1;
 }
 
 /**
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 5fb8844a6db5..65655925791a 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -80,6 +80,12 @@
 #define HBM_MINOR_VERSION_OS               0
 #define HBM_MAJOR_VERSION_OS               2
 
+/*
+ * MEI version with dma ring support
+ */
+#define HBM_MINOR_VERSION_DR               1
+#define HBM_MAJOR_VERSION_DR               2
+
 /* Host bus message command opcode */
 #define MEI_HBM_CMD_OP_MSK                  0x7f
 /* Host bus message command RESPONSE */
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 975afaa38a66..377397e1b5a5 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -418,6 +418,7 @@ struct mei_fw_version {
  * @hbm_f_fa_supported  : hbm feature fixed address client
  * @hbm_f_ie_supported  : hbm feature immediate reply to enum request
  * @hbm_f_os_supported  : hbm feature support OS ver message
+ * @hbm_f_dr_supported  : hbm feature dma ring supported
  *
  * @fw_ver : FW versions
  *
@@ -495,6 +496,7 @@ struct mei_device {
 	unsigned int hbm_f_fa_supported:1;
 	unsigned int hbm_f_ie_supported:1;
 	unsigned int hbm_f_os_supported:1;
+	unsigned int hbm_f_dr_supported:1;
 
 	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
 
-- 
2.14.4

