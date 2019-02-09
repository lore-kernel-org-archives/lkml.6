Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FD4C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19FF21934
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 17:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOqJ0neR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfBIRT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 12:19:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36638 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfBIRT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 12:19:28 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so3193061plo.3;
        Sat, 09 Feb 2019 09:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hAOwpNEAeiEKjcjszxzZGOzOHXkIIcQmK9gcwo5oYdw=;
        b=sOqJ0neRvDesm3I6+Saq1KBrbkBZ8hlkGeUnOuSZ7snIqZVgMJr+YV+8tdEKxrSVUz
         i81FoForconY4KeJ5RG0JVMSyyqhTqRQlIyrkQInDxlZ0BJUktAz5CGfpSxSmjOyLdjU
         X5NJEJB6HNhxiZIHyPwMdAIwq3+SBW9uXQtthAyK+LRODr9U3RP6oDykOx2F4lrBPATf
         py74P8+uwGHl7oHhBp63WR//9w3eHWP0JvSuepMdCRDjidBNp7D5MEgN6fkVsh23wo80
         ggfo8YyhXOR1/jC9PEDtJB48E2bS9dlf2eee23rm+uMwFP7Rp/R4Zklq3lFRrVUgvJE6
         Fx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hAOwpNEAeiEKjcjszxzZGOzOHXkIIcQmK9gcwo5oYdw=;
        b=OFFw40rqWUvlSFp50ouXx1GNFzmd6EWYJIYO5DuFO8viEhGIpoxJ1Is1tf8LOXf4Tj
         c9QMWlUaSbW/oAeXGoxDB5LpKrXyI1ExEWV2Se08iEOtxPN+R6o97m6+iOi21ss31Bam
         8wbll1QiXIOX8OsxSefbFORsqoRq9qnW7w0sZt+oNnnWEf/nonUMQ58cC0NpcA8c9C23
         gnOumda2ptUUyXLZLUGIq3tWcQw8LkkBUVi6cO2Rh17AqCyk/+MlcU1sEl3wmQZQttGV
         B/MmPOlNHODGw0mbbM655nZizxJ1feNyvmizHuG5SH6Rtw2G+5GCjd6hsh9xoQrwajZ8
         OVfA==
X-Gm-Message-State: AHQUAuYIgg/Vs9D3dIs5Fse0Y9+63RsVNXcAf2/C+k3bdEFtzs0LPE7m
        pm0oaPMwJ3hB4IhVTux4JPF/VzUU
X-Google-Smtp-Source: AHgI3IZhISqLh1JDI6jNDvSG3P61sLNkQjkqI5gco/89knORQVW5xQT/2T4T712ZInsSk7WLEIpedw==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr29999592pll.305.1549732767472;
        Sat, 09 Feb 2019 09:19:27 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p81sm7258649pfa.107.2019.02.09.09.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 09:19:26 -0800 (PST)
Date:   Sat, 9 Feb 2019 09:19:25 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     iSven Van Asbroeck <thesven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: apanel - switch to using brightness_set_blocking()
Message-ID: <20190209171925.GA24193@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that LEDs core allows "blocking" flavor of "set brightness" method we
can use it and get rid of private work item. As a bonus, we are no longer
forgetting to cancel it when we unbind the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/apanel.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/apanel.c b/drivers/input/misc/apanel.c
index 094bddf56755..2e138fef1274 100644
--- a/drivers/input/misc/apanel.c
+++ b/drivers/input/misc/apanel.c
@@ -22,7 +22,6 @@
 #include <linux/io.h>
 #include <linux/input-polldev.h>
 #include <linux/i2c.h>
-#include <linux/workqueue.h>
 #include <linux/leds.h>
 
 #define APANEL_NAME	"Fujitsu Application Panel"
@@ -60,7 +59,6 @@ struct apanel {
 	unsigned short keymap[MAX_PANEL_KEYS];
 	u16    nkeys;
 	u16    led_bits;
-	struct work_struct led_work;
 	struct led_classdev mail_led;
 };
 
@@ -109,15 +107,7 @@ static void apanel_poll(struct input_polled_dev *ipdev)
 			report_key(idev, ap->keymap[i]);
 }
 
-/* Track state changes of LED */
-static void led_update(struct work_struct *work)
-{
-	struct apanel *ap = container_of(work, struct apanel, led_work);
-
-	i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
-}
-
-static void mail_led_set(struct led_classdev *led,
+static int mail_led_set(struct led_classdev *led,
 			 enum led_brightness value)
 {
 	struct apanel *ap = container_of(led, struct apanel, mail_led);
@@ -127,7 +117,7 @@ static void mail_led_set(struct led_classdev *led,
 	else
 		ap->led_bits &= ~0x8000;
 
-	schedule_work(&ap->led_work);
+	return i2c_smbus_write_word_data(ap->client, 0x10, ap->led_bits);
 }
 
 static int apanel_remove(struct i2c_client *client)
@@ -179,7 +169,7 @@ static struct apanel apanel = {
 	},
 	.mail_led = {
 		.name = "mail:blue",
-		.brightness_set = mail_led_set,
+		.brightness_set_blocking = mail_led_set,
 	},
 };
 
@@ -235,7 +225,6 @@ static int apanel_probe(struct i2c_client *client,
 	if (err)
 		goto out3;
 
-	INIT_WORK(&ap->led_work, led_update);
 	if (device_chip[APANEL_DEV_LED] != CHIP_NONE) {
 		err = led_classdev_register(&client->dev, &ap->mail_led);
 		if (err)
-- 
2.20.1.791.gb4d0f1c61a-goog


-- 
Dmitry
