Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564E2C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C192171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694138;
	bh=8x07KEVdRFuH6/HSkA1AcgTqbZxpUN0O6s+0V4HljYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eQOMiEOzzuZy8gQpn4fJdu+JzGyNdoGG/ewfTi3hsVrRqGQGW75YVOYQ2t/Qi6Xgo
	 moyzTXfUR/XSkNBCk9BbVo/Y5pq96scQih2WNHwyqAHEBvCJ5q9hfVbKq1wLJG8mC6
	 RBZJ3NSDhoz9v/r7iIX5uLhS5YACsmLY1lSOM5U8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389256AbfA1Qs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:48:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388513AbfA1QVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5852147A;
        Mon, 28 Jan 2019 16:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692469;
        bh=8x07KEVdRFuH6/HSkA1AcgTqbZxpUN0O6s+0V4HljYs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TiLNcDP0ISzFpwzp8pCRKGe8kPzHSxh2NiCyWEbE9OR1tNCt8WQQEhVibbMnwJy5
         fIUq2qvyHszA2vIJ8YfzsDBXqDgZtev4CCbIL8m9fCs1UohDTI87kgCpND5Kh8Nxf5
         b1XQqebXtcYGQTtFu05Ln/HbklJCKuq8dNfDcPn4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wei Wang <wvw@google.com>, Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 032/107] Thermal: do not clear passive state during system sleep
Date:   Mon, 28 Jan 2019 11:18:32 -0500
Message-Id: <20190128161947.57405-32-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Wang <wvw@google.com>

[ Upstream commit 964f4843a455d2ffb199512b08be8d5f077c4cac ]

commit ff140fea847e ("Thermal: handle thermal zone device properly
during system sleep") added PM hook to call thermal zone reset during
sleep. However resetting thermal zone will also clear the passive state
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
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/thermal_core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 226b0b4aced6..cd82ae34ddfa 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -597,16 +597,20 @@ static void update_temperature(struct thermal_zone_device *tz)
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
@@ -2297,7 +2301,7 @@ static int thermal_pm_notify(struct notifier_block *nb,
 	case PM_POST_SUSPEND:
 		atomic_set(&in_suspend, 0);
 		list_for_each_entry(tz, &thermal_tz_list, node) {
-			thermal_zone_device_reset(tz);
+			thermal_zone_device_init(tz);
 			thermal_zone_device_update(tz,
 						   THERMAL_EVENT_UNSPECIFIED);
 		}
-- 
2.19.1

