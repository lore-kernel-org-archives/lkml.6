Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC7EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3BA208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 23:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SNGryQaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3BA208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeHXCmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 22:42:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41634 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727409AbeHXCmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 22:42:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id s15-v6so3370405pgv.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 16:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUOKN+UyMz6MyOH+hKTvmBUtxDhaBxGiCHvAaiY8n/U=;
        b=SNGryQaK8uW8+D2PMxJV3eWo+BN0u6nSQDzhwQArqVrGLcV5p537duWddWPt3/0/2L
         7ExM7BcqdSj0SKkjkl55ClkWJor90k0PE3h7xRK7xWeEUABx/nP8UUDZ8uLEsPn0BY54
         MiJcaopWIwy3NoKQqXteBC7pvJ79HUEzRmBw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZUOKN+UyMz6MyOH+hKTvmBUtxDhaBxGiCHvAaiY8n/U=;
        b=E/jANAz6njlSBpRxVAY+DK0U9NSi/qA6uNAl6etwgxwRvNrClWFMgAIByfzpaHs5Hk
         ysGkmGCHsE6ijzbo5j09b8zL0qXAnkGUmY38cnlnYF1j7IxnAYKPhE47+ZtBJNr9aMW1
         mDElGABlXBwh7kJCYS2HFMf87gkCMncegBwEBhQH1fmknY5EIdNXpn5i0NaVij6vSfWm
         fDHMsN0kC+lO0arrM/fhHrWxROa1ncAOoJcc4DHFa0rRh+JM1LeABO4U/3BdW/OT2iBZ
         xu0pMCfUEYWa6QdHKmd3ceMog9E5pPC+qwUvGOO9EBn0e24NH9XfsPkUxejPDe8BKoF+
         EXMQ==
X-Gm-Message-State: AOUpUlGtp6ZT9UHRXg2JnnwwZ2TKS+ONvqhT4i7ybeEsNf1vZSm0MzzW
        Q5dFXXHiPSpIcIJ2BbsAIW3AUAMOKV4=
X-Google-Smtp-Source: AA+uWPxaib/abS9fqzOm7ntJe7b8glX0dH+dB/ttZ6cIqjGOhtBZJee0DDIzJvUyGxjoxNAa7Am3vQ==
X-Received: by 2002:a63:6988:: with SMTP id e130-v6mr18427574pgc.249.1535065820122;
        Thu, 23 Aug 2018 16:10:20 -0700 (PDT)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5e2b:39df:72ed:4968])
        by smtp.gmail.com with ESMTPSA id h3-v6sm6312469pgn.26.2018.08.23.16.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Aug 2018 16:10:19 -0700 (PDT)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-input@vger.kernel.org, joe@perches.com, andi@etezian.org,
        gregkh@linuxfoundation.org, dmitry.torokhov@gmail.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH] Input: elants_i2c - Fix sw reset delays
Date:   Thu, 23 Aug 2018 16:10:13 -0700
Message-Id: <20180823231013.254037-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only need to wait 10ms instead of 30ms before starting fastboot or
sending IAP on the touchscreen. Also, instead of delaying everytime
sw_reset is called, this delays 10ms in the function that starts
fastboot. There's also an explicit 20ms delay before sending IAP when
updating the firmware, so no additional delay is needed there. This
change also has the benefit of not delaying when wakeup is enabled
during suspend. This is because sw_reset is called, yet fastboot
isn't.

Change-Id: I9e3019720186ba0023891fafeb4fe3d2510e454b
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/input/touchscreen/elants_i2c.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index d21ca39b0fdb..18ce04ba0173 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -284,12 +284,6 @@ static int elants_i2c_sw_reset(struct i2c_client *client)
 		return error;
 	}
 
-	/*
-	 * We should wait at least 10 msec (but no more than 40) before
-	 * sending fastboot or IAP command to the device.
-	 */
-	msleep(30);
-
 	return 0;
 }
 
@@ -500,6 +494,12 @@ static int elants_i2c_fastboot(struct i2c_client *client)
 	const u8 boot_cmd[] = { 0x4D, 0x61, 0x69, 0x6E };
 	int error;
 
+	/*
+	 * We should wait at least 10 msec (but no more than 40) before sending
+	 * fastboot command to the device.
+	 */
+	usleep_range(10 * 1000, 11 * 1000);
+
 	error = elants_i2c_send(client, boot_cmd, sizeof(boot_cmd));
 	if (error) {
 		dev_err(&client->dev, "boot failed: %d\n", error);
@@ -643,6 +643,10 @@ static int elants_i2c_do_update_firmware(struct i2c_client *client,
 			dev_err(&client->dev, "Failed close idle: %d\n", error);
 		msleep(60);
 		elants_i2c_sw_reset(client);
+		/*
+		 * We should wait at least 10 msec (but no more than 40) before
+		 * sending IAP command to the device.
+		 */
 		msleep(20);
 		error = elants_i2c_send(client, enter_iap, sizeof(enter_iap));
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

