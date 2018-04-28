Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeD1Rut (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 13:50:49 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40137 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbeD1Rus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 13:50:48 -0400
X-Google-Smtp-Source: AB8JxZpF2DK/KHMhs2GG/rMJOg9QEOo5Nkun/6aJYe0d79xugzM1sIZBE/eWUZlVlBcl2ZgooirXeA==
Date: Sat, 28 Apr 2018 19:50:43 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>
Subject: Re: [RFD] x86: The future of MPX
Message-ID: <20180428175043.y35czmhcursyrzsy@gmail.com>
References: <alpine.DEB.2.21.1804272122390.1596@nanos.tec.linutronix.de>
 <20180428091823.h3iajtxkqdwdcpst@gmail.com>
 <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwgcmpSoNh17Pbtsw8j8KzufdvroC9Rsd3K-UbTTP9qPg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sat, Apr 28, 2018 at 2:18 AM Ingo Molnar <mingo@kernel.org> wrote:
> 
> > I just tried the MPX testcases with the latest kernel:
> 
> >   deimos:~/tip/tools/testing/selftests/x86> ./mpx-mini-test_64
> 
> They need to be run as root. They try to access
> 
>      /sys/kernel/debug/tracing/set_ftrace_pid
>      /sys/kernel/debug/tracing/trace
> 
> and that's root-only.

Indeed - but note that they are crashing as root as well here:

  root@deimos:/home/mingo/tip/tools/testing/selftests/x86# ./mpx-mini-test_64 
  [...]
  Aborted (core dumped)

... because I don't even have /sys/kernel/debug/tracing/set_ftrace_pid... :-/

That's despite having ftrace enabled.

After some digging I found out that 'set_ftrace_pid' is dependent on 
CONFIG_FUNCTION_TRACING=y (not just CONFIG_TRACING=y), which I didn't
have enabled on this kernel.

After enabling it I got the 64-bit testcase to work:

  #
  ...
  ./mpx-mini-test_64 completed successfully

But the 32-bit testcase is erroring out:

  root@deimos:/home/mingo/tip/tools/testing/selftests/x86# ./mpx-mini-test_32 
  XSAVE is supported by HW & OS
  XSAVE processor supported state mask: 0x21f
  XSAVE OS supported state mask: 0x21f
   BNDREGS: size: 64 user: 1 supervisor: 0 aligned: 0
    BNDCSR: size: 64 user: 1 supervisor: 0 aligned: 0
  executing unmaptest
  mpx dig (  1) complete, SUCCESS (       0 /    0)
  #BR status == 2, missing bounds table,kernel should have handled!!

v4.17-rc2 based kernel, so it should have the latest MPX code.

Thanks,

	Ingo
