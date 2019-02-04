Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49718C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CBB2184B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KqxgWaCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730391AbfBDOYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:44 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59694 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbfBDOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENlHC092552;
        Mon, 4 Feb 2019 08:23:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290227;
        bh=93dULJjujpSqIrNJQ463PFFgzThrUMl392hE2ZPf+UI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KqxgWaCzRjdSVy5taTeA6JWQ2J15STPlHjTxqFKjeXRjNGCSMZGEXjWiXhmRnhAxO
         7Om4R/nozEgq5HXTzSJZk3i3EN2OmMxXCV3w8+0GfHKENWoVV9bYfYZTKlFsrvXRGA
         gzx0suTuBCuiHU8W+kL90ztARRkjj6Pi73qh6g9c=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENlBS010485
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:47 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:46 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKl012232;
        Mon, 4 Feb 2019 08:23:43 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 13/14] rpmsg: virtio_rpmsg_bus: move back rpmsg_hdr into a public header
Date:   Mon, 4 Feb 2019 16:22:46 +0200
Message-ID: <1549290167-876-14-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Commit e88dae5da46d ("rpmsg: Move virtio specifics from public header")
has moved the struct rpmsg_hdr definition from the public rpmsg.h and
made it private to virtio_rpmsg_bus module. This structure is a common
header used in all virtio rpmsg messages, and used by various virtio
rpmsg bus drivers. So, move this back into the virtio_rpmsg specific
public header to make it visible to various rpmsg drivers.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c   | 21 +--------------------
 include/linux/rpmsg/virtio_rpmsg.h | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/rpmsg/virtio_rpmsg.h

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 664f957..f654923 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -26,6 +26,7 @@
 #include <linux/rpmsg.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
+#include <linux/rpmsg/virtio_rpmsg.h>
 
 #include "rpmsg_internal.h"
 
@@ -73,26 +74,6 @@ struct virtproc_info {
 #define VIRTIO_RPMSG_F_NS	0 /* RP supports name service notifications */
 
 /**
- * struct rpmsg_hdr - common header for all rpmsg messages
- * @src: source address
- * @dst: destination address
- * @reserved: reserved for future use
- * @len: length of payload (in bytes)
- * @flags: message flags
- * @data: @len bytes of message payload data
- *
- * Every message sent(/received) on the rpmsg bus begins with this header.
- */
-struct rpmsg_hdr {
-	u32 src;
-	u32 dst;
-	u32 reserved;
-	u16 len;
-	u16 flags;
-	u8 data[0];
-} __packed;
-
-/**
  * struct rpmsg_ns_msg - dynamic name service announcement message
  * @name: name of remote service that is published
  * @addr: address of remote service that is published
diff --git a/include/linux/rpmsg/virtio_rpmsg.h b/include/linux/rpmsg/virtio_rpmsg.h
new file mode 100644
index 0000000..cf5f820
--- /dev/null
+++ b/include/linux/rpmsg/virtio_rpmsg.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_RPMSG_VIRTIO_RPMSG_H
+#define _LINUX_RPMSG_VIRTIO_RPMSG_H
+
+/**
+ * struct rpmsg_hdr - common header for all virtio rpmsg messages
+ * @src: source address
+ * @dst: destination address
+ * @reserved: reserved for future use
+ * @len: length of payload (in bytes)
+ * @flags: message flags
+ * @data: @len bytes of message payload data
+ *
+ * Every message sent(/received) on the rpmsg bus begins with this header.
+ */
+struct rpmsg_hdr {
+	u32 src;
+	u32 dst;
+	u32 reserved;
+	u16 len;
+	u16 flags;
+	u8 data[0];
+} __packed;
+
+#endif
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

