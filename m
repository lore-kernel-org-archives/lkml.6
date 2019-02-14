Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10792218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="v+GlI0hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387846AbfBNXD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:03:27 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:60273 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfBNXBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=6ZU/qYXswpDm1I3o44PiL+adMqtfT0R/2jW+VS2kvk4=; b=v+GlI0hpjBey
        g2uhTVvtMqPf2G8QWc0EEtvharetMBC7TAi8FBe/TaOoqIYilZJEAyRVZn30ZA8Vx2S4TrJeLRw0y
        s06YlIBh2FrCTdtNVAVXIhp1fdjb3k8guHkw5j9pRjPgwXgyEFsFkZm1b8shFfqUXALeGhYhtFK88
        cTG2qGyKlYdRo84eVL4SjXklUAiKOUSLhIuJJHhQzG+eD8p6xZ3QL29ostkhonGq9d5prq2R8PWXP
        9SNaroEztFslkoMwZbckyh5o/Ko8x7FS+a5GReQR3/UqlwIrGSP2fLEBp5xSnQswIj1f3YO9EGWhI
        IjcX6Jgh13cjXgGPsA0C9A==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1guQ0Z-000DLb-AW; Fri, 15 Feb 2019 00:01:31 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id BFA0FC04D0;
        Fri, 15 Feb 2019 00:01:28 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, will.deacon@arm.com, tj@kernel.org,
        longman@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v7 09/23] locking/lockdep: Make it easy to detect whether or not inside a selftest
Date:   Thu, 14 Feb 2019 15:00:44 -0800
Message-Id: <20190214230058.196511-10-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214230058.196511-1-bvanassche@acm.org>
References: <20190214230058.196511-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5l/+lDF/HdQ5BfR5oRJ0+BZ602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTbXCyMe5v8y2H30acbVA7+CsLowAEMLnIs/c915wTAPANfX
 yKo+pvzCeHRww82sG/8HW2me2F11ZDpUG2A5Oiv0I5mALh2L1FvYZOvwUqXjvDk55wR+TsdsSUF6
 GKzdvFr/HXw7HB6/ASdSFy6HwS/kPXDwAtkmamZ68x0sIvfyXcDIKE+0kbt+hzad+8LmAP3D1N2U
 GbvmsuDbvpqB9SNial5u6w2P0n3AP5HxdAj+kw2FxVgE7SkvtWKxkgySOE3GN0ExaDjCWJE9qkQd
 cN59bBwMKfB73GOq6x000AEXifFzAzRoMTGLkyW94JLtHXpy+28pF/HE/UXip0YpvmqSgtBtsvjK
 9mpXvZ581yfqNeeYAkx3ZcmLZYF56A5GPA+gQUA9iOUB9gXW15it62GvKaV7puimXuHjFEy4159w
 b450J4XCXsfFdbMPgtsajKwG2cpJ3lvOyWe43aQJV0FQAw4GDaNi9opIpCCZlwPhCSifQg48iasD
 JL+gSQdpc7Qjle0LcSTVPooEuo2QsxqqSZrgzSd/y/UPcC3OGqi0VLzxDmzcG0iKavUv44HfPfc9
 3SsS4aMXJmiJ2G0eb5ahWSZS8itsoBzU38uNQrbb6O7J//0XCxCMJn8bXo41UD0XUeyeeLgoe8v3
 Ml5+IDYsxJeBk/os5j8abOYt1SAwFTiWFYSlhfdXoL2rBaBWqCutI4g+l6rCWbY0MZcgnbHshzjL
 mWRvvkZRtgBBWwxR0VpXCEqSenvCQusD//B2Ay/DNaBiti8rX52xSxVHK1dLr1x1RYIHNNee2LMZ
 auWd3bJLCnhUZijhyP+NAi4z4ocCHqI/c8KjUic/Eh5gmfm8Qixyw/DNQAInR1tPJCnqBScHL8+l
 TGBIVE9xbEkX79v7DEiBILyHFulTt8MZ+2FHvumGWhrOrsi8Jm+XkWaiDAd3nY0YMuPuNHKfsH9r
 46Yhu1/rdU1t/SWu+yxj6TsAI+iDD9vGjzLZdruisfuPhyICICyimEKZnywKt5h6ngx9mFmID8gM
 9QZDi01IhiaMMDRcCgYQIezXimM8MMGBqfqdqJBJSRulWz3lJxoVd7HeK8WDo27Oo9Jnn2NG+H38
 c/DXtHJOj+IrynVpkScfoGQWOPBVY82M8ECfDTyNS/J0MyNuDItEaHVAyCe015AGfC4N4YKcCY/W
 O55FSnHkew==
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
 include/linux/lockdep.h  | 5 +++++
 kernel/locking/lockdep.c | 6 ++++++
 lib/locking-selftest.c   | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index b5e6bfe0ae4a..66eee1ba0f2a 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -265,6 +265,7 @@ extern void lockdep_reset(void);
 extern void lockdep_reset_lock(struct lockdep_map *lock);
 extern void lockdep_free_key_range(void *start, unsigned long size);
 extern asmlinkage void lockdep_sys_exit(void);
+extern void lockdep_set_selftest_task(struct task_struct *task);
 
 extern void lockdep_off(void);
 extern void lockdep_on(void);
@@ -395,6 +396,10 @@ static inline void lockdep_on(void)
 {
 }
 
+static inline void lockdep_set_selftest_task(struct task_struct *task)
+{
+}
+
 # define lock_acquire(l, s, t, r, c, n, i)	do { } while (0)
 # define lock_release(l, n, i)			do { } while (0)
 # define lock_downgrade(l, i)			do { } while (0)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 7f80d8789978..42161b8f0e68 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -81,6 +81,7 @@ module_param(lock_stat, int, 0644);
  * code to recurse back into the lockdep code...
  */
 static arch_spinlock_t lockdep_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+static struct task_struct *lockdep_selftest_task_struct;
 
 static int graph_lock(void)
 {
@@ -331,6 +332,11 @@ void lockdep_on(void)
 }
 EXPORT_SYMBOL(lockdep_on);
 
+void lockdep_set_selftest_task(struct task_struct *task)
+{
+	lockdep_selftest_task_struct = task;
+}
+
 /*
  * Debugging switches:
  */
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 1e1bbf171eca..a1705545e6ac 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1989,6 +1989,7 @@ void locking_selftest(void)
 
 	init_shared_classes();
 	debug_locks_silent = !debug_locks_verbose;
+	lockdep_set_selftest_task(current);
 
 	DO_TESTCASE_6R("A-A deadlock", AA);
 	DO_TESTCASE_6R("A-B-B-A deadlock", ABBA);
@@ -2097,5 +2098,6 @@ void locking_selftest(void)
 		printk("---------------------------------\n");
 		debug_locks = 1;
 	}
+	lockdep_set_selftest_task(NULL);
 	debug_locks_silent = 0;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

