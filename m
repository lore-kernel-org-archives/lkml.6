Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13791C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2D62083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2D62083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbeJBU4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:56:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbeJBUKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:43 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 74F5EB2F;
        Tue,  2 Oct 2018 13:27:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 055/228] ACPI / button: increment wakeup count only when notified
Date:   Tue,  2 Oct 2018 06:22:32 -0700
Message-Id: <20181002132503.001654655@linuxfoundation.org>
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

From: Ravi Chandra Sadineni <ravisadineni@chromium.org>

[ Upstream commit 7c058c7c74b3dbeb7d157c273959f87faf710350 ]

Because acpi_lid_initialize_state() is called on every system
resume and it triggers acpi_lid_notify_state() which invokes
acpi_pm_wakeup_event() for the lid device, the lid's wakeup count is
incremented even if the lid was not the source of the event that woke up
the system. That behavior confuses user space deamons using
wakeup_count to identify the potential system wakeup source. To avoid
the confusion, only trigger acpi_pm_wakeup_event() in the
acpi_button_notify() path and don't do that in the
acpi_lid_initialize_state() path.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/acpi/button.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct
 		button->last_time = ktime_get();
 	}
 
-	if (state)
-		acpi_pm_wakeup_event(&device->dev);
-
 	ret = blocking_notifier_call_chain(&acpi_lid_notifier, state, device);
 	if (ret == NOTIFY_DONE)
 		ret = blocking_notifier_call_chain(&acpi_lid_notifier, state,
@@ -366,7 +363,8 @@ int acpi_lid_open(void)
 }
 EXPORT_SYMBOL(acpi_lid_open);
 
-static int acpi_lid_update_state(struct acpi_device *device)
+static int acpi_lid_update_state(struct acpi_device *device,
+				 bool signal_wakeup)
 {
 	int state;
 
@@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct
 	if (state < 0)
 		return state;
 
+	if (state && signal_wakeup)
+		acpi_pm_wakeup_event(&device->dev);
+
 	return acpi_lid_notify_state(device, state);
 }
 
@@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(st
 		(void)acpi_lid_notify_state(device, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -409,7 +410,7 @@ static void acpi_button_notify(struct ac
 			users = button->input->users;
 			mutex_unlock(&button->input->mutex);
 			if (users)
-				acpi_lid_update_state(device);
+				acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
 


