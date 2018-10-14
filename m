Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE5EC71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA6C20835
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FA6C20835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbeJNXMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:12:08 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36353 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbeJNXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:06 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLr-0004cm-Fn; Sun, 14 Oct 2018 16:30:43 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000W5-DI; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mike Galbraith" <efault@gmx.de>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        "linux-man" <linux-man@vger.kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Mike Galbraith" <umgwanakikbuti@gmail.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.563310568@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 262/366] sched/autogroup: Fix 64-bit kernel nice
 level adjustment
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Galbraith <efault@gmx.de>

commit 83929cce95251cc77e5659bf493bd424ae0e7a67 upstream.

Michael Kerrisk reported:

> Regarding the previous paragraph...  My tests indicate
> that writing *any* value to the autogroup [nice priority level]
> file causes the task group to get a lower priority.

Because autogroup didn't call the then meaningless scale_load()...

Autogroup nice level adjustment has been broken ever since load
resolution was increased for 64-bit kernels.  Use scale_load() to
scale group weight.

Michael Kerrisk tested this patch to fix the problem:

> Applied and tested against 4.9-rc6 on an Intel u7 (4 cores).
> Test setup:
>
> Terminal window 1: running 40 CPU burner jobs
> Terminal window 2: running 40 CPU burner jobs
> Terminal window 1: running  1 CPU burner job
>
> Demonstrated that:
> * Writing "0" to the autogroup file for TW1 now causes no change
>   to the rate at which the process on the terminal consume CPU.
> * Writing -20 to the autogroup file for TW1 caused those processes
>   to get the lion's share of CPU while TW2 TW3 get a tiny amount.
> * Writing -20 to the autogroup files for TW1 and TW3 allowed the
>   process on TW3 to get as much CPU as it was getting as when
>   the autogroup nice values for both terminals were 0.

Reported-by: Michael Kerrisk <mtk.manpages@gmail.com>
Tested-by: Michael Kerrisk <mtk.manpages@gmail.com>
Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-man <linux-man@vger.kernel.org>
Link: http://lkml.kernel.org/r/1479897217.4306.6.camel@gmx.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: s/sched_prio_to_weight/prio_to_weight/]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/sched/auto_group.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/sched/auto_group.c
+++ b/kernel/sched/auto_group.c
@@ -197,6 +197,7 @@ int proc_sched_autogroup_set_nice(struct
 {
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
+	unsigned long shares;
 	int err;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
@@ -215,9 +216,10 @@ int proc_sched_autogroup_set_nice(struct
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
+	shares = scale_load(prio_to_weight[nice + 20]);
 
 	down_write(&ag->lock);
-	err = sched_group_set_shares(ag->tg, prio_to_weight[nice + 20]);
+	err = sched_group_set_shares(ag->tg, shares);
 	if (!err)
 		ag->nice = nice;
 	up_write(&ag->lock);

