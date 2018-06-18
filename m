Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864ECC5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B71420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 04:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B71420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932575AbeFRE63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 00:58:29 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:54781 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754363AbeFRE61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 00:58:27 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.52 with ESMTP; 18 Jun 2018 13:58:26 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.125 with ESMTP; 18 Jun 2018 13:58:25 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     peterz@infradead.org, mingo@kernel.org, rostedt@goodmis.org
Cc:     tglx@linutronix.de, raistlin@linux.it,
        linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        bristot@redhat.com, kernel-team@lge.com, joel@joelfernandes.org
Subject: [RESEND PATCH v5 1/2] sched/deadline: Add cpudl_maximum_dl() for better readability
Date:   Mon, 18 Jun 2018 13:58:24 +0900
Message-Id: <1529297905-24703-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v4
 - Fix a typo in cpudl_init() of the 2nd patch

Changes from v3
 - Rebase onto the latest tip/sched/core
 - Apply what Joel suggests, to set cp->elements[0].cpu to -1
   when the heap becomes empty in cpudl_clear()

Changes from v2
 - Run spellchecker over the text and fix typos
 - Add acked-by Daniel

Changes from v1
 - Enhance commit msg
 - Prevent WARN in cpumask_test_cpu() in cpudl_find() when best_cpu == -1

-----8<-----
From 13efb279e8189e454062854fb1ce2df407543630 Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Mon, 4 Jun 2018 15:12:50 +0900
Subject: [RESEND PATCH v5 1/2] sched/deadline: Add cpudl_maximum_dl() for better
 readability

Current code uses cpudl_maximum() to get the root node's cpu, while it
directly accesses the root node to get the root node's dl. It would be
more readable and consistent between them if we provide the same way to
access them. So add a function for dl as we did it for cpu.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
---
 kernel/sched/cpudeadline.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index 5031645..ae4fbdc 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -105,11 +105,16 @@ static void cpudl_heapify(struct cpudl *cp, int idx)
 		cpudl_heapify_down(cp, idx);
 }
 
-static inline int cpudl_maximum(struct cpudl *cp)
+static inline int cpudl_maximum_cpu(struct cpudl *cp)
 {
 	return cp->elements[0].cpu;
 }
 
+static inline u64 cpudl_maximum_dl(struct cpudl *cp)
+{
+	return cp->elements[0].dl;
+}
+
 /*
  * cpudl_find - find the best (later-dl) CPU in the system
  * @cp: the cpudl max-heap context
@@ -127,12 +132,12 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
 	    cpumask_and(later_mask, cp->free_cpus, &p->cpus_allowed)) {
 		return 1;
 	} else {
-		int best_cpu = cpudl_maximum(cp);
+		int best_cpu = cpudl_maximum_cpu(cp);
 
 		WARN_ON(best_cpu != -1 && !cpu_present(best_cpu));
 
 		if (cpumask_test_cpu(best_cpu, &p->cpus_allowed) &&
-		    dl_time_before(dl_se->deadline, cp->elements[0].dl)) {
+		    dl_time_before(dl_se->deadline, cpudl_maximum_dl(cp))) {
 			if (later_mask)
 				cpumask_set_cpu(best_cpu, later_mask);
 
-- 
1.9.1

