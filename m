Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5E92147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbfBSX2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:03 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50642 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSX2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:03 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id dce9d06b5f8238e3; Wed, 20 Feb 2019 00:28:01 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/4] cpufreq: Pass updated policy to driver ->setpolicy() callback
Date:   Wed, 20 Feb 2019 00:26:30 +0100
Message-ID: <1982548.ex0OEcQ4PI@aspire.rjw.lan>
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

The invocation of the ->setpolicy() cpufreq driver callback should
be equivalent to calling cpufreq_governor_limits(policy) for drivers
with internal governors, but in fact it isn't so, because the
temporary new_policy object is passed to it instead of the updated
policy.

That is a bit confusing, so make cpufreq_set_policy() pass the
updated policy to the driver ->setpolicy() callback.

No intentional changes of behavior.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2286,7 +2286,7 @@ static int cpufreq_set_policy(struct cpu
 	if (cpufreq_driver->setpolicy) {
 		policy->policy = new_policy->policy;
 		pr_debug("setting range\n");
-		return cpufreq_driver->setpolicy(new_policy);
+		return cpufreq_driver->setpolicy(policy);
 	}
 
 	if (new_policy->governor == policy->governor) {

