Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721BFC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442722086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 442722086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbeJLV5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60096 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJLV5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0CE503001389;
        Fri, 12 Oct 2018 14:24:33 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A043282C5;
        Fri, 12 Oct 2018 14:24:30 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/5] Input: elantech/SMBus - export all capabilities from the PS/2 node
Date:   Fri, 12 Oct 2018 16:24:13 +0200
Message-Id: <20181012142413.26107-6-benjamin.tissoires@redhat.com>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 12 Oct 2018 14:24:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent touchpads might not have all the information regarding the
characteristics through the I2C port.
On some Lenovo t480s, this results in the touchpad not being detected
as a clickpad, and on the Lenovo P52, this results in a failure while
fetching the resolution through I2C.

We need to imitate the Windows behavior: fetch the data under PS/2, and
limit the querries under I2C.

This patch exports the needed info from PS/2.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 78ac732e8188..f597b5d14de8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1764,17 +1764,30 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 				 struct elantech_device_info *info,
 				 bool leave_breadcrumbs)
 {
-	const struct property_entry i2c_properties[] = {
-		PROPERTY_ENTRY_BOOL("elan,trackpoint"),
-		{ },
-	};
+	struct property_entry i2c_props[10] = {};
 	struct i2c_board_info smbus_board = {
 		I2C_BOARD_INFO("elan_i2c", 0x15),
 		.flags = I2C_CLIENT_HOST_NOTIFY,
 	};
+	unsigned int prop_idx = 0;
+
+	smbus_board.properties = i2c_props;
+
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,max_x", info->x_max);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,max_y", info->y_max);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,min_x", info->x_min);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,min_y", info->y_min);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,x_res", info->x_res);
+	i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,y_res", info->y_res);
 
 	if (info->has_trackpoint)
-		smbus_board.properties = i2c_properties;
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_BOOL("elan,trackpoint");
+
+	if (info->width)
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_U32("elan,width", info->width);
+
+	if (elantech_is_buttonpad(info))
+		i2c_props[prop_idx++] = PROPERTY_ENTRY_BOOL("elan,clickpad");
 
 	return psmouse_smbus_init(psmouse, &smbus_board, NULL, 0, false,
 				  leave_breadcrumbs);
-- 
2.14.3

