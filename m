Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968947AbeEXU0b (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:26:31 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36505 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967470AbeEXU00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:26:26 -0400
X-Google-Smtp-Source: AB8JxZrVEtmx2SUEeGSKM3wDhJR24AQR+6vdWaxVTaoc1rpc8wouMI+h52u73U4WjkLYYvCYVPmYVE56ZS6Y6d0eZSM=
MIME-Version: 1.0
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com>
In-Reply-To: <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 24 May 2018 13:26:14 -0700
Message-ID: <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: hpa@zytor.com
Cc: Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, sedat.dilek@gmail.com,
        tstellar@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 11:59 AM <hpa@zytor.com> wrote:
> Ok, this is the *second* thing about LLVM-originated bug reports that
drives me batty. When you *do* identify a real problem, you propose a paper
over and/or talk about it as an LLVM issue and don't consider the often far
bigger picture.

Considering the bigger picture is why we have this thread going.  You have
much more context about the kernel than I or the llvm maintainers do.  We
can't consider the bigger picture until we ask.

> Issue 1: Fundamentally,

Fundamentally, the Linux kernel should not rely on GCC's heuristics for
adding or not adding a stack protector to functions with custom calling
conventions that are not marked in any way to let the compiler know.

Should GCC change their heuristic, deciding to insert stack guards for
non-inlined but marked static inline functions for
-fstack-protector-strong, or the kernel decide to use
-fstack-protector-all, the paravirt code will break in the same way.

> You are claiming it doesn't buy us anything, but you are only looking at
the paravirt case which is kind of "special" (in the short bus kind of way),

That's fair.  Is another possible solution to have paravirt maybe not use
native_save_fl() then, but its own non-static-inline-without-m-constraint
implementation?

> Issue 2: ... The other option is to turn stack canary explicitly off for
all such functions.

We're looking to add the compiler attribute no_stack_protector.  It's added
in mainline clang, the llvm bug cited earlier is about getting it
backported into clang-6.0.1 release.  Sedat has tested/verified a set of
patches to the kernel that use this new feature in:
https://marc.info/?l=linux-kernel&m=152697630812366&w=2

> Issue 3: Let's face it, reading and writing the flags should be builtins,
exactly because it has to do stack operations, which really means the
compiler should be involved.

I'm happy to propose that as a feature request to llvm+gcc.
-- 
Thanks,
~Nick Desaulniers
