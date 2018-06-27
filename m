Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4310C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DFD725E58
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 17:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M78Od7l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFD725E58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965335AbeF0RzK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 13:55:10 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45795 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934337AbeF0RzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 13:55:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id bi1-v6so1395071plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 10:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cBD8eQG8nvVrU+5Wm63PiXTipuVP76EsJWLpLCB6+FM=;
        b=M78Od7l1tWvQdL5HUOcmnlo/RM4mSvppV3q1KwHDiMIfDfkkd4NeoTs/M5vBxzoXlU
         c4H/sFQj7Qg/hVHC02W+dNT5AJ5XB+8GTwrgBkHJWMCpQ2Tr/ztru7GphKhv5HvaIKSq
         6fZReXAr8in3vr2nRiw4tb9l7HVRDJL2Aishc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cBD8eQG8nvVrU+5Wm63PiXTipuVP76EsJWLpLCB6+FM=;
        b=rwOJzEub/baznUzZe/bwz15JRKRtitlJ6EmSFzKODA5rpL+nBFZNSbUHPC2Pjj7F1x
         yXvrCWHVSScx87SHuaEe43J60XVO8zF3NHnl3ay36KpekB+a8X6Q4XZmRjPb8lvhfOve
         kvVkAdXUUmaqKffWgfqFTEeFMtdzVDDdr/F/vuUESUPTzyZQJIqUIEVkVPfdebIq/v6a
         VOdHOqvIuOZo9XpDgfbfzQP+EO/XGgcmleOAEiwxSudxwJIIOOzJh2aEFcjf6m4/bQe4
         2jbsiA5KdxUOTRiuLA5xEA1hlvCOSvGqwrToEh2R4HXsTqIwbJU1zQHDO9D24124m2xS
         m3dA==
X-Gm-Message-State: APt69E3hqWtSdK8wohqDu/HFFfGG0rB7TO3JHyKd4VKKcZ3xamSC8EzY
        olYYZIpfEcE4wc2eXAm0wt133A==
X-Google-Smtp-Source: ADUXVKK4qrJPqRo0xnPw8Lg/x5JNqCF99P75VMPlSMcClgIT6g80x0qNIz/yw1meUkJZ7HLlb51gEw==
X-Received: by 2002:a17:902:b217:: with SMTP id t23-v6mr7206931plr.312.1530122107947;
        Wed, 27 Jun 2018 10:55:07 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:0:1000:1501:1f1:adfa:a458:823f])
        by smtp.gmail.com with ESMTPSA id s87-v6sm11702208pfa.106.2018.06.27.10.55.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 10:55:07 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, ravisadineni@chromium.org,
        ravisadineni@google.com
Cc:     dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: [PATCH V3] ACPI LID: increment wakeup count only when notified.
Date:   Wed, 27 Jun 2018 10:55:02 -0700
Message-Id: <20180627175502.178725-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <2352530.ePvj7nqZEq@aspire.rjw.lan>
References: <2352530.ePvj7nqZEq@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 v3:  Change is_notification to signal_wakeup
 V2: Increment the wakeup count only when the lid is open.

 drivers/acpi/button.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5ee2dbbc..40ed3ec9fc94c 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -235,9 +235,6 @@ static int acpi_lid_notify_state(struct acpi_device *device, int state)
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
 
@@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	if (state < 0)
 		return state;
 
+	if (state && signal_wakeup)
+		acpi_pm_wakeup_event(&device->dev);
+
 	return acpi_lid_notify_state(device, state);
 }
 
@@ -384,7 +385,7 @@ static void acpi_lid_initialize_state(struct acpi_device *device)
 		(void)acpi_lid_notify_state(device, 1);
 		break;
 	case ACPI_BUTTON_LID_INIT_METHOD:
-		(void)acpi_lid_update_state(device);
+		(void)acpi_lid_update_state(device, false);
 		break;
 	case ACPI_BUTTON_LID_INIT_IGNORE:
 	default:
@@ -409,7 +410,7 @@ static void acpi_button_notify(struct acpi_device *device, u32 event)
 			users = button->input->users;
 			mutex_unlock(&button->input->mutex);
 			if (users)
-				acpi_lid_update_state(device);
+				acpi_lid_update_state(device, true);
 		} else {
 			int keycode;
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

