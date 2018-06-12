Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 35EA8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94D6208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 11:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E94D6208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbeFLLBY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 07:01:24 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:56247 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932286AbeFLLBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 07:01:23 -0400
Received: from 79.184.255.56.ipv4.supernova.orange.pl (79.184.255.56) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 57f6f2dc109e2e6c; Tue, 12 Jun 2018 13:01:21 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lukas Wunner <lukas@wunner.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
Date:   Tue, 12 Jun 2018 13:00:20 +0200
Message-ID: <10125310.W3e2TP0641@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If a device link is added via device_link_add() by the driver of the
link's consumer device, the supplier's runtime PM usage counter is
going to be dropped by the pm_runtime_put_suppliers() call in
driver_probe_device().  However, in that case it is not incremented
unless the supplier driver is already present and the link is not
stateless.  That leads to a runtime PM usage counter imbalance for
the supplier device in a few cases.

To prevent that from happening, bump up the supplier runtime
PM usage counter in device_link_add() for all links with the
DL_FLAG_PM_RUNTIME flag set that are added at the consumer probe
time.  Use pm_runtime_get_noresume() for that as the callers of
device_link_add() who want the supplier to be resumed by it should
pass DL_FLAG_RPM_ACTIVE in flags to it anyway.

Fixes: 21d5c57b3726 (PM / runtime: Use device links)
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This is a replacement for commit 1e8378619841 (PM / runtime: Fixup
reference counting of device link suppliers at probe) that is going
to be reverted.

---
 drivers/base/core.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/base/core.c
===================================================================
--- linux-pm.orig/drivers/base/core.c
+++ linux-pm/drivers/base/core.c
@@ -216,6 +216,13 @@ struct device_link *device_link_add(stru
 			link->rpm_active = true;
 		}
 		pm_runtime_new_link(consumer);
+		/*
+		 * If the link is being added by the consumer driver at probe
+		 * time, balance the decrementation of the supplier's runtime PM
+		 * usage counter after consumer probe in driver_probe_device().
+		 */
+		if (consumer->links.status == DL_DEV_PROBING)
+			pm_runtime_get_noresume(supplier);
 	}
 	get_device(supplier);
 	link->supplier = supplier;
@@ -234,14 +241,6 @@ struct device_link *device_link_add(stru
 		case DL_DEV_DRIVER_BOUND:
 			switch (consumer->links.status) {
 			case DL_DEV_PROBING:
-				/*
-				 * Balance the decrementation of the supplier's
-				 * runtime PM usage counter after consumer probe
-				 * in driver_probe_device().
-				 */
-				if (flags & DL_FLAG_PM_RUNTIME)
-					pm_runtime_get_sync(supplier);
-
 				link->status = DL_STATE_CONSUMER_PROBE;
 				break;
 			case DL_DEV_DRIVER_BOUND:

