Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50966C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BE121470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BE121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJDT1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5104 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbeJDT1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F75830001D7;
        Thu,  4 Oct 2018 12:34:37 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.36.118.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 73AA42CE66;
        Thu,  4 Oct 2018 12:34:33 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2] Input: reserve 2 events code because of HID
Date:   Thu,  4 Oct 2018 14:34:30 +0200
Message-Id: <20181004123430.29348-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 04 Oct 2018 12:34:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
a duplicate is found") from the v4.18 kernel, HID used to shift the
event codes if a duplicate usage was found. This ended up in a situation
where a device would export a ton of ABS_MISC+n event codes, or a ton
of REL_MISC+n event codes.

This is now fixed, however userspace needs to detect those situation.
Fortunately, ABS_MT_SLOT-1 (ABS_MISC+6) was never assigned a code, and
so libinput can detect fake multitouch devices from genuine ones by
checking if ABS_MT_SLOT-1 is set.

Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
true high res mice from some other device in a pre-v4.18 kernel.

Set in stone that the ABS_MISC+6 and REL_MISC+1 are reserved and should not
be used so userspace can properly work around those old kernels.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Dmitry, I did not take your Acked-by, as I added 2 new events and wanted to
be sure you are still OK.

Jiri, this will still need to go through your tree, as the input-event-codes
changes that introduce REL_WHEEL_HI_RES are in your for-4.20/logitech-highres.

Cheers,
Benjamin

 include/uapi/linux/input-event-codes.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 29fb891ea337..b5e0e9856c47 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,7 +708,15 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
-#define REL_WHEEL_HI_RES	0x0a
+/*
+ * 0x0a is reserved and should not be used in input drivers.
+ * It was used by HID as REL_MISC+1 and userspace needs to detect if
+ * the next REL_* event is correct or is just REL_MISC + n.
+ * We define here REL_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define REL_RESERVED		0x0a
+#define REL_WHEEL_HI_RES	0x0b
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
@@ -745,6 +753,15 @@
 
 #define ABS_MISC		0x28
 
+/*
+ * 0x2e is reserved and should not be used in input drivers.
+ * It was used by HID as ABS_MISC+6 and userspace needs to detect if
+ * the next ABS_* event is correct or is just ABS_MISC + n.
+ * We define here ABS_RESERVED so userspace can rely on it and detect
+ * the situation described above.
+ */
+#define ABS_RESERVED		0x2e
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
-- 
2.14.3

