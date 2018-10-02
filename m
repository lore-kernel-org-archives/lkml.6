Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A15C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73722089A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D73722089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeJBUKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60250 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeJBUKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:41 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E7059C20;
        Tue,  2 Oct 2018 13:27:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 054/228] platform/x86: asus-wireless: Fix uninitialized symbol usage
Date:   Tue,  2 Oct 2018 06:22:31 -0700
Message-Id: <20181002132502.890574091@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: João Paulo Rechi Vita <jprvita@endlessm.com>

[ Upstream commit eca4c4e47eb0658ad251f0bff465e23c055377da ]

'ret' will not be initialized if acpi_evaluate_integer() returns through
an error path, so it should not be used in this case. This fixes the
following Smatch static analyser error:

 drivers/platform/x86/asus-wireless.c:76 asus_wireless_method() error:
                                                     uninitialized symbol 'ret'.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: João Paulo Rechi Vita <jprvita@endlessm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/asus-wireless.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -52,13 +52,12 @@ static const struct acpi_device_id devic
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
 
-static u64 asus_wireless_method(acpi_handle handle, const char *method,
-				int param)
+static acpi_status asus_wireless_method(acpi_handle handle, const char *method,
+					int param, u64 *ret)
 {
 	struct acpi_object_list p;
 	union acpi_object obj;
 	acpi_status s;
-	u64 ret;
 
 	acpi_handle_debug(handle, "Evaluating method %s, parameter %#x\n",
 			  method, param);
@@ -67,24 +66,27 @@ static u64 asus_wireless_method(acpi_han
 	p.count = 1;
 	p.pointer = &obj;
 
-	s = acpi_evaluate_integer(handle, (acpi_string) method, &p, &ret);
+	s = acpi_evaluate_integer(handle, (acpi_string) method, &p, ret);
 	if (ACPI_FAILURE(s))
 		acpi_handle_err(handle,
 				"Failed to eval method %s, param %#x (%d)\n",
 				method, param, s);
-	acpi_handle_debug(handle, "%s returned %#llx\n", method, ret);
-	return ret;
+	else
+		acpi_handle_debug(handle, "%s returned %#llx\n", method, *ret);
+
+	return s;
 }
 
 static enum led_brightness led_state_get(struct led_classdev *led)
 {
 	struct asus_wireless_data *data;
-	int s;
+	acpi_status s;
+	u64 ret;
 
 	data = container_of(led, struct asus_wireless_data, led);
 	s = asus_wireless_method(acpi_device_handle(data->adev), "HSWC",
-				 data->hswc_params->status);
-	if (s == data->hswc_params->on)
+				 data->hswc_params->status, &ret);
+	if (ACPI_SUCCESS(s) && ret == data->hswc_params->on)
 		return LED_FULL;
 	return LED_OFF;
 }
@@ -92,10 +94,11 @@ static enum led_brightness led_state_get
 static void led_state_update(struct work_struct *work)
 {
 	struct asus_wireless_data *data;
+	u64 ret;
 
 	data = container_of(work, struct asus_wireless_data, led_work);
 	asus_wireless_method(acpi_device_handle(data->adev), "HSWC",
-			     data->led_state);
+			     data->led_state, &ret);
 }
 
 static void led_state_set(struct led_classdev *led, enum led_brightness value)


