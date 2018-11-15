Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C5C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2678E223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2678E223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388835AbeKPES2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:18:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46424 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726453AbeKPES2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:18:28 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 41B9C30014D1;
        Thu, 15 Nov 2018 18:09:37 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E88560BF9;
        Thu, 15 Nov 2018 18:09:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] hyper-v: Fix wakeup from suspend-to-idle
Date:   Thu, 15 Nov 2018 19:09:33 +0100
Message-Id: <20181115180933.396-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 15 Nov 2018 18:09:37 +0000 (UTC)
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
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: K. Y. Srinivasan <kys@microsoft.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
- It seems the patch slipped through the cracks, resending.
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
2.17.2

