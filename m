Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD022146E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 11:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD022146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeLJLan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 06:30:43 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:51145 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLJLan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 06:30:43 -0500
Received: from 79.184.252.35.ipv4.supernova.orange.pl (79.184.252.35) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 3457bc1e441579d4; Mon, 10 Dec 2018 12:30:40 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Doug Smythies <dsmythies@telus.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2] cpuidle: Add 'above' and 'below' idle state metrics
Date:   Mon, 10 Dec 2018 12:30:23 +0100
Message-ID: <3514439.dzOWKx1Cjx@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add two new metrics for CPU idle states, "above" and "below", to count
the number of times the given state had been asked for (or entered
from the kernel's perspective), but the observed idle duration turned
out to be too short or too long for it (respectively).

These metrics help to estimate the quality of the CPU idle governor
in use.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Fix a leftover in the documentation from the previous versions
       of the patch and a typo in the changelog.

---
 Documentation/ABI/testing/sysfs-devices-system-cpu |    7 ++++
 Documentation/admin-guide/pm/cpuidle.rst           |   10 ++++++
 drivers/cpuidle/cpuidle.c                          |   31 ++++++++++++++++++++-
 drivers/cpuidle/sysfs.c                            |    6 ++++
 include/linux/cpuidle.h                            |    2 +
 5 files changed, 55 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/cpuidle.c
+++ linux-pm/drivers/cpuidle/cpuidle.c
@@ -202,7 +202,6 @@ int cpuidle_enter_state(struct cpuidle_d
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	ktime_t time_start, time_end;
-	s64 diff;
 
 	/*
 	 * Tell the time framework to switch to a broadcast timer because our
@@ -248,6 +247,9 @@ int cpuidle_enter_state(struct cpuidle_d
 		local_irq_enable();
 
 	if (entered_state >= 0) {
+		s64 diff, delay = drv->states[entered_state].exit_latency;
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
+				dev->states_usage[entered_state].above++;
+				break;
+			}
+		} else if (diff > delay) {
+			for (i = entered_state + 1; i < drv->state_count; i++) {
+				if (drv->states[i].disabled ||
+				    dev->states_usage[i].disable)
+					continue;
+
+				/*
+				 * Update if a deeper state would have been a
+				 * better match for the observed idle duration.
+				 */
+				if (diff - delay >= drv->states[i].target_residency)
+					dev->states_usage[entered_state].below++;
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
+	unsigned long long	above; /* Number of times it's been too deep */
+	unsigned long long	below; /* Number of times it's been too shallow */
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
+define_show_state_ull_function(above)
+define_show_state_ull_function(below)
 
 define_one_state_ro(name, show_state_name);
 define_one_state_ro(desc, show_state_desc);
@@ -310,6 +312,8 @@ define_one_state_ro(power, show_state_po
 define_one_state_ro(usage, show_state_usage);
 define_one_state_ro(time, show_state_time);
 define_one_state_rw(disable, show_state_disable, store_state_disable);
+define_one_state_ro(above, show_state_above);
+define_one_state_ro(below, show_state_below);
 
 static struct attribute *cpuidle_state_default_attrs[] = {
 	&attr_name.attr,
@@ -320,6 +324,8 @@ static struct attribute *cpuidle_state_d
 	&attr_usage.attr,
 	&attr_time.attr,
 	&attr_disable.attr,
+	&attr_above.attr,
+	&attr_below.attr,
 	NULL
 };
 
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -398,6 +398,16 @@ deeper the (effective) idle state repres
 a number of files (attributes) representing the properties of the idle state
 object corresponding to it, as follows:
 
+``above``
+	Total number of times this idle state had been asked for, but the
+	observed idle duration was certainly too short to match its target
+	residency.
+
+``below``
+	Total number of times this idle state had been asked for, but cerainly
+	a deeper idle state would have been a better match for the observed idle
+	duration.
+
 ``desc``
 	Description of the idle state.
 
Index: linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
===================================================================
--- linux-pm.orig/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ linux-pm/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -145,6 +145,8 @@ What:		/sys/devices/system/cpu/cpuX/cpui
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/power
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/time
 		/sys/devices/system/cpu/cpuX/cpuidle/stateN/usage
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/above
+		/sys/devices/system/cpu/cpuX/cpuidle/stateN/below
 Date:		September 2007
 KernelVersion:	v2.6.24
 Contact:	Linux power management list <linux-pm@vger.kernel.org>
@@ -166,6 +168,11 @@ Description:
 
 		usage: (RO) Number of times this state was entered (a count).
 
+		above: (RO) Number of times this state was entered, but the
+		       observed CPU idle duration was too short for it (a count).
+
+		below: (RO) Number of times this state was entered, but the
+		       observed CPU idle duration was too long for it (a count).
 
 What:		/sys/devices/system/cpu/cpuX/cpuidle/stateN/desc
 Date:		February 2008

