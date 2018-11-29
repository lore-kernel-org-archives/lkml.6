Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E95C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563592082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 563592082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbeK3IlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:41:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:52692 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726374AbeK3IlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:41:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FA83ABB1;
        Thu, 29 Nov 2018 21:34:29 +0000 (UTC)
Date:   Thu, 29 Nov 2018 13:34:21 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>,
        Yongji Xie <elohimes@gmail.com>, mingo@redhat.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        xieyongji@baidu.com, zhangyu31@baidu.com, liuqi16@baidu.com,
        yuanlinsi01@baidu.com, nixun@baidu.com, lilin24@baidu.com,
        longman@redhat.com
Subject: Re: [RFC] locking/rwsem: Avoid issuing wakeup before setting the
 reader waiter to nil
Message-ID: <20181129213421.wwvhsjql3m3lvtv4@linux-r8p5>
References: <1543495830-2644-1-git-send-email-xieyongji@baidu.com>
 <20181129131232.GN2131@hirez.programming.kicks-ass.net>
 <5598cd71-c3c8-d6ef-eb30-777cf901a2ef@redhat.com>
 <20181129160627.GU2131@hirez.programming.kicks-ass.net>
 <8cc45695-b325-a219-8b46-d5da6ddfdd63@redhat.com>
 <20181129172700.GA11632@hirez.programming.kicks-ass.net>
 <20181129180828.GA11650@hirez.programming.kicks-ass.net>
 <729ceddb-dd9a-ec2a-f74e-03fa4d7e65e8@redhat.com>
 <20181129213017.v3eljor54lfpoug2@linux-r8p5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181129213017.v3eljor54lfpoug2@linux-r8p5>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I messed up something such that waiman was not in the thread. Ccing.

>On Thu, 29 Nov 2018, Waiman Long wrote:
>
>>That can be costly for x86 which will now have 2 locked instructions.
>
>Yeah, and when used as an actual queue we should really start to notice.
>Some users just have a single task in the wake_q because avoiding the cost
>of wake_up_process() with locks held is significant.
>
>How about instead of adding the barrier before the cmpxchg, we do it
>in the failed branch, right before we return. This is the uncommon
>path.
>
>Thanks,
>Davidlohr
>
>diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>index 091e089063be..0d844a18a9dc 100644
>--- a/kernel/sched/core.c
>+++ b/kernel/sched/core.c
>@@ -408,8 +408,14 @@ void wake_q_add(struct wake_q_head *head, struct task_struct *task)
>	 * This cmpxchg() executes a full barrier, which pairs with the full
>	 * barrier executed by the wakeup in wake_up_q().
>	 */
>-	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL))
>+	if (cmpxchg(&node->next, NULL, WAKE_Q_TAIL)) {
>+		/*
>+		 * Ensure, that when the cmpxchg() fails, the corresponding
>+		 * wake_up_q() will observe our prior state.
>+		 */
>+		smp_mb__after_atomic();
>		return;
>+	}
>
>	get_task_struct(task);
>
