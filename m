Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E4CC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8833B2567E
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8833B2567E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbeGAR12 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:27:28 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031414AbeGAQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:37:24 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9A1ADACC;
        Sun,  1 Jul 2018 16:37:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.17 021/220] PM / core: Fix supplier device runtime PM usage counter imbalance
Date:   Sun,  1 Jul 2018 18:20:45 +0200
Message-Id: <20180701160909.235911641@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160908.272447118@linuxfoundation.org>
References: <20180701160908.272447118@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit 47e5abfb546a3ace23a77453dc2e9db92704c5ac upstream.

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
device_link_add() who want the supplier to be resumed by it are
expected to pass DL_FLAG_RPM_ACTIVE in flags to it anyway, but
additionally resume the supplier if the link is added during
consumer driver probe to retain the existing behavior for the
callers depending on it.

Fixes: 21d5c57b3726 (PM / runtime: Use device links)
Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: 4.10+ <stable@vger.kernel.org> # 4.10+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
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
@@ -235,12 +242,12 @@ struct device_link *device_link_add(stru
 			switch (consumer->links.status) {
 			case DL_DEV_PROBING:
 				/*
-				 * Balance the decrementation of the supplier's
-				 * runtime PM usage counter after consumer probe
-				 * in driver_probe_device().
+				 * Some callers expect the link creation during
+				 * consumer driver probe to resume the supplier
+				 * even without DL_FLAG_RPM_ACTIVE.
 				 */
 				if (flags & DL_FLAG_PM_RUNTIME)
-					pm_runtime_get_sync(supplier);
+					pm_runtime_resume(supplier);
 
 				link->status = DL_STATE_CONSUMER_PROBE;
 				break;


