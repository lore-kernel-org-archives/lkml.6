Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77416C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225D123F00
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225D123F00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933739AbeGCQDG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:03:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932531AbeGCQDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:03:03 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC8E723EDE;
        Tue,  3 Jul 2018 16:03:02 +0000 (UTC)
Date:   Tue, 3 Jul 2018 12:03:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        Claudio Scordino <claudio@evidence.eu.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] sched/deadline: Add update_rq_clock(later_rq) in
 push_dl_task()
Message-ID: <20180703120301.3667f418@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Running tests on the deadline scheduler I triggered a WARN_ON() in
assert_clock_updated(). Unfortunately, this caused printk() to try
to wake up the klogd which caused a nasty deadlock. All I got out of
the output was:

 "------------[ cut here ]------------"

But a bit of tweaking of where the 'cut here' prints were, I was able
to find the source. The warning is triggered by:

 push_dl_task {
 	add_running_bw() {
 		__add_running_bw() {
 			cpufreq_update_util() {
 				data->func(data, rq_clock(rq), flags);
 				rq_clock() {
 					assert_clock_updated()

The rq_clock() is called on the rq of the CPU that is being pushed to.
There's no guarantee that it has been updated at this time. Since we
have the rq lock of that rq, the CPU doing the push can update the
clock to make sure that it is up-to-date before proceeding to do the
push.

Link: http://lkml.kernel.org/r/20180703105449.2a211fb2@gandalf.local.home
Suggested-by: Juri Lelli <juri.lelli@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index fbfc3f1d368a..90b6e9df79b2 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2085,6 +2085,8 @@ static int push_dl_task(struct rq *rq)
 		goto retry;
 	}
 
+	update_rq_clock(later_rq);
+
 	deactivate_task(rq, next_task, 0);
 	sub_running_bw(&next_task->dl, &rq->dl);
 	sub_rq_bw(&next_task->dl, &rq->dl);
