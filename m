Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B7DECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AC32087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AC32087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731897AbeGMO2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:28:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729778AbeGMO2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:28:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9BDD40122CF;
        Fri, 13 Jul 2018 14:14:02 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-134.ams2.redhat.com [10.36.116.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93AE11C67D;
        Fri, 13 Jul 2018 14:14:01 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 01/12] input: add MT_TOOL_DIAL
Date:   Fri, 13 Jul 2018 16:13:43 +0200
Message-Id: <20180713141354.7286-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
References: <20180713141354.7286-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 14:14:02 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Fri, 13 Jul 2018 14:14:02 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
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

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v4:
- replace the values with hex
- make MT_TOOL_MAX > MT_TOOL_DIAL

changes in v3:
- re-insert the change in include/uapi/linux/input.h

new in v2 (extracted from previous series in its own patch)
---
 Documentation/input/multi-touch-protocol.rst | 12 ++++++------
 include/uapi/linux/input.h                   |  9 +++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

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
index 7288a7c573cc..fb78f6f500f3 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -270,10 +270,11 @@ struct input_mask {
 /*
  * MT_TOOL types
  */
-#define MT_TOOL_FINGER		0
-#define MT_TOOL_PEN		1
-#define MT_TOOL_PALM		2
-#define MT_TOOL_MAX		2
+#define MT_TOOL_FINGER		0x00
+#define MT_TOOL_PEN		0x01
+#define MT_TOOL_PALM		0x02
+#define MT_TOOL_DIAL		0x0a
+#define MT_TOOL_MAX		0x0f
 
 /*
  * Values describing the status of a force-feedback effect
-- 
2.14.3

