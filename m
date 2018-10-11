Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6F6C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3B92085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3B92085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJLHNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:13:13 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:48858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJLHNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:13:13 -0400
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gAkbx-0004Iz-Nr; Fri, 12 Oct 2018 01:43:21 +0200
Date:   Fri, 12 Oct 2018 01:43:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kristen C Accardi <kristen@linux.intel.com>
cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
In-Reply-To: <1539293003.3566.15.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810120116090.1457@nanos.tec.linutronix.de>
References: <20181011185458.10186-1-kristen@linux.intel.com>  <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>  <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com> <1539293003.3566.15.camel@linux.intel.com>
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

On Thu, 11 Oct 2018, Kristen C Accardi wrote:
> On Thu, 2018-10-11 at 13:55 -0700, Kees Cook wrote:
> > I think this looks like a good idea. It might be worth adding a
> > comment about the checks to explain why those errors are whitelisted.
> > It's a cheap and effective mitigation for "unknown future problems"
> > that doesn't degrade normal workloads.
> > 
> > > > +                       return;
> > > > +
> > > > +               wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> > 
> > What about CPUs without FLUSH_L1D? Could it be done manually with a
> > memcpy or something?
> 
> It could - my original implementation (pre l1d_flush msr) did, but it
> did come with some additional cost in that I allocated per-cpu memory
> to keep a 32K buffer around that I could memcpy. It also sacrificed
> completeness for simplicity by not taking into account cases where L1
> was not 32K. As far as I know this msr is pretty widely deployed, even
> on older hardware.

You don't need that per cpu thing, really. We have both the MSR flush and
the software fallback in KVM vmx_l1d_flush(). The performance impact is
pretty much the same between the MSR flush and the software fallback.

Vs. deployment of the MSR. I'm not sure how wide this is supported on older
CPUs as there have been limitations on microcode patch space, but I can't
find the support matrix right now. Thanks Intel for reshuffling the webpage
every other week!

Thanks,

	tglx


