Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD767C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CEE21888
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:05:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CEE21888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeHGKSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:18:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbeHGKSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:18:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A319640216E4;
        Tue,  7 Aug 2018 08:05:45 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-103.ams2.redhat.com [10.36.117.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 588A82166BA2;
        Tue,  7 Aug 2018 08:05:43 +0000 (UTC)
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
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Dann Frazier <dann.frazier@canonical.com>
Subject: [PATCH v3 1/4] ACPI / scan: Fix acpi_is_indirect_io_slave() always returning false
Date:   Tue,  7 Aug 2018 10:05:36 +0200
Message-Id: <20180807080539.17811-2-hdegoede@redhat.com>
In-Reply-To: <20180807080539.17811-1-hdegoede@redhat.com>
References: <20180807080539.17811-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 07 Aug 2018 08:05:45 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 07 Aug 2018 08:05:45 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
gets set to 0 by acpi_bus_type_and_status() and filled with its actual
value later when acpi_add_single_object() calls acpi_bus_get_status().

This means that status is 0 when acpi_device_enumeration_by_parent()
gets called which makes the acpi_match_device_ids() call in
acpi_is_indirect_io_slave() always return -ENOENT.

This commit fixes this by making acpi_bus_type_and_status() set status to
ACPI_STA_DEFAULT until acpi_add_single_object() calls acpi_bus_get_status()

Fixes: dfda4492322e ("ACPI / scan: Do not enumerate Indirect IO host children")
Cc: stable@vger.kernel.org
Cc: John Garry <john.garry@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Dann Frazier <dann.frazier@canonical.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/scan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 970dd87d347c..6799d00dd790 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1612,7 +1612,8 @@ static int acpi_add_single_object(struct acpi_device **child,
 	 * Note this must be done before the get power-/wakeup_dev-flags calls.
 	 */
 	if (type == ACPI_BUS_TYPE_DEVICE)
-		acpi_bus_get_status(device);
+		if (acpi_bus_get_status(device) < 0)
+			acpi_set_device_status(device, 0);
 
 	acpi_bus_get_power_flags(device);
 	acpi_bus_get_wakeup_device_flags(device);
@@ -1690,7 +1691,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
 		 * acpi_add_single_object updates this once we've an acpi_device
 		 * so that acpi_bus_get_status' quirk handling can be used.
 		 */
-		*sta = 0;
+		*sta = ACPI_STA_DEFAULT;
 		break;
 	case ACPI_TYPE_PROCESSOR:
 		*type = ACPI_BUS_TYPE_PROCESSOR;
-- 
2.18.0

