Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B399C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690F620856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697761;
	bh=Z7ALoxnJg3T5Ud46HOi/UoMMW9X9EWYkhMLhDPbsEoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wYhyCgmrxHyIkOdm6nXyHbwWrjDBeosViw3Z73xLBjZZOgmdAR4ZU1g7g8jcZQJLY
	 37cpVKM0KJzonDY6XkSB52IDLIsHi8gHqjEb/nZwIJgkvcB4ISEsZs7EbTmANdwhpz
	 DZH7qxjiwN+stZpfzPgOdeapDBWwCB3pssQ90iZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbfA1RtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:49:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbfA1PpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:45:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C3A2147A;
        Mon, 28 Jan 2019 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690316;
        bh=Z7ALoxnJg3T5Ud46HOi/UoMMW9X9EWYkhMLhDPbsEoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTy2CuwACPtd4/kE5xyjW+VODhNervpuR20RpfSqfVUItKOYKA5HVsuBxA2twxM5u
         +/I9usvbOSqzsgfiYqgRndD1g76z2uL9IBpK4qaWJPjRWtBKxvnyQI545sMAFl2fcL
         iSLsGlcOrit4f/N9Fxy08CcHZXDpiwz5313o9qP0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 047/304] platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Date:   Mon, 28 Jan 2019 10:39:24 -0500
Message-Id: <20190128154341.47195-47-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit 6ad16b78a039b45294b1ad5d69c14ac57b2fe706 ]

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
Signed-off-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b6fd4838f60f..e5d5b1adb5a9 100644
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
2.19.1

