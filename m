Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67441C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B83C245DD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hUF9qbic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B83C245DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeFVQg5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:36:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51874 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934119AbeFVQgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IkJ+MlMnfgQLbR3ylk0md3pCcZ0B9p8NMOxXP6J33Hw=; b=hUF9qbicshOdOO9nhO+fdXQvs
        4P2zhO7E+wKrqBTMy3DqElHdaSVGNpBZNTsez7ykkNu2wBX/DEJfSmaQd0G8ey3qAcW3ieFAfUPbC
        dFS+iAqaqgW6MWOu5nJVTU+ar6Wpo2GbupjgfjRGp+c0rLI0Uf2dNI7Mv3nAMiXGBoD0QLHA1nV1j
        VaBFzgfGSBl5MYllQLaxON98tWSooIbPtvYjui1az0oBuooY7TVnbdkTGl9DgDgRR71Q6nKWxKGhp
        v5Io8Y5IApyloaZf2HC5guCSOK3DRAFRn77sqkVfn6ssMu9lEG2zOJCODybJzu7v4oYI9Nxo/ej8k
        GuI4rSB/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fWP3D-00021z-Fl; Fri, 22 Jun 2018 16:36:44 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1623F2029F1D9; Fri, 22 Jun 2018 18:36:35 +0200 (CEST)
Date:   Fri, 22 Jun 2018 18:36:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH REBASED RESEND] x86/cpu: Move early cpu initialization
 into a separate translation unit
Message-ID: <20180622163635.GO2494@hirez.programming.kicks-ass.net>
References: <20180612103657.18041-1-kirill.shutemov@linux.intel.com>
 <alpine.DEB.2.21.1806221603150.2402@nanos.tec.linutronix.de>
 <20180622151446.lqqmk6nkzzkb6lew@black.fi.intel.com>
 <alpine.DEB.2.21.1806221720500.2402@nanos.tec.linutronix.de>
 <20180622155824.npfinfnpidplufad@black.fi.intel.com>
 <alpine.DEB.2.21.1806221809070.2402@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1806221809070.2402@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 06:16:05PM +0200, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Kirill A. Shutemov wrote:
> > On Fri, Jun 22, 2018 at 03:35:18PM +0000, Thomas Gleixner wrote:

> > > How is that supposed to work correctly?
> > > 
> > > start_kernel()
> > >   ....
> > >   trap_init()
> > >     cpu_init()
> > > 
> > >   ....
> > >   check_bugs()
> > >     alternative_instructions()
> > > 
> > > So the first invocation of cpu_init() on the boot CPU will then use
> > > static_cpu_has() which is not yet initialized proper.
> > 
> > Ouch.
> > 
> > Is there a way to catch such improper static_cpu_has() users?
> > Silent misbehaviour is risky.
> 
> Yes, it is. I don't think we have something in place right now, but we
> should add it definitely. PeterZ ????

So static_cpu_has() _should_ work. That thing is mightily convoluted,
but behold:

| static __always_inline __pure bool _static_cpu_has(u16 bit)
| {
|         asm_volatile_goto("1: jmp 6f\n"
|                  "2:\n"
|                  ".skip -(((5f-4f) - (2b-1b)) > 0) * "
|                          "((5f-4f) - (2b-1b)),0x90\n"

<snip magic shite>

|                  ".section .altinstr_aux,\"ax\"\n"
|                  "6:\n"
|                  " testb %[bitnum],%[cap_byte]\n"
|                  " jnz %l[t_yes]\n"
|                  " jmp %l[t_no]\n"
|                  ".previous\n"
|                  : : [feature]  "i" (bit),
|                      [always]   "i" (X86_FEATURE_ALWAYS),
|                      [bitnum]   "i" (1 << (bit & 7)),
|                      [cap_byte] "m" (((const char *)boot_cpu_data.x86_capability)[bit >> 3])
|                  : : t_yes, t_no);
| t_yes:
|         return true;
| t_no:
|         return false;
| }

So by default that emits, before patching:

	jmp 6f
	'however many single byte NOPs are needed'

	.section.altinstr_aux
	6: testb %[bitnum],%[cap_byte]
	   jnz %l[t_yes]
	   jmp %l[t_no]
	.previous

Which is a dynamic test for the bit in the bitmask. Which always works,
irrespective of the alternative patching.

The magic, which I cut out, will rewrite the "jmp 6f, nops" thing to
"jmp %l[y_{yes,no}]" at the alternative patching and we'll loose the
dynamic test, pinning the condition forever more.
