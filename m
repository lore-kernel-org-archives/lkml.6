Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E7ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B4D20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="c7UB4Qku"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B4D20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbeGXQ6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:58:33 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34822 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388289AbeGXQ6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:58:32 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so1807537ybm.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jj9PUN9+FJBMWWUulO+Z0+YP6u7vXi2omKcLphrSOYU=;
        b=c7UB4Qku9Iaf5x4CEZM3Ud3RAFrD6uJHfIpHYF3vh3E03v1J7EN2Jfvtae1zuSN1o9
         6Ut5kcgoV5SybOXGWvgynXvYHRwzCVSndARKM0ACPVV3c10gujrWTkzZY5cyO72IkEez
         HwOXZcsMCpavG+UJDGTTT+KsJSn/67/a6wiYUqHOMnukDNeqxweacl7QlN6fabtZS0X2
         uayrXjr3g5E8U01WvdnTKaxxQcja8Td84+K52EKmMup2P9AonhSviJcz7SNjhyI/8+bu
         fuvaR0zSMkinUwDRHzTDfaOaGkhTLMse+s6LIax016NA/VRbBCWshYj7WaxWnceAAHEg
         Je2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jj9PUN9+FJBMWWUulO+Z0+YP6u7vXi2omKcLphrSOYU=;
        b=QDj9qZF8B5U6CRqrtc/gPZzqvrCHef6UJ6rPOO89NITo+RCORa2/XlBOFj7MDHywhq
         OryHtZh7sqdKamTi+r2JWDoUkuGbkQfDxtyRhdhVkIvqJGsbg5HvLk7YD883zsju0X/s
         bO1noliTMfBIEGZ6qhm0Wt4k5cwQxE7Ri6Afs1J9on3/8U65VyGFSGstt6rewm4fuyUp
         iPfLXNjZ6/QvB6RSgcq1ERJ6sFWr3YA1dsnwQUN40B3t09vMT3FUBkaiwc1M3lomCk+Z
         aGac3mvY7tYKB7C0pHW+aJrGl5xx4DwKb/+ege1wvwc2KSncYB2ZcYTFT23fCbreq0RE
         rKlQ==
X-Gm-Message-State: AOUpUlFEd7htZiMv4k+3H2XMvFMz4rT083kSP+e/5wXiIYEXlB4D5va7
        KYRIF7kcZVvGIeVa/fCQq/AKjQ==
X-Google-Smtp-Source: AAOMgpfAbklHXXYI/O0IIZx9PaF9PbuSbLRuM158XYokrPZZOuADh43aa9uHS4isE6KBPX0KK+E1xg==
X-Received: by 2002:a25:35c4:: with SMTP id c187-v6mr9525224yba.283.1532447486008;
        Tue, 24 Jul 2018 08:51:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:c07])
        by smtp.gmail.com with ESMTPSA id d143-v6sm5918499ywe.60.2018.07.24.08.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 08:51:24 -0700 (PDT)
Date:   Tue, 24 Jul 2018 11:54:15 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 09/10] psi: cgroup support
Message-ID: <20180724155415.GB11598@cmpxchg.org>
References: <20180712172942.10094-1-hannes@cmpxchg.org>
 <20180712172942.10094-10-hannes@cmpxchg.org>
 <20180717154059.GB2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717154059.GB2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Jul 17, 2018 at 05:40:59PM +0200, Peter Zijlstra wrote:
> On Thu, Jul 12, 2018 at 01:29:41PM -0400, Johannes Weiner wrote:
> > +/**
> > + * cgroup_move_task - move task to a different cgroup
> > + * @task: the task
> > + * @to: the target css_set
> > + *
> > + * Move task to a new cgroup and safely migrate its associated stall
> > + * state between the different groups.
> > + *
> > + * This function acquires the task's rq lock to lock out concurrent
> > + * changes to the task's scheduling state and - in case the task is
> > + * running - concurrent changes to its stall state.
> > + */
> > +void cgroup_move_task(struct task_struct *task, struct css_set *to)
> > +{
> > +	unsigned int task_flags = 0;
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +	u64 now;
> > +
> > +	rq = task_rq_lock(task, &rf);
> > +
> > +	if (task_on_rq_queued(task)) {
> > +		task_flags = TSK_RUNNING;
> > +	} else if (task->in_iowait) {
> > +		task_flags = TSK_IOWAIT;
> > +	}
> > +	if (task->flags & PF_MEMSTALL)
> > +		task_flags |= TSK_MEMSTALL;
> > +
> > +	if (task_flags) {
> > +		update_rq_clock(rq);
> > +		now = rq_clock(rq);
> > +		psi_task_change(task, now, task_flags, 0);
> > +	}
> > +
> > +	/*
> > +	 * Lame to do this here, but the scheduler cannot be locked
> > +	 * from the outside, so we move cgroups from inside sched/.
> > +	 */
> > +	rcu_assign_pointer(task->cgroups, to);
> > +
> > +	if (task_flags)
> > +		psi_task_change(task, now, 0, task_flags);
> > +
> > +	task_rq_unlock(rq, task, &rf);
> > +}
> 
> Why is that not part of cpu_cgroup_attach() / sched_move_task() ?

Hm, there is some overlap, but it's not the same operation.

cpu_cgroup_attach() handles rq migration between cgroups that have the
cpu controller enabled, but psi needs to migrate task counts around
for memory and IO as well, as we always need to know nr_runnable.

The cpu controller is super expensive, though, and e.g. we had to
disable it for cost purposes while still running psi, so it wouldn't
be great to need full hierarchical per-cgroup scheduling policy just
to know the runnable count in a group.

Likewise, I don't think we'd want to change the cgroup core to call
->attach for *all* cgroups and have the callback figure out whether
the controller is actually enabled on them or not for this one case.
