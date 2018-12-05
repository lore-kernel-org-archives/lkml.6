Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63778C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2320879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC2320879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbeLEWpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:45:50 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:56347 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbeLEWpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:45:49 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.177)
 id bb70f2fd3131f3ff; Wed, 5 Dec 2018 23:45:46 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH] cpuidle: Add cpuidle.governor= command line parameter
Date:   Wed, 05 Dec 2018 23:45:34 +0100
Message-ID: <1752296.bicKxrytZO@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add cpuidle.governor= command line parameter to allow the default
cpuidle governor to be replaced.

That is useful, for example, if someone running a tickful kernel
wants to use the menu governor on it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/10714995/ and
https://patchwork.kernel.org/patch/10705317/

---
 Documentation/admin-guide/kernel-parameters.txt |    3 +++
 Documentation/admin-guide/pm/cpuidle.rst        |    7 +++++++
 drivers/cpuidle/cpuidle.c                       |    1 +
 drivers/cpuidle/cpuidle.h                       |    1 +
 drivers/cpuidle/governor.c                      |    9 +++++++--
 5 files changed, 19 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/cpuidle/governor.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governor.c
+++ linux-pm/drivers/cpuidle/governor.c
@@ -11,10 +11,13 @@
 #include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/mutex.h>
+#include <linux/module.h>
 #include <linux/pm_qos.h>
 
 #include "cpuidle.h"
 
+char param_governor[CPUIDLE_NAME_LEN];
+
 LIST_HEAD(cpuidle_governors);
 struct cpuidle_governor *cpuidle_curr_governor;
 
@@ -86,9 +89,11 @@ int cpuidle_register_governor(struct cpu
 	mutex_lock(&cpuidle_lock);
 	if (__cpuidle_find_governor(gov->name) == NULL) {
 		ret = 0;
-		list_add_tail(&gov->governor_list, &cpuidle_governors);
 		if (!cpuidle_curr_governor ||
-		    cpuidle_curr_governor->rating < gov->rating)
+		    !strncasecmp(param_governor, gov->name, CPUIDLE_NAME_LEN) ||
+		    (cpuidle_curr_governor->rating < gov->rating &&
+		     strncasecmp(param_governor, cpuidle_curr_governor->name,
+				 CPUIDLE_NAME_LEN)))
 			cpuidle_switch_governor(gov);
 	}
 	mutex_unlock(&cpuidle_lock);
Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -731,4 +731,5 @@ static int __init cpuidle_init(void)
 }
 
 module_param(off, int, 0444);
+module_param_string(governor, param_governor, CPUIDLE_NAME_LEN, 0444);
 core_initcall(cpuidle_init);
Index: linux-pm/drivers/cpuidle/cpuidle.h
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.h
+++ linux-pm/drivers/cpuidle/cpuidle.h
@@ -7,6 +7,7 @@
 #define __DRIVER_CPUIDLE_H
 
 /* For internal use only */
+extern char param_governor[];
 extern struct cpuidle_governor *cpuidle_curr_governor;
 extern struct list_head cpuidle_governors;
 extern struct list_head cpuidle_detected_devices;
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -576,6 +576,13 @@ processors implementing the architecture
 however, so it is rather crude and not very energy-efficient.  For this reason,
 it is not recommended for production use.
 
+The ``cpuidle.governor=`` kernel command line switch allows the ``CPUIdle``
+governor to use to be specified.  It has to be appended with a string matching
+the name of an available governor (e.g. ``cpuidle.governor=menu``) and that
+governor will be used instead of the default one.  It is possible to force
+the ``menu`` governor to be used on the systems that use the ``ladder`` governor
+by default this way, for example.
+
 The other kernel command line parameters controlling CPU idle time management
 described below are only relevant for the *x86* architecture and some of
 them affect Intel processors only.
Index: linux-pm/Documentation/admin-guide/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/admin-guide/kernel-parameters.txt
+++ linux-pm/Documentation/admin-guide/kernel-parameters.txt
@@ -674,6 +674,9 @@
 	cpuidle.off=1	[CPU_IDLE]
 			disable the cpuidle sub-system
 
+	cpuidle.governor=
+			[CPU_IDLE] Name of the cpuidle governor to use.
+
 	cpufreq.off=1	[CPU_FREQ]
 			disable the cpufreq sub-system
 

