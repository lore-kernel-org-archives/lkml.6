Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965C3C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EFF2077C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 22:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EFF2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbeJLGDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 02:03:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48756 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeJLGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 02:03:32 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAjWl-0003XH-Cb; Fri, 12 Oct 2018 00:33:55 +0200
Date:   Fri, 12 Oct 2018 00:33:54 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Andy Lutomirski <luto@kernel.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
In-Reply-To: <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810120030530.1457@nanos.tec.linutronix.de>
References: <20181011185458.10186-1-kristen@linux.intel.com> <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com> <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
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

On Thu, 11 Oct 2018, Kees Cook wrote:
> On Thu, Oct 11, 2018 at 1:48 PM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
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
> 
> I think this looks like a good idea. It might be worth adding a
> comment about the checks to explain why those errors are whitelisted.
> It's a cheap and effective mitigation for "unknown future problems"
> that doesn't degrade normal workloads.

pt_regs->ax is unsigned long, so you want to check this with IS_ERR_VALUE()
first.

               if (!IS_ERR_VALUE(regs->ax))
		        return;

and then you really want to have something smarter than a gazillion of
whitelisted error value checks, which effectively compile into a gazillion
conditonal branches.

Thanks,

	tglx
