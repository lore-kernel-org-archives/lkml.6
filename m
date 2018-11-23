Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A98C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A0C20664
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A0C20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394991AbeKXA7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:59:41 -0500
Received: from bran.ispras.ru ([83.149.199.196]:28112 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388230AbeKXA7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:59:41 -0500
X-Greylist: delayed 513 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2018 19:59:40 EST
Received: from monopod.intra.ispras.ru (monopod.intra.ispras.ru [10.10.3.121])
        by smtp.ispras.ru (Postfix) with ESMTP id 8CDD920AA2;
        Fri, 23 Nov 2018 17:06:40 +0300 (MSK)
Date:   Fri, 23 Nov 2018 17:06:38 +0300 (MSK)
From:   Alexander Monakov <amonakov@ispras.ru>
To:     Alexander Popov <alex.popov@linux.com>
cc:     Florian Weimer <fweimer@redhat.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Emese Revfy <re.emese@gmail.com>,
        Thomas Garnier <thgarnie@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Jann Horn <jannh@google.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>, gcc@gcc.gnu.org
Subject: Re: Investigating a stack state mismatch in Linux kernel
In-Reply-To: <57225f38-3f6d-4029-8f89-4b6eba97c3c1@linux.com>
Message-ID: <alpine.LNX.2.20.13.1811231634330.6732@monopod.intra.ispras.ru>
References: <b7aad232-76e1-241f-00e2-77783ce30f87@linux.com> <875zwyabac.fsf@oldenburg.str.redhat.com> <2a2b1181-2175-7e4e-189c-12630f43d10d@linux.com> <57225f38-3f6d-4029-8f89-4b6eba97c3c1@linux.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 21 Nov 2018, Alexander Popov wrote:

> Hello everyone!
> 
> At irc.freenode.org/#gcc people told me that I should CC gcc@gcc.gnu.org to get
> some attention of gcc developers.
> 
> Link to previous discussion:
>  https://www.openwall.com/lists/kernel-hardening/2018/11/14/1

So just for information, it isn't a plugin bug. I'll elaborate below, but in
short, objtool was complaining about unreachable code.  To be fair though,
gcc could have made the problem easier to spot.

Now for the details.

The repro uses an unusual (randomized) kernel config, in particular gcov is
enabled and NR_CPUS is 1. Thus we have

static int duplicate_processor_ids[] = {
        [0 ... 1 - 1] = -1,
};

and the compiler deduces that the loop in acpi_duplicate_processor_id does not
iterate:

bool acpi_duplicate_processor_id(int proc_id)
{
        int i;

        for (i = 0; i < nr_duplicate_ids; i++) {
                if (duplicate_processor_ids[i] == proc_id)
                        return true;
        }
        return false;
}

However as gcov is enabled, loop backedge remains, followed by gcov counter
increment and __builtin_unreachable() (on GIMPLE). On RTL, however, the basic
block with the increment ends with a barrier rtx, which is not visible in
assembly and looks just as if control flow falls through to a function exit.
Since the exit in question corresponds to a shrink-wrapped early exit that
does not push/pop registers, objtool complains.

Ultimately this is poor luck, if gcc optimized the code better or terminated
the block that-should-not-be-reached with ud2, it would not arise.

Alexander
