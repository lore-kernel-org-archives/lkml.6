Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C438ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F065220684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 21:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BaxLCmgP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="BaxLCmgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F065220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbeGSWJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 18:09:20 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55734 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbeGSWJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 18:09:20 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9B4016063A; Thu, 19 Jul 2018 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532035463;
        bh=NFCryJhGa2jS+bKL5haq/pgyhmkalyDxt7yIxo5HYvw=;
        h=From:To:Cc:Subject:Date:From;
        b=BaxLCmgPkYpOO2KTZxTPk0LlotrxUwFl2+zVxn6A2KQDztD14mGonIY/AJ9qdQn9E
         GzeML5x4ah2K7tZXinYCQzgCB8M81E+6oMIVi4Z1rSgBIU771E7NyQ1Jg9i9TLrz6O
         4/dA4GT/VlpRGr99pI5ZIN9CV5NdW/UAzl0iM4cc=
Received: from rishabhb-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BDDD660481;
        Thu, 19 Jul 2018 21:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532035463;
        bh=NFCryJhGa2jS+bKL5haq/pgyhmkalyDxt7yIxo5HYvw=;
        h=From:To:Cc:Subject:Date:From;
        b=BaxLCmgPkYpOO2KTZxTPk0LlotrxUwFl2+zVxn6A2KQDztD14mGonIY/AJ9qdQn9E
         GzeML5x4ah2K7tZXinYCQzgCB8M81E+6oMIVi4Z1rSgBIU771E7NyQ1Jg9i9TLrz6O
         4/dA4GT/VlpRGr99pI5ZIN9CV5NdW/UAzl0iM4cc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDDD660481
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rishabhb@codeaurora.org
From:   Rishabh Bhatnagar <rishabhb@codeaurora.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Vikram Mulukutla <markivx@codeaurora.org>
Subject: [PATCH] dd: Invoke one probe retry cycle after every initcall level
Date:   Thu, 19 Jul 2018 14:24:00 -0700
Message-Id: <1532035440-7860-1-git-send-email-rishabhb@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers that are registered at an initcall level may have to
wait until late_init before the probe deferral mechanism can
retry their probe functions. It is possible that their
dependencies were resolved much earlier, in some cases even
before the next initcall level. Invoke one probe retry cycle
at every _sync initcall level, allowing these drivers to be
probed earlier.

Signed-off-by: Vikram Mulukutla <markivx@codeaurora.org>
Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
---
 drivers/base/dd.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 1435d72..e6a6821 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -224,23 +224,44 @@ void device_unblock_probing(void)
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
+arch_initcall_sync(deferred_probe_initcall);
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

