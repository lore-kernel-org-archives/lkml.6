Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HuARMoHlGFt3LQAAmS7hNA
	; Thu, 07 Jun 2018 07:58:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E45C2607E7; Thu,  7 Jun 2018 07:58:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 64DB560452;
	Thu,  7 Jun 2018 07:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64DB560452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeFGH6G (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 03:58:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753405AbeFGHy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 03:54:57 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 003E5C12A8;
        Thu,  7 Jun 2018 07:54:57 +0000 (UTC)
Received: from plouf.banquise.eu.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B8FF52026DEF;
        Thu,  7 Jun 2018 07:54:54 +0000 (UTC)
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mario.Limonciello@dell.com,
        Peter Hutterer <peter.hutterer@who-t.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 02/13] input: add MT_TOOL_DIAL
Date: Thu,  7 Jun 2018 09:54:37 +0200
Message-Id: <20180607075448.5706-3-benjamin.tissoires@redhat.com>
In-Reply-To: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
References: <20180607075448.5706-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 07:54:57 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Thu, 07 Jun 2018 07:54:57 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
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

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2 (extracted from previous series in its own patch)
---
 Documentation/input/multi-touch-protocol.rst | 12 ++++++------
 include/uapi/linux/input-event-codes.h       |  3 ++-
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
diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index e8841cdb1ebd..a8d55f3909d3 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -854,6 +854,7 @@
 #define MT_TOOL_FINGER		0
 #define MT_TOOL_PEN		1
 #define MT_TOOL_PALM		2
-#define MT_TOOL_MAX		2
+#define MT_TOOL_DIAL		10
+#define MT_TOOL_MAX		10
 
 #endif
-- 
2.14.3
