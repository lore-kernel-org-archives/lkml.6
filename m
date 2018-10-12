Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2225AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B4A2098A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B4A2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeJLV5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 17:57:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728616AbeJLV5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 17:57:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9861930001D4;
        Fri, 12 Oct 2018 14:24:30 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93B61282C9;
        Fri, 12 Oct 2018 14:24:28 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/5] Input: elan_i2c - do not query the info if they are provided
Date:   Fri, 12 Oct 2018 16:24:12 +0200
Message-Id: <20181012142413.26107-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Fri, 12 Oct 2018 14:24:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See the previous patch for a long explanation.

TL;DR: the P52 and the t480s from Lenovo can't rely on I2C to fetch
the information, so we need it from PS/2.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elan_i2c_core.c | 49 +++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f5ae24865355..5e7ba383f95c 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -366,27 +366,50 @@ static unsigned int elan_convert_resolution(u8 val)
 
 static int elan_query_device_parameters(struct elan_tp_data *data)
 {
+	struct i2c_client *client = data->client;
 	unsigned int x_traces, y_traces;
 	u8 hw_x_res, hw_y_res;
 	int error;
 
-	error = data->ops->get_max(data->client, &data->max_x, &data->max_y);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,max_x", &data->max_x) ||
+	    device_property_read_u32(&client->dev,
+				     "elan,max_y", &data->max_y)) {
+		error = data->ops->get_max(data->client,
+					   &data->max_x,
+					   &data->max_y);
+		if (error)
+			return error;
+	}
 
-	error = data->ops->get_num_traces(data->client, &x_traces, &y_traces);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,width", &data->width_x)) {
+		error = data->ops->get_num_traces(data->client,
+						  &x_traces, &y_traces);
+		if (error)
+			return error;
 
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+		data->width_x = data->max_x / x_traces;
+		data->width_y = data->max_y / y_traces;
+	} else {
+		data->width_y = data->width_x;
+	}
 
-	error = data->ops->get_resolution(data->client, &hw_x_res, &hw_y_res);
-	if (error)
-		return error;
+	if (device_property_read_u32(&client->dev,
+				     "elan,x_res", &data->x_res) ||
+	    device_property_read_u32(&client->dev,
+				     "elan,y_res", &data->y_res)) {
+		error = data->ops->get_resolution(data->client,
+						  &hw_x_res, &hw_y_res);
+		if (error)
+			return error;
+
+		data->x_res = elan_convert_resolution(hw_x_res);
+		data->y_res = elan_convert_resolution(hw_y_res);
+	}
 
-	data->x_res = elan_convert_resolution(hw_x_res);
-	data->y_res = elan_convert_resolution(hw_y_res);
+	if (device_property_read_bool(&client->dev, "elan,clickpad"))
+		data->clickpad = 1;
 
 	return 0;
 }
-- 
2.14.3

