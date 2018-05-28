Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938570AbeE1MFu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:05:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423133AbeE1LFg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:05:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Martitz <kugel@rockbox.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.16 038/272] PM / core: Fix direct_complete handling for devices with no callbacks
Date: Mon, 28 May 2018 12:01:11 +0200
Message-Id: <20180528100243.952620533@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit c62ec4610c40bcc44f2d3d5ed1c312737279e2f3 upstream.

Commit 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE
driver flags) inadvertently prevented the power.direct_complete flag
from being set for devices without PM callbacks and with disabled
runtime PM which also prevents power.direct_complete from being set
for their parents.  That led to problems including a resume crash on
HP ZBook 14u.

Restore the previous behavior by causing power.direct_complete to be
set for those devices again, but do that in a more direct way to
avoid overlooking that case in the future.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199693
Fixes: 08810a4119aa (PM / core: Add NEVER_SKIP and SMART_PREPARE driver flags)
Reported-by: Thomas Martitz <kugel@rockbox.org>
Tested-by: Thomas Martitz <kugel@rockbox.org>
Cc: 4.15+ <stable@vger.kernel.org> # 4.15+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/main.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1923,10 +1923,8 @@ static int device_prepare(struct device
 
 	dev->power.wakeup_path = false;
 
-	if (dev->power.no_pm_callbacks) {
-		ret = 1;	/* Let device go direct_complete */
+	if (dev->power.no_pm_callbacks)
 		goto unlock;
-	}
 
 	if (dev->pm_domain)
 		callback = dev->pm_domain->ops.prepare;
@@ -1960,7 +1958,8 @@ unlock:
 	 */
 	spin_lock_irq(&dev->power.lock);
 	dev->power.direct_complete = state.event == PM_EVENT_SUSPEND &&
-		pm_runtime_suspended(dev) && ret > 0 &&
+		((pm_runtime_suspended(dev) && ret > 0) ||
+		 dev->power.no_pm_callbacks) &&
 		!dev_pm_test_driver_flags(dev, DPM_FLAG_NEVER_SKIP);
 	spin_unlock_irq(&dev->power.lock);
 	return 0;
