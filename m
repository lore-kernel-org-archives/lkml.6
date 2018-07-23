Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68962ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F86220671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F86220671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388285AbeGWSwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:52:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50580 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388096AbeGWSwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:52:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 45FF787A71;
        Mon, 23 Jul 2018 17:50:00 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE31F178BB;
        Mon, 23 Jul 2018 17:49:59 +0000 (UTC)
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
Subject: [PATCH 1/2] cpu/hotplug: Add a cpus_read_trylock() function
Date:   Mon, 23 Jul 2018 13:49:38 -0400
Message-Id: <1532368179-15263-2-git-send-email-longman@redhat.com>
In-Reply-To: <1532368179-15263-1-git-send-email-longman@redhat.com>
References: <1532368179-15263-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 17:50:00 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Mon, 23 Jul 2018 17:50:00 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases where it can be useful to have a cpus_read_trylock()
function to work around circular lock dependency problem involving
the cpu_hotplug_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/cpu.h | 2 ++
 kernel/cpu.c        | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index a97a63e..e850bfe 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -103,6 +103,7 @@ static inline void cpu_maps_update_done(void)
 extern void cpus_write_unlock(void);
 extern void cpus_read_lock(void);
 extern void cpus_read_unlock(void);
+extern int  cpus_read_trylock(void);
 extern void lockdep_assert_cpus_held(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
@@ -115,6 +116,7 @@ static inline void cpus_write_lock(void) { }
 static inline void cpus_write_unlock(void) { }
 static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
+static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0db8938..307486b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -290,6 +290,12 @@ void cpus_read_lock(void)
 }
 EXPORT_SYMBOL_GPL(cpus_read_lock);
 
+int cpus_read_trylock(void)
+{
+	return percpu_down_read_trylock(&cpu_hotplug_lock);
+}
+EXPORT_SYMBOL_GPL(cpus_read_trylock);
+
 void cpus_read_unlock(void)
 {
 	percpu_up_read(&cpu_hotplug_lock);
-- 
1.8.3.1

