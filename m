Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3039BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0145F208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0145F208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbeKODAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:00:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbeKODAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:00:33 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6E33E80462;
        Wed, 14 Nov 2018 16:56:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B1D519744;
        Wed, 14 Nov 2018 16:56:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Nov 2018 17:56:34 +0100 (CET)
Date:   Wed, 14 Nov 2018 17:56:32 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] cgroup: cgroup v2 freezer
Message-ID: <20181114165631.GE13885@redhat.com>
References: <20181112230422.5911-1-guro@fb.com>
 <20181112230422.5911-5-guro@fb.com>
 <20181113154825.GC30990@redhat.com>
 <20181113215919.GC15590@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113215919.GC15590@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 14 Nov 2018 16:56:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 11/13, Roman Gushchin wrote:
>
> > > +#define TASK_FROZEN			0x1000
> > > +#define TASK_STATE_MAX			0x2000
> >
> > Just noticed the new task state... Why? Can't we avoid it?
>
> We can, but it's nice to show to userspace that tasks are frozen,
> rather than just stuck somewhere in the kernel...

But then you need to change get_task_state() too. Which iiuc could
probably check ->frozen along with ->state.

I do not think the new task state is a good idea, at least I would like
to ask you to make a separate patch which we can discuss separately.


> > > +	set_current_state(TASK_WAKEKILL | TASK_INTERRUPTIBLE | TASK_FROZEN);
> >
> > Why not __set_current_state() ?
>
> Hm, it's not a hot path at all, so set_current_state() is good enough.
> Not a strong preference, of course.

It is not about performance, to me set_current_state() looks as if we need
a memory barrier for some obscure/undocumented reason and this doesn't help
to understand the code.

> > If ->state include TASK_INTERRUPTIBLE, why do we need TASK_WAKEKILL?
> >
> > And again, why TASK_FROZEN?
>
> So, should it be just TASK_INTERRUPTIBLE | TASK_FROZEN ?

Again, TASK_FROZEN is pointless at least until you change fs/proc or until
you have wake_up_state(TASK_FROZEN). May be cgroup_do_freeze() and/or
ptrace_attach() could use it, but see above, I'd suggest to make another
patch.

Looks like you need TASK_KILLABLE, see below.

> > > +	clear_thread_flag(TIF_SIGPENDING);
> > > +	schedule();
> > > +	recalc_sigpending();
> >
> > I simply can't understand these 3 lines above but I bet this is not correct ;)
>
> So, yeah, the problem is that if there is TIF_SIGPENDING bit set, schedule()
> will return immediately, so we're getting pretty much a busy loop here.

I suspected this answer ;)

> This is a nasty workaround.

No, this is very wrong. Just suppose the caller is killed right before
clear_thread_flag(TIF_SIGPENDING).

> I believe we can clear and not call recalc_sigpending() at all. Does this seem
> to be correct?

I think you need to simply remove both clear_thread_flag() and recalc_sigpending().
If schedule() is called in TASK_KILLABLE state it will return only if
fatal_signal_pending() is true, and this is what we want, right?

OK, it seems you are going to make the new version anyway, so I can wait for it
and not read this series ;)

Oleg.

