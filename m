Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F86C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED320881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 05:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ED320881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbeLCFbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 00:31:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:34176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725812AbeLCFbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 00:31:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F26CACB1;
        Mon,  3 Dec 2018 05:31:39 +0000 (UTC)
Date:   Sun, 2 Dec 2018 21:31:30 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        longman@redhat.com, andrea.parri@amarulasolutions.com
Subject: [PATCH -tip] kernel/sched,wake_q: Branch predict wake_q_add() cmpxchg
Message-ID: <20181203053130.gwkw6kg72azt2npb@linux-r8p5>
References: <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
 <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
 <20181129221714.GF11632@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181129221714.GF11632@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cmpxchg will fail when the task is already in the process
of waking up, and as such is an extremely rare occurrence.
Micro-optimize the call and put an unlikely() around it.

To no surprise, when using CONFIG_PROFILE_ANNOTATED_BRANCHES
under a number of workloads the incorrect rate was a mere 1-2%.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 091e089063be..f7747cf6e427 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -408,7 +408,7 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
 	 * This cmpxchg() executes a full barrier, which pairs with the full
 	 * barrier executed by the wakeup in wake_up_q().
 	 */
-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
+	if (unlikely(cmpxchg(&node->next, NULL, WAKE_Q_TAIL)))
 		return;
 
 	get_task_struct(task);
-- 
2.16.4

