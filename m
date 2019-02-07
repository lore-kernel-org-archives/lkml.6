Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD43C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064EB2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 18:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBGSq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 13:46:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:60946 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfBGSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 13:46:53 -0500
Received: from 79.184.254.36.ipv4.supernova.orange.pl (79.184.254.36) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 9fea27cacdebb27e; Thu, 7 Feb 2019 19:46:51 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Lukas Wunner <lukas@wunner.de>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Lucas Stach <l.stach@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/2] PM-runtime: Take suppliers into account in __pm_runtime_set_status()
Date:   Thu, 07 Feb 2019 19:38:56 +0100
Message-ID: <1634058.cXDNg15SOd@aspire.rjw.lan>
In-Reply-To: <3917694.ab5GGAjohB@aspire.rjw.lan>
References: <3917694.ab5GGAjohB@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If the target device has any suppliers, as reflected by device links
to them, __pm_runtime_set_status() does not take them into account,
which is not consistent with the other parts of the PM-runtime
framework and may lead to programming mistakes.

Modify __pm_runtime_set_status() to take suppliers into account by
activating them upfront if the new status is RPM_ACTIVE and
deactivating them on exit if the new status is RPM_SUSPENDED.

If the activation of one of the suppliers fails, the new status
will be RPM_SUSPENDED and the (remaining) suppliers will be
deactivated on exit (the child count of the device's parent
will be dropped too then).

Of course, adding device links locking to __pm_runtime_set_status()
means that it cannot be run fron interrupt context, so make it use
spin_lock_irq() and spin_unlock_irq() instead of spin_lock_irqsave()
and spin_unlock_irqrestore(), respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/runtime.c |   45 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

Index: linux-pm/drivers/base/power/runtime.c
===================================================================
--- linux-pm.orig/drivers/base/power/runtime.c
+++ linux-pm/drivers/base/power/runtime.c
@@ -1102,20 +1102,43 @@ EXPORT_SYMBOL_GPL(pm_runtime_get_if_in_u
  * and the device parent's counter of unsuspended children is modified to
  * reflect the new status.  If the new status is RPM_SUSPENDED, an idle
  * notification request for the parent is submitted.
+ *
+ * If @dev has any suppliers (as reflected by device links to them), and @status
+ * is RPM_ACTIVE, they will be activated upfront and if the activation of one
+ * of them fails, the status of @dev will be changed to RPM_SUSPENDED (instead
+ * of the @status value) and the suppliers will be deacticated on exit.  The
+ * error returned by the failing supplier activation will be returned in that
+ * case.
  */
 int __pm_runtime_set_status(struct device *dev, unsigned int status)
 {
 	struct device *parent = dev->parent;
-	unsigned long flags;
 	bool notify_parent = false;
 	int error = 0;
 
 	if (status != RPM_ACTIVE && status != RPM_SUSPENDED)
 		return -EINVAL;
 
-	spin_lock_irqsave(&dev->power.lock, flags);
+	/*
+	 * If the new status is RPM_ACTIVE, the suppliers can be activated
+	 * upfront regardless of the current status, because next time
+	 * rpm_put_suppliers() runs, the rpm_active refcounts of the links
+	 * involved will be dropped down to one anyway.
+	 */
+	if (status == RPM_ACTIVE) {
+		int idx = device_links_read_lock();
+
+		error = rpm_get_suppliers(dev);
+		if (error)
+			status = RPM_SUSPENDED;
+
+		device_links_read_unlock(idx);
+	}
+
+	spin_lock_irq(&dev->power.lock);
 
 	if (!dev->power.runtime_error && !dev->power.disable_depth) {
+		status = dev->power.runtime_status;
 		error = -EAGAIN;
 		goto out;
 	}
@@ -1147,19 +1170,31 @@ int __pm_runtime_set_status(struct devic
 
 		spin_unlock(&parent->power.lock);
 
-		if (error)
+		if (error) {
+			status = RPM_SUSPENDED;
 			goto out;
+		}
 	}
 
  out_set:
 	__update_runtime_status(dev, status);
-	dev->power.runtime_error = 0;
+	if (!error)
+		dev->power.runtime_error = 0;
+
  out:
-	spin_unlock_irqrestore(&dev->power.lock, flags);
+	spin_unlock_irq(&dev->power.lock);
 
 	if (notify_parent)
 		pm_request_idle(parent);
 
+	if (status == RPM_SUSPENDED) {
+		int idx = device_links_read_lock();
+
+		rpm_put_suppliers(dev);
+
+		device_links_read_unlock(idx);
+	}
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(__pm_runtime_set_status);

