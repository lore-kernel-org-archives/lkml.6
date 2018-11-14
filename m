Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EEFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A2512082A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 02:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaN44D4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A2512082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732613AbeKNMsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 07:48:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732588AbeKNMsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 07:48:03 -0500
Received: from lerouge.suse.de (lfbn-ncy-1-241-207.w83-194.abo.wanadoo.fr [83.194.85.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 276572243E;
        Wed, 14 Nov 2018 02:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542163612;
        bh=8ioHrvVqMotMEuuyPe4OPeiwEZhcyver40glMmEgXmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NaN44D4n9zXmXv1afFKqt38lVYa5geZ82H2EEKVI5Fiw6d5rePAfEimFfUxmrhk0w
         n1eX2zpW88rkeVDirJX5IOyTRozvF+5SuyJo3Pr80k5E1M440aD00+MA7yo+v+nH9V
         ZueCY46Xpy7L8gcXaWG5rkHNSE5IvlS/Lytp7BbY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@redhat.com>
Subject: [PATCH 16/25] sched/cputime: Allow to pass cputime index on user/guest accounting
Date:   Wed, 14 Nov 2018 03:46:00 +0100
Message-Id: <1542163569-20047-17-git-send-email-frederic@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542163569-20047-1-git-send-email-frederic@kernel.org>
References: <1542163569-20047-1-git-send-email-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we account user or guest cputime, we decide to add the delta either
to the nice fields or the normal fields of kcpustat and this depends on
the nice value for the task passed in parameter.

Since we are going to track the nice-ness from vtime instead, we'll need
to be able to use a different source than the task passed in parameter
on accounting time. So allow the callers of account_user/guest_time() to
pass custom kcpustat destination index fields.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cputime.c | 50 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 61aa7ba..63c4f0b 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -108,6 +108,20 @@ static inline void task_group_account_field(struct task_struct *p, int index,
 	cgroup_account_cputime_field(p, index, tmp);
 }
 
+static void account_user_time_index(struct task_struct *p,
+				    u64 cputime, enum cpu_usage_stat index)
+{
+	/* Add user time to process. */
+	p->utime += cputime;
+	account_group_user_time(p, cputime);
+
+	/* Add user time to cpustat. */
+	task_group_account_field(p, index, cputime);
+
+	/* Account for user time used */
+	acct_account_cputime(p);
+}
+
 /*
  * Account user CPU time to a process.
  * @p: the process that the CPU time gets accounted to
@@ -115,27 +129,14 @@ static inline void task_group_account_field(struct task_struct *p, int index,
  */
 void account_user_time(struct task_struct *p, u64 cputime)
 {
-	int index;
-
-	/* Add user time to process. */
-	p->utime += cputime;
-	account_group_user_time(p, cputime);
+	enum cpu_usage_stat index;
 
 	index = (task_nice(p) > 0) ? CPUTIME_NICE : CPUTIME_USER;
-
-	/* Add user time to cpustat. */
-	task_group_account_field(p, index, cputime);
-
-	/* Account for user time used */
-	acct_account_cputime(p);
+	account_user_time_index(p, cputime, index);
 }
 
-/*
- * Account guest CPU time to a process.
- * @p: the process that the CPU time gets accounted to
- * @cputime: the CPU time spent in virtual machine since the last update
- */
-void account_guest_time(struct task_struct *p, u64 cputime)
+static void account_guest_time_index(struct task_struct *p,
+				     u64 cputime, enum cpu_usage_stat index)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
 
@@ -145,7 +146,7 @@ void account_guest_time(struct task_struct *p, u64 cputime)
 	p->gtime += cputime;
 
 	/* Add guest time to cpustat. */
-	if (task_nice(p) > 0) {
+	if (index == CPUTIME_GUEST_NICE) {
 		cpustat[CPUTIME_NICE] += cputime;
 		cpustat[CPUTIME_GUEST_NICE] += cputime;
 	} else {
@@ -155,6 +156,19 @@ void account_guest_time(struct task_struct *p, u64 cputime)
 }
 
 /*
+ * Account guest CPU time to a process.
+ * @p: the process that the CPU time gets accounted to
+ * @cputime: the CPU time spent in virtual machine since the last update
+ */
+void account_guest_time(struct task_struct *p, u64 cputime)
+{
+	enum cpu_usage_stat index;
+
+	index = (task_nice(p) > 0) ? CPUTIME_GUEST_NICE : CPUTIME_GUEST;
+	account_guest_time_index(p, cputime, index);
+}
+
+/*
  * Account system CPU time to a process and desired cpustat field
  * @p: the process that the CPU time gets accounted to
  * @cputime: the CPU time spent in kernel space since the last update
-- 
2.7.4

