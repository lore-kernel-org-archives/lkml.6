Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDEhsSaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07B5F601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933787AbeFFRCT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933753AbeFFRCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:02:04 -0400
X-Google-Smtp-Source: ADUXVKKJmOWYjIrHwvMB3funWZJsVmG6q7yci8okFuRTMJjA1E1yE+aau2jPtkN9XedDD6zPgPpDbi6hFAAS5sghnz4=
MIME-Version: 1.0
References: <5B1672FE.4050705@huawei.com> <5B1792C9.8010203@huawei.com> <5B17A6B6.70300@huawei.com>
In-Reply-To: <5B17A6B6.70300@huawei.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 10:01:50 -0700
X-Gmail-Original-Message-ID: <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com>
Message-ID: <CALCETrXiaqyAKzcT17P35Gf6fNBchPYF_JsQ+3ezNeETs_UTbA@mail.gmail.com>
Subject: Re: Is this a kernel BUG? ///Re: [Question] Can we use SIGRTMIN when
 vdso disabled on X86?
To: thunder.leizhen@huawei.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andrew Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yaomin2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 2:18 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
> I found that glibc has already dealt with this case. So this issue must have been met before, should it be maintained by libc/user?
>
>         if (GLRO(dl_sysinfo_dso) == NULL)
>         {
>                 kact.sa_flags |= SA_RESTORER;
>
>                 kact.sa_restorer = ((act->sa_flags & SA_SIGINFO)
>                         ? &restore_rt : &restore);
>         }
>
>
> On 2018/6/6 15:52, Leizhen (ThunderTown) wrote:
> >
> >
> > On 2018/6/5 19:24, Leizhen (ThunderTown) wrote:
> >> After I executed "echo 0 > /proc/sys/abi/vsyscall32" to disable vdso, the rt_sigaction01 test case from ltp_2015 failed.
> >> The test case source code please refer to the attachment, and the output as blow:
> >>
> >> -----------------
> >> ./rt_sigaction01
> >> rt_sigaction01    0  TINFO  :  signal: 34
> >> rt_sigaction01    1  TPASS  :  rt_sigaction call succeeded: result = 0
> >> rt_sigaction01    0  TINFO  :  sa.sa_flags = SA_RESETHAND|SA_SIGINFO
> >> rt_sigaction01    0  TINFO  :  Signal Handler Called with signal number 34
> >>
> >> Segmentation fault
> >> ------------------
> >>
> >>
> >> Is this the desired result? In function ia32_setup_rt_frame, I found below code:
> >>
> >>      if (ksig->ka.sa.sa_flags & SA_RESTORER)
> >>              restorer = ksig->ka.sa.sa_restorer;
> >>      else
> >>              restorer = current->mm->context.vdso +
> >>                      vdso_image_32.sym___kernel_rt_sigreturn;
> >>      put_user_ex(ptr_to_compat(restorer), &frame->pretcode);
> >>
> >> Because the vdso is disabled, so current->mm->context.vdso is NULL, which cause the result of frame->pretcode invalid.
> >>
> >> I'm not sure whether this is a kernel bug or just an error of test case itself. Can anyone help me?
> >>
> >
>
>

I can't tell from your email what you're testing, what behavior you
expect, and what you saw.  A program that sets up a signal handler
without supplying a restorer will not work if the vDSO is off, and
this is by design.

(FWIW, there is a very longstanding libc bug that causes this case to
get severely screwed up if the user's SS is not the expected value,
and that bug was just fixed very recently.  But I doubt this is what
you're seeing.)

I suppose we could improve the kernel to at least push NULL instead of
some random address a bit above 0, but it'll still crash.
