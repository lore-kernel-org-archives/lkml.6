Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C749C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010EF20882
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010EF20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeKHIg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:36:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42376 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeKHIg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:36:58 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKWrg-00024Z-FO; Thu, 08 Nov 2018 00:04:00 +0100
Date:   Thu, 8 Nov 2018 00:03:59 +0100 (CET)
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
In-Reply-To: <e41a9d15-f667-ebb5-3fbb-91f14ae034a3@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811072337120.1666@nanos.tec.linutronix.de>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com> <a14236d8b56dafe6988ce1b266a6e929be5296a8.1540923609.git.tim.c.chen@linux.intel.com> <alpine.DEB.2.21.1811042042060.10744@nanos.tec.linutronix.de> <ea646842-bd32-3615-bf38-27b568a2d81e@linux.intel.com>
 <alpine.DEB.2.21.1811052326040.1659@nanos.tec.linutronix.de> <81398b26-e1c3-aac3-b44a-2a0982ae74e0@linux.intel.com> <alpine.DEB.2.21.1811060139090.1659@nanos.tec.linutronix.de> <e41a9d15-f667-ebb5-3fbb-91f14ae034a3@linux.intel.com>
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

On Tue, 6 Nov 2018, Tim Chen wrote:
> >>> 2) Add _TIF_UPDATE_SPEC_CTRL to the SYSCALL_EXIT_WORK_FLAGS and handle it
> >>>    in the slow work path.
> >>
> >> There can be tasks that don't do any syscalls, and it seems like we can
> >> have MSRs getting out of sync?
> > 
> > Setting the TIF flag directly in a remote task is wrong. It needs to be
> > handled when the _TIF_UPDATE_SPEC_CTRL is evaluated, i.e. the information
> > needs to be stored process wide e.g. in task->mm.
> > 
> > But yes, if the remote task runs in user space forever, it won't
> > help. Though the point is that dumpable is usually set when the process
> > starts, so it's probably mostly a theoretical issue.
> > 
> 
> I took a crack to implement what you suggested to update
> remote task's flag and remote SPEC_CTRL MSR on the syscall exit slow path.

can we please take a step back and look at the problem again?

The goal is to glue the mitigation decision on dumpable. That's debatable,
but understandable, so let's not go into that discussion.

There are two ways to modify dumpable:

  1) prctl(PR_SET_DUMPABLE)

  2) operations which change UID/GID and end up in commit_creds()

Now the really interesting question is _when_ is any of the above invoked:

  1) When the process is still single threaded ?

  2) When the process has already spawned threads ?

If #2 is just the oddball exception, then why on earth should we go through
loops and hoops to make it work and add overhead in hot paths for no real
value?

So what we really want before discussing any potential solutions and their
pro and cons is an answer to that.

If we don't have that answer, then we might just create a purely academic
solution which creates more problems than it solves.

Thanks,

	tglx






