Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34031C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE5220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE5220693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966501AbeFSNz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:55:26 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:58240 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965698AbeFSNzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:55:22 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 0dvL1y00U3XaVaC01dvL9m; Tue, 19 Jun 2018 15:55:21 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0000Yr-Br; Tue, 19 Jun 2018 15:55:20 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fVH6O-0002Ln-Aj; Tue, 19 Jun 2018 15:55:20 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date:   Tue, 19 Jun 2018 15:55:17 +0200
Message-Id: <20180619135518.8990-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180619135518.8990-1-geert+renesas@glider.be>
References: <20180619135518.8990-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a callback to inform a device that its wake-up setting has been
changed.  This allows a device to synchronize device configuration with
an external user action.

E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
switch, the system suspend/resume procedure is:
  1. Configure PMIC for DDR backup mode (by software), which changes the
     role of the accessory power switch from a power to a wake-up
     switch,
  2. Switch accessory power switch off (manually), to prepare for system
     suspend,
  3. Suspend system (by software),
  4. Switch accessory power switch on (manually), to wake up the system.

As step 2 involves a manual operation, step 1 cannot be combined
with step 3 and performed in the PMIC's suspend callback (unlike on
systems with a momentary power switch).

Adding the new callback allows to move step 1 to the new callback, to be
performed in response to the user writing "enabled" to the PMIC's
"wakeup" virtual file in sysfs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Is there a better way to handle this?

Currently step 1 is done in userspace using i2set, which is very
user-unfriendly
(https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).

v2:
  - Improve patch description.
---
 drivers/base/power/wakeup.c | 4 ++++
 include/linux/pm.h          | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 5fa1898755a34878..933560d658692fe3 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -255,6 +255,8 @@ static int device_wakeup_attach(struct device *dev, struct wakeup_source *ws)
 	if (dev->power.wakeirq)
 		device_wakeup_attach_irq(dev, dev->power.wakeirq);
 	spin_unlock_irq(&dev->power.lock);
+	if (dev->power.wakeup_change_notify)
+		dev->power.wakeup_change_notify(dev, true);
 	return 0;
 }
 
@@ -372,6 +374,8 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
 {
 	struct wakeup_source *ws;
 
+	if (dev->power.wakeup_change_notify)
+		dev->power.wakeup_change_notify(dev, false);
 	spin_lock_irq(&dev->power.lock);
 	ws = dev->power.wakeup;
 	dev->power.wakeup = NULL;
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d835706f2..3dec274bffffc6f8 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -599,6 +599,7 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	void (*wakeup_change_notify)(struct device *dev, bool enable);
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-- 
2.17.1

