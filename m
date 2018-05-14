Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753890AbeENOkm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 10:40:42 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35111 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753769AbeENOkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 10:40:39 -0400
X-Google-Smtp-Source: AB8JxZqAlyxRwKgqp16GGlC+3FkOhHuFWx0bC/qF+JB/g4UPMGe2vz4h78jY+0LVdTqWomyvWMaHmw==
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com
Cc: konrad.wilk@oracle.com, andr2000@gmail.com, andrii_chepurnyi@epam.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH v3 1/2] xen/kbdif: Sync up with the canonical definition in Xen
Date: Mon, 14 May 2018 17:40:28 +0300
Message-Id: <20180514144029.16019-1-andr2000@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

This is the sync up with the canonical definition of the keyboard
protocol in Xen:
1. Add missing string constants for {feature|request}-raw-pointer
   to align with the rest of the interface file.

2. Add new XenStore feature fields, so it is possible to individually
   control set of exposed virtual devices for each guest OS:
     - set feature-disable-keyboard to 1 if no keyboard device needs
       to be created
     - set feature-disable-pointer to 1 if no pointer device needs
       to be created

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 include/xen/interface/io/kbdif.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/include/xen/interface/io/kbdif.h b/include/xen/interface/io/kbdif.h
index 2a9510ade701..808ef7d02a65 100644
--- a/include/xen/interface/io/kbdif.h
+++ b/include/xen/interface/io/kbdif.h
@@ -51,6 +51,18 @@
  * corresponding entries in XenStore and puts 1 as the value of the entry.
  * If a feature is not supported then 0 must be set or feature entry omitted.
  *
+ * feature-disable-keyboard
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual keyboard device by the
+ *      frontend then this must be set to 1.
+ *
+ * feature-disable-pointer
+ *      Values:         <uint>
+ *
+ *      If there is no need to expose a virtual pointer device by the
+ *      frontend then this must be set to 1.
+ *
  * feature-abs-pointer
  *      Values:         <uint>
  *
@@ -63,6 +75,13 @@
  *      Backends, which support reporting of multi-touch events
  *      should set this to 1.
  *
+ * feature-raw-pointer
+ *      Values:        <uint>
+ *
+ *      Backends, which support reporting raw (unscaled) absolute coordinates
+ *      for pointer devices should set this to 1. Raw (unscaled) values have
+ *      a range of [0, 0x7fff].
+ *
  *------------------------- Pointer Device Parameters ------------------------
  *
  * width
@@ -98,6 +117,13 @@
  *
  *      Request backend to report multi-touch events.
  *
+ * request-raw-pointer
+ *      Values:         <uint>
+ *
+ *      Request backend to report raw unscaled absolute pointer coordinates.
+ *      This option is only valid if request-abs-pointer is also set.
+ *      Raw unscaled coordinates have the range [0, 0x7fff]
+ *
  *----------------------- Request Transport Parameters -----------------------
  *
  * event-channel
@@ -163,9 +189,13 @@
 
 #define XENKBD_DRIVER_NAME		"vkbd"
 
+#define XENKBD_FIELD_FEAT_DSBL_KEYBRD	"feature-disable-keyboard"
+#define XENKBD_FIELD_FEAT_DSBL_POINTER	"feature-disable-pointer"
 #define XENKBD_FIELD_FEAT_ABS_POINTER	"feature-abs-pointer"
+#define XENKBD_FIELD_FEAT_RAW_POINTER	"feature-raw-pointer"
 #define XENKBD_FIELD_FEAT_MTOUCH	"feature-multi-touch"
 #define XENKBD_FIELD_REQ_ABS_POINTER	"request-abs-pointer"
+#define XENKBD_FIELD_REQ_RAW_POINTER	"request-raw-pointer"
 #define XENKBD_FIELD_REQ_MTOUCH		"request-multi-touch"
 #define XENKBD_FIELD_RING_GREF		"page-gref"
 #define XENKBD_FIELD_EVT_CHANNEL	"event-channel"
-- 
2.17.0
