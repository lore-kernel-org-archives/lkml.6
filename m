Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980FDC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE9A216FB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE9A216FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeHHKs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:48:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50100 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726979AbeHHKsz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:48:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D69040241CF;
        Wed,  8 Aug 2018 08:30:17 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-117-222.ams2.redhat.com [10.36.117.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0D9F2027047;
        Wed,  8 Aug 2018 08:30:15 +0000 (UTC)
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
        John Garry <john.garry@huawei.com>, linux-i2c@vger.kernel.org
Subject: [PATCH v4 3/4] ACPI / x86-utils: Remove status workaround from acpi_device_always_present()
Date:   Wed,  8 Aug 2018 10:30:05 +0200
Message-Id: <20180808083006.31919-4-hdegoede@redhat.com>
In-Reply-To: <20180808083006.31919-1-hdegoede@redhat.com>
References: <20180808083006.31919-1-hdegoede@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 08:30:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 08 Aug 2018 08:30:17 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'hdegoede@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we init the status field to ACPI_STA_DEFAULT rather then to 0,
the workaround for acpi_match_device_ids() always returning -ENOENT when
status is 0 is no longer needed.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
-New patch in v3 of this patch-set
---
 drivers/acpi/x86/utils.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
index ec5b0f190231..a4fb97d64b3b 100644
--- a/drivers/acpi/x86/utils.c
+++ b/drivers/acpi/x86/utils.c
@@ -103,13 +103,9 @@ static const struct always_present_id always_present_ids[] = {
 
 bool acpi_device_always_present(struct acpi_device *adev)
 {
-	u32 *status = (u32 *)&adev->status;
-	u32 old_status = *status;
 	bool ret = false;
 	unsigned int i;
 
-	/* acpi_match_device_ids checks status, so set it to default */
-	*status = ACPI_STA_DEFAULT;
 	for (i = 0; i < ARRAY_SIZE(always_present_ids); i++) {
 		if (acpi_match_device_ids(adev, always_present_ids[i].hid))
 			continue;
@@ -125,15 +121,9 @@ bool acpi_device_always_present(struct acpi_device *adev)
 		    !dmi_check_system(always_present_ids[i].dmi_ids))
 			continue;
 
-		if (old_status != ACPI_STA_DEFAULT) /* Log only once */
-			dev_info(&adev->dev,
-				 "Device [%s] is in always present list\n",
-				 adev->pnp.bus_id);
-
 		ret = true;
 		break;
 	}
-	*status = old_status;
 
 	return ret;
 }
-- 
2.18.0

