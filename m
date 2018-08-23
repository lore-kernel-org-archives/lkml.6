Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE80C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B6C420A8B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:18:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6C420A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbeHWLrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:47:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbeHWLrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:47:12 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5644C83;
        Thu, 23 Aug 2018 08:18:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Nick Dyer <nick@shmanahar.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 008/217] Input: synaptics-rmi4 - fix axis-swap behavior
Date:   Thu, 23 Aug 2018 09:52:01 +0200
Message-Id: <20180823075505.806661419@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas Stach <l.stach@pengutronix.de>

[ Upstream commit 645a397d325db6e1bb36588095ae637738b37693 ]

The documentation for the touchscreen-swapped-x-y property states that
swapping is done after inverting if both are used. RMI4 did it the other
way around, leading to inconsistent behavior with regard to other
touchscreens.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Tested-by: Nick Dyer <nick@shmanahar.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_2d_sensor.c |   34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -32,15 +32,15 @@ void rmi_2d_sensor_abs_process(struct rm
 	if (obj->type == RMI_2D_OBJECT_NONE)
 		return;
 
-	if (axis_align->swap_axes)
-		swap(obj->x, obj->y);
-
 	if (axis_align->flip_x)
 		obj->x = sensor->max_x - obj->x;
 
 	if (axis_align->flip_y)
 		obj->y = sensor->max_y - obj->y;
 
+	if (axis_align->swap_axes)
+		swap(obj->x, obj->y);
+
 	/*
 	 * Here checking if X offset or y offset are specified is
 	 * redundant. We just add the offsets or clip the values.
@@ -120,15 +120,15 @@ void rmi_2d_sensor_rel_report(struct rmi
 	x = min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)x));
 	y = min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)y));
 
-	if (axis_align->swap_axes)
-		swap(x, y);
-
 	if (axis_align->flip_x)
 		x = min(RMI_2D_REL_POS_MAX, -x);
 
 	if (axis_align->flip_y)
 		y = min(RMI_2D_REL_POS_MAX, -y);
 
+	if (axis_align->swap_axes)
+		swap(x, y);
+
 	if (x || y) {
 		input_report_rel(sensor->input, REL_X, x);
 		input_report_rel(sensor->input, REL_Y, y);
@@ -141,17 +141,10 @@ static void rmi_2d_sensor_set_input_para
 	struct input_dev *input = sensor->input;
 	int res_x;
 	int res_y;
+	int max_x, max_y;
 	int input_flags = 0;
 
 	if (sensor->report_abs) {
-		if (sensor->axis_align.swap_axes) {
-			swap(sensor->max_x, sensor->max_y);
-			swap(sensor->axis_align.clip_x_low,
-			     sensor->axis_align.clip_y_low);
-			swap(sensor->axis_align.clip_x_high,
-			     sensor->axis_align.clip_y_high);
-		}
-
 		sensor->min_x = sensor->axis_align.clip_x_low;
 		if (sensor->axis_align.clip_x_high)
 			sensor->max_x = min(sensor->max_x,
@@ -163,14 +156,19 @@ static void rmi_2d_sensor_set_input_para
 				sensor->axis_align.clip_y_high);
 
 		set_bit(EV_ABS, input->evbit);
-		input_set_abs_params(input, ABS_MT_POSITION_X, 0, sensor->max_x,
-					0, 0);
-		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, sensor->max_y,
-					0, 0);
+
+		max_x = sensor->max_x;
+		max_y = sensor->max_y;
+		if (sensor->axis_align.swap_axes)
+			swap(max_x, max_y);
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
 
 		if (sensor->x_mm && sensor->y_mm) {
 			res_x = (sensor->max_x - sensor->min_x) / sensor->x_mm;
 			res_y = (sensor->max_y - sensor->min_y) / sensor->y_mm;
+			if (sensor->axis_align.swap_axes)
+				swap(res_x, res_y);
 
 			input_abs_set_res(input, ABS_X, res_x);
 			input_abs_set_res(input, ABS_Y, res_y);


