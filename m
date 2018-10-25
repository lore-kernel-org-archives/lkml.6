Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA1DECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C814D20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ma2VuIg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C814D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeJYWrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbeJYWrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:42 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C65D20834;
        Thu, 25 Oct 2018 14:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476886;
        bh=bVJbbLUbw57/OQ7Ehm0jH1+4kMz5P0o+zPwqjZCOZMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ma2VuIg+sP/68sFLEZl1P20Sfbk4HqEvjAk+WGnMXFQleKFtjfoyoqVPY18rSYLGn
         89OPPNO5x6FBwtm2U52cIVqbKBadMVU2ysnN9QTJ/6A/G3Tmz4QWqabWBZXrdWGeda
         HIn8d1/DOqnrxebOQfhibk5UvCxMlinrB9BtLrJo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 13/98] platform/x86: acer-wmi: setup accelerometer when ACPI device was found
Date:   Thu, 25 Oct 2018 10:12:58 -0400
Message-Id: <20181025141423.213774-13-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>

[ Upstream commit f9ac89f5ad613b462339e845aeb8494646fd9be2 ]

The 98d610c3739a patch was introduced since v4.11-rc1 that it causes
that the accelerometer input device will not be created on workable
machines because the HID string comparing logic is wrong.

And, the patch doesn't prevent that the accelerometer input device
be created on the machines that have no BST0001. That's because
the acpi_get_devices() returns success even it didn't find any
match device.

This patch fixed the HID string comparing logic of BST0001 device.
And, it also makes sure that the acpi_get_devices() returns
acpi_handle for BST0001.

Fixes: 98d610c3739a ("acer-wmi: setup accelerometer when machine has appropriate notify event")
Reference: https://bugzilla.kernel.org/show_bug.cgi?id=193761
Reported-by: Samuel Sieb <samuel-kbugs@sieb.net>
Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index c29b9b611ab2..1515c9480f89 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1856,7 +1856,7 @@ static acpi_status __init acer_wmi_get_handle_cb(acpi_handle ah, u32 level,
 	if (!strcmp(ctx, "SENR")) {
 		if (acpi_bus_get_device(ah, &dev))
 			return AE_OK;
-		if (!strcmp(ACER_WMID_ACCEL_HID, acpi_device_hid(dev)))
+		if (strcmp(ACER_WMID_ACCEL_HID, acpi_device_hid(dev)))
 			return AE_OK;
 	} else
 		return AE_OK;
@@ -1877,8 +1877,7 @@ static int __init acer_wmi_get_handle(const char *name, const char *prop,
 	handle = NULL;
 	status = acpi_get_devices(prop, acer_wmi_get_handle_cb,
 					(void *)name, &handle);
-
-	if (ACPI_SUCCESS(status)) {
+	if (ACPI_SUCCESS(status) && handle) {
 		*ah = handle;
 		return 0;
 	} else {
@@ -2247,8 +2246,8 @@ static int __init acer_wmi_init(void)
 		if (err)
 			return err;
 		err = acer_wmi_accel_setup();
-		if (err)
-			return err;
+		if (err && err != -ENODEV)
+			pr_warn("Cannot enable accelerometer\n");
 	}
 
 	err = platform_driver_register(&acer_platform_driver);
-- 
2.17.1

