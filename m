Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9785C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3D2208B3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:23:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3D2208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965437AbeFSGXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:23:46 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:56326 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965152AbeFSGXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:23:45 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fVA3L-0000Zv-NE; Tue, 19 Jun 2018 08:23:43 +0200
Date:   Tue, 19 Jun 2018 08:23:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
cc:     Siarhei.Liakh@concurrent-rt.com,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bpetkov@suse.de>
Subject: Re: [PATCH] x86: Call fixup_exception() before notify_die() in
 math_error()
In-Reply-To: <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1806190820210.1692@nanos.tec.linutronix.de>
References: <DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com> <CALCETrXUdLZTnf0EF2LVM4ru2G6nkFX--gQ=6JpBRNZ7Gm+MsQ@mail.gmail.com>
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

On Mon, 18 Jun 2018, Andy Lutomirski wrote:

> On Thu, Jun 14, 2018 at 10:10 PM Siarhei Liakh
> <Siarhei.Liakh@concurrent-rt.com> wrote:
> >
> > fpu__drop() has an explicit fwait which under some conditions can trigger
> > a fixable FPU exception while in kernel. Thus, we should attempt to fixup
> > the exception first, and only call notify_die() if the fixup failed just
> > like in do_general_protection(). The original call sequence incorrectly
> > triggers KDB entry on debug kernels under particular FPU-intensive
> > workloads. This issue had been privately observed, fixed, and tested
> > on 4.9.98, while this patch brings the fix to the upstream.
> 
> Reviewed-by: Andy Lutomirski <luto@kernel.org>
> 
> With the caveat that you are perpetuating what is arguably a bug in
> some of the other entries: math_error() can now be called with IRQs
> off and return with IRQs on.  If we actually start asserting good
> behavior in the entry code, we'll need to fix this.

Confused. math_error() is still invoked with interrupts off. What's
different now is that notify_die() is called with interrupts conditionally
enabled while upstream it's always called with interrupts disabled.

Thanks,

	tglx



