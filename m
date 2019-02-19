Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC64C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2561D21738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfBSX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:22 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:49637 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728409AbfBSX2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:04 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 2348b037af8b512f; Wed, 20 Feb 2019 00:28:02 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] cpufreq: Reorder and simplify cpufreq_update_policy()
Date:   Wed, 20 Feb 2019 00:24:25 +0100
Message-ID: <12123959.u3IqJzSc3J@aspire.rjw.lan>
In-Reply-To: <11668536.bBDtnvkYQE@aspire.rjw.lan>
References: <11668536.bBDtnvkYQE@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In cpufreq_update_policy(), instead of updating new_policy.cur
separately, which is kind of confusing, because cpufreq_set_policy()
doesn't take that value into account directly anyway, make the copy
of the existing policy after calling cpufreq_update_current_freq().

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2354,23 +2354,18 @@ void cpufreq_update_policy(unsigned int
 	if (policy_is_inactive(policy))
 		goto unlock;
 
-	pr_debug("updating policy for CPU %u\n", cpu);
-	memcpy(&new_policy, policy, sizeof(*policy));
-	new_policy.min = policy->user_policy.min;
-	new_policy.max = policy->user_policy.max;
-
 	/*
 	 * BIOS might change freq behind our back
 	 * -> ask driver for current freq and notify governors about a change
 	 */
-	if (cpufreq_driver->get && !cpufreq_driver->setpolicy) {
-		if (cpufreq_suspended)
-			goto unlock;
+	if (cpufreq_driver->get && !cpufreq_driver->setpolicy &&
+	    (cpufreq_suspended || WARN_ON(!cpufreq_update_current_freq(policy))))
+		goto unlock;
 
-		new_policy.cur = cpufreq_update_current_freq(policy);
-		if (WARN_ON(!new_policy.cur))
-			goto unlock;
-	}
+	pr_debug("updating policy for CPU %u\n", cpu);
+	memcpy(&new_policy, policy, sizeof(*policy));
+	new_policy.min = policy->user_policy.min;
+	new_policy.max = policy->user_policy.max;
 
 	cpufreq_set_policy(policy, &new_policy);
 

