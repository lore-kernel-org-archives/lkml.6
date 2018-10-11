Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D4AC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DE820644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRmZdYdu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13DE820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJLEq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbeJLEq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:46:29 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ED121480
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539292644;
        bh=P+dMCSacJLoCczGihGSKLnRPVqm01gqEh2hV36UAqLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vRmZdYduZppcUMXie6CJuDe2ob/GfVd3OcLvauLw2+qtOp7ztWH40Xxjem7LqYWtK
         caK9M7eAoE0183KxWG3yT38SiastG42+L/UstxwRZ5j0rmw7hSo71OlGgsdD/4Ng+L
         8Zc6pRrAGa0JNVGc0B9tPIMEw0m6wxwANElBO0V8=
Received: by mail-wm1-f42.google.com with SMTP id y11-v6so10340977wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 14:17:24 -0700 (PDT)
X-Gm-Message-State: ABuFfohqEBiCrWqvfILH/+F2vjxfeG4tSQaPOpIMney/x+V+ru69ad5y
        SjKMTxytBsVkVooaXujijbLrKF/1NXkMwENWuaVACQ==
X-Google-Smtp-Source: ACcGV63cPPr/qSsEx2NCfiteYCWfKpiAKWIDjVDHdL5EOlVD/XjEUUNG3lSSprVPu05yeiji2k9uk7VI6NV7XZn+cQA=
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr3052906wmf.19.1539292642496;
 Thu, 11 Oct 2018 14:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181011185458.10186-1-kristen@linux.intel.com>
 <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com> <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
In-Reply-To: <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Oct 2018 14:17:10 -0700
X-Gmail-Original-Message-ID: <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
Message-ID: <CALCETrVG5=iqfohYxKSvAQx3DhzD95MhmDU3mU8+kCegps2cbw@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 1:55 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 11, 2018 at 1:48 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
> > <kristen@linux.intel.com> wrote:
> >>
> >> This patch aims to make it harder to perform cache timing attacks on data
> >> left behind by system calls. If we have an error returned from a syscall,
> >> flush the L1 cache.
> >>
> >> It's important to note that this patch is not addressing any specific
> >> exploit, nor is it intended to be a complete defense against anything.
> >> It is intended to be a low cost way of eliminating some of side effects
> >> of a failed system call.
> >>
> >> A performance test using sysbench on one hyperthread and a script which
> >> attempts to repeatedly access files it does not have permission to access
> >> on the other hyperthread found no significant performance impact.
> >>
> >> Suggested-by: Alan Cox <alan@linux.intel.com>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> ---
> >>  arch/x86/Kconfig        |  9 +++++++++
> >>  arch/x86/entry/common.c | 18 ++++++++++++++++++
> >>  2 files changed, 27 insertions(+)
> >>
> >> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> >> index 1a0be022f91d..bde978eb3b4e 100644
> >> --- a/arch/x86/Kconfig
> >> +++ b/arch/x86/Kconfig
> >> @@ -445,6 +445,15 @@ config RETPOLINE
> >>           code are eliminated. Since this includes the syscall entry path,
> >>           it is not entirely pointless.
> >>
> >> +config SYSCALL_FLUSH
> >> +       bool "Clear L1 Cache on syscall errors"
> >> +       default n
> >> +       help
> >> +         Selecting 'y' allows the L1 cache to be cleared upon return of
> >> +         an error code from a syscall if the CPU supports "flush_l1d".
> >> +         This may reduce the likelyhood of speculative execution style
> >> +         attacks on syscalls.
> >> +
> >>  config INTEL_RDT
> >>         bool "Intel Resource Director Technology support"
> >>         default n
> >> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
> >> index 3b2490b81918..26de8ea71293 100644
> >> --- a/arch/x86/entry/common.c
> >> +++ b/arch/x86/entry/common.c
> >> @@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
> >>         prepare_exit_to_usermode(regs);
> >>  }
> >>
> >> +__visible inline void l1_cache_flush(struct pt_regs *regs)
> >> +{
> >> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
> >> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> >> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
> >> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
> >> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
> >> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
> >
> > What about ax > 0?  (Or more generally, any ax outside the range of -1
> > .. -4095 or whatever the error range is.)  As it stands, it looks like
> > you'll flush on successful read(), write(), recv(), etc, and that
> > could seriously hurt performance on real workloads.
>
> Seems like just changing this with "ax == 0" into "ax >= 0" would solve that?

I can easily imagine that there are other errors for which performance
matters.  EBUSY comes to mind.

>
> I think this looks like a good idea. It might be worth adding a
> comment about the checks to explain why those errors are whitelisted.
> It's a cheap and effective mitigation for "unknown future problems"
> that doesn't degrade normal workloads.

I still want to see two pieces of information before I ack a patch like this:

 - How long does L1D_FLUSH take, roughly?

 - An example of a type of attack that would be mitigated.

For the latter, I assume that the goal is to mitigate against attacks
where a syscall speculatively loads something sensitive and then
fails.  But, before it fails, it leaks the information it
speculatively loaded, and that leak ended up in L1D but *not* in other
cache levels.  And somehow the L1D can't be probed quickly enough in a
parallel thread to meaningfully get the information out of L1D.  Or
maybe it's trying to mitigate against the use of failing syscalls to
get some sensitive data into L1D and then using something like L1TF to
read it out.

But this really needs to be clarified.  Alan said that a bunch of the
"yet another Spectre variant" attacks would have been mitigated by
this patch.  An explanation of *how* would be in order.

And we should seriously consider putting this kind of thing under
CONFIG_SPECULATIVE_MITIGATIONS or similar.  The idea being that it
doesn't mitigate a clear known attack family.
