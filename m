Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752214AbeEOW5L (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 18:57:11 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41821 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeEOW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 18:57:09 -0400
X-Google-Smtp-Source: AB8JxZrrJJryK5PuHz7MutjHDTwWxfyltY129YBmLzEfzBswc7P2DeaQwMYHB/LFot7FLvpiDLn2GprHMilKoRKLCA4=
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
References: <20180515030038.GA11822@embeddedor.com> <20180515150859.1bccbd8d4543848b30fea859@linux-foundation.org>
 <alpine.DEB.2.21.1805160027260.1605@nanos.tec.linutronix.de>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 15 May 2018 15:57:08 -0700
Message-ID: <CAPcyv4iksLzZ=eMjWw6Wi87F2OSXHd16gKRLExgGhx=Mdr+AwQ@mail.gmail.com>
Subject: Re: [PATCH] kernel: sys: fix potential Spectre v1
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 3:29 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Tue, 15 May 2018, Andrew Morton wrote:
>> On Mon, 14 May 2018 22:00:38 -0500 "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>>
>> > resource can be controlled by user-space, hence leading to a
>> > potential exploitation of the Spectre variant 1 vulnerability.
>> >
>> > This issue was detected with the help of Smatch:
>> >
>> > kernel/sys.c:1474 __do_compat_sys_old_getrlimit() warn: potential
>> > spectre issue 'get_current()->signal->rlim' (local cap)
>> > kernel/sys.c:1455 __do_sys_old_getrlimit() warn: potential spectre issue
>> > 'get_current()->signal->rlim' (local cap)
>> >
>> > Fix this by sanitizing *resource* before using it to index
>> > current->signal->rlim
>> >
>> > Notice that given that speculation windows are large, the policy is
>> > to kill the speculation on the first load and not worry if it can be
>> > completed with a dependent load/store [1].
>>
>> hm.  Not my area, but I'm always willing to learn ;)
>>
>> > --- a/kernel/sys.c
>> > +++ b/kernel/sys.c
>> > @@ -69,6 +69,9 @@
>> >  #include <asm/io.h>
>> >  #include <asm/unistd.h>
>> >
>> > +/* Hardening for Spectre-v1 */
>> > +#include <linux/nospec.h>
>> > +
>> >  #include "uid16.h"
>> >
>> >  #ifndef SET_UNALIGN_CTL
>> > @@ -1451,6 +1454,7 @@ SYSCALL_DEFINE2(old_getrlimit, unsigned int, resource,
>> >     if (resource >= RLIM_NLIMITS)
>> >             return -EINVAL;
>> >
>> > +   resource = array_index_nospec(resource, RLIM_NLIMITS);
>> >     task_lock(current->group_leader);
>> >     x = current->signal->rlim[resource];
>>
>> Can the speculation proceed past the task_lock()?  Or is the policy to
>> ignore such happy happenstances even if they are available?
>
> Locks are not in the way of speculation. Speculation has almost no limits
> except serializing instructions. At least they respect the magic AND
> limitation in array_index_nospec().

I'd say it another way, because they don't respect the magic AND, we
just make the result in the speculation path safe. So, it's controlled
speculation.
