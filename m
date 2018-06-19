Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ADADC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14E42083D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D14E42083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966412AbeFSNJB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:09:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57085 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965720AbeFSNJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:09:00 -0400
Received: from hsi-kbw-5-158-153-55.hsi19.kabel-badenwuerttemberg.de ([5.158.153.55] helo=nanos.guests.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVGNO-0005TJ-A4; Tue, 19 Jun 2018 15:08:50 +0200
Date:   Tue, 19 Jun 2018 15:08:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Laight <David.Laight@ACULAB.COM>
cc:     'Andy Lutomirski' <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: RE: Lazy FPU restoration / moving kernel_fpu_end() to context
 switch
In-Reply-To: <8fcc0d8f5d8f48ca92e034d0c1a3c157@AcuMS.aculab.com>
Message-ID: <alpine.DEB.2.21.1806191506420.10546@nanos.tec.linutronix.de>
References: <CAHmME9pBqGhCjdwx64GxYTKWiMkDNY3v2gnVL_Xm2q=3guOAsQ@mail.gmail.com> <CALCETrU+2mBPDfkBz1i_GT1EOJau+mzj4yOK8N0UnT2pGjiUWQ@mail.gmail.com> <6eecf873-9d87-5345-70ba-5c064a31714b@linux.intel.com> <CALCETrWoDEXzH=y9sqoGWtzLPoeWgpRyUQw5AiCubX4O+UOa3w@mail.gmail.com>
 <8fcc0d8f5d8f48ca92e034d0c1a3c157@AcuMS.aculab.com>
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

On Tue, 19 Jun 2018, David Laight wrote:
> From: Andy Lutomirski
> > Sent: 15 June 2018 19:54
> > On Fri, Jun 15, 2018 at 11:50 AM Dave Hansen
> > <dave.hansen@linux.intel.com> wrote:
> > >
> > > On 06/15/2018 11:31 AM, Andy Lutomirski wrote:
> > > > for (thing) {
> > > >   kernel_fpu_begin();
> > > >   encrypt(thing);
> > > >   kernel_fpu_end();
> > > > }
> > >
> > > Don't forget that the processor has optimizations for this, too.  The
> > > "modified optimization" will notice that between:
> > >
> > >         kernel_fpu_end();   -> XRSTOR
> > > and
> > >         kernel_fpu_start(); -> XSAVE(S|OPT)
> > >
> > > the processor has not modified the states.  It'll skip doing any writes
> > > of the state.  Doing what Andy is describing is still way better than
> > > letting the processor do it, but you should just know up front that this
> > > may not be as much of a win as you would expect.
> > 
> > Even with the modified optimization, kernel_fpu_end() still needs to
> > reload the state that was trashed by the kernel FPU use.  If the
> > kernel is using something like AVX512 state, then kernel_fpu_end()
> > will transfer an enormous amount of data no matter how clever the CPU
> > is.  And I think I once measured XSAVEOPT taking a hundred cycles or
> > so even when RFBM==0, so it's not exactly super fast.
> 
> If the kernel was entered by a system call do you need to save the AVX512
> state at all?
> IIRC the registers are all defined as 'called saved' so there is no expectation
> that they will be saved across the syscall wrapper function call.
> All you need to do is ensure that 'kernel' values aren't passed back to userspace.
> There is a single instruction to zero all the AVX512 registers.

Then we need different treatment for exception entries and consecutive
preemption. Lots of corner cases to cover ...

Thanks,

	tglx
