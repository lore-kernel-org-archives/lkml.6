Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF35AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C402084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbfBUNGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:06:52 -0500
Received: from mother.openwall.net ([195.42.179.200]:47404 "HELO
        mother.openwall.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725831AbfBUNGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:06:52 -0500
Received: (qmail 32250 invoked from network); 21 Feb 2019 13:06:49 -0000
Received: from localhost (HELO pvt.openwall.com) (127.0.0.1)
  by localhost with SMTP; 21 Feb 2019 13:06:49 -0000
Received: by pvt.openwall.com (Postfix, from userid 503)
        id 5E5A8AA7D0; Thu, 21 Feb 2019 14:06:45 +0100 (CET)
Date:   Thu, 21 Feb 2019 14:06:45 +0100
From:   Solar Designer <solar@openwall.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        X86 ML <x86@kernel.org>
Subject: Re: [PATCH v2] x86/asm: Pin sensitive CR4 bits
Message-ID: <20190221130645.GA8281@openwall.com>
References: <20190220180934.GA46255@beast> <20190220184859.GA6429@openwall.com> <CAGXu5jLB=so4r169pq1KF3Kyfh2Kw_t6ZXGavpzVO2sg3=D1tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jLB=so4r169pq1KF3Kyfh2Kw_t6ZXGavpzVO2sg3=D1tw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 01:20:58PM -0800, Kees Cook wrote:
> On Wed, Feb 20, 2019 at 10:49 AM Solar Designer <solar@openwall.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 10:09:34AM -0800, Kees Cook wrote:
> > > +     if (WARN_ONCE((val & cr4_pin) != cr4_pin, "cr4 bypass attempt?!\n"))
> > > +             goto again;
> >
> > I think "goto again" is too mild a response given that it occurs after a
> > successful write of a non-pinned value to CR4.  I think it'd allow some
> > exploits to eventually win the race: make their desired use of whatever
> > functionality SMEP, etc. would have prevented - which may be just a few
> > instructions they need to run - before the CR4 value is reverted after
> > "goto again".  I think it's one of those cases where a kernel panic
> > would be more appropriate.
> 
> It will not land upstream with a BUG() or panic(). Linus has
> explicitly stated that none of this work can do that until it has
> "baked" in the kernel for a couple years.

OK.

> In his defense, anyone sufficiently paranoid can already raise the
> priority of a WARN() into a panic via sysctl kernel.panic_on_warn (and
> kernel.panic_on_oops).

I think there are too many uses of WARN() for anyone sane to enable
that in production, whereas it'd have made sense to enable it for the
few security-related uses.

> > Also, WARN_ONCE possibly introduces a delay sufficient to realistically
> > win this race on the first try.  If we choose to warn, we should do it
> > after having reverted the CR4 value, not before.
> 
> Isn't cr4 CPU-local though?

Good point.  I don't know.  If CR4 is per hardware thread, then the race
would require an interrupt and would be much harder to win.

> Couldn't we turn off interrupts to stop the race?

This won't help.  An attack would skip the code that disables interrupts
and land right on the MOV instruction.

Alexander
