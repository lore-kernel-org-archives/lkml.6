Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DEEC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8E920835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8E920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbeJLV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53152 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJLV5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 614A085A04;
        Fri, 12 Oct 2018 14:24:23 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21070282C5;
        Fri, 12 Oct 2018 14:24:20 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/5] Input: elantech - query the min/max information beforehand too
Date:   Fri, 12 Oct 2018 16:24:09 +0200
Message-Id: <20181012142413.26107-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 12 Oct 2018 14:24:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the latest generation of Elantech touchpads, we need to forward
the min/max information from PS/2 to SMBus. Prepare this work
by fetching the information before creating the SMBus companion
device.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 160 +++++++++++++++++++----------------------
 drivers/input/mouse/elantech.h |   5 ++
 2 files changed, 79 insertions(+), 86 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 2d95e8d93cc7..577c795cbe82 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -994,88 +994,6 @@ static int elantech_set_absolute_mode(struct psmouse *psmouse)
 	return rc;
 }
 
-static int elantech_set_range(struct psmouse *psmouse,
-			      unsigned int *x_min, unsigned int *y_min,
-			      unsigned int *x_max, unsigned int *y_max,
-			      unsigned int *width)
-{
-	struct elantech_data *etd = psmouse->private;
-	struct elantech_device_info *info = &etd->info;
-	unsigned char param[3];
-	unsigned char traces;
-
-	switch (info->hw_version) {
-	case 1:
-		*x_min = ETP_XMIN_V1;
-		*y_min = ETP_YMIN_V1;
-		*x_max = ETP_XMAX_V1;
-		*y_max = ETP_YMAX_V1;
-		break;
-
-	case 2:
-		if (info->fw_version == 0x020800 ||
-		    info->fw_version == 0x020b00 ||
-		    info->fw_version == 0x020030) {
-			*x_min = ETP_XMIN_V2;
-			*y_min = ETP_YMIN_V2;
-			*x_max = ETP_XMAX_V2;
-			*y_max = ETP_YMAX_V2;
-		} else {
-			int i;
-			int fixed_dpi;
-
-			i = (info->fw_version > 0x020800 &&
-			     info->fw_version < 0x020900) ? 1 : 2;
-
-			if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
-				return -1;
-
-			fixed_dpi = param[1] & 0x10;
-
-			if (((info->fw_version >> 16) == 0x14) && fixed_dpi) {
-				if (info->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
-					return -1;
-
-				*x_max = (info->capabilities[1] - i) * param[1] / 2;
-				*y_max = (info->capabilities[2] - i) * param[2] / 2;
-			} else if (info->fw_version == 0x040216) {
-				*x_max = 819;
-				*y_max = 405;
-			} else if (info->fw_version == 0x040219 || info->fw_version == 0x040215) {
-				*x_max = 900;
-				*y_max = 500;
-			} else {
-				*x_max = (info->capabilities[1] - i) * 64;
-				*y_max = (info->capabilities[2] - i) * 64;
-			}
-		}
-		break;
-
-	case 3:
-		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
-			return -1;
-
-		*x_max = (0x0f & param[0]) << 8 | param[1];
-		*y_max = (0xf0 & param[0]) << 4 | param[2];
-		break;
-
-	case 4:
-		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
-			return -1;
-
-		*x_max = (0x0f & param[0]) << 8 | param[1];
-		*y_max = (0xf0 & param[0]) << 4 | param[2];
-		traces = info->capabilities[1];
-		if ((traces < 2) || (traces > *x_max))
-			return -1;
-
-		*width = *x_max / (traces - 1);
-		break;
-	}
-
-	return 0;
-}
-
 /*
  * (value from firmware) * 10 + 790 = dpi
  * we also have to convert dpi to dots/mm (*10/254 to avoid floating point)
@@ -1191,10 +1109,9 @@ static int elantech_set_input_params(struct psmouse *psmouse)
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 	struct elantech_device_info *info = &etd->info;
-	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
-
-	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
-		return -1;
+	unsigned int x_min = info->x_min, y_min = info->y_min,
+		     x_max = info->x_max, y_max = info->y_max,
+		     width = info->width;
 
 	__set_bit(INPUT_PROP_POINTER, dev->propbit);
 	__set_bit(EV_KEY, dev->evbit);
@@ -1678,6 +1595,7 @@ static int elantech_query_info(struct psmouse *psmouse,
 			       struct elantech_device_info *info)
 {
 	unsigned char param[3];
+	unsigned char traces;
 
 	memset(info, 0, sizeof(*info));
 
@@ -1746,6 +1664,76 @@ static int elantech_query_info(struct psmouse *psmouse,
 		}
 	}
 
+	/* query range information */
+	switch (info->hw_version) {
+	case 1:
+		info->x_min = ETP_XMIN_V1;
+		info->y_min = ETP_YMIN_V1;
+		info->x_max = ETP_XMAX_V1;
+		info->y_max = ETP_YMAX_V1;
+		break;
+
+	case 2:
+		if (info->fw_version == 0x020800 ||
+		    info->fw_version == 0x020b00 ||
+		    info->fw_version == 0x020030) {
+			info->x_min = ETP_XMIN_V2;
+			info->y_min = ETP_YMIN_V2;
+			info->x_max = ETP_XMAX_V2;
+			info->y_max = ETP_YMAX_V2;
+		} else {
+			int i;
+			int fixed_dpi;
+
+			i = (info->fw_version > 0x020800 &&
+			     info->fw_version < 0x020900) ? 1 : 2;
+
+			if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+				return -EINVAL;
+
+			fixed_dpi = param[1] & 0x10;
+
+			if (((info->fw_version >> 16) == 0x14) && fixed_dpi) {
+				if (info->send_cmd(psmouse, ETP_SAMPLE_QUERY, param))
+					return -EINVAL;
+
+				info->x_max = (info->capabilities[1] - i) * param[1] / 2;
+				info->y_max = (info->capabilities[2] - i) * param[2] / 2;
+			} else if (info->fw_version == 0x040216) {
+				info->x_max = 819;
+				info->y_max = 405;
+			} else if (info->fw_version == 0x040219 || info->fw_version == 0x040215) {
+				info->x_max = 900;
+				info->y_max = 500;
+			} else {
+				info->x_max = (info->capabilities[1] - i) * 64;
+				info->y_max = (info->capabilities[2] - i) * 64;
+			}
+		}
+		break;
+
+	case 3:
+		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+			return -EINVAL;
+
+		info->x_max = (0x0f & param[0]) << 8 | param[1];
+		info->y_max = (0xf0 & param[0]) << 4 | param[2];
+		break;
+
+	case 4:
+		if (info->send_cmd(psmouse, ETP_FW_ID_QUERY, param))
+			return -EINVAL;
+
+		info->x_max = (0x0f & param[0]) << 8 | param[1];
+		info->y_max = (0xf0 & param[0]) << 4 | param[2];
+		traces = info->capabilities[1];
+		if ((traces < 2) || (traces > info->x_max))
+			return -EINVAL;
+
+		info->width = info->x_max / (traces - 1);
+		break;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 119727085a60..194503ed59c5 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -144,8 +144,13 @@ struct elantech_device_info {
 	unsigned char debug;
 	unsigned char hw_version;
 	unsigned int fw_version;
+	unsigned int x_min;
+	unsigned int y_min;
+	unsigned int x_max;
+	unsigned int y_max;
 	unsigned int x_res;
 	unsigned int y_res;
+	unsigned int width;
 	unsigned int bus;
 	bool paritycheck;
 	bool jumpy_cursor;
-- 
2.14.3

