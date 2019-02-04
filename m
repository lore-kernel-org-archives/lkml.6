Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5257CC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5A5214DA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbfBDJC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:02:27 -0500
Received: from terminus.zytor.com ([198.137.202.136]:33543 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfBDJC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:02:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x149211S358913
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 01:02:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14921fw358910;
        Mon, 4 Feb 2019 01:02:01 -0800
Date:   Mon, 4 Feb 2019 01:02:01 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Hidetoshi Seto <tipbot@zytor.com>
Message-ID: <tip-1ca4fa3ab604734e38e2a3000c9abf788512ffa7@git.kernel.org>
Cc:     ishii.shuuichir@jp.fujitsu.com, torvalds@linux-foundation.org,
        seto.hidetoshi@jp.fujitsu.com, tglx@linutronix.de,
        joe.lawrence@redhat.com, peterz@infradead.org,
        tarumizu.kohei@jp.fujitsu.com, mingo@kernel.org,
        m.mizuma@jp.fujitsu.com, efault@gmx.de,
        linux-kernel@vger.kernel.org, msys.mizuma@gmail.com, hpa@zytor.com
Reply-To: ishii.shuuichir@jp.fujitsu.com, torvalds@linux-foundation.org,
          seto.hidetoshi@jp.fujitsu.com, tglx@linutronix.de,
          joe.lawrence@redhat.com, peterz@infradead.org,
          tarumizu.kohei@jp.fujitsu.com, mingo@kernel.org,
          m.mizuma@jp.fujitsu.com, msys.mizuma@gmail.com, hpa@zytor.com,
          efault@gmx.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190129151245.5073-1-msys.mizuma@gmail.com>
References: <20190129151245.5073-1-msys.mizuma@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/debug: Initialize sd_sysctl_cpus if
 !CONFIG_CPUMASK_OFFSTACK
Git-Commit-ID: 1ca4fa3ab604734e38e2a3000c9abf788512ffa7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  1ca4fa3ab604734e38e2a3000c9abf788512ffa7
Gitweb:     https://git.kernel.org/tip/1ca4fa3ab604734e38e2a3000c9abf788512ffa7
Author:     Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
AuthorDate: Tue, 29 Jan 2019 10:12:45 -0500
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 4 Feb 2019 09:13:21 +0100

sched/debug: Initialize sd_sysctl_cpus if !CONFIG_CPUMASK_OFFSTACK

register_sched_domain_sysctl() copies the cpu_possible_mask into
sd_sysctl_cpus, but only if sd_sysctl_cpus hasn't already been
allocated (ie, CONFIG_CPUMASK_OFFSTACK is set).  However, when
CONFIG_CPUMASK_OFFSTACK is not set, sd_sysctl_cpus is left
uninitialized (all zeroes) and the kernel may fail to initialize
sched_domain sysctl entries for all possible CPUs.

This is visible to the user if the kernel is booted with maxcpus=n, or
if ACPI tables have been modified to leave CPUs offline, and then
checking for missing /proc/sys/kernel/sched_domain/cpu* entries.

Fix this by separating the allocation and initialization, and adding a
flag to initialize the possible CPU entries while system booting only.

Tested-by: Syuuichirou Ishii <ishii.shuuichir@jp.fujitsu.com>
Tested-by: Tarumizu, Kohei <tarumizu.kohei@jp.fujitsu.com>
Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190129151245.5073-1-msys.mizuma@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/debug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index de3de997e245..8039d62ae36e 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -315,6 +315,7 @@ void register_sched_domain_sysctl(void)
 {
 	static struct ctl_table *cpu_entries;
 	static struct ctl_table **cpu_idx;
+	static bool init_done = false;
 	char buf[32];
 	int i;
 
@@ -344,7 +345,10 @@ void register_sched_domain_sysctl(void)
 	if (!cpumask_available(sd_sysctl_cpus)) {
 		if (!alloc_cpumask_var(&sd_sysctl_cpus, GFP_KERNEL))
 			return;
+	}
 
+	if (!init_done) {
+		init_done = true;
 		/* init to possible to not have holes in @cpu_entries */
 		cpumask_copy(sd_sysctl_cpus, cpu_possible_mask);
 	}
