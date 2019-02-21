Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60739C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DE320818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfBUQ31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:29:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33827 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbfBUQ31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:29:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 573A681106;
        Thu, 21 Feb 2019 16:29:26 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.152])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0584C5D9D3;
        Thu, 21 Feb 2019 16:29:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Feb 2019 17:29:26 +0100 (CET)
Date:   Thu, 21 Feb 2019 17:29:24 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Roman Gushchin <guroan@gmail.com>, Tejun Heo <tj@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 0/7] freezer for cgroup v2
Message-ID: <20190221162923.GA26064@redhat.com>
References: <20190219220252.4906-1-guro@fb.com>
 <20190220143748.GA9477@redhat.com>
 <20190220220020.GA16335@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220220020.GA16335@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 21 Feb 2019 16:29:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20, Roman Gushchin wrote:
>
> On Wed, Feb 20, 2019 at 03:37:48PM +0100, Oleg Nesterov wrote:
> >
> > I tried to not argue with intent, but to be honest I am more and more
> > sceptical... Lets forget about ptrace for the moment.
> >
> > Once again, why do we want a killable freezer?
> >
> > If a user wants to kill a frozen task from CGRP_FROZEN cgroup he can simply
> >
> > 	1. send SIGKILL to that task
> >
> > 	2. migrate it to the root cgroup.
> >
> > why this doesn't / can't work?
>
> It does work, but it doesn't look as a nice interface to take into
> the cgroup v2 world.
>
> It just not clear, why killing a frozen task requires some cgroup-level
> operations? It doesn't add anything except some additional complexity
> to the userspace.

Yes.

But to me this is a reasonable trade-off because this way we do not add
additional complexity to the kernel.

Actually, "killable" is not that difficult afaics. "ptraceable" looks more
problematic to me. Again, user-space can do

	1. PTRACE_SEIZE
	2. move the tracee to the root cgroup
	3. do anything with the tracee
	4. move it back

> Generally speaking, any process hanging in D-state
> for a long time isn't the nicest object from the userspace's point of view.

Roman, this is unfair comparison ;)

> Exactly as a SIGSTOPped process can be killed without sending SIGCONT,
> why a frozen task would require some additional operations?

this too,

> And I'm not talking about the case, when the process which is sending
> SIGKILL has no write access to cgroupfs.

True.

But there is another case. If admin wants to freeze a cgroup then it is not
clear why a user which can send SIGKILL to a frozen process should wake it up.

------------------------------------------------------------------------------
Again, it is not that I hate the idea of killable/ptraceable freezer. Just I
personally think it's not worth the trouble. Perhaps I am wrong, but so far
I do not see a good implementation...

And, apart from reading/writing the registers, what can ptrace do with a frozen
tracee? This doesn't look like a "must have" feature to me.

At least, may I ask you again to make (if possible) a separate patch which adds
the ability to kill/ptrace?
------------------------------------------------------------------------------

> > Why I am starting to argue... The ability to kill a frozen task complicates
> > the code, and since cgroup_enter_stopped() (in this version at least) doesn't
> > properly interacts with freezable_schedule() leads to other problems.
> >
> > From 7/7:
> >
> > 	+  cgroup.freeze
> > 	+	A read-write single value file which exists on non-root cgroups.
> > 	+	Allowed values are "0" and "1". The default is "0".
> > 	+
> > 	+	Writing "1" to the file causes freezing of the cgroup and all
> > 	+	descendant cgroups. This means that all belonging processes will
> > 	+	be stopped and will not run until the cgroup will be explicitly
> > 	+	unfrozen. Freezing of the cgroup may take some time;
> >                                                  ^^^^^^^^^^^^^^^^^^
> > it may take infinite time.
> >
> > Just suppose that a task does vfork() and this races with cgroup_do_freeze(true).
> > If the new child notices JOBCTL_TRAP_FREEZE before exit/exec the cgroup will be
> > never frozen.
>
> Hm, why? cgroup_update_frozen() called from cgroup_post_fork() should bring
> the cgroup into the frozen state. If it's not true (I'm missing some race here),
> it's a bug, but I don't see why it's not possible in general.

A task P calls vfork() and creates the new child C. Now, how can the parent P
(which sleeps in TASK_KILLABLE) call cgroup_enter_stopped() ? It can't until C
exits or execs. C can't exit or exec because it is frozen.

> > If I read the current kernel/cgroup/freezer.c correctly, CGROUP_FREEZING should
> > "always" work (unless a task hangs in D state) and to me this looks more important
> > than kill/ptrace support...
>
> Again, I don't see a case, when cgroup v1 freezer will work and the proposed
> v2 freezer won't work in general.

See above.

Oleg.

