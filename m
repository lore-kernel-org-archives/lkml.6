Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BFECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FB620892
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roy82IIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62FB620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeKIHlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:41:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbeKIHlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:41:05 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9172081C;
        Thu,  8 Nov 2018 22:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714615;
        bh=L5ltFcKQy5ZV/+SePChDGaxR0cvT3oceZX5zqDXf47s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Roy82IIB4AWJbDClRfU2LmVxWsj56WZiJkJwXM70oBNaZcvGagIeNkCZu3oVxCnFk
         bAprHOaGvOoybG27QdqbEmdet1eXrKsABFryh9D7rn5TYG6Zaq8FiLC9DAE68V8/Oh
         K4Hh7kmPTLXh8ujcMLqrb9xuDqz6c32+YII5g7hc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Sieb <samuel-kbugs@sieb.net>,
        "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 044/171] platform/x86: acer-wmi: setup accelerometer when ACPI device was found
Date:   Thu,  8 Nov 2018 13:50:14 -0800
Message-Id: <20181108215130.701445738@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



