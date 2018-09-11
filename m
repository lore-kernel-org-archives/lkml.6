Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310DC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26620854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kaq4iFAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C26620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeIKOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:50:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59074 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeIKOuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:50:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=X8dwrA/MQjdPOv6z3KzheZB6CWnKOqpvZtUMUMkiqmQ=; b=kaq4iFAi8B7fxwy5uamet23Eq
        Um3sIU6PY09R2lYCgks1/DZa4CUCAmXGH/Ob5T2AMEqUcNlLydJQZpZDYWSvhNg0McwDZpXMCvH+3
        N+zHWl6qw2qvzdEvpXkwghhtas+dIK68dfj9qOXVVBW6+eY3MDokADITZ/W96jxpllhNY0qcZsLrL
        7astto6k9PSDeYLxN9M4WR6jcFwrmYMT8NhWvxkhZtYNrD6Diu/ODy2JJlytDd0OEx0g5YwYJ62Vp
        HZ2t8MSxWGJzj6BqJOT+pzLQKqQGV+7ztw2tYhrEwlIigmp8AR84y1hiaM21rT/VObWwZpmxxP7B/
        ZDPf4cHQA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fzfKS-0005J6-MK; Tue, 11 Sep 2018 09:51:28 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B8E52057F828; Tue, 11 Sep 2018 11:51:27 +0200 (CEST)
Date:   Tue, 11 Sep 2018 11:51:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        torvalds@linux-foundation.org, mingo@kernel.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:locking/core] jump_label/lockdep: Assert we hold the
 hotplug lock for _cpuslocked() operations
Message-ID: <20180911095127.GT24082@hirez.programming.kicks-ass.net>
References: <tip-cb538267ea1e9e025ec692577c9ae75797261889@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-cb538267ea1e9e025ec692577c9ae75797261889@git.kernel.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 03:09:29AM -0700, tip-bot for Peter Zijlstra wrote:
> Commit-ID:  cb538267ea1e9e025ec692577c9ae75797261889
> Gitweb:     https://git.kernel.org/tip/cb538267ea1e9e025ec692577c9ae75797261889
> Author:     Peter Zijlstra <peterz@infradead.org>
> AuthorDate: Tue, 31 Jul 2018 14:35:32 +0200
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 10 Sep 2018 10:16:38 +0200
> 
> jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations
> 
> Weirdly we seem to have forgotten this...

This of course instantly triggered a false positive :/

---
Subject: lockdep,cpu/hotplug: Annotate AP thread

Anybody trying to assert the cpu_hotplug_lock is held
(lockdep_assert_cpus_held()) from AP callbacks will fail, because the
lock is held by the BP.

Stick in an explicit annotation in cpuhp_thread_fun() to make this work.

Fixes: cb538267ea1e ("jump_label/lockdep: Assert we hold the hotplug lock for _cpuslocked() operations")
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/cpu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0097acec1c71..08c168b159da 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -616,6 +616,12 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	 */
 	smp_mb();
 
+	/*
+	 * The BP holds the hotplug lock, but we're now running on the AP,
+	 * ensure that anybody asserting the lock is held, will actually find
+	 * it so.
+	 */
+	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
 	cpuhp_lock_acquire(bringup);
 
 	if (st->single) {
@@ -661,6 +667,7 @@ static void cpuhp_thread_fun(unsigned int cpu)
 	}
 
 	cpuhp_lock_release(bringup);
+	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, 1, _THIS_IP_);
 
 	if (!st->should_run)
 		complete_ap_thread(st, bringup);
