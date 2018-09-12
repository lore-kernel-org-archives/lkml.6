Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A7C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A3920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:11:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A3920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeILVQR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:16:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36320 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726819AbeILVQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:16:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54B47701E6;
        Wed, 12 Sep 2018 16:11:04 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D1CCFA997;
        Wed, 12 Sep 2018 16:11:02 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-pm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hyper-v: Fix wakeup from suspend-to-idle
Date:   Wed, 12 Sep 2018 18:11:01 +0200
Message-Id: <20180912161101.2634-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 16:11:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Wed, 12 Sep 2018 16:11:04 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'vkuznets@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It makes little sense but still possible to put Hyper-V guests into
suspend-to-idle state. To wake them up two wakeup sources were registered
in the past: hyperv-keyboard and hid-hyperv. However, since
commit eed4d47efe95 ("ACPI / sleep: Ignore spurious SCI wakeups from
suspend-to-idle") pm_wakeup_event() from these devices is ignored. Switch
to pm_wakeup_hard_event() API as these devices are actually the only
possible way to wakeup Hyper-V guests.

Fixes: eed4d47efe95 (ACPI / sleep: Ignore spurious SCI wakeups from suspend-to-idle)
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 drivers/hid/hid-hyperv.c              | 2 +-
 drivers/input/serio/hyperv-keyboard.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index b372854cf38d..704049e62d58 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -309,7 +309,7 @@ static void mousevsc_on_receive(struct hv_device *device,
 		hid_input_report(input_dev->hid_device, HID_INPUT_REPORT,
 				 input_dev->input_buf, len, 1);
 
-		pm_wakeup_event(&input_dev->device->device, 0);
+		pm_wakeup_hard_event(&input_dev->device->device);
 
 		break;
 	default:
diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
index 47a0e81a2989..a8b9be3e28db 100644
--- a/drivers/input/serio/hyperv-keyboard.c
+++ b/drivers/input/serio/hyperv-keyboard.c
@@ -177,7 +177,7 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
 		 * state because the Enter-UP can trigger a wakeup at once.
 		 */
 		if (!(info & IS_BREAK))
-			pm_wakeup_event(&hv_dev->device, 0);
+			pm_wakeup_hard_event(&hv_dev->device);
 
 		break;
 
-- 
2.14.4

