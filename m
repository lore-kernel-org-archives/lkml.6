Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F244CC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B675B20645
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B675B20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbeJNXVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:21:49 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36250 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728094AbeJNXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:12:02 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLq-0004cU-62; Sun, 14 Oct 2018 16:30:42 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLX-0000WJ-ED; Sun, 14 Oct 2018 16:30:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ingo Molnar" <mingo@kernel.org>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.122664497@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 263/366] sched/autogroup: Fix possible Spectre-v1
 indexing for sched_prio_to_weight[]
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

From: Peter Zijlstra <peterz@infradead.org>

commit 354d7793070611b4df5a79fbb0f12752d0ed0cc5 upstream.

> kernel/sched/autogroup.c:230 proc_sched_autogroup_set_nice() warn: potential spectre issue 'sched_prio_to_weight'

Userspace controls @nice, sanitize the array index.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/sched/auto_group.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/kernel/sched/auto_group.c
+++ b/kernel/sched/auto_group.c
@@ -8,6 +8,7 @@
 #include <linux/utsname.h>
 #include <linux/security.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 unsigned int __read_mostly sysctl_sched_autogroup_enabled = 1;
 static struct autogroup autogroup_default;
@@ -198,7 +199,7 @@ int proc_sched_autogroup_set_nice(struct
 	static unsigned long next = INITIAL_JIFFIES;
 	struct autogroup *ag;
 	unsigned long shares;
-	int err;
+	int err, idx;
 
 	if (nice < MIN_NICE || nice > MAX_NICE)
 		return -EINVAL;
@@ -216,7 +217,9 @@ int proc_sched_autogroup_set_nice(struct
 
 	next = HZ / 10 + jiffies;
 	ag = autogroup_task_get(p);
-	shares = scale_load(prio_to_weight[nice + 20]);
+
+	idx = array_index_nospec(nice + 20, 40);
+	shares = scale_load(prio_to_weight[idx]);
 
 	down_write(&ag->lock);
 	err = sched_group_set_shares(ag->tg, shares);

