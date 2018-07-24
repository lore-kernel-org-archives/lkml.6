Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7A3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BF320856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16BF320856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbeGXTeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:34:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388427AbeGXTeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:34:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99998DC41;
        Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B75D111AF18;
        Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v2 2/2] cpufreq: Fix a circular lock dependency problem
Date:   Tue, 24 Jul 2018 14:26:05 -0400
Message-Id: <1532456765-17576-3-git-send-email-longman@redhat.com>
In-Reply-To: <1532456765-17576-1-git-send-email-longman@redhat.com>
References: <1532456765-17576-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With lockdep turned on, the following circular lock dependency problem
was reported:

[   57.470040] ======================================================
[   57.502900] WARNING: possible circular locking dependency detected
[   57.535208] 4.18.0-0.rc3.1.el8+7.x86_64+debug #1 Tainted: G
[   57.577761] ------------------------------------------------------
[   57.609714] tuned/1505 is trying to acquire lock:
[   57.633808] 00000000559deec5 (cpu_hotplug_lock.rw_sem){++++}, at: store+0x27/0x120
[   57.672880]
[   57.672880] but task is already holding lock:
[   57.702184] 000000002136ca64 (kn->count#118){++++}, at: kernfs_fop_write+0x1d0/0x410
[   57.742176]
[   57.742176] which lock already depends on the new lock.
[   57.742176]
[   57.785220]
[   57.785220] the existing dependency chain (in reverse order) is:
    :
[   58.932512] other info that might help us debug this:
[   58.932512]
[   58.973344] Chain exists of:
[   58.973344]   cpu_hotplug_lock.rw_sem --> subsys mutex#5 --> kn->count#118
[   58.973344]
[   59.030795]  Possible unsafe locking scenario:
[   59.030795]
[   59.061248]        CPU0                    CPU1
[   59.085377]        ----                    ----
[   59.108160]   lock(kn->count#118);
[   59.124935]                                lock(subsys mutex#5);
[   59.156330]                                lock(kn->count#118);
[   59.186088]   lock(cpu_hotplug_lock.rw_sem);
[   59.208541]
[   59.208541]  *** DEADLOCK ***

In the cpufreq_register_driver() function, the lock sequence is:

  cpus_read_lock --> kn->count

For the cpufreq sysfs store method, the lock sequence is:

  kn->count --> cpus_read_lock

These sequences are actually safe as they are taking a share lock on
cpu_hotplug_lock. However, the current lockdep code doesn't check for
share locking when detecting circular lock dependency.  Fixing that
could be a substantial effort.

Instead, we can work around this problem by using cpus_read_trylock()
in the store method which is much simpler. The chance of not getting
the read lock is very small. If that happens, the userspace application
that writes the sysfs file will get an error.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/cpufreq/cpufreq.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd32..1ddb5ce 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -923,7 +923,12 @@ static ssize_t store(struct kobject *kobj, struct attribute *attr,
 	struct freq_attr *fattr = to_attr(attr);
 	ssize_t ret = -EINVAL;
 
-	cpus_read_lock();
+	/*
+	 * cpus_read_trylock() is used here to work around a circular lock
+	 * dependency problem with respect to the cpufreq_register_driver().
+	 */
+	if (!cpus_read_trylock())
+		return -EBUSY;
 
 	if (cpu_online(policy->cpu)) {
 		down_write(&policy->rwsem);
-- 
1.8.3.1

