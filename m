Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D9BC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC57020827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 07:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC57020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbeKFRKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:10:51 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:36895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbeKFRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:10:51 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gJw4K-0005UY-0Q; Tue, 06 Nov 2018 08:46:36 +0100
Date:   Tue, 6 Nov 2018 08:46:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Patch v4 17/18] x86/speculation: Update SPEC_CTRL MSRs of remote
 CPUs
In-Reply-To: <81398b26-e1c3-aac3-b44a-2a0982ae74e0@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811060139090.1659@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811042042060.10744@nanos.tec.linutronix.de> <ea646842-bd32-3615-bf38-27b568a2d81e@linux.intel.com>
 <alpine.DEB.2.21.1811052326040.1659@nanos.tec.linutronix.de> <81398b26-e1c3-aac3-b44a-2a0982ae74e0@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tim,

On Mon, 5 Nov 2018, Tim Chen wrote:
> > Aside of the condition being pointless in that case, that issues an IPI
> > whether the task is running or not. So this allows a task to issue tons of
> > async IPIs disturbing others by toggling the control.
> 
> I'm not crazy about sending IPIs too.  Hence the original implementation
> using TIF_UPDATE_SPEC_CTRL flag.

which has it's own problems of bloating the context switch code.

> I've thought a bit about the options you suggested and was unclear
> on a few things.
> 
> > 1) Restrict the PRCTL control so it is only possible to modify it at the
> >    point where the application is still single threaded.
> 
> My understanding is PRCTL applied on the task only. Should it be extended
> to other task threads?  In that case, it seems like we didn't do that for SSBD?

Right, we did not.

This was discussed back then already and we agreed on avoiding the
complexity for this and only allow task scope. Though the child tasks will
inherit the TIF flag.

> > 2) Add _TIF_UPDATE_SPEC_CTRL to the SYSCALL_EXIT_WORK_FLAGS and handle it
> >    in the slow work path.
> 
> There can be tasks that don't do any syscalls, and it seems like we can
> have MSRs getting out of sync?

Setting the TIF flag directly in a remote task is wrong. It needs to be
handled when the _TIF_UPDATE_SPEC_CTRL is evaluated, i.e. the information
needs to be stored process wide e.g. in task->mm.

But yes, if the remote task runs in user space forever, it won't
help. Though the point is that dumpable is usually set when the process
starts, so it's probably mostly a theoretical issue.

> > I'm less and less convinced that piggybacking this on dumpable is a good
> > idea. 
> 
> There are daemons like sshd that are non-dumpable.  So I think protecting
> them is desired.  Otherwise all those daemons will need to be updated to
> use PRCTL.  In the original implementation, IBPB is issued for
> non-dumpable task.  It will be nice to retain that.

A lot of things are nice to have, but you really have to carefully weigh
the tradeoff between the conveniance and the complexity plus the fast path
bloat it creates.

IBPB is a different thing as it writes into a different MSR and there is no
requirement to have the MSR access coordinated with the SSB handling in
switch_to(). 

As dumpable is evaluated in switch_mm() already it might be worthwhile to
evaluate whether the STIBP propagation can be tied to that. That does not
solve the problem of tasks running in user space forever, but we don't care
about that for IBPB either and as I said above it's mostly a theoretical
problem.

Thanks,

	tglx

