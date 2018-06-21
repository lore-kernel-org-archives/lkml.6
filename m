Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F8AC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0936A208A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0936A208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933385AbeFUMJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:09:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933199AbeFUMJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:09:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EAEEB8182D16;
        Thu, 21 Jun 2018 12:09:14 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-117-99.ams2.redhat.com [10.36.117.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F3682026D6B;
        Thu, 21 Jun 2018 12:09:13 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 01/12] input: add MT_TOOL_DIAL
Date:   Thu, 21 Jun 2018 14:08:57 +0200
Message-Id: <20180621120908.16706-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 12:09:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Thu, 21 Jun 2018 12:09:15 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A dial is a tool you place on a multitouch surface which reports its
orientation or a relative angle of rotation when rotating its knob.

Some examples are the Dell Totem (on the Canvas 27"), the Microsoft Dial,
or the Griffin Powermate, though the later can't be put on a touch surface.

We give some extra space to account for other types of fingers if we need
(MT_TOOL_THUMB)

Slightly change the documentation to not make it mandatory to update each
MT_TOOL we add.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2 (extracted from previous series in its own patch)

changes in v3:
- re-insert the change in include/uapi/linux/input.h
---
 Documentation/input/multi-touch-protocol.rst | 12 ++++++------
 include/uapi/linux/input.h                   |  3 ++-
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
index b51751a0cd5d..6be70342e709 100644
--- a/Documentation/input/multi-touch-protocol.rst
+++ b/Documentation/input/multi-touch-protocol.rst
@@ -310,12 +310,12 @@ ABS_MT_TOOL_Y
 ABS_MT_TOOL_TYPE
     The type of approaching tool. A lot of kernel drivers cannot distinguish
     between different tool types, such as a finger or a pen. In such cases, the
-    event should be omitted. The protocol currently supports MT_TOOL_FINGER,
-    MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_. For type B devices, this event is
-    handled by input core; drivers should instead use
-    input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may change over
-    time while still touching the device, because the firmware may not be able
-    to determine which tool is being used when it first appears.
+    event should be omitted. The protocol currently mainly supports
+    MT_TOOL_FINGER, MT_TOOL_PEN, and MT_TOOL_PALM [#f2]_.
+    For type B devices, this event is handled by input core; drivers should
+    instead use input_mt_report_slot_state(). A contact's ABS_MT_TOOL_TYPE may
+    change over time while still touching the device, because the firmware may
+    not be able to determine which tool is being used when it first appears.
 
 ABS_MT_BLOB_ID
     The BLOB_ID groups several packets together into one arbitrarily shaped
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index 7288a7c573cc..e931b0468b6d 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -273,7 +273,8 @@ struct input_mask {
 #define MT_TOOL_FINGER		0
 #define MT_TOOL_PEN		1
 #define MT_TOOL_PALM		2
-#define MT_TOOL_MAX		2
+#define MT_TOOL_DIAL		10
+#define MT_TOOL_MAX		10
 
 /*
  * Values describing the status of a force-feedback effect
-- 
2.14.3

