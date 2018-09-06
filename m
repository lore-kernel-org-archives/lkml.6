Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9898120652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 12:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9898120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbeIFRHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 13:07:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33765 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbeIFRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 13:07:05 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxtRl-0006TD-Ej; Thu, 06 Sep 2018 14:31:41 +0200
Date:   Thu, 6 Sep 2018 14:31:41 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jann Horn <jannh@google.com>
cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>, bpetkov@suse.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/process: don't mix user/kernel regs in 64bit
 __show_regs
In-Reply-To: <CAG48ez03ujGFDOFCsiWFYk2caGvg0ak3GpTHKLKS7-dahC_F5Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1809061426100.1570@nanos.tec.linutronix.de>
References: <20180831194151.123586-1-jannh@google.com> <CALCETrUMhg8nxeMr0VtBEveKDKAMk+16amDWGFduhAJWaU3O6A@mail.gmail.com> <CAG48ez03ujGFDOFCsiWFYk2caGvg0ak3GpTHKLKS7-dahC_F5Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018, Jann Horn wrote:
> On Fri, Aug 31, 2018 at 10:12 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Fri, Aug 31, 2018 at 12:41 PM, Jann Horn <jannh@google.com> wrote:
> > > When the kernel.print-fatal-signals sysctl has been enabled (I don't know
> > > whether anyone actually enables it), a simple userspace crash will cause
> > > the kernel to write a crash dump that contains, among other things, the
> > > kernel gsbase into dmesg.
> > >
> > > As suggested by Andy, limit output to pt_regs, FS_BASE and KERNEL_GS_BASE
> > > in this case.
> > >
> > > This also moves the bitness-specific logic from show_regs() into
> > > process_{32,64}.c.
> > >
> > > Signed-off-by: Jann Horn <jannh@google.com>
> > > Fixes: 45807a1df9f5 ("vdso: print fatal signals")
> > > ---
> > > @Andy: Does this look like what you had in mind?
> >
> > Yes.
> >
> > Although there's another option: remove print-fatal-signals.
> 
> Who wants to decide? Ingo, it's your feature - what do you think?

It seems to be documented for trouble shooting in lots of places and the
fix is not horrible. So lets keep it.

Thanks,

	tglx
