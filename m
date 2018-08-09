Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD76C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656D321D68
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656D321D68
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbeHIOFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 10:05:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38476 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731223AbeHIOFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 10:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5F2D180D2F6B;
        Thu,  9 Aug 2018 11:40:53 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FEC8100725C;
        Thu,  9 Aug 2018 11:40:51 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c@vger.kernel.org
Subject: [PATCH v6 2/4] ACPI / scan: Create platform device for fwnodes with multiple i2c devices
Date:   Thu,  9 Aug 2018 13:40:44 +0200
Message-Id: <20180809114046.21366-3-hdegoede@redhat.com>
In-Reply-To: <20180809114046.21366-1-hdegoede@redhat.com>
References: <20180809114046.21366-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 11:40:53 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 09 Aug 2018 11:40:53 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices have multiple I2cSerialBus resources and for things to work
an i2c-client must be instantiated for each, each with its own
i2c_device_id.

Normally we only instantiate an i2c-client for the first resource, using
the ACPI HID as id.

This commit adds a list of HIDs of devices, which need multiple i2c-clients
instantiated from a single fwnode, to acpi_device_enumeration_by_parent and
makes acpi_device_enumeration_by_parent return false for these devices so
that a platform device will be instantiated.

This allows the drivers/platform/x86/i2c-multi-instantiate.c driver, which
knows which i2c_device_id to use for each resource, to bind to the fwnode
and initiate an i2c-client for each resource.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patch-set

Changes in v4:
-Some small code-style fixes
---
 drivers/acpi/scan.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 6799d00dd790..b51913372e21 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1540,6 +1540,18 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 {
 	struct list_head resource_list;
 	bool is_serial_bus_slave = false;
+	/*
+	 * These devices have multiple I2cSerialBus resources and an i2c-client
+	 * must be instantiated for each, each with its own i2c_device_id.
+	 * Normally we only instantiate an i2c-client for the first resource,
+	 * using the ACPI HID as id. These special cases are handled by the
+	 * drivers/platform/x86/i2c-multi-instantiate.c driver, which knows
+	 * which i2c_device_id to use for each resource.
+	 */
+	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+		{"BSG1160", },
+		{}
+	};
 
 	if (acpi_is_indirect_io_slave(device))
 		return true;
@@ -1551,6 +1563,10 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	     fwnode_property_present(&device->fwnode, "baud")))
 		return true;
 
+	/* Instantiate a pdev for the i2c-multi-instantiate drv to bind to */
+	if (!acpi_match_device_ids(device, i2c_multi_instantiate_ids))
+		return false;
+
 	INIT_LIST_HEAD(&resource_list);
 	acpi_dev_get_resources(device, &resource_list,
 			       acpi_check_serial_bus_slave,
-- 
2.18.0

