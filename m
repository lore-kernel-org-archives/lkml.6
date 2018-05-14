Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752615AbeENLIJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 07:08:09 -0400
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:39411 "EHLO
        forwardcorp1j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752028AbeENLIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 07:08:06 -0400
Authentication-Results: smtpcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH] sched: refill quota for current period when refilling timer
 activates
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Ben Segall <bsegall@google.com>
Date: Mon, 14 May 2018 13:58:23 +0300
Message-ID: <152629550328.178124.4904326637886063654.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Period timer deactivates if task group has no activity during past period,
i.e. if were no throttle and runtime from global pool weren't consumed.
When timer activates back global pool contains unpredictable amount of
expired runtime allocated long ago. In some cases this works fine and
task could use it until next refill. But series short execution slices
could drain all that leftovers because each switch expires local poll.
In this case task group will be throttled until quota refill.

This patch refills quota right at the moment of timer's activation.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 kernel/sched/fair.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 79f574dba096..b8d73ed17ff6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5165,6 +5165,8 @@ void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 
 	if (!cfs_b->period_active) {
 		cfs_b->period_active = 1;
+		/* refill quota for current period after inactivity */
+		__refill_cfs_bandwidth_runtime(cfs_b);
 		hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 		hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
 	}
