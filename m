Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22472C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BAB206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3BAB206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIGNbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:31:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58180 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbeIGNbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:31:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5C6598010FDF;
        Fri,  7 Sep 2018 08:51:21 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E884B2156889;
        Fri,  7 Sep 2018 08:51:17 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        Peter Hutterer <peter.hutterer@who-t.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Input: reserve 2 events code because of HID
Date:   Fri,  7 Sep 2018 10:51:15 +0200
Message-Id: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 08:51:21 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 07 Sep 2018 08:51:21 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@gmail.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
a duplicate is found") from the v4.18 kernel, HID used to shift the
event codes if a duplicate usage was found. This ended up in a situation
where a device would export a ton of ABS_MISC+n event codes, or a ton
of REL_MISC+n event codes.

This is now fixed, however userspace needs to detect those situation.
Fortunately, ABS_MISC+1 was never assigned a code, and so libinput
can detect fake multitouch devices from genuine ones by checking is
ABS_MISC+1 is set.

Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
true high res mice from some other device in a pre-v4.18 kernel.

Set in stone that the ABS_MISC+1 and REL_MISC+1 are reserved and should not
be used so userspace can properly work around those old kernels.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

while reviewing my local tree, I realize that we might want to be able
to differentiate older kernels from new ones that export REL_WHEEL_HI_RES.

I know Dmitry was against adding several REL_MISC, so I hope just moving
REL_WHEEL_HI_RES by one and reserving the faulty event codes would be good
this time.

This patch applies on top of the branch for-4.20/logitech-highres from
Jiri's tree. It should go through Jiri's tree as well.

Cheers,
Benjamin

 include/uapi/linux/input-event-codes.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 29fb891ea337..30149939249a 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -708,7 +708,12 @@
 #define REL_DIAL		0x07
 #define REL_WHEEL		0x08
 #define REL_MISC		0x09
-#define REL_WHEEL_HI_RES	0x0a
+/*
+ * 0x0a is reserved and should not be used.
+ * It was used by HID as REL_MISC+1 and usersapce needs to detect if
+ * the next REL_* event is correct or is just REL_MISC + n.
+ */
+#define REL_WHEEL_HI_RES	0x0b
 #define REL_MAX			0x0f
 #define REL_CNT			(REL_MAX+1)
 
@@ -745,6 +750,12 @@
 
 #define ABS_MISC		0x28
 
+/*
+ * 0x29 is reserved and should not be used.
+ * It was used by HID as ABS_MISC+1 and usersapce needs to detect if
+ * the next ABS_* event is correct or is just ABS_MISC + n.
+ */
+
 #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
 #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
 #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
-- 
2.14.3

