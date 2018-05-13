Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEMNJ4 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 09:09:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751345AbeEMNJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 09:09:55 -0400
Date: Sun, 13 May 2018 06:09:44 -0700
From: tip-bot for Sudeep Holla <tipbot@zytor.com>
Message-ID: <tip-1332a90558013ae4242e3dd7934bdcdeafb06c0d@git.kernel.org>
Cc: mingo@kernel.org, fweisbec@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, sudeep.holla@arm.com, hpa@zytor.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org
In-Reply-To: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
References: <1525881728-4858-1-git-send-email-sudeep.holla@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] tick: Prefer a lower rating device only if it's
 CPU local device
Git-Commit-ID: 1332a90558013ae4242e3dd7934bdcdeafb06c0d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1332a90558013ae4242e3dd7934bdcdeafb06c0d
Gitweb:     https://git.kernel.org/tip/1332a90558013ae4242e3dd7934bdcdeafb06c0d
Author:     Sudeep Holla <sudeep.holla@arm.com>
AuthorDate: Wed, 9 May 2018 17:02:08 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 13 May 2018 15:07:41 +0200

tick: Prefer a lower rating device only if it's CPU local device

Checking the equality of cpumask for both new and old tick device doesn't
ensure that it's CPU local device. This will cause issue if a low rating
clockevent tick device is registered first followed by the registration
of higher rating clockevent tick device.

In such case, clockevents_released list will never get emptied as both
the devices get selected as preferred one and we will loop forever in
clockevents_notify_released.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Link: https://lkml.kernel.org/r/1525881728-4858-1-git-send-email-sudeep.holla@arm.com

---
 kernel/time/tick-common.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..78e598334007 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -277,7 +277,8 @@ static bool tick_check_preferred(struct clock_event_device *curdev,
 	 */
 	return !curdev ||
 		newdev->rating > curdev->rating ||
-	       !cpumask_equal(curdev->cpumask, newdev->cpumask);
+	       (!cpumask_equal(curdev->cpumask, newdev->cpumask) &&
+	        !tick_check_percpu(curdev, newdev, smp_processor_id()));
 }
 
 /*
