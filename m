Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA06C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CFE02086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 22:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="jf8C6CoI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CFE02086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeKHIJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:09:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42122 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbeKHIJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:09:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id u10-v6so2583533pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhXyLGLoOKp5Huh29/RTwRXsqfSZBbXr8NHx5WWp9EM=;
        b=jf8C6CoINECukURlsc6L1XmwH5jIF0Kadhse5fZODz8bW2q4cYj9xU0iq7PdACbYzC
         3kMKJX3w58Vtyr6tuug/qNOfrl/CHxWe8NdLhXbyrCHMXMOftw0B7qepXPB0P8ft8QRv
         9q3InTYK+y5yR51NOv8Rx2ghsxKMAptXgsaqydNK/eowOi1bMbbcdNFOg28y/1JjEGM9
         JWkDZqTejlYg0igYsrgyyeFktvd5pc30Smhz6f+4Se8NnA2I01UDAjkIa926W5apbHW9
         F8uiAUN0zNGOpnNy0hy3WbnsvLo/3p6sbuaazd7EWHCZF5wi+aAHxLUi1Xa+ffWpLm5e
         5IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uhXyLGLoOKp5Huh29/RTwRXsqfSZBbXr8NHx5WWp9EM=;
        b=rfONCHeYbedRSPQtjNBTw8ygtyCcYhXhdSpZRSYJ9T8pbZZWdNdY7h9EwgxRAIHFjt
         6fC5cG4fFk6ZKTplRi7wYKQl81lopKuQYB1XCBzzthzSbXKo04RCd16prJRpLZzvbylp
         9YoYYfbF93wQmrl5c6vHrLlsxjvb5WQvr0zvC9c560Z34vgUB9HUoSR9NvBEFa22h4kf
         zOsICCJzyUL3Zvvid8YRozi3Tjvm0DNHVXtlXrIhq4Oib6DZ7zqdK1SX95uqroD+f6sP
         ZZyU9+9VNeNuHHc/fnw0pafJXkbpVWJU9bM21QaXV6Ui4L8UvW48sQGBAlb/YbDZStEj
         +YsQ==
X-Gm-Message-State: AGRZ1gL9wQ0yws7VJRQp42ndRlABopCy7ZqC1CP3HbbbsyzmJjR9E2+Y
        0vVvLEMBTaoyxD80fohcV+gTRA==
X-Google-Smtp-Source: AJdET5cq00ccHXQiPigDw1DUOfsdEVr9cXisKwLFyXwIbd2FkQbAr/QDkGEhcMZvo9Ps03LcMrjQLQ==
X-Received: by 2002:a62:1196:: with SMTP id 22-v6mr2128846pfr.178.1541630191034;
        Wed, 07 Nov 2018 14:36:31 -0800 (PST)
Received: from wvw-pc1.mtv.corp.google.com ([2620:0:1000:1601:b03:46c1:8e31:9255])
        by smtp.gmail.com with ESMTPSA id s141-v6sm3727778pfc.63.2018.11.07.14.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:36:29 -0800 (PST)
From:   Wei Wang <wvw@google.com>
X-Google-Original-From: Wei Wang < wvw@google.com >
Cc:     wei.vince.wang@gmail.com, Wei Wang <wvw@google.com>,
        Kame Wang <kamewang@google.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Thermal: do not clear passive state during system sleep
Date:   Wed,  7 Nov 2018 14:36:11 -0800
Message-Id: <20181107223611.61092-1-wvw@google.com>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wvw@google.com>

commit ff140fea847e ("Thermal: handle thermal zone device properly
during system sleep") added PM hook to call thermal zone reset during
sleep. However reseting thermal zone will also clear the passive state
and thus cancel the polling queue which leads the passive cooling device
state not being cleared properly after sleep.

thermal_pm_notify => thermal_zone_device_reset set passive to 0
thermal_zone_trip_update will skip update passive as `old_target ==
instance->target'.
monitor_thermal_zone => thermal_zone_device_set_polling will cancel
tz->poll_queue, so the cooling device state will not be changed
afterwards.

Reported-by: Kame Wang <kamewang@google.com>
Signed-off-by: Wei Wang <wvw@google.com>
---
 drivers/thermal/thermal_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6ab982309e6a..29b26b0959e8 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -451,16 +451,20 @@ static void update_temperature(struct thermal_zone_device *tz)
 			tz->last_temperature, tz->temperature);
 }
 
-static void thermal_zone_device_reset(struct thermal_zone_device *tz)
+static void thermal_zone_device_init(struct thermal_zone_device *tz)
 {
 	struct thermal_instance *pos;
-
 	tz->temperature = THERMAL_TEMP_INVALID;
-	tz->passive = 0;
 	list_for_each_entry(pos, &tz->thermal_instances, tz_node)
 		pos->initialized = false;
 }
 
+static void thermal_zone_device_reset(struct thermal_zone_device *tz)
+{
+	tz->passive = 0;
+	thermal_zone_device_init(tz);
+}
+
 void thermal_zone_device_update(struct thermal_zone_device *tz,
 				enum thermal_notify_event event)
 {
@@ -1501,7 +1505,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			thermal_zone_device_reset(tz);
+			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
-- 
2.19.1.930.g4563a0d9d0-goog

