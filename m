Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17F4C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8212B21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695219;
	bh=E4haNz1KFU9KMcZa4cI/X5nbWOOAhLfiC4jNjAaRw1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W2azCw67NV35aiJrub5xixC9VlKh4/2VFggs6fcXhc9vYAyZKqZ20YRWJLp9PGvFk
	 tpMVue9aw8u+A2lXnPFn6L79r6TeLAYp9YcShAQDEtcn7jhTQSZWxDAOoiTiSDvlS4
	 VUhlxu1USqiDGpuErBCKFvJ5pjdHhtAfMYddhBHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387601AbfA1RG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:06:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732209AbfA1QNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59A602147A;
        Mon, 28 Jan 2019 16:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691983;
        bh=E4haNz1KFU9KMcZa4cI/X5nbWOOAhLfiC4jNjAaRw1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0+BwGE/kisfJxrzlpSV2eAWZcfMLmbJdT549swvYBs80HOETiji1GJ4rRXUd/ju5
         mV7WPdUWHqCzVP5cK0ykpF7hYTyI4wYMVD9c5W0OB4oZrrIo7a09uRtnJZcK2CusG9
         tFRoVYvPM3gl1WtbaY8k6RtiESKminIuIShByIuA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 027/170] platform/chrome: don't report EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Date:   Mon, 28 Jan 2019 11:09:37 -0500
Message-Id: <20190128161200.55107-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
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
index e7bbdf947bbc..2ac4a7178470 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -551,6 +551,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
 
 int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
 {
+	u8 event_type;
 	u32 host_event;
 	int ret;
 
@@ -570,11 +571,22 @@ int cros_ec_get_next_event(struct cros_ec_device *ec_dev, bool *wake_event)
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

