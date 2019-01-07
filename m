Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03282C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A6F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZdN4v7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfAGQna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:43:30 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37419 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfAGQna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:43:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id c25so377305pgb.4;
        Mon, 07 Jan 2019 08:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qd8d9av0X2U/poq85wxG6Xx4DFGNRfZuTQF5237CE6I=;
        b=oZdN4v7L0oJGbbdXPwG0OrDxbZD+A79AAtNco3D1RbchYX2jPpTCkl5Y0J825q+gDh
         thgG3bql3TXFwx/ic2kurJox3w1aowxUzbBuLoc5Nrcfz/7xU3CID393VkGtKp55h4Ci
         TylpZjOPmszZXcJFLkaqmr1631lRlTwBFKLgWUYAJggNZMH/EnC5qWteKHt9wPa6jjHG
         JHem55b1ypYQFKdKfsHHic4595XgkBpLYMsj0aoBCuHa/+n4Ry7rFtea6D/FhdB1BoG7
         4t8L7MmK4mAp10rDqZDGlzOaWan+FPFd5hh7znttCJZk0P3FVtptYVIS3m/18sBNk2Q+
         uaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qd8d9av0X2U/poq85wxG6Xx4DFGNRfZuTQF5237CE6I=;
        b=AQ66Kq33s+Qd/R3mDsO2k2Q3xbut+TOpii7gqUDu37j3x1J6kXY3sbFZ78Qhwt64fR
         cxSzasNm4ud7RTGWz4HMZ6IFgGF8k5d7BGOAoocNtQbH165w4EFaAHBaP9PEEVSYhXXd
         ev9HuldOIfWreNWExd27zE53dv2CiTV84e2OIA2ygsi6CbpDP9f+VN6lmrde3p2clUe4
         d2WEmoMIW0jPQZ/aJq2u1Md0FnSHC+CxC3sP0Yg9hQ/FZBmB4z9l9jGVg/grNtBBKTre
         5ZxMPipUOzJ6aGlPz+oc+mC91iVSk0dyeamqqIuhRxuO6MmQ6hDZDbLdkh47dEBIlg5i
         S3iQ==
X-Gm-Message-State: AJcUukdEqxgY86ta72jxGgddSBg7BNALTFuHaOwqnJ6xsj6X7xAMCrM/
        PI6X1BFg0VcvCtU/aT64kZw0tk3F
X-Google-Smtp-Source: ALg8bN4tm+rwR2jor3ow9WQRX08ARyPvwYz2lyo2V+wzNY+yuohx36rjQFivWHtViwsRxT95XOZq2w==
X-Received: by 2002:a63:5c22:: with SMTP id q34mr11512297pgb.417.1546879409162;
        Mon, 07 Jan 2019 08:43:29 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id c72sm118865326pfb.107.2019.01.07.08.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 08:43:28 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org,
        Steven Han <nazgul33@gmail.com>
Subject: [PATCH V2 1/2] Input: rotary_encoder - Support key events
Date:   Tue,  8 Jan 2019 01:42:48 +0900
Message-Id: <20190107164249.2342-2-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107164249.2342-1-nazgul33@gmail.com>
References: <20190107164249.2342-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Han <nazgul33@gmail.com>

Support generating EV_KEY pair, instead of EV_REL.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <daniel@caiaq.de>
To: linux-input@vger.kernel.org
---
V2: added missing input_sync()
---
 drivers/input/misc/rotary_encoder.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 72eee6d55527..0014a7d9f8f9 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -41,6 +41,8 @@ struct rotary_encoder {
 	u32 steps;
 	u32 axis;
 	bool relative_axis;
+	bool relative_keys;
+	u32 keycodes[2];
 	bool rollover;
 	enum rotary_encoder_encoding encoding;
 
@@ -79,6 +81,11 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
 				 encoder->axis, encoder->dir);
+	} else if (encoder->relative_keys) {
+		u32 keycode = encoder->keycodes[encoder->dir > 0];
+		input_event(encoder->input, EV_KEY, keycode, 1);
+		input_sync(encoder->input);
+		input_event(encoder->input, EV_KEY, keycode, 0);
 	} else {
 		unsigned int pos = encoder->pos;
 
@@ -237,6 +244,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "linux,axis", &encoder->axis);
 	encoder->relative_axis =
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
+	encoder->relative_keys =
+		device_property_read_bool(dev, "rotary-encoder,relative-keys");
+	if (encoder->relative_keys) {
+		err = device_property_read_u32_array(dev,
+					"rotary-encoder,relative-keycodes",
+					encoder->keycodes, 2);
+		if (err)
+			dev_err(dev, "unable to get keycodes: %d\n", err);
+		return err;
+	}
 
 	encoder->gpios = devm_gpiod_get_array(dev, NULL, GPIOD_IN);
 	if (IS_ERR(encoder->gpios)) {
@@ -260,9 +277,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
 
-	if (encoder->relative_axis)
+	if (encoder->relative_axis) {
 		input_set_capability(input, EV_REL, encoder->axis);
-	else
+	} else if (encoder->relative_keys) {
+		input_set_capability(input, EV_KEY, encoder->keycodes[0]);
+		input_set_capability(input, EV_KEY, encoder->keycodes[1]);
+	} else
 		input_set_abs_params(input,
 				     encoder->axis, 0, encoder->steps, 0, 1);
 
-- 
2.17.1

