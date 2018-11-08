Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CC3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3093020857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l5Dfe0bt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3093020857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbeKHMXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:23:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33083 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbeKHMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:23:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id w22-v6so5485011plk.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 18:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unJ3MBaEXWa3jyTE0fBY8lUVuDlHuOqyytI3tDcgPeY=;
        b=l5Dfe0btmMG1XBFBSqelfUtcpVOpAeUx23pB/6YsHJnHRMaqBB2bVgIOz3GIdE6Pxb
         4315gpeAwbxm0n0PzLu4cB2DDWF5uRsFLXzq8LWUU0O+zszSYRzhNnvNt7upwHWADVsw
         LUJV0Tr7GuVvwEvKhUrLNanSV2u0tx5gB4fpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unJ3MBaEXWa3jyTE0fBY8lUVuDlHuOqyytI3tDcgPeY=;
        b=WnhTpp9GSw5RQeSc2UUACnybwxSH/T4snxZe+UOHXOnXIq/nUwkU+fRppZZPiSmlyL
         gvIjQwdil74kpe3jWzMRR8hQCAuBzBJiIMz8VrC2dx+3TAfR9at55hmDDuQ5YNMZevx9
         +vvEHa1h2OLatUVOJIbsrQg0ZkAj8vM4/JYVaonWlurJC+y1Ihpz0ujeHGBOylYVqd1y
         I6ekQZc99LK6O37X0+KPqg/kt+OTtbdRLEr4Gcg3xh8jluHRfEeOG8faX1G//mLA6BHS
         6iMGlftT4FLRzQx/Upq4cTGG1Rzbx42pTfc+Qps1u5RxISDUSj4CgXZpQODLjxAVryvR
         0V9w==
X-Gm-Message-State: AGRZ1gKEBIiAdnG78/a1AVuiQz+E8InS9Gndt4OG/LeBiYFhxw2qhY2b
        ZK9e7thAHGGVQpBM7Uku/V0C6g==
X-Google-Smtp-Source: AJdET5dGKZzZLQyAJWPnSR0abql/kSQ7YqTwk/M1NitDR5wvazxiP9ZqV7h1c/m3RknALQ5sVc3erQ==
X-Received: by 2002:a17:902:2468:: with SMTP id m37-v6mr2863125plg.154.1541645387143;
        Wed, 07 Nov 2018 18:49:47 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id x14-v6sm2271519pfe.178.2018.11.07.18.49.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 18:49:46 -0800 (PST)
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
Subject: [PATCH v2 2/2] platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Date:   Wed,  7 Nov 2018 18:49:39 -0800
Message-Id: <20181108024939.174321-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181108024939.174321-1-briannorris@chromium.org>
References: <20181108024939.174321-1-briannorris@chromium.org>
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
v1 -> v2:
 * no change
---
 drivers/platform/chrome/cros_ec_proto.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index fff67b389c87..cc7baf0ecb3c 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -575,6 +575,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 {
+	u8 event_type;
 	u32 host_event;
 	int ret;
 
@@ -594,11 +595,22 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
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

