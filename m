Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78A5C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB11920865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 23:45:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB11920865
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeILEqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 00:46:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:5839 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbeILEqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 00:46:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2018 16:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,362,1531810800"; 
   d="scan'208";a="72208216"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.116.215])
  by orsmga007.jf.intel.com with ESMTP; 11 Sep 2018 16:45:00 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Even Xu <even.xu@intel.com>
Subject: [PATCH 1/9] hid: intel-ish-hid: ishtp: add helper function for driver data get/set
Date:   Tue, 11 Sep 2018 16:44:13 -0700
Message-Id: <20180911234421.10691-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
References: <20180911234421.10691-1-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Even Xu <even.xu@intel.com>

Add helper function ishtp_set_drvdata() and ishtp_get_drvdata() for
different ISH client drivers to set/get private driver data.

Signed-off-by: Even Xu <even.xu@intel.com>
Reviewed-by: Andriy Shevchenko <andriy.shevchenko@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/bus.c | 27 +++++++++++++++++++++++++++
 drivers/hid/intel-ish-hid/ishtp/bus.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
index 2623a567ffba..d5db5e96e4a1 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.c
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
@@ -563,6 +563,33 @@ void ishtp_put_device(struct ishtp_cl_device *cl_device)
 }
 EXPORT_SYMBOL(ishtp_put_device);
 
+/**
+ * ishtp_set_drvdata() - set client driver data
+ * @cl_device:	client device instance
+ * @data:	driver data need to be set
+ *
+ * Set client driver data to cl_device->driver_data.
+ */
+void ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data)
+{
+	cl_device->driver_data = data;
+}
+EXPORT_SYMBOL(ishtp_set_drvdata);
+
+/**
+ * ishtp_get_drvdata() - get client driver data
+ * @cl_device:	client device instance
+ *
+ * Get client driver data from cl_device->driver_data.
+ *
+ * Return: pointer of driver data
+ */
+void *ishtp_get_drvdata(struct ishtp_cl_device *cl_device)
+{
+	return cl_device->driver_data;
+}
+EXPORT_SYMBOL(ishtp_get_drvdata);
+
 /**
  * ishtp_bus_new_client() - Create a new client
  * @dev:	ISHTP device instance
diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.h b/drivers/hid/intel-ish-hid/ishtp/bus.h
index a1ffae7f26ad..88883311667e 100644
--- a/drivers/hid/intel-ish-hid/ishtp/bus.h
+++ b/drivers/hid/intel-ish-hid/ishtp/bus.h
@@ -101,6 +101,9 @@ void	ishtp_reset_compl_handler(struct ishtp_device *dev);
 void	ishtp_put_device(struct ishtp_cl_device *);
 void	ishtp_get_device(struct ishtp_cl_device *);
 
+void	ishtp_set_drvdata(struct ishtp_cl_device *cl_device, void *data);
+void	*ishtp_get_drvdata(struct ishtp_cl_device *cl_device);
+
 int	__ishtp_cl_driver_register(struct ishtp_cl_driver *driver,
 				   struct module *owner);
 #define ishtp_cl_driver_register(driver)		\
-- 
2.17.1

