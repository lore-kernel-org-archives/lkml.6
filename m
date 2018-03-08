Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935743AbeCHKhB convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:37:01 -0500
Received: from ozlabs.org ([103.22.144.67]:36437 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934059AbeCHKhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:37:00 -0500
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Jiri Slaby <jslaby@suse.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/21] powerpc: Add missing prototype for sys_debug_setcontext
In-Reply-To: <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
References: <20180225172236.29650-1-malat@debian.org> <20180225172236.29650-18-malat@debian.org> <87muzoglga.fsf@concordia.ellerman.id.au> <CA+7wUsyMQcvEOOAuthFg4Sc783x4KBqtjkgB81KzJqPxQnwdYA@mail.gmail.com>
Date: Thu, 08 Mar 2018 21:36:57 +1100
Message-ID: <878tb2etva.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:

> On Sun, Mar 4, 2018 at 11:54 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Mathieu Malaterre <malat@debian.org> writes:
>>
>>> In commit 81e7009ea46c ("powerpc: merge ppc signal.c and ppc64 signal32.c")
>>> the function sys_debug_setcontext was added without a prototype.
>>>
>>> Fix compilation warning (treated as error in W=1):
>>>
>>>   CC      arch/powerpc/kernel/signal_32.o
>>> arch/powerpc/kernel/signal_32.c:1227:5: error: no previous prototype for ‘sys_debug_setcontext’ [-Werror=missing-prototypes]
>>>  int sys_debug_setcontext(struct ucontext __user *ctx,
>>>      ^~~~~~~~~~~~~~~~~~~~
>>> cc1: all warnings being treated as errors
>>
>> This one should actually be using the SYSCALL_DEFINE syntax, so that it
>> can be used with CONFIG_FTRACE_SYSCALLS.
>>
>> See eg. our mmap:
>>
>>   SYSCALL_DEFINE6(mmap, unsigned long, addr, size_t, len,
>>                 unsigned long, prot, unsigned long, flags,
>>                 unsigned long, fd, off_t, offset)
>>   {
>>         return do_mmap2(addr, len, prot, flags, fd, offset, PAGE_SHIFT);
>>   }
>>
>>
>> We probably still need this patch, but I'm not entirely sure because the
>> SYSCALL_DEFINE macro does all sorts of shenanigans.
>
> I see. Could you please drop this patch then. The patch does not look
> that trivial anymore. I'll need to dig a bit more on how to do the
> syscall stuff with a 7 params function.

Ergh, yuck, seems we're the first suckers to need do that.

I think I'll take this patch for now, it's still good for now at least,
and then the SYSCALL_DEFINE stuff can be an addition.

cheers
