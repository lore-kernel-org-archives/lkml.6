Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3C2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEF320666
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BJ2l1cha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEF320666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbeIZEUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:20:54 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:37174 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725732AbeIZEUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:20:54 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id D5A7830C032;
        Tue, 25 Sep 2018 15:11:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com D5A7830C032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1537913472;
        bh=HWZkzipohahKF9Xn78eY47nsrAWkE04r0DXQkbDfu9E=;
        h=From:To:Cc:Subject:Date:From;
        b=BJ2l1cha4crwgytF+oDKt+vCGYAq1nPfepPE5buZx09rV6DDX/0X2ewv7PqbpOLLD
         /CyQhS5qrlULUN78SejJU/tMUunOVPDi2hCTw5fV9KYKTLZHVB0VVbudEuOG/s4c2O
         OwFTYU9H10GVVsupXGOPEJ1k6Os+4td7Z4M/S6SU=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 19D28AC071C;
        Tue, 25 Sep 2018 15:11:12 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] PM / core: Fix extra pm_runtime_enable on resume
Date:   Tue, 25 Sep 2018 18:10:55 -0400
Message-Id: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matching pm_runtime_disable/pm_runtime_enable routines should be
called for "direct_complete" devices during suspend/resume and there
are cases where the pm_runtime_disable is skipped during suspend but
pm_runtime_enable is still called during resume. This is a problem
because the runtime enable state is really a counter and this can
incorrectly enable pm_runtime when it should not be enabled. This
happens for any direct_complete device doing an async suspend after
the global variable "async_error" is set (which is set by any sync
or async device's suspend error or early wake condition).

This failure is very timing dependent but for testing and debug
the following changes will make it happen more frequently.
- Add an msleep(500) as the first line in async_suspend() in
  drivers/base/power/main.c
- Modify alarmtimer_suspend in kernel/time/alarmtimer.c to just
  return -EBUSY

To see the failure condition that's been fixed with this patch,
enable dynamic debug for drivers/power/main.c and then run
"rtcwake -s 2 -m standby" and grep for
"skipping runtime enable during resume" messages.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/base/power/main.c | 21 +++++++++++++++++++--
 include/linux/pm.h        |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3f68e2919dc5..2dc40662aae0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -945,7 +945,13 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
 	if (dev->power.direct_complete) {
 		/* Match the pm_runtime_disable() in __device_suspend(). */
-		pm_runtime_enable(dev);
+		if (dev->power.pm_runtime_disabled) {
+			pm_runtime_enable(dev);
+			dev->power.pm_runtime_disabled = false;
+		} else {
+			pm_dev_dbg(dev, state,
+				   "skipping runtime enable during ");
+		}
 		goto Complete;
 	}
 
@@ -1736,8 +1742,19 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	if (dev->power.direct_complete) {
 		if (pm_runtime_status_suspended(dev)) {
 			pm_runtime_disable(dev);
-			if (pm_runtime_status_suspended(dev))
+			if (pm_runtime_status_suspended(dev)) {
+				/*
+				 * If any device's sync or async suspend fails
+				 * and sets async_error, any async suspend for
+				 * direct_complete devices after the failure
+				 * will not execute the pm_runtime_disable
+				 * above. This flag lets the async device's
+				 * resume function (which is always run) know
+				 * if a matching pm_runtime_enable is needed.
+				 */
+				dev->power.pm_runtime_disabled = true;
 				goto Complete;
+			}
 
 			pm_runtime_enable(dev);
 		}
diff --git a/include/linux/pm.h b/include/linux/pm.h
index e723b78d8357..45738ad977fd 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -593,6 +593,7 @@ struct dev_pm_info {
 	bool			is_late_suspended:1;
 	bool			early_init:1;	/* Owned by the PM core */
 	bool			direct_complete:1;	/* Owned by the PM core */
+	unsigned int		pm_runtime_disabled:1;
 	u32			driver_flags;
 	spinlock_t		lock;
 #ifdef CONFIG_PM_SLEEP
-- 
1.9.0.138.g2de3478

