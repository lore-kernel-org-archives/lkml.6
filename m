Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EEAC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B224C20661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:03:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B224C20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeLIWDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:03:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35608 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbeLIVz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 16:55:28 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72q-0002im-WF; Sun, 09 Dec 2018 21:55:25 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72l-0003hN-Mo; Sun, 09 Dec 2018 21:55:19 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.323017567@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 321/328] cpuidle: Do not access cpuidle_devices when
 !CONFIG_CPU_IDLE
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Catalin Marinas <catalin.marinas@arm.com>

commit 9bd616e3dbedfc103f158197c8ad93678849b1ed upstream.

The cpuidle_devices per-CPU variable is only defined when CPU_IDLE is
enabled. Commit c8cc7d4de7a4 ("sched/idle: Reorganize the idle loop")
removed the #ifdef CONFIG_CPU_IDLE around cpuidle_idle_call() with the
compiler optimising away __this_cpu_read(cpuidle_devices). However, with
CONFIG_UBSAN && !CONFIG_CPU_IDLE, this optimisation no longer happens
and the kernel fails to link since cpuidle_devices is not defined.

This patch introduces an accessor function for the current CPU cpuidle
device (returning NULL when !CONFIG_CPU_IDLE) and uses it in
cpuidle_idle_call().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/cpuidle.h | 3 +++
 kernel/sched/idle.c     | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -146,6 +146,8 @@ extern int cpuidle_play_dead(void);
 extern void cpuidle_use_deepest_state(bool enable);
 
 extern struct cpuidle_driver *cpuidle_get_cpu_driver(struct cpuidle_device *dev);
+static inline struct cpuidle_device *cpuidle_get_device(void)
+{return __this_cpu_read(cpuidle_devices); }
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_select(struct cpuidle_driver *drv,
@@ -179,6 +181,7 @@ static inline int cpuidle_play_dead(void
 static inline void cpuidle_use_deepest_state(bool enable) {}
 static inline struct cpuidle_driver *cpuidle_get_cpu_driver(
 	struct cpuidle_device *dev) {return NULL; }
+static inline struct cpuidle_device *cpuidle_get_device(void) {return NULL; }
 #endif
 
 #ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -76,7 +76,7 @@ void __weak arch_cpu_idle(void)
  */
 static void cpuidle_idle_call(void)
 {
-	struct cpuidle_device *dev = __this_cpu_read(cpuidle_devices);
+	struct cpuidle_device *dev = cpuidle_get_device();
 	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
 	int next_state, entered_state;
 	bool broadcast;

