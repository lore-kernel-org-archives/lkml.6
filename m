Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7128BC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ABB4217CC
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ABB4217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeHMUXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:23:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45532 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMUXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:23:50 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5CB2F6079C; Mon, 13 Aug 2018 17:40:38 +0000 (UTC)
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C975606CF;
        Mon, 13 Aug 2018 17:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9C975606CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=fail smtp.mailfrom=rishabhb@quicinc.com
From:   Rishabh Bhatnagar <rishabhb@quicinc.com>
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        psodagud@codeaurora.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, linux-pm@vger.kernel.org,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: [PATCH v1] dd: Invoke one probe retry cycle after some initcall levels
Date:   Mon, 13 Aug 2018 10:39:49 -0700
Message-Id: <1534181989-22536-1-git-send-email-rishabhb@quicinc.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rishabh Bhatnagar <rishabhb@codeaurora.org>

Drivers that are registered at an initcall level may have to
wait until late_init before the probe deferral mechanism can
retry their probe functions. It is possible that their
dependencies were resolved much earlier, in some cases even
before the next initcall level. Invoke one probe retry cycle
at every _sync initcall level after subsys initcall, allowing
these drivers to be probed earlier.
To give an example many Qualcomm drivers are dependent on the 
regulator and bus driver. Both the regulator and bus driver 
are probed in the subsys_initcall level. Now the probe of bus 
driver requires regulator to be working. If the probe of bus 
driver happens before regulator, then bus driver's probe will 
be deferred and all other device's probes which depend on bus 
driver will also be deferred.
The impact of this problem is reduced if we have this patch.

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---

Changes since v0:
 * Remove arch_initcall_sync(deferred_probe_initcall) from patch. This is not
   really needed as none of the devices are re-probed in arch_initcall_sync
   level.

 drivers/base/dd.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..9aa41aa 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,23 +224,43 @@ void device_unblock_probing(void)
 	driver_deferred_probe_trigger();
 }
 
+static void enable_trigger_defer_cycle(void)
+{
+	driver_deferred_probe_enable = true;
+	driver_deferred_probe_trigger();
+	/*
+	 * Sort as many dependencies as possible before the next initcall
+	 * level
+	 */
+	flush_work(&deferred_probe_work);
+}
+
 /**
  * deferred_probe_initcall() - Enable probing of deferred devices
  *
  * We don't want to get in the way when the bulk of drivers are getting probed.
  * Instead, this initcall makes sure that deferred probing is delayed until
- * late_initcall time.
+ * all the registered initcall functions at a particular level are completed.
+ * This function is invoked at every *_initcall_sync level.
  */
 static int deferred_probe_initcall(void)
 {
-	driver_deferred_probe_enable = true;
-	driver_deferred_probe_trigger();
-	/* Sort as many dependencies as possible before exiting initcalls */
-	flush_work(&deferred_probe_work);
+	enable_trigger_defer_cycle();
+	driver_deferred_probe_enable = false;
+	return 0;
+}
+subsys_initcall_sync(deferred_probe_initcall);
+fs_initcall_sync(deferred_probe_initcall);
+device_initcall_sync(deferred_probe_initcall);
+
+static int deferred_probe_enable_fn(void)
+{
+	/* Enable deferred probing for all time */
+	enable_trigger_defer_cycle();
 	initcalls_done = true;
 	return 0;
 }
-late_initcall(deferred_probe_initcall);
+late_initcall(deferred_probe_enable_fn);
 
 /**
  * device_is_bound() - Check if device is bound to a driver
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

