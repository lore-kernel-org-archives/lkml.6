Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90B992082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fg6iYCYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B992082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeLDLRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeLDLFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:05:21 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D0FE2146D;
        Tue,  4 Dec 2018 11:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921520;
        bh=SaoXWiAPKn7EKf9vrOfOU8YcDNExd1aBr6YpghV3aBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fg6iYCYGYGMGQSl6wBiYvYvaboY43YxteqtP0EHaHYzyDjYGxsXP3v/OKvbhVqwOE
         ItNQ4M8EJhX77thl60zCCiS+wZMJfr/YlcTlgaSagbYC8bHQo0yGk2uV05G7eJ+d7x
         sjlgtcKUOeK1fxYkv6ObBywIZuSzAbRphZnFVCmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 068/146] sched/core: Fix cpu.max vs. cpuhotplug deadlock
Date:   Tue,  4 Dec 2018 11:49:14 +0100
Message-Id: <20181204103729.576480739@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra peterz@infradead.org

commit ce48c146495a1a50e48cdbfbfaba3e708be7c07c upstream

Tejun reported the following cpu-hotplug lock (percpu-rwsem) read recursion:

  tg_set_cfs_bandwidth()
    get_online_cpus()
      cpus_read_lock()

    cfs_bandwidth_usage_inc()
      static_key_slow_inc()
        cpus_read_lock()

Reported-by: Tejun Heo <tj@kernel.org>
Tested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180122215328.GP3397@worktop
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/jump_label.h |    7 +++++++
 kernel/jump_label.c        |   12 +++++++++---
 kernel/sched/fair.c        |    4 ++--
 3 files changed, 18 insertions(+), 5 deletions(-)

--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -160,6 +160,8 @@ extern void arch_jump_label_transform_st
 extern int jump_label_text_reserved(void *start, void *end);
 extern void static_key_slow_inc(struct static_key *key);
 extern void static_key_slow_dec(struct static_key *key);
+extern void static_key_slow_inc_cpuslocked(struct static_key *key);
+extern void static_key_slow_dec_cpuslocked(struct static_key *key);
 extern void jump_label_apply_nops(struct module *mod);
 extern int static_key_count(struct static_key *key);
 extern void static_key_enable(struct static_key *key);
@@ -222,6 +224,9 @@ static inline void static_key_slow_dec(s
 	atomic_dec(&key->enabled);
 }
 
+#define static_key_slow_inc_cpuslocked(key) static_key_slow_inc(key)
+#define static_key_slow_dec_cpuslocked(key) static_key_slow_dec(key)
+
 static inline int jump_label_text_reserved(void *start, void *end)
 {
 	return 0;
@@ -416,6 +421,8 @@ extern bool ____wrong_branch_error(void)
 
 #define static_branch_inc(x)		static_key_slow_inc(&(x)->key)
 #define static_branch_dec(x)		static_key_slow_dec(&(x)->key)
+#define static_branch_inc_cpuslocked(x)	static_key_slow_inc_cpuslocked(&(x)->key)
+#define static_branch_dec_cpuslocked(x)	static_key_slow_dec_cpuslocked(&(x)->key)
 
 /*
  * Normal usage; boolean enable/disable.
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -79,7 +79,7 @@ int static_key_count(struct static_key *
 }
 EXPORT_SYMBOL_GPL(static_key_count);
 
-static void static_key_slow_inc_cpuslocked(struct static_key *key)
+void static_key_slow_inc_cpuslocked(struct static_key *key)
 {
 	int v, v1;
 
@@ -180,7 +180,7 @@ void static_key_disable(struct static_ke
 }
 EXPORT_SYMBOL_GPL(static_key_disable);
 
-static void static_key_slow_dec_cpuslocked(struct static_key *key,
+static void __static_key_slow_dec_cpuslocked(struct static_key *key,
 					   unsigned long rate_limit,
 					   struct delayed_work *work)
 {
@@ -211,7 +211,7 @@ static void __static_key_slow_dec(struct
 				  struct delayed_work *work)
 {
 	cpus_read_lock();
-	static_key_slow_dec_cpuslocked(key, rate_limit, work);
+	__static_key_slow_dec_cpuslocked(key, rate_limit, work);
 	cpus_read_unlock();
 }
 
@@ -229,6 +229,12 @@ void static_key_slow_dec(struct static_k
 }
 EXPORT_SYMBOL_GPL(static_key_slow_dec);
 
+void static_key_slow_dec_cpuslocked(struct static_key *key)
+{
+	STATIC_KEY_CHECK_USE();
+	__static_key_slow_dec_cpuslocked(key, 0, NULL);
+}
+
 void static_key_slow_dec_deferred(struct static_key_deferred *key)
 {
 	STATIC_KEY_CHECK_USE();
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4040,12 +4040,12 @@ static inline bool cfs_bandwidth_used(vo
 
 void cfs_bandwidth_usage_inc(void)
 {
-	static_key_slow_inc(&__cfs_bandwidth_used);
+	static_key_slow_inc_cpuslocked(&__cfs_bandwidth_used);
 }
 
 void cfs_bandwidth_usage_dec(void)
 {
-	static_key_slow_dec(&__cfs_bandwidth_used);
+	static_key_slow_dec_cpuslocked(&__cfs_bandwidth_used);
 }
 #else /* HAVE_JUMP_LABEL */
 static bool cfs_bandwidth_used(void)


