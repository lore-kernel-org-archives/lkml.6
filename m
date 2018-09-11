Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C343C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188132087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188132087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbeILEqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:5845 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbeILEqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208230"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:01 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 5/9] hid: intel-ish-hid: ishtp: add helper function for client search
Date:   Tue, 11 Sep 2018 16:44:17 -0700
Message-Id: <20180911234421.10691-6-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Add helper function ishtp_fw_cl_get_client() for client driver searching
client information to hide internal details from callers.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 25 +++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index d5db5e96e4a1..728dc6d4561a 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -148,6 +148,31 @@ int ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le *uuid)
 }
 EXPORT_SYMBOL(ishtp_fw_cl_by_uuid);
 
+/**
+ * ishtp_fw_cl_get_client() - return client information to client
+ * @dev: the ishtp device structure
+ * @uuid: uuid of the client to search
+ *
+ * Search firmware client using UUID and reture related client information.
+ *
+ * Return: pointer of client information on success, NULL on failure.
+ */
+struct ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const uuid_le *uuid)
+{
+	int i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->fw_clients_lock, flags);
+	i = ishtp_fw_cl_by_uuid(dev, uuid);
+	spin_unlock_irqrestore(&dev->fw_clients_lock, flags);
+	if (i < 0 || dev->fw_clients[i].props.fixed_address)
+		return NULL;
+
+	return &dev->fw_clients[i];
+}
+EXPORT_SYMBOL(ishtp_fw_cl_get_client);
+
 /**
  * ishtp_fw_cl_by_id() - return index to fw_clients for client_id
  * @dev: the ishtp device structure
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index 88883311667e..b8a5bcc82536 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -113,5 +113,7 @@ void	ishtp_cl_driver_unregister(struct ishtp_cl_driver *driver);
 int	ishtp_register_event_cb(struct ishtp_cl_device *device,
 				void (*read_cb)(struct ishtp_cl_device *));
 int	ishtp_fw_cl_by_uuid(struct ishtp_device *dev, const uuid_le *cuuid);
+struct	ishtp_fw_client *ishtp_fw_cl_get_client(struct ishtp_device *dev,
+						const uuid_le *uuid);
 
 #endif /* _LINUX_ISHTP_CL_BUS_H */
-- 
2.17.1

