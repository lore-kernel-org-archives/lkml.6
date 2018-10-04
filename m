Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6487C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74F32098A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74F32098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeJDQDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:03:34 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:65098 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeJDQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:03:34 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id 23b951b3e89db010; Thu, 4 Oct 2018 11:11:13 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Al Cooper <alcooperx@gmail.com>, Pavel Machek <pavel@ucw.cz>
Subject: [PATCH] PM / core: Clear the direct_complete flag on errors
Date:   Thu, 04 Oct 2018 11:08:12 +0200
Message-ID: <61559514.Vym8FNvob2@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If __device_suspend() returns early on an error or pending wakeup
and the power.direct_complete flag has been set for the device
already, the subsequent device_resume() will be confused by it
and it will call pm_runtime_enable() incorrectly, as runtime PM
has not been disabled for the device by __device_suspend().

To avoid that, clear power.direct_complete if __device_suspend()
is not going to disable runtime PM for the device before returning.

Fixes: aae4518b3124 (PM / sleep: Mechanism to avoid resuming runtime-suspended devices unnecessarily)
Reported-by: Al Cooper <alcooperx@gmail.com>
Cc: 3.16+ <stable@vger.kernel.org> # 3.16+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/base/power/main.c
===================================================================
--- linux-pm.orig/drivers/base/power/main.c
+++ linux-pm/drivers/base/power/main.c
@@ -1713,8 +1713,10 @@ static int __device_suspend(struct devic
 
 	dpm_wait_for_subordinate(dev, async);
 
-	if (async_error)
+	if (async_error) {
+		dev->power.direct_complete = false;
 		goto Complete;
+	}
 
 	/*
 	 * If a device configured to wake up the system from sleep states
@@ -1726,6 +1728,7 @@ static int __device_suspend(struct devic
 		pm_wakeup_event(dev, 0);
 
 	if (pm_wakeup_pending()) {
+		dev->power.direct_complete = false;
 		async_error = -EBUSY;
 		goto Complete;
 	}

