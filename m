Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C32C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37092215EA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37092215EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeLCMcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:32:35 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:50715 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeLCMcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:32:35 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 2a611bc2e0403aea; Mon, 3 Dec 2018 13:31:41 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Doug Smythies <dsmythies@telus.net>
Subject: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date:   Mon, 03 Dec 2018 13:31:30 +0100
Message-ID: <2384234.f8XooCOKzQ@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add two new metrics for CPU idle states, "high" and "low", to count
the number of times the given state had been asked for (or entered
from the kernel's perspective), but the observed idle duration turned
out to be too high or too low for it (respectively).

These mertics help to estimat the quality of the CPU idle governor
in use.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of https://patchwork.kernel.org/patch/10705317/

---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    7 +++++
 Documentation/admin-guide/pm/cpuidle.rst           |    8 +++++
 drivers/cpuidle/cpuidle.c                          |   29 +++++++++++++++++++++
 drivers/cpuidle/sysfs.c                            |    6 ++++
 include/linux/cpuidle.h                            |    2 +
 5 files changed, 52 insertions(+)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -248,6 +248,8 @@ int cpuidle_enter_state(struct cpuidle_d
 		local_irq_enable();
 
 	if (entered_state >= 0) {
+		int i;
+
 		/*
 		 * Update cpuidle counters
 		 * This can be moved to within driver enter routine,
@@ -260,6 +262,33 @@ int cpuidle_enter_state(struct cpuidle_d
 		dev->last_residency = (int)diff;
 		dev->states_usage[entered_state].time += dev->last_residency;
 		dev->states_usage[entered_state].usage++;
+
+		if (diff < drv->states[entered_state].target_residency) {
+			for (i = entered_state - 1; i >= 0; i--) {
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
+					continue;
+
+				/* Shallower states are enabled, so update. */
+				dev->states_usage[entered_state].high++;
+				break;
+			}
+		} else {
+			for (i = entered_state + 1; i < drv->state_count; i++) {
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
+					continue;
+
+				/*
+				 * Update if a deeper state would have been a
+				 * better match for the observed idle duration.
+				 */
+				if (diff >= drv->states[i].target_residency)
+					dev->states_usage[entered_state].low++;
+
+				break;
+			}
+		}
 	} else {
 		dev->last_residency = 0;
 	}
Index: linux-pm/include/linux/cpuidle.h
===================================================================
--- linux-pm.orig/include/linux/cpuidle.h
+++ linux-pm/include/linux/cpuidle.h
@@ -33,6 +33,8 @@ struct cpuidle_state_usage {
 	unsigned long long	disable;
 	unsigned long long	usage;
 	unsigned long long	time; /* in US */
+	unsigned long long	high; /* Number of times it's been too deep */
+	unsigned long long	low;  /* Number of times it's been too shallow */
 #ifdef CONFIG_SUSPEND
 	unsigned long long	s2idle_usage;
 	unsigned long long	s2idle_time; /* in US */
Index: linux-pm/drivers/cpuidle/sysfs.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/sysfs.c
+++ linux-pm/drivers/cpuidle/sysfs.c
@@ -301,6 +301,8 @@ define_show_state_str_function(name)
 define_show_state_str_function(desc)
 define_show_state_ull_function(disable)
 define_store_state_ull_function(disable)
+define_show_state_ull_function(high)
+define_show_state_ull_function(low)
 
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
@@ -310,6 +312,8 @@ define_one_state_ro(power, show_state_po
 define_one_state_ro(usage, show_state_usage);
 define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
+define_one_state_ro(high, show_state_high);
+define_one_state_ro(low, show_state_low);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -320,6 +324,8 @@ static struct attribute *cpuidle_state_d
 	&attr_usage.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
+	&attr_high.attr,
+	&attr_low.attr,
 	NULL
 };
 
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -404,9 +404,17 @@ object corresponding to it, as follows:
 ``disable``
 	Whether or not this idle state is disabled.
 
+``high``
+	Total number of times this idle state had been asked for, but the
+	observed idle duration was too short to match its target residency.
+
 ``latency``
 	Exit latency of the idle state in microseconds.
 
+``low``
+	Total number of times this idle state had been asked for, but a deeper
+	idle state would have been a better match for the observed idle duration.
+
 ``name``
 	Name of the idle state.
 
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/high
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/low
 Date:		September 2007
 KernelVersion:	v2.6.24
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -166,6 +168,11 @@ Description:
 
 		usage: (RO) Number of times this state was entered (a count).
 
+		high: (RO) Number of times this state was entered, but the
+		      observed CPU target residency was too high for it (a count).
+
+		low: (RO) Number of times this state was entered, but the
+		     observed CPU target residency was too low for it (a count).
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
 Date:		February 2008

