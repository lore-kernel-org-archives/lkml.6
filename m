Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69413C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AE320C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfBZPao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:30:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfBZPan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:30:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2C86930BC753;
        Tue, 26 Feb 2019 15:30:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id D9EBD60BFB;
        Tue, 26 Feb 2019 15:30:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Feb 2019 16:30:42 +0100 (CET)
Date:   Tue, 26 Feb 2019 16:30:40 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] kernel: release ptraced tasks before
 zap_pid_ns_processes
Message-ID: <20190226153039.GA21443@redhat.com>
References: <20190110175200.12442-1-avagin@gmail.com>
 <9049595f-5c48-6866-2769-96be697f9493@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9049595f-5c48-6866-2769-96be697f9493@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 26 Feb 2019 15:30:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26, Jiri Slaby wrote:
>
> On 10. 01. 19, 18:52, Andrei Vagin wrote:
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -558,12 +558,14 @@ static struct task_struct *find_alive_thread(struct task_struct *p)
> >  	return NULL;
> >  }
> >
> > -static struct task_struct *find_child_reaper(struct task_struct *father)
> > +static struct task_struct *find_child_reaper(struct task_struct *father,
> > +						struct list_head *dead)
> >  	__releases(&tasklist_lock)
> >  	__acquires(&tasklist_lock)
> >  {
> >  	struct pid_namespace *pid_ns = task_active_pid_ns(father);
> >  	struct task_struct *reaper = pid_ns->child_reaper;
> > +	struct task_struct *p, *n;
> >
> >  	if (likely(reaper != father))
> >  		return reaper;
> > @@ -579,6 +581,12 @@ static struct task_struct *find_child_reaper(struct task_struct *father)
> >  		panic("Attempted to kill init! exitcode=0x%08x\n",
> >  			father->signal->group_exit_code ?: father->exit_code);
> >  	}
> > +
> > +	list_for_each_entry_safe(p, n, dead, ptrace_entry) {
> > +		list_del_init(&p->ptrace_entry);
> > +		release_task(p);
> > +	}
> > +
>
> Hi,
>
> from our (SUSE) QA we received a report that this patch causes a
> performance decline in libmicro pthread_* benchmark as reported in:
> https://bugzilla.suse.com/show_bug.cgi?id=1126762

Access Denied

> I tried myself from the repo:
> https://github.com/redhat-performance/libMicro
>
> I ran
> pthread_create -B 8 -C 200 -S
>
> and with the patch applied:
> # STATISTICS       usecs/call (raw)          usecs/call (outliers removed)
> #                   mean     23.38611                17.29311
>
> Without:
> #                   mean     41.36539                39.21347

can't reproduce, I see the same numbers with or without this patch.
However, I did "./bin/pthread_create -B 8 -C 200 -S" under KVM.

> The benchmark seems to create 8 (-B above) pthreads, does lock/unlock in
> them and then the threads exit. The benchmark reaps the threads via
> pthread_join. This all happens 200 times (-C above).

Given that this test-case doesn't use CLONE_PID, I fail to understand how
this patch can make any noticeable difference performance wise...

with this patch forget_original_parent() just passes the additional argument
to find_child_reaper(), nothing else.

The extra list_for_each_entry_safe/release_task loop can't happen, and even
if it could it shouldn't cause any performance regression too.

> Any idea how to restore the performance close to the previous state?

maybe you can try perf to find out where does this difference come from?

Oleg.

