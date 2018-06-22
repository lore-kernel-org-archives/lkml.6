Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06664C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F252460E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F252460E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754378AbeFVQvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:51:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:42385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754261AbeFVQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:51:34 -0400
Received: from p4fea482e.dip0.t-ipconnect.de ([79.234.72.46] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fWPH2-0000Qv-4D; Fri, 22 Jun 2018 18:51:00 +0200
Date:   Fri, 22 Jun 2018 18:50:56 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH REBASED RESEND] x86/cpu: Move early cpu initialization
 into a separate translation unit
In-Reply-To: <20180622163635.GO2494@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1806221848030.1589@nanos.tec.linutronix.de>
References: <20180612103657.18041-1-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1806221603150.2402@nanos.tec.linutronix.de> <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com> <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
 <20180622155824.npfinfnpidplufad@black.fi.intel.com> <alpine.DEB.2.21.1806221809070.2402@nanos.tec.linutronix.de> <20180622163635.GO2494@hirez.programming.kicks-ass.net>
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

On Fri, 22 Jun 2018, Peter Zijlstra wrote:
> On Fri, Jun 22, 2018 at 06:16:05PM +0200, Thomas Gleixner wrote:
> > On Fri, 22 Jun 2018, Kirill A. Shutemov wrote:
> > > On Fri, Jun 22, 2018 at 03:35:18PM +0000, Thomas Gleixner wrote:
> 
> > > > How is that supposed to work correctly?
> > > > 
> > > > start_kernel()
> > > >   ....
> > > >   trap_init()
> > > >     cpu_init()
> > > > 
> > > >   ....
> > > >   check_bugs()
> > > >     alternative_instructions()
> > > > 
> > > > So the first invocation of cpu_init() on the boot CPU will then use
> > > > static_cpu_has() which is not yet initialized proper.
> > > 
> > > Ouch.
> > > 
> > > Is there a way to catch such improper static_cpu_has() users?
> > > Silent misbehaviour is risky.
> > 
> > Yes, it is. I don't think we have something in place right now, but we
> > should add it definitely. PeterZ ????
> 
> So static_cpu_has() _should_ work. That thing is mightily convoluted,
> but behold:
> 
> | static __always_inline __pure bool _static_cpu_has(u16 bit)
> | {
> |         asm_volatile_goto("1: jmp 6f\n"
> |                  "2:\n"
> |                  ".skip -(((5f-4f) - (2b-1b)) > 0) * "
> |                          "((5f-4f) - (2b-1b)),0x90\n"
> 
> <snip magic shite>
> 
> |                  ".section .altinstr_aux,\"ax\"\n"
> |                  "6:\n"
> |                  " testb %[bitnum],%[cap_byte]\n"
> |                  " jnz %l[t_yes]\n"
> |                  " jmp %l[t_no]\n"
> |                  ".previous\n"
> |                  : : [feature]  "i" (bit),
> |                      [always]   "i" (X86_FEATURE_ALWAYS),
> |                      [bitnum]   "i" (1 << (bit & 7)),
> |                      [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
> |                  : : t_yes, t_no);
> | t_yes:
> |         return true;
> | t_no:
> |         return false;
> | }
> 
> So by default that emits, before patching:
> 
> 	jmp 6f
> 	'however many single byte NOPs are needed'
> 
> 	.section.altinstr_aux
> 	6: testb %[bitnum],%[cap_byte]
> 	   jnz %l[t_yes]
> 	   jmp %l[t_no]
> 	.previous
> 
> Which is a dynamic test for the bit in the bitmask. Which always works,
> irrespective of the alternative patching.
> 
> The magic, which I cut out, will rewrite the "jmp 6f, nops" thing to
> "jmp %l[y_{yes,no}]" at the alternative patching and we'll loose the
> dynamic test, pinning the condition forever more.

Hrm. Memory seems have to tricked me. So yes, it should work then.

Though I still prefer the two liners fixup of the cpu_init() section
mismatch thingy for now over the whole code move. Especially since Borislav
and I have plans to rework that insanity completely once the speculative
distractions are subsiding.

Thanks,

	tglx

