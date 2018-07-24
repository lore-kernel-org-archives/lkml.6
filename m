Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F413FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1B9520880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B9520880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbeGXTeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:34:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51334 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388495AbeGXTd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:33:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44A5E7A7E5;
        Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
Received: from llong.com (dhcp-17-175.bos.redhat.com [10.18.17.175])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBE84111AF19;
        Tue, 24 Jul 2018 18:26:14 +0000 (UTC)
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
Subject: [PATCH v2 1/2] cpu/hotplug: Add a cpus_read_trylock() function
Date:   Tue, 24 Jul 2018 14:26:04 -0400
Message-Id: <1532456765-17576-2-git-send-email-longman@redhat.com>
In-Reply-To: <1532456765-17576-1-git-send-email-longman@redhat.com>
References: <1532456765-17576-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 24 Jul 2018 18:26:15 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'longman@redhat.com' RCPT:''
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

