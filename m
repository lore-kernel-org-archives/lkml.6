Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE92AC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5AE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 08:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5AE20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeJCPUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 11:20:40 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:54095 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeJCPUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 11:20:39 -0400
Received: from 79.184.253.194.ipv4.supernova.orange.pl (79.184.253.194) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.148)
 id a8cd1d85abc03ef7; Wed, 3 Oct 2018 10:33:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] PM / core: Fix extra pm_runtime_enable on resume
Date:   Wed, 03 Oct 2018 10:30:14 +0200
Message-ID: <16552133.rou2tyfJcz@aspire.rjw.lan>
In-Reply-To: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
References: <1537913455-43397-1-git-send-email-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, September 26, 2018 12:10:55 AM CEST Al Cooper wrote:
> Matching pm_runtime_disable/pm_runtime_enable routines should be
> called for "direct_complete" devices during suspend/resume and there
> are cases where the pm_runtime_disable is skipped during suspend but
> pm_runtime_enable is still called during resume. This is a problem
> because the runtime enable state is really a counter and this can
> incorrectly enable pm_runtime when it should not be enabled. This
> happens for any direct_complete device doing an async suspend after
> the global variable "async_error" is set (which is set by any sync
> or async device's suspend error or early wake condition).

So the bug is simply that the direct_complete flag is not cleared
when we are going to bail out of __device_suspend() early due to an
error or wakeup.

The patch below should fix it then (without adding extra flags to
struct dev_pm_info), shouldn't it?

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

