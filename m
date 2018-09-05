Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE658C4321E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FD2B20890
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD2B20890
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeIEQ6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeIEQ6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:58:41 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC25020881;
        Wed,  5 Sep 2018 12:28:38 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fxWvF-0002GG-PG; Wed, 05 Sep 2018 08:28:37 -0400
Message-Id: <20180905122837.674583106@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 05 Sep 2018 08:28:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        tom.zanussi@linux.intel.com, stable-rt@vger.kernel.org,
        Mike Galbraith <efault@gmx.de>
Subject: [PATCH RT 20/22] sched: Allow pinned user tasks to be awakened to the CPU they pinned
References: <20180905122754.443196118@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14.63-rt41-rc1 stable review patch.
If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

[ Upstream commit cd4d35ef89948221f7cd1751cee453943967364c ]

Since commit 7af443ee16976 ("sched/core: Require cpu_active() in
select_task_rq(), for user tasks") select_fallback_rq() will BUG() if
the CPU to which a task has pinned itself and pinned becomes
!cpu_active() while it slept.
The task will continue running on the to-be-removed CPU and will remove
itself from the CPU during takedown_cpu() (while cpuhp_pin_lock will be
acquired) and move to another CPU based on its mask after the
migrate_disable() section has been left.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a5ce37b90fca..6e6bd5262f23 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -980,7 +980,7 @@ static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
 		return false;
 
-	if (is_per_cpu_kthread(p))
+	if (is_per_cpu_kthread(p) || __migrate_disabled(p))
 		return cpu_online(cpu);
 
 	return cpu_active(cpu);
-- 
2.18.0


