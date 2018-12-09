Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E88DC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F74720645
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 18:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RosKmYVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F74720645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbeLIStz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 13:49:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55545 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbeLIStx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 13:49:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so8760749wmc.5;
        Sun, 09 Dec 2018 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V4nHkRJwv9CwQNMV+4crpYzlkpCHmtclq15uioLDagg=;
        b=RosKmYVL8tYINCTUhJLY/hcwNHY6nZXSKq5laQX/MGWkIN31K/eJsN6Rvq6dk2RIPE
         6wGZdJmvtw1xNKHe1/nGAc6VhXGE3TYfj/aAI1oFdvSoXLzBHDFznhC+TuSOxdm3UMA/
         at1w/iq12S8hfldlSLPPKrtLhTZGV22X2U48HE1qVV/M533td9qFtTF11x73BYs+Ix86
         HlbMSd1IEn98ltgfh/arDE5yo5RRLR2uhOapo+hl90xPyUDPTzAE3VSVE4yinMLtoAkc
         Y4KQshAfSd6acZX1+4jkqg1Pbrp6HtKFxlCCTy0ZfaEvWvNvvTG72KjjzHyAw656D42O
         MmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V4nHkRJwv9CwQNMV+4crpYzlkpCHmtclq15uioLDagg=;
        b=ffjPfovNqKgmjJAjixw9gU1tzzRU39dqqxGlAlmM6wR22IvdprnhlTRx0bs1emOnNY
         Qr11i9URIGhGrUzRiHHct7C3FRijDh00iOT35kMBZcZOd1TuNIdsN9bhtnWn3wxh9yhC
         I6CHfxpxLZAra+lnTn9xzAjWuFlWo0v/RGZo5x6xGgG5kcZmzCRVG7ESXTaFkH8+Io6L
         yHAQtiV8PVs8N3QTYA4gX7iGLMUQMWPuVmLrW9xdAcLvmkYjy1kziVEE0aBSWormQbGG
         RTtQsWWyMrFGlKs63JIqWxsLFZIhCTSuO6FKvAgX+XUOGJr8Omg/vgiTpcMX9dqO1CKM
         X/1A==
X-Gm-Message-State: AA+aEWa40/mcHRIV4fC2TSHeJeEweQ0MQ4SdEwd5vsHpxYIW1wH/dICT
        7xkx5QTeMfistuPaJTlklKp5G3hn
X-Google-Smtp-Source: AFSGD/UX/G3qy1ahpLD1Gj/XscsN6Y/clxNxPrQdQjmJMwO4WFlJ1Wn7BzQKkkiO4NbztwoJFjzA4w==
X-Received: by 2002:a1c:5d4f:: with SMTP id r76-v6mr8319173wmb.25.1544381391270;
        Sun, 09 Dec 2018 10:49:51 -0800 (PST)
Received: from myhost.home (cit97.neoplus.adsl.tpnet.pl. [83.31.43.97])
        by smtp.gmail.com with ESMTPSA id e19sm20009021wrc.25.2018.12.09.10.49.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 10:49:50 -0800 (PST)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jacek.anaszewski@gmail.com,
        krzk@kernel.org
Subject: [PATCH 2/2] led: triggers: Add LED_INIT_DEFAULT_TRIGGER flag
Date:   Sun,  9 Dec 2018 19:49:42 +0100
Message-Id: <20181209184942.22391-2-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
References: <20181209184942.22391-1-jacek.anaszewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the flag LED_INIT_DEFAULT_TRIGGER for indicating that trigger
being set is a default trigger for the LED class device, and
thus it should be initialized with settings provided in the fwnode.

Set the flag in the led_trigger_set_default(). It is expected to be
cleared in the activate() op of a trigger after trigger fwnode
initialization data is parsed and applied. This should happen only
once after LED class device registration, to allow leaving triggers
in the idle state on re-apply and let the users apply their own
settings without being interfered with the default ones.

Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
---
 drivers/leds/led-triggers.c | 2 ++
 include/linux/leds.h        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/leds/led-triggers.c b/drivers/leds/led-triggers.c
index 52b12e601ebe..9421222ca7a0 100644
--- a/drivers/leds/led-triggers.c
+++ b/drivers/leds/led-triggers.c
@@ -201,10 +201,12 @@ void led_trigger_set_default(struct led_classdev *led_cdev)
 	down_write(&led_cdev->trigger_lock);
 	list_for_each_entry(trig, &trigger_list, next_trig) {
 		if (!strcmp(led_cdev->default_trigger, trig->name)) {
+			led_cdev->flags |= LED_INIT_DEFAULT_TRIGGER;
 			led_trigger_set(led_cdev, trig);
 			break;
 		}
 	}
+
 	up_write(&led_cdev->trigger_lock);
 	up_read(&triggers_list_lock);
 }
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 7393a316d9fa..6f05a5816371 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -51,6 +51,7 @@ struct led_classdev {
 #define LED_PANIC_INDICATOR	BIT(20)
 #define LED_BRIGHT_HW_CHANGED	BIT(21)
 #define LED_RETAIN_AT_SHUTDOWN	BIT(22)
+#define LED_INIT_DEFAULT_TRIGGER BIT(23)
 
 	/* set_brightness_work / blink_timer flags, atomic, private. */
 	unsigned long		work_flags;
-- 
2.11.0

