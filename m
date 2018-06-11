Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4072AC07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA14A208B2
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jGvhzr07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA14A208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933824AbeFKR7D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:59:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36893 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932647AbeFKR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:59:01 -0400
Received: by mail-pf0-f195.google.com with SMTP id y5-v6so9731494pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 10:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zpWNBfoGxwT7agTpDOavD9TWXLeX5cvkMqjV9IQ59+I=;
        b=jGvhzr07gSVdx+gdIr0uitQjVSklkbD3tPTsIfwYza2U+nEg1Zi/QsoqQU4HK2WFNg
         thr7+9xUY2TdPEEh0cGC77bg+/5bkSgbprdvcCsU4Rk77t3wh9v3fx3iLdXt8UIWRTn2
         rh+KlnY+Y5XAtJ8LwwVxH8Dn17SB2JEOYkuj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zpWNBfoGxwT7agTpDOavD9TWXLeX5cvkMqjV9IQ59+I=;
        b=bTqNY8e9T36ArkGQFpLaKoBxnAHF2SUZ8zX3yA2nQER95SgaCz+kuXBakvn/AgSSea
         WbpV0k1J4KPS1HiTIkeg0WqNP0fNsgon0rTTWG9UhHUDVAngPQwhkc64UNKo9eyD/RJ2
         gbDFd8FiWQy+xPKY8fk20wTUEuiTvK1Ct1u/F4gdosqPiGy1dHdFa6CwFFPWL7TXw5h6
         BmozmGtFk2H/Oyf01/niN709apwFJyCu5q2jbspjhOPwxv4le+zf5mXy3L6GDb7bng2M
         7fJ5bzH/kQ80vyBzKD0P2mBeLYkkycmLmLfxkKDmJi0mJpMdL5QlP/jmSFKZwA0J79tM
         XgYw==
X-Gm-Message-State: APt69E1FbIa2VMCTOXQ8ivJGWmLUCM5P0HklwuBrSpd8s1SxH+vtWvsi
        5zqU33+MTkdGDosX4yWqavELeAzwIsc=
X-Google-Smtp-Source: ADUXVKKZwvvC09st0mK0delV1RLILGOf7XLtSRHnS7T11MGdctDzM4EdSZ2aI244/dex5HvF5pv/rg==
X-Received: by 2002:a62:ca99:: with SMTP id y25-v6mr166675pfk.187.1528739941289;
        Mon, 11 Jun 2018 10:59:01 -0700 (PDT)
Received: from ravisadineni0.mtv.corp.google.com ([2620:0:1000:1501:1f1:adfa:a458:823f])
        by smtp.gmail.com with ESMTPSA id w19-v6sm78377806pgv.59.2018.06.11.10.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 10:59:00 -0700 (PDT)
From:   Ravi Chandra Sadineni <ravisadineni@chromium.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, ravisadineni@chromium.org,
        ravisadineni@google.com
Cc:     dmitry.torokhov@gmail.com, tbroch@google.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rajatja@google.com, bleung@google.com, furquan@chromium.org
Subject: [PATCH V2] ACPI LID: increment wakeup count only when notified.
Date:   Mon, 11 Jun 2018 10:57:59 -0700
Message-Id: <20180611175759.181681-1-ravisadineni@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
References: <CAJZ5v0gXqyKQ5yTtqFYzv=KW2o+b4vGiUYiWWn+iT=zY-mU9xw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ACPI LID increments wakeup count irrespective of the wake source.
This is because we call acpi_lid_initialize_state on every resume.
Userland deamons using wakeup_count to identify the potential wake
source for the last wake will be thrown off by this. Instead increment
the wakeup count only when there is a FIXED_HARDWARE/NOTFIY_STATUS event.

Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
---
 V2: Increment the wakeup count only when the lid is open.

 drivers/acpi/button.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 2345a5ee2dbbc..d2fe03e4faf05 100644
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
+				 bool is_notification)
 {
 	int state;
 
@@ -374,6 +372,9 @@ static int acpi_lid_update_state(struct acpi_device *device)
 	if (state < 0)
 		return state;
 
+	if (state && is_notification)
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
2.18.0.rc1.242.g61856ae69a-goog

