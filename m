Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0D921738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfBSX2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:28:09 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:63351 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSX2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:28:05 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id ab6004f183a040c8; Wed, 20 Feb 2019 00:28:03 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] cpufreq: Add kerneldoc comments for two core functions
Date:   Wed, 20 Feb 2019 00:22:51 +0100
Message-ID: <3161414.QiNJczLRHX@aspire.rjw.lan>
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

Add kerneldoc comments describing cpufreq_set_policy() and
cpufreq_update_policy() as they have not been properly documented
so far and they really need to be documented.

While at it, fix white space around the cpufreq_set_policy() header.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq.c
+++ linux-pm/drivers/cpufreq/cpufreq.c
@@ -2218,12 +2218,25 @@ int cpufreq_get_policy(struct cpufreq_po
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
-/*
- * policy : current policy.
- * new_policy: policy to be set.
+/**
+ * cpufreq_set_policy - Modify cpufreq policy parameters.
+ * @policy: Policy object to modify.
+ * @new_policy: New policy data.
+ *
+ * Pass @new_policy to the cpufreq driver's ->verify() callback, run the
+ * installed policy notifiers for it with the CPUFREQ_ADJUST value, pass it to
+ * the driver's ->verify() callback again and run the notifiers for it again
+ * with the CPUFREQ_NOTIFY value.  Next, copy the min and max parameters
+ * of @new_policy to @policy and either invoke the driver's ->setpolicy()
+ * callback (if present) or carry out a governor update for @policy.  That is,
+ * run the current governor's ->limits() callback (if the governor field in
+ * @new_policy points to the same object as the one in @policy) or replace the
+ * governor for @policy with the new one stored in @new_policy.
+ *
+ * The cpuinfo part of @policy is not updated by this function.
  */
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
-				struct cpufreq_policy *new_policy)
+			      struct cpufreq_policy *new_policy)
 {
 	struct cpufreq_governor *old_gov;
 	int ret;
@@ -2319,11 +2332,14 @@ static int cpufreq_set_policy(struct cpu
 }
 
 /**
- *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
- *	@cpu: CPU which shall be re-evaluated
+ * cpufreq_update_policy - Re-evaluate an existing cpufreq policy.
+ * @cpu: CPU to re-evaluate the policy for.
  *
- *	Useful for policy notifiers which have different necessities
- *	at different times.
+ * Update the current frequency for the cpufreq policy of @cpu and use
+ * cpufreq_set_policy() to re-apply the min and max limits saved in the
+ * user_policy sub-structure of that policy, which triggers the evaluation
+ * of policy notifiers and the cpufreq driver's ->verify() callback for the
+ * policy in question, among other things.
  */
 void cpufreq_update_policy(unsigned int cpu)
 {

