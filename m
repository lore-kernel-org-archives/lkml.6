Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D46C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A083320C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 21:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A083320C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeK0Iup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 03:50:45 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:55931 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0Iup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 03:50:45 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gROqR-0001oY-HS; Mon, 26 Nov 2018 22:55:07 +0100
Date:   Mon, 26 Nov 2018 22:55:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tim Chen <tim.c.chen@linux.intel.com>
cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [patch 20/24] x86/speculation: Split out TIF update
In-Reply-To: <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1811262244510.1682@nanos.tec.linutronix.de>
References: <20181121201430.559770965@linutronix.de> <20181121201724.227260385@linutronix.de> <f976eb35-5dcd-387e-eb29-f7c6636fd17b@linux.intel.com> <alpine.DEB.2.21.1811222352340.1665@nanos.tec.linutronix.de> <20181123073735.GA12959@gmail.com>
 <c51dd20a-2cea-1bd1-bee7-48ca25f9bdb9@linux.intel.com>
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

On Mon, 26 Nov 2018, Tim Chen wrote:
> On 11/22/2018 11:37 PM, Ingo Molnar wrote:
> >> We also had that discussion with SSBD and decided that we won't chase
> >> threads and send IPIs around. Yes, it's not perfect, but not the end of the
> >> world either. For PRCTL it's a non issue.
> 
> Looks like seccomp thread can be running on a remote CPU when its
> TIF_SPEC_IB flag gets updated.
>
> I wonder if this will cause STIBP to be always off in this scenario, when
> two tasks with SPEC_IB flags running on a remote CPU have STIBP bit always
> *off* in SPEC MSR.
> 
> Let's say we have tasks A and B running on a remote CPU:
> 
> task A: SPEC_IB flag is on
>
> task B: SPEC_IB flag is off but is currently running on remote CPU, SPEC
>         MSR's STIBP bit is off
>
> Now arch_seccomp_spec_mitigation is called, setting SPEC_IB flag on task B.
> SPEC MSR becomes out of sync with running task B's SPEC_IB flag.
> 
>
> Task B context switches to task A. Because both tasks have SPEC_IB flag
> set and the flag status is unchanged, SPEC MSR's STIBP bit is not
> updated.  SPEC MSR STIBP bit remains off if tasks A and B are the only
> tasks running on the CPU.
>
> There is an equivalent scenario where the SPEC MSR's STIBP bit remains on
> even though both running task A and B's SPEC_IB flags are turned off.
>
> Wonder if I may be missing something so the above scenario is not of
> concern?

The above is real. The question is whether we need to worry about it.

If so, then the right thing to do is to leave thread_info.flags alone and
flip the bits in a shadow storage, e.g. thread_info.spec_flags and after
updating that set something like TIF_SPEC_UPDATE and evaluate that bit on
context switch and if set update the TIF flags. Too tired to code that now,
but it's straight forward. I'll look at it on wednesday if nobody beats me
to it.

Thanks,

	tglx




