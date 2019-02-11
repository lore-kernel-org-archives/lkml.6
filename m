Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD767C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAAC20700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901606;
	bh=npl2pjBTnGauGmA4xkWal9FZ77i1HMF6MHGXrRLH+1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pNaR/DUXbjY08zshJH5wPglCnkFdQ5orPI1VB6eHxbSrfDRc1eVxfVYnSKZleQ4Mo
	 Ax8PWFjt3J0CZTyL2R2ChBxj2E4bhZeSewQ8wvuweq8svDRhlATd6aMjqABfjKB7iw
	 0QRxXBA8SjzAfaJ58jlmKhGNFa3hwKsIH4pBmTY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfBKOWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:22:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbfBKOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:22:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B086D20844;
        Mon, 11 Feb 2019 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894953;
        bh=npl2pjBTnGauGmA4xkWal9FZ77i1HMF6MHGXrRLH+1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHBS8XHZ7yDJ+Z7oXE+ba3FfUhEGAeDTiwmm81y2934pd/96bPvGO2ERQU/Pnbjhh
         qZUK4/wUunF1mPVzKsWtcGS7+cI2x9+VEyzqqDCHf0pspkIcWUW1LEmhTmFVr8YVQ9
         XX/E+HEb+nZLsHXWoubHY1yxMPYAiLHYtNGXnZnI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 041/352] platform/chrome: dont report EC_MKBP_EVENT_SENSOR_FIFO as wakeup
Date:   Mon, 11 Feb 2019 15:14:28 +0100
Message-Id: <20190211141848.922190292@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



