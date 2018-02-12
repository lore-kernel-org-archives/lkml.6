Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935545AbeBLNgN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:36:13 -0500
Received: from smtp-out4.electric.net ([192.162.216.184]:60324 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbeBLNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:36:12 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: "'Denys Vlasenko'" <dvlasenk@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "luto@kernel.org" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "linux-tip-commits@vger.kernel.org"
        <linux-tip-commits@vger.kernel.org>
Subject: RE: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS
 macro
Thread-Topic: [tip:x86/pti] x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS
 macro
Thread-Index: AQHTpAWn8ytJURfBkkCmTvx0P6k12KOgxElw
Date: Mon, 12 Feb 2018 13:36:52 +0000
Message-ID: <1b5552f1231b4c9b867a17d0c5c594bb@AcuMS.aculab.com>
References: <20180211104949.12992-5-linux@dominikbrodowski.net>
 <tip-7b7b09f110f06f3c006e9b3f4590f7d9ba91345b@git.kernel.org>
 <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
In-Reply-To: <22559e63-5b78-21a7-27cd-a985957d5879@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1CDaJuV008276

From: Denys Vlasenko
> Sent: 12 February 2018 13:29
...
> >
> > x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS macro
> >
> > Those instances where ALLOC_PT_GPREGS_ON_STACK is called just before
> > SAVE_AND_CLEAR_REGS can trivially be replaced by PUSH_AND_CLEAN_REGS.
> > This macro uses PUSH instead of MOV and should therefore be faster, at
> > least on newer CPUs.
...
> > Link: http://lkml.kernel.org/r/20180211104949.12992-5-linux@dominikbrodowski.net
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >   arch/x86/entry/calling.h  | 36 ++++++++++++++++++++++++++++++++++++
> >   arch/x86/entry/entry_64.S |  6 ++----
> >   2 files changed, 38 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> > index a05cbb8..57b1b87 100644
> > --- a/arch/x86/entry/calling.h
> > +++ b/arch/x86/entry/calling.h
> > @@ -137,6 +137,42 @@ For 32-bit we have the following conventions - kernel is built with
> >   	UNWIND_HINT_REGS offset=\offset
> >   	.endm
> >
> > +	.macro PUSH_AND_CLEAR_REGS
> > +	/*
> > +	 * Push registers and sanitize registers of values that a
> > +	 * speculation attack might otherwise want to exploit. The
> > +	 * lower registers are likely clobbered well before they
> > +	 * could be put to use in a speculative execution gadget.
> > +	 * Interleave XOR with PUSH for better uop scheduling:
> > +	 */
> > +	pushq   %rdi		/* pt_regs->di */
> > +	pushq   %rsi		/* pt_regs->si */
> > +	pushq   %rdx		/* pt_regs->dx */
> > +	pushq   %rcx		/* pt_regs->cx */
> > +	pushq   %rax		/* pt_regs->ax */
> > +	pushq   %r8		/* pt_regs->r8 */
> > +	xorq    %r8, %r8	/* nospec   r8 */
> 
> xorq's are slower than xorl's on Silvermont/Knights Landing.
> I propose using xorl instead.

Does using movq to copy the first zero to the other registers make
the code any faster?

ISTR mov reg-reg is often implemented as a register rename rather than an
alu operation.

	David
