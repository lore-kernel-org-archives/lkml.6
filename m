Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA868C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EE8206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="jKV+MIIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfAIVCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:02:54 -0500
Received: from out002.mailprotect.be ([83.217.72.86]:47265 "EHLO
        out002.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbfAIVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=gVTSyr2CW5SrFQ28tooukuObKYN06uK7ZgjBOarpHWc=; b=jKV+MIIxYmms
        xAqJIKzGFvH86/uv3Xse1aZ7AaL670x/vFC3K3JkiR8oqmGt7+ouTBdb0/6oSvLXbZCAG1R/5BIJz
        eQxwxRPj7n/aVciTQEd3QT54x6U0DOewdg+9jNs+PUB9oGhCpXV3NaL3Bz7M3tm4zar9lvzonk9m9
        XQKHig0HE/X2bCmLTPDMdIOq/kvqnud4Vq0YMZjhBxF7CJdPdNgGUn683F3N5ySzHA+DyqH8UJM2Z
        kMKK96OGVunCkkrEgXxxwY31HlC+tTqlEdS6Bq/lVIlFOY9V9STRkvVCVjKtpCj+immPjT91KRnxq
        VD16cJvgcnG0dHwHeYGRFg==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out002.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1ghKzk-0009DF-Jz; Wed, 09 Jan 2019 22:02:39 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id 8DF49C16CB;
        Wed,  9 Jan 2019 22:02:31 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     peterz@infradead.org
Cc:     mingo@redhat.com, tj@kernel.org, longman@redhat.com,
        johannes.berg@intel.com, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v6 07/16] locking/lockdep: Make it easy to detect whether or not inside a selftest
Date:   Wed,  9 Jan 2019 13:01:55 -0800
Message-Id: <20190109210204.192109-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.1.97.g81188d93c3-goog
In-Reply-To: <20190109210204.192109-1-bvanassche@acm.org>
References: <20190109210204.192109-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sWQ0QGCnIDIHJCYpthZyMl602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWyFDaym8oavoPYsm7m1mVEGf0/5ST3nkt5XYDK
 YAuRpmF7E2F3eqKXiTd2ECUghryWXlqwG31yUGf3t09vBVYS71V1Pk0aHudBU1wyWVTA5OYS1waI
 XXCBiQFDV0yen8nGcSeERs4TOTnIH1kc1IWc5eLazqbUYkjl7F1LyK0RORpPpdZNVUjgiMbKm8bg
 Pc6kSNgvEAWLFiDAlQR6Wu0I/iWDegq4fQ11AxLVlrI7DVH6GzPz+r852EXXeYX4ImMyzDg6HYuT
 CyYgL61SIkBTYXPEvhymCNb22qmKERGbL1SqvGGff0htQqhQf0/aDrhpLM4xnCPpmyyS7jgD9Nen
 VVoB/PLX+rmdznc91veCJAwpCI+5VHpzDqRcT2+GtIE8SRAgmLDKAcp9i+Q+BEiSUj07SNjVkl0P
 Pj+OUYZX3/1fKPQPEuPra72LpiTN2rUT6Y9xm3kmEG6YzhU+GhpkbBQllJXXeGX8fAMzPNqrCG8d
 f68W0InH/+bTMKNm38MHmfnhF9U/dVeZ9xbDBH3UiCDt3yfQxlhCaKc8coJFU+8pOMQJvQ/Ck3ii
 U+4DQAj38VcpxSBd167NiiR0DMS/T4GvZUhi7BJ7QOeRk66G/m8jRjgifve2wm5/91NPphLvvvzQ
 9GNh9b1TbdpjF1FTb03lcHpFIfMAJ4QVWmoS6p6qltsYPx2OGpapJQwbU6lxiSPQp1QN34zBsoOP
 LAVTMEsOC75ReJHeVybconOP07vieGH1wwKQhUuVJ6kr80wTGaiTXW7z2lMqAnbumOwh0pBt+CpM
 AQh13vqug5h3DxzBdvlUa2+UUyu7NFINUZnGH6MGqPsyY3c+PAyEW2W8OJIAiDKO1d3jsySf+J0s
 zc1uD9pAwuLhqtxw5exj8Aw7fqb5R4VemuUI6bcEARsm0JyPNwoZFF/BeruF9IPYgMLyX2cd5RrN
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
index 52b280480a08..1e82ca4982b3 100644
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
2.20.1.97.g81188d93c3-goog

