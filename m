Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3F2C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0780206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 23:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0780206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbeIEEEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeIEEEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:04:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 87BB13001500;
        Tue,  4 Sep 2018 23:37:19 +0000 (UTC)
Received: from sky.random (ovpn-120-15.rdu2.redhat.com [10.10.120.15])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41A4A16C10;
        Tue,  4 Sep 2018 23:37:15 +0000 (UTC)
Date:   Tue, 4 Sep 2018 19:37:14 -0400
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
Message-ID: <20180904233714.GJ4762@redhat.com>
References: <nycvar.YFH.7.76.1808312242130.25787@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.1809041619510.15880@cbobk.fhfr.pm>
 <alpine.LRH.2.00.1809041639340.14475@gjva.wvxbf.pm>
 <31436186-88da-324e-88a0-8fdca7bf60ac@linux.intel.com>
 <nycvar.YFH.7.76.1809041932590.15880@cbobk.fhfr.pm>
 <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99FC4B6EFCEFD44486C35F4C281DC67321447094@ORSMSX107.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 04 Sep 2018 23:37:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 04, 2018 at 06:10:47PM +0000, Schaufler, Casey wrote:
> The real reason to use an LSM based approach is that overloading ptrace
> checks is a Really Bad Idea. Ptrace is a user interface. Side-channel is a
> processor interface. Even if ptrace_may_access() does exactly what you

"Side channel is a processor interface" doesn't make me optimistic,
but I assume you're not speaking for Intel.

> want it to for side-channel mitigation today it would be incredibly
> inappropriate to tie the two together for eternity. You don't want to restrict
> the ptrace checks to only those things that are also good for side-channel,
> and vice versa. 

It seems like you want to make this more configurable, we have all
debugfs x86 specific tweaks to disable IBPB at runtime and we don't
allow a runtime opt-out of IBPB alone.

If you shutdown either IBRS or retpolines at runtime with debugfs,
then IBPB goes away too.

Giving a finegrined way to disable only IBPB we found was overkill
because IBPB has never been measurable if done only when the prev task
cannot ptrace the next task (which is a superset of the too weak
upstream not dumpable check, but still not a performance issue).

Allowing IBPB runtime opt-out doesn't make much sense if you don't
allow to disable retpolines too still at runtime. And disabling
retpolines from LSM doesn't sounds the right place, it's an x86
temporary quirk only relevant for current buggy CPUs.

There should be a function that decides when IBPB and flush_RSB should
be run (flush_RSB has to be run if SMEP because with SMEP there's no
need to run flush_RSB at every kernel entry anymore), and that
function happens to check ptrace today, but it would check other stuff
too if we had other interfaces besides ptrace that would allow the
prev task to read the memory of the next task. So it's not so much
about ptrace nor about IBPB, it's about "IBPB&flush_RSB" vs "prev task
can read memory of next task". Then each arch can implement
"IBPB&flush_RSB" method its own way but the check is for the common
code and it should be in the scheduler and there's just 1 version of
this check needed.

I don't think there should be a ton of different versions of this
function each providing a different answer, which is what LSM would
provide.

At most you can add a x86 debugfs tweak to shut off the logic but
again it would make more sense if retpolines could be shut off at
runtime too, doing it just for IBPB sounds backwards because it has
such an unmeasurable overhead.

> Yes. That would be me. 

Even the attempt to make an innocuous call like
ptrace_has_cap(tcred->user_ns, mode) will eventually
deadlock there.

I used a PTRACE_MODE_ check that the ptrace check code uses to filter
out specific calls that may eventually enter LSM and hard lockup in
non reproducible workloads (some false positive IBPB is ok, especially
if it avoids a deadlock).

Everything can be fixed in any way, but calling LSM from scheduler
code doesn't sound the most robust thing to do in general because what
works outside the scheduler doesn't work from within those semi atomic
regions (it tends to work initially until it eventually
deadlocks). The original code of such check, had all sort of deadlocks
because of that.

Thanks,
Andrea
