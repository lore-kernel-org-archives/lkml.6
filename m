Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE678C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A46402084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="U7o8SdDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46402084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbeLKWPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:15:13 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:42321 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeLKWOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=HWkK7iQq9ta80RrwtU/c+rcN0zUUfrCgPS8BSybIfyI=; b=U7o8SdDzELgq
        /plZnVpUA6JJdQz+gjY7emigjaeBfGKn/ml5KMmc7bypcwyd/OjTncNiitUwKafG9NbdvScw9bdi1
        38BKOlXGjA+ecHt3/9tOnJk8lHeTOB6hgdUm2AmKeUl9kwGswH+MVH/GRwhaR92Uq0jqUftERX3EE
        rRE0HmU7UHnHzUeI8nIoM1oYwd7VBH11VcSZtJOzS6CmiK5O9IwrHnnXifXEWoIfZhGbIqQfuWIwm
        /yzNZcMHDWuMVww+UgtacpU4B5QEooOYKzyP/H35H1dAbDp01HnGe4IXJBuHNEd3GlloRrkc3tJmN
        FyVmNBcLNk9iELLZCXaLHQ==;
Received: from smtp-auth.mailprotect.be ([178.208.39.155])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gWqHx-0006rV-0S; Tue, 11 Dec 2018 23:14:01 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id E22E8C0787;
        Tue, 11 Dec 2018 23:13:47 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 06/15] locking/lockdep: Make it easy to detect whether or not inside a selftest
Date:   Tue, 11 Dec 2018 14:13:12 -0800
Message-Id: <20181211221321.196536-7-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
In-Reply-To: <20181211221321.196536-1-bvanassche@acm.org>
References: <20181211221321.196536-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.155
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.04)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5m8X79C6/njB9cLGJ2H97yB602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORq885fckR2lOUj20Q7g
 y3EbSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLvIbV2
 8+z33+Jptxx0qf7sMg+Uydj1pr4eGGBDyIkBGRKqltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxwNolP4YgdnKg3eGwyxTOLqCbURtyW14Wq5/enGMyFyGJIAiDKO1d3jsySf+J0s
 zc3volzWZu5fe7ghC/HzOt6Mfqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
 VWdImRunoKaV5Izq4VabSfIGUY8RJ38dSGEP+JYPRX76oPSBtBBPLYw1mZQfhvSXPX1npIQpGBE7
 MnJiHvQ8gQs8eCOaG4DvtrnB4hxWBV/7jCqhcJq0hur2OKHH5lr9xXvSM4nM3avg
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch that frees unused lock classes will modify the behavior of
lockdep_free_key_range() and lockdep_reset_lock() depending on whether
or not these functions are called from the context of the lockdep
selftests. Hence make it easy to detect whether or not lockdep code
is called from the context of a lockdep selftest.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/lockdep.h  | 2 ++
 kernel/locking/lockdep.c | 1 +
 lib/locking-selftest.c   | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b5e6bfe0ae4a..16ac9fe56783 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -466,6 +466,8 @@ enum xhlock_context_t {
 #define STATIC_LOCKDEP_MAP_INIT(_name, _key) \
 	{ .name = (_name), .key = (void *)(_key), }
 
+extern struct task_struct *lockdep_selftest_task_struct;
+
 static inline void lockdep_invariant_state(bool force) {}
 static inline void lockdep_init_task(struct task_struct *task) {}
 static inline void lockdep_free_task(struct task_struct *task) {}
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4fcc2a07bfb4..aeb775a4bed3 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -81,6 +81,7 @@ module_param(lock_stat, int, 0644);
  * code to recurse back into the lockdep code...
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+struct task_struct *lockdep_selftest_task_struct;
 
 static int graph_lock(void)
 {
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..b37fd3fe7fd6 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1989,6 +1989,7 @@ void locking_selftest(void)
 
 	init_shared_classes();
 	debug_locks_silent = !debug_locks_verbose;
+	lockdep_selftest_task_struct = current;
 
 	DO_TESTCASE_6R("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
@@ -2097,5 +2098,6 @@ void locking_selftest(void)
 		printk("---------------------------------\n");
 		debug_locks = 1;
 	}
+	lockdep_selftest_task_struct = NULL;
 	debug_locks_silent = 0;
 }
-- 
2.20.0.rc2.403.gdbc3b29805-goog

