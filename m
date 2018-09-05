Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B91C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B1720867
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 02:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B1720867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeIEHGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 03:06:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbeIEHGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 03:06:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5B65B81DED;
        Wed,  5 Sep 2018 02:38:37 +0000 (UTC)
Received: from sky.random (ovpn-120-15.rdu2.redhat.com [10.10.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B52E3600C1;
        Wed,  5 Sep 2018 02:38:33 +0000 (UTC)
Date:   Tue, 4 Sep 2018 22:38:32 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     "Schaufler, Casey" <casey.schaufler@intel.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v3 1/3] ptrace: Provide ___ptrace_may_access() that can
 be applied on arbitrary tasks
Message-ID: <20180905023832.GM4762@redhat.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
 <20180904233714.GJ4762@redhat.com>
 <99FC4B6EFCEFD44486C35F4C281DC6732144723D@ORSMSX107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC6732144723D@ORSMSX107.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 05 Sep 2018 02:38:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 01:00:37AM +0000, Schaufler, Casey wrote:
> Sorry, I've been working in security too long for my
> optimistic streak to be very wide.

Eheh. So I was simply trying to follow in context, but it wasn't
entirely clear, so I tried to take it out of context and then it was
even less clear, never mind I was only looking for some more
explanation.

> Not especially, no. I have gotten considerable feedback that
> it should be configurable, and while I may not see the value myself,
> I do respect the people who've requested the configurability.

Correct me if I'm wrong, but LSM as last word "module" implies to make
this logic modular.

My wondering is because:

1) why not just a single version of this logic in the scheduler?
   (i.e. can only be on or off or perhaps a only-ibpb-dumpable tweak
   to retain current slightly higher perf but less secure behavior)

2) even if you want a myriad of versions of this IBPB logic, how do
   the different versions can possibly fit in a whole "module" whose
   semantics have pretty much nothing to do with the other methods in
   the module like LSM_HOOK_INIT(capable, cap_capable),
   LSM_HOOK_INIT(vm_enough_memory, cap_vm_enough_memory), and
   LSM_HOOK_INIT(mmap_addr, cap_mmap_addr), or even
   LSM_HOOK_INIT(inode_follow_link, selinux_inode_follow_link),
   LSM_HOOK_INIT(inode_permission, selinux_inode_permission). I mean
   it looks an apple to oranges monolithic link in the same module. Or
   are you going to load this method in a separate module with only a
   single method implemented and then load multiple LSM modules at the
   same time?

3) if you need so much tweaking that not even a single off/on switch
   independent of any module loaded through LSM is not enough, how is
   it ok that all the rest shouldn't be configurable? All the rest has
   more performance impact than this one so it'd start from there if
   something.

I understand how configurablity is valuable (this is why we kept
everything dynamic tunable at runtime, including the PTI stop machine
to allow even PTI TLB flushes to be turned off).

I'm just trying to understand how IBPB fits in a LSM module
implementation.

Even if you build with CONFIG_SECURITY=n PTI won't go away, retpoline
won't go away, the l1flush in vmenter won't go away, the
pte/transhugepmd inversion won't go away, why only the runtime
tunability or tweaking of IBPB fits in a LSM module?

> If they provide different answers there should be different
> functions. It's a question of viewpoint. If you don't care about
> the SELinux viewpoint you shouldn't have to include it in your
> checks, any more than you care about x86 issues when you're
> running on a MIPS processor.

I don't see how selinux fits into this. Selinux doesn't affect virtual
memory protection. Not having selinux even built in doesn't mean you
are ok with virtual memory protection not being provided by the CPU.

Or in other words selinux fits into this as much as seccomp or
apparmor fits into this.

This is just like a memory barrier mb() to be executed in the context
switch code. Security issues can emerge with the lack of it regardless
if selinux is built in and enabled or CONFIG_SECURITY=n.

selinux matters after an exploit already happened, this as opposed is
needed to prevent the exploit in the first place.

Also the correct fully secure version provides a single answer
(i.e. in theory assuming a perfect implementation that didn't forget
anything so having a single implementation will also increase the
chances that we get as close as possible to the theoretical correct
implementation).

If it provides different answers in this case it is because somebody
wants not perfect security to provide higher performance, i.e. the
"configurablity" which is valuable and fine feature to provide. Just a
LSM module doesn't seem the most flexibile way to provide
configurability by far.

> Yes, even security people have to worry about locking.

Yes it was some lock that if contended would lockup if used from
inside the scheduler.

> What *is* the most robust way?

The below pretty much explains it.

> Yes, there are locking issues. The code in the LSM infrastructure and in
> the security modules needs to be aware of that and deal with it. The SELinux
> code I proposed is more complex than it could be because the audit code
> requires locking that doesn't work in the switching context.

Or in other words having multiple versions of this called from within
the scheduler is a bit like making the kernel modular and then because
the locking is subtle you may then have scheduler deadlocks only
happening with some kernel module loaded instead of others, but the
real question is what is the payoff compared to just allowing the
scheduler code to be tuned with x86 debugfs or sysctl the normal
way.

Also how would a new common code method in LSM fit for CPUs that are
so slow that they can't possibly need anything like IBPB and
flush_RSB()?

Thanks!
Andrea
