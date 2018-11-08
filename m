Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19695C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45412086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 01:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Sk+o5pG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45412086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbeKHLDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:03:33 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45891 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbeKHLDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 06:03:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id o19-v6so8698675pll.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 17:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZM37ydsAhx9pb+GHNLecqfSXNwveIWhX5+XzvfOUiE=;
        b=Sk+o5pG4etRdpHiTtcrVfO+bMRQ4jdAODTCyAGpW8xzWFOvoEHvLhvF0DxWv9JNJ7A
         3Idag2NEhY1Id3kO5ostkMtcPIBdWzcyONI73uNHFvHx0AHLXPJSLlH7MEAyYX6hpHYh
         rDU1dhI5W48xlsijr6HsFrfEv0CX9uZz0ppKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZM37ydsAhx9pb+GHNLecqfSXNwveIWhX5+XzvfOUiE=;
        b=rfVJRRMlADfMbDrzfd6ieNMYccq2wBpqF6PzmFRSI7RjJ03ER011P0eVRv7+rBwa/F
         g2L1E8uHHmYJEhGlkI2i2FE96m88vY4xQn0ARoZ/Z8064gM5mUlDi5hdXN6LbQ4otsw4
         6nDGUzuJquYHyGda86VYg5D8stlNlLzbXiu32marMydV0UbJWqsEJgtf3/sUMRQpOQft
         naB2LfX0xqTbzwM9OOJTCzNnS6tIptJweSr0cIeHwapRuOHJr6LPgMRaiHsxgJuBE74i
         2psFyiuMooFgwyXRH8mnMjghEP/QMBOa9iBn20gUsx32meOKoS8C3gHh3Ba2mYOeBRJX
         NMOw==
X-Gm-Message-State: AGRZ1gL2yhM6kHdjLRzeGS40aw724gpBfJRbGeAvdi/Akr4BBR9AT5aw
        PC5CllnIkbg8l/6cX4zVSBsu8A==
X-Google-Smtp-Source: AJdET5cCQqxAEK19G+Ln7prH2lvUrUKFkcS3iffMQ3KclO4nDqV5OumJPa/6OQBvpERGvuyd7qIy8A==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8-v6mr2514280plk.19.1541640633019;
        Wed, 07 Nov 2018 17:30:33 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id l72-v6sm2323193pfi.149.2018.11.07.17.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:30:32 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Benson Leung <bleung@chromium.org>
Cc:     Lee Jones <lee.jones@linaro.org>, <linux-kernel@vger.kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Nematbakhsh <shawnn@chromium.org>,
        Alexandru Stan <amstan@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        RaviChandra Sadineni <ravisadineni@chromium.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/2] platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Date:   Wed,  7 Nov 2018 17:30:05 -0800
Message-Id: <20181108013005.37362-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108013005.37362-1-briannorris@chromium.org>
References: <20181108013005.37362-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EC_MKBP_EVENT_SENSOR_FIFO events can be triggered for a variety of
reasons, and there are very few cases in which they should be treated as
wakeup interrupts (particularly, when a certain
MOTIONSENSE_MODULE_FLAG_* is set, but this is not even supported in the
mainline cros_ec_sensor driver yet). Most of the time, they are benign
sensor readings. In any case, the top-level cros_ec device doesn't know
enough to determine that they should wake the system, and so it should
not report the event. This would be the job of the cros_ec_sensors
driver to parse.

This patch adds checks to cros_ec_get_next_event() such that it doesn't
signal 'wakeup' for events of type EC_MKBP_EVENT_SENSOR_FIFO.

This patch is particularly relevant on devices like Scarlet (Rockchip
RK3399 tablet, known as Acer Chromebook Tab 10), where the EC firmware
reports sensor events much more frequently. This was causing
/sys/power/wakeup_count to increase very frequently, often needlessly
interrupting our ability to suspend the system.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 49625836fdd6..d2a372453628 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -582,6 +582,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 {
+	u8 event_type;
 	u32 host_event;
 	int ret;
 
@@ -601,11 +602,22 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 		return ret;
 
 	if (wake_event) {
+		event_type = ec_dev->event_data.event_type;
 		host_event = cros_ec_get_host_event(ec_dev);
 
-		/* Consider non-host_event as wake event */
-		*wake_event = !host_event ||
-			      !!(host_event & ec_dev->host_event_wake_mask);
+		/*
+		 * Sensor events need to be parsed by the sensor sub-device.
+		 * Defer them, and don't report the wakeup here.
+		 */
+		if (event_type == EC_MKBP_EVENT_SENSOR_FIFO)
+			*wake_event = false;
+		/* Masked host-events should not count as wake events. */
+		else if (host_event &&
+			 !(host_event & ec_dev->host_event_wake_mask))
+			*wake_event = false;
+		/* Consider all other events as wake events. */
+		else
+			*wake_event = true;
 	}
 
 	return ret;
-- 
2.19.1.930.g4563a0d9d0-goog

