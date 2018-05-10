Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966384AbeEJPws (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:52:48 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36854 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965033AbeEJPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:52:46 -0400
X-Google-Smtp-Source: AB8JxZpba8svyDcEkdmDctzI++wm2Ec00BskghkdIAQZMo9kcZlHjM1wztA4ybifx7l89UJ2l5R09A==
Date: Thu, 10 May 2018 08:52:42 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yonghong Song <yhs@fb.com>, mingo@kernel.org,
        torvalds@linux-foundation.org, ast@fb.com, daniel@iogearbox.net,
        linux-kernel@vger.kernel.org, x86@kernel.org, netdev@vger.kernel.org,
        kernel-team@fb.com, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH bpf v3] x86/cpufeature: bpf hack for clang not supporting
 asm goto
Message-ID: <20180510155240.5s2fpgm2fwal3jlj@ast-mbp.dhcp.thefacebook.com>
References: <20180504033119.2130788-1-yhs@fb.com>
 <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510100634.GZ12217@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 12:06:34PM +0200, Peter Zijlstra wrote:
> On Thu, May 03, 2018 at 08:31:19PM -0700, Yonghong Song wrote:
> 
> > This approach is preferred since the already deployed bcc scripts, or
> > any other bpf applicaitons utilizing LLVM JIT compilation functionality,
> > will continue work with the new kernel without re-compilation and
> > re-deployment.
> 
> So I really hate this and would much rather see the BPF build
> environment changed. It not consistenyly having __BPF__ defined really
> smells like a bug on your end.
> 
> Sometimes you just need to update tools... Is it really too hard to do
> -D__BPF__ in the bpf build process that we need to mollest the kernel
> for it?
> 
> > Note that this is a hack in the kernel to workaround bpf compilation issue.
> > The hack will be removed once clang starts to support asm goto.
> 
> Note that that ^^ already mandates people re-deploy their bpf tools, so
> why is llvm supporting asm-goto a better point to re-deploy than fixing
> a consistent __BPF__ define for the bpf build environment?

This thread has been going for over a month now. Looks like we're starting
to go in circles and what we discussed earlier got lost. To recap:

- this is NOT a bpf issue. libbcc is the first user that got broken
  by commit d0266046ad54 ("x86: Remove FAST_FEATURE_TESTS")

- all other libraries and tools (like fuzzers, static code analyzers, etc)
  that are using clang front-end to process kernel headers are broken too

That makes me wonder what happened with "we do not break user space" rule?

I think the safest course of action would be to partially revert the
offending commit d0266046ad54 which we proposed first.
Since you were concerned that this is somehow will disincentivize clang
folks to add asm-goto support, we agreed to add this __NO_CLANG_BPF_HACK
macro to un-break libbcc at least, so that existing libbcc installations
will continue to work when people upgrade kernels.

The __BPF__ macro is automatically defined by clang when '-target bpf' is used.
This is NOT the case here. libbcc has to use native target when
processing kernel headers.

It happens from time to time that one or the other libbcc script gets
broken by new kernel because kprobe symbol that the script is using
got changed in the recent kernel. That's ok and we deal with this situation
all the time. What's different this time that ALL bcc scripts are broken
because of this commit and we cannot workaround in user space.
