Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D531C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCC1222F2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 20:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzMj31Pk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfAEU1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 15:27:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38559 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfAEU1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 15:27:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so18944887pgc.5;
        Sat, 05 Jan 2019 12:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8IRzqMHeMjla7T1fmt9Jv4hRUW0RpFhYmchTS3E2r8=;
        b=qzMj31Pk72P6QGLudmsB0CFaifm+e2yD0E0P4+kATwN1lYxEigrBvGGF1c0UQLRsNr
         3/5LYULJFgLmB2WnH065mEL6TrXuQE9lWdXqASXXYC5lihA805uxbIT2PKzbHHla6+C5
         9k6TXamiyGtK0cRPZrbSNbqcyAlWLyGeDlMTcFOn8dobEZAVFNf1JeiLra7rNH/FfRcW
         Mu2xTInfohs8VaBj5f25Z4pF4mmE+4nLyml6v2MvlFp0q7mlPnaJJsA0S386dpkKgS6C
         zFDZBxyzJJBLZvL3lRcgyWoRXWlqh8rgo35JmlG30VPX8EKZEot81AgmkyJ2T6wgLjre
         1lUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8IRzqMHeMjla7T1fmt9Jv4hRUW0RpFhYmchTS3E2r8=;
        b=FbPpGaHWhIRCd6euSMV0IqcC/qm+/Ag3PdPx764nRNpYGmwgn3skLydTyenW0ETW9Y
         k0jldpZOP4ToeiSpZUJ/hdfgBhplbAjlMEjMWP14w/gwS9bw86aRHXnX4EQOez6UQC/1
         8/4HncXU3+aDDodlzxBzP4YDDmKN39mIVd7jIl3qU2hWGXqVuE+dKSPI35G0pGLWULcf
         ywdNII2nYb6aIDZCaeUwlQDYBjeGJYDnBDMr1j1chfkzXv4OeKqDP2xkaGZBc9np294F
         k5nWrq/78qEL5bKNZRqLPPGHWohKeBtwWdm5qBZl3kyFZzPuACbpcQDlFCIWQvzfXXh/
         8f4A==
X-Gm-Message-State: AJcUukcV2AIta+5A+I2br4cL4bnfJU5a6AXz0uQgAVItz5XQyq1McVnr
        7LL9YDt9E5dP7TwSlobxS+hPi7yK
X-Google-Smtp-Source: ALg8bN5j7eRIA2rYtkw2gkjuVXu/gR0FU4dJMwRchc/X5ZokSBrZNhqCy5xmzVsbpeKeksvg3uXlgg==
X-Received: by 2002:a63:1258:: with SMTP id 24mr5782511pgs.114.1546720027493;
        Sat, 05 Jan 2019 12:27:07 -0800 (PST)
Received: from localhost.localdomain ([121.161.238.230])
        by smtp.gmail.com with ESMTPSA id d129sm94559165pfc.31.2019.01.05.12.27.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 12:27:07 -0800 (PST)
From:   Donghoon Han <nazgul33@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org,
        Steven Han <nazgul33@gmail.com>
Subject: [PATCH 1/2] Input: rotary_encoder - Support key events
Date:   Sun,  6 Jan 2019 05:26:58 +0900
Message-Id: <20190105202659.20198-2-nazgul33@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105202659.20198-1-nazgul33@gmail.com>
References: <20190105202659.20198-1-nazgul33@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Han <nazgul33@gmail.com>

Support generating EV_KEY pair, instead of EV_REL.

Signed-off-by: Donghoon Han <nazgul33@gmail.com>
---
 drivers/input/misc/rotary_encoder.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 72eee6d55527..180e35884289 100644
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
 
@@ -79,6 +81,10 @@ static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
 				 encoder->axis, encoder->dir);
+	} else if (encoder->relative_keys) {
+		u32 keycode = encoder->keycodes[encoder->dir > 0];
+		input_event(encoder->input, EV_KEY, keycode, 1);
+		input_event(encoder->input, EV_KEY, keycode, 0);
 	} else {
 		unsigned int pos = encoder->pos;
 
@@ -237,6 +243,16 @@ static int rotary_encoder_probe(struct platform_device *pdev)
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
@@ -260,9 +276,12 @@ static int rotary_encoder_probe(struct platform_device *pdev)
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

