Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F93C7112C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F2620853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjtuC6m6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F2620853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeJVShe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728144AbeJVShb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:37:31 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A6F2087D;
        Mon, 22 Oct 2018 10:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540203576;
        bh=I1GRFTrhgmOg0l7ozCWVPJalyQmHkusLNoUS/tFCpr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjtuC6m6r3gz608XofZsPi90qaocWSRo1CvFOtVEJRJgfWT60k3Mfzbmd2GcZEDjy
         x3nRLRnH8R70vkxMDYlMXNaZjS9Sf7Wrr3PiG9zvq+miho+iyBwr5WSKslAKYywcXM
         WzIgNKbWpkLLjU+0Oe/zEg92yViViPTvIP3L27Bo=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Drake <drake@endlessm.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 04/27] Input: i8042 - enable keyboard wakeups by default when s2idle is used
Date:   Mon, 22 Oct 2018 06:19:01 -0400
Message-Id: <20181022101924.40531-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022101924.40531-1-sashal@kernel.org>
References: <20181022101924.40531-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

[ Upstream commit 684bec1092b6991ff2a7751e8a763898576eb5c2 ]

Previously, on typical consumer laptops, pressing a key on the keyboard
when the system is in suspend would cause it to wake up (default or
unconditional behaviour). This happens because the EC generates a SCI
interrupt in this scenario.

That is no longer true on modern laptops based on Intel WhiskeyLake,
including Acer Swift SF314-55G, Asus UX333FA, Asus UX433FN and Asus
UX533FD. We confirmed with Asus EC engineers that the "Modern Standby"
design has been modified so that the EC no longer generates a SCI
in this case; the keyboard controller itself should be used for wakeup.

In order to retain the standard behaviour of being able to use the
keyboard to wake up the system, enable serio wakeups by default on
platforms that are using s2idle.

Link: https://lkml.kernel.org/r/CAB4CAwfQ0mPMqCLp95TVjw4J0r5zKPWkSvvkK4cpZUGE--w8bQ@mail.gmail.com
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042.c | 29 ++++++++++++++++++++---------
 include/linux/suspend.h     |  2 ++
 kernel/power/suspend.c      |  6 ++++++
 3 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 824f4c1c1f31..6462f1798fbb 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -1392,15 +1392,26 @@ static void __init i8042_register_ports(void)
 	for (i = 0; i < I8042_NUM_PORTS; i++) {
 		struct serio *serio = i8042_ports[i].serio;
 
-		if (serio) {
-			printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
-				serio->name,
-				(unsigned long) I8042_DATA_REG,
-				(unsigned long) I8042_COMMAND_REG,
-				i8042_ports[i].irq);
-			serio_register_port(serio);
-			device_set_wakeup_capable(&serio->dev, true);
-		}
+		if (!serio)
+			continue;
+
+		printk(KERN_INFO "serio: %s at %#lx,%#lx irq %d\n",
+			serio->name,
+			(unsigned long) I8042_DATA_REG,
+			(unsigned long) I8042_COMMAND_REG,
+			i8042_ports[i].irq);
+		serio_register_port(serio);
+		device_set_wakeup_capable(&serio->dev, true);
+
+		/*
+		 * On platforms using suspend-to-idle, allow the keyboard to
+		 * wake up the system from sleep by enabling keyboard wakeups
+		 * by default.  This is consistent with keyboard wakeup
+		 * behavior on many platforms using suspend-to-RAM (ACPI S3)
+		 * by default.
+		 */
+		if (pm_suspend_via_s2idle() && i == I8042_KBD_PORT_NO)
+			device_set_wakeup_enable(&serio->dev, true);
 	}
 }
 
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 440b62f7502e..206b735f383f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -251,6 +251,7 @@ static inline bool idle_should_enter_s2idle(void)
 	return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
 }
 
+extern bool pm_suspend_via_s2idle(void);
 extern void __init pm_states_init(void);
 extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
 extern void s2idle_wake(void);
@@ -282,6 +283,7 @@ static inline void pm_set_suspend_via_firmware(void) {}
 static inline void pm_set_resume_via_firmware(void) {}
 static inline bool pm_suspend_via_firmware(void) { return false; }
 static inline bool pm_resume_via_firmware(void) { return false; }
+static inline bool pm_suspend_via_s2idle(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 87331565e505..3eeafaff190a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -63,6 +63,12 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+bool pm_suspend_via_s2idle(void)
+{
+	return mem_sleep_current == PM_SUSPEND_TO_IDLE;
+}
+EXPORT_SYMBOL_GPL(pm_suspend_via_s2idle);
+
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
 	lock_system_sleep();
-- 
2.17.1

