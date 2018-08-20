Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45801C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E8321581
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 13:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04E8321581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbeHTQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 12:18:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeHTQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 12:18:09 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1frjpH-0005Xa-OS; Mon, 20 Aug 2018 15:02:32 +0200
Date:   Mon, 20 Aug 2018 15:02:31 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jinpu Wang <jinpu.wang@profitbricks.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, konrad.wilk@oracle.com,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [BUG]smt sysfs dir missing on 4.4.148 and 4.14.63
In-Reply-To: <CAMGffEk=6eVgB=A--FyooDoVPY4mEiOdf=yNnqdX4cF6Ud_NuA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1808201500590.1551@nanos.tec.linutronix.de>
References: <CAMGffEnzVo5VVSVBjCOBMhcoV1qXf0XXqJqr3C01xQn-aUiZFQ@mail.gmail.com> <20180816155126.GA18296@kroah.com> <CAMGffEmJR310NKHO1JpwE8yTg1Oeu_oaTaJ1D2_T_UHKCnHwKA@mail.gmail.com> <20180816163937.GA5105@kroah.com> <CAMGffEk2FqRn0av7T-aF-TKvRAKeinm96NYjJju_T4CmUrYPkQ@mail.gmail.com>
 <CAMGffEnKt0xcc6LhNdZQGRmckJ3qCFxCOnQ3owZmWWiaKYdYuw@mail.gmail.com> <20180817170129.GE24945@kroah.com> <alpine.DEB.2.21.1808181330380.2151@nanos.tec.linutronix.de> <CAMGffEk=6eVgB=A--FyooDoVPY4mEiOdf=yNnqdX4cF6Ud_NuA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2018, Jinpu Wang wrote:

> On Sat, Aug 18, 2018 at 2:50 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Fri, 17 Aug 2018, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 17, 2018 at 02:39:00PM +0200, Jinpu Wang wrote:
> > > >
> > > > I found the problem, CONFIG_HOTPLUG_SMT is enable due to CONFIG_SMP,
> > > > but I did explicitly enable CONFIG_HOTPLUG_CPU.
> > > >
> > > > That's why the smt dir is missing, and kernel panic when I boot with
> > > > 'nosmt' or 'l1tf=full' probably also other combination.
> > > >
> > > > With CONFIG_HOTPLUG_CPU=y, it works fine so far.
> > >
> > > So do we need a new configuration dependancy here to resolve this
> > > problem?  Why is this not an issue in Linus's tree?
> >
> > That's probably the same problem on Linus tree. Have not tested it yet
> > though. I'll have a look.
> >
> > Thanks,
> >
> >         tglx
> >
> Yeah, it's the same problem on Linus tree.
> 
> Probably makes sense to do the following, I can sent a formal patch if
> you think it's right thing to do:
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index b0312f8..8a52f0b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -188,7 +188,7 @@ config X86
>         select HAVE_SYSCALL_TRACEPOINTS
>         select HAVE_UNSTABLE_SCHED_CLOCK
>         select HAVE_USER_RETURN_NOTIFIER
> -       select HOTPLUG_SMT                      if SMP
> +       select HOTPLUG_SMT                      if SMP && HOTPLUG_CPU

That works, but we might as well force 'select HOTPLUG_CPU if SMP' so the
L1TF mitigations are functional. Sigh....

Thanks,

	tglx
