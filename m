Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034685AbeEXWF7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 18:05:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45289 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1034671AbeEXWF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 18:05:58 -0400
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com>
 <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <dd1626ae-114f-3817-c8b2-f845e079bfc6@zytor.com>
Date: Thu, 24 May 2018 15:05:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/24/18 13:26, Nick Desaulniers wrote:
> 
> Considering the bigger picture is why we have this thread going.  You have
> much more context about the kernel than I or the llvm maintainers do.  We
> can't consider the bigger picture until we ask.
> 

And this is correct. However, *every* LLVM request we get seem to be of
the form "if you apply this patch it will patch over one particular
instance of a problem with the kernel-LLVM."

There are two problems with that:

1. It focuses narrowly on an issue, which might (and more than a handful
   of times have) mask much more fundamental, serious bugs, in both the
   kernel and LLVM.

2. It makes it sound like an LLVM problem that wants to be hacked in the
   kernel. More than a handful of times that is exactly what they have
   been.

Look how many fundamental issues we have uncovered from this simple
issue, which would have gotten completely lost had we just applied this
patch.

>> Issue 1: Fundamentally,
> 
> Fundamentally, the Linux kernel should not rely on GCC's heuristics for
> adding or not adding a stack protector to functions with custom calling
> conventions that are not marked in any way to let the compiler know.

This is true, although it is actually NOT the fundamental issue (see
below) but you also deleted the exact LLVM problem that I pointed out:

COMPILER AR: "=rm" should NEVER generate worse code than "=r". That is
unequivocally a compiler bug.

The other problem here is that omitting the stack canary is really not
the right thing to do, either. The right thing to do is to add a
mechanism for the compiler to know to reserve some number of stack
slots. Ideally this should work even if a function includes an inline
function or macro that contains the actual inline assembly.

COMPILER AR: Add a mechanism for the compiler to know that inline
assembly needs a certain amount of slack stack space. In the ideal
universe, this should ALSO mean the compiler offsets all "m" references
that contain references to the stack pointer.

KERNEL AR: Add those annotations to all cases of inline assembly that
modifies the stack pointer.

>> You are claiming it doesn't buy us anything, but you are only looking at
> the paravirt case which is kind of "special" (in the short bus kind of way),
> 
> That's fair.  Is another possible solution to have paravirt maybe not use
> native_save_fl() then, but its own non-static-inline-without-m-constraint
> implementation?

KERNEL AR: change native_save_fl() to an extern inline with an assembly
out-of-line implementation, to satisfy the paravirt requirement that no
GPRs other than %rax are clobbered.

>> Issue 3: Let's face it, reading and writing the flags should be builtins,
> exactly because it has to do stack operations, which really means the
> compiler should be involved.
> 
> I'm happy to propose that as a feature request to llvm+gcc.

Being discussed elsewhere, of course.

	-hpa
