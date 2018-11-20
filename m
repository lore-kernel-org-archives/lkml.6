Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC90C46462
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1952087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1952087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbeKUC31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:29:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:25307 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729306AbeKUC30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:29:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 07:59:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="93533535"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 07:59:30 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 887684FB; Tue, 20 Nov 2018 17:59:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 05/15] i2c: acpi: Return error pointers from i2c_acpi_new_device()
Date:   Tue, 20 Nov 2018 17:59:14 +0200
Message-Id: <20181120155924.10773-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
References: <20181120155924.10773-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The caller would like to know the reason why the i2c_acpi_new_device() fails.
For example, if adapter is not available, it might be in the future and we
would like to re-probe the clients again. But at the same time we would like to
bail out if the error seems unrecoverable, such as out of memory condition.
To achieve this, return error pointer in some cases.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/i2c-core-acpi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 32affd3fa8bd..af4b5bd5d973 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -387,6 +387,7 @@ struct notifier_block i2c_acpi_notifier = {
  * Also see i2c_new_device, which this function calls to create the i2c-client.
  *
  * Returns a pointer to the new i2c-client, or NULL if the adapter is not found.
+ * In some cases might return an error pointer.
  */
 struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 				       struct i2c_board_info *info)
@@ -399,7 +400,7 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 
 	adev = ACPI_COMPANION(dev);
 	if (!adev)
-		return NULL;
+		return ERR_PTR(-ENODEV);
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
@@ -409,9 +410,11 @@ struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     i2c_acpi_fill_info, &lookup);
 	acpi_dev_free_resource_list(&resource_list);
+	if (ret < 0)
+		return ERR_PTR(ret);
 
-	if (ret < 0 || !info->addr)
-		return NULL;
+	if (!info->addr)
+		return ERR_PTR(-EADDRNOTAVAIL);
 
 	adapter = i2c_acpi_find_adapter_by_handle(lookup.adapter_handle);
 	if (!adapter)
-- 
2.19.1

