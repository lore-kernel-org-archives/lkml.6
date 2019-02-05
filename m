Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8179C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF8B820821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:35:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbfBELfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:35:02 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBELfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:35:02 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gqz07-0003XJ-P9; Tue, 05 Feb 2019 12:34:51 +0100
Date:   Tue, 5 Feb 2019 12:34:51 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190205113451.dbnjybqpvhdda6un@linutronix.de>
References: <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
 <20190122134015.GI26587@zn.tnic>
 <20190122161551.GB9745@redhat.com>
 <20190122170023.GJ26587@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122170023.GJ26587@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-22 18:00:23 [+0100], Borislav Petkov wrote:
> On Tue, Jan 22, 2019 at 05:15:51PM +0100, Oleg Nesterov wrote:
> > I don't know... tried to google, found nothing.
> > 
> > the comment in /usr/include/sys/ucontext.h mentions SysV/i386 ABI + historical
> > reasons, this didn't help.
> 
> So I'm being told by one of the psABI folks that this is not really
> written down somewhere explicitly but it is the result from the POSIX
> and psABI treatise of signal handlers, what they're supposed to do,
> caller- and callee-saved registers, etc.
> 
> And FPU registers are volatile, i.e., caller-saved. Which means, the
> handler itself doesn't save them but the caller, which, doesn't really
> expect any signals - they are async. So the kernel must do that and
> slap the FPU regs onto the user stack...

My point was save them somewhere else if it is possible. So we could
save a few cycles during signal delivery and it would make the code a
little simpler.

Let me finish the series and then we can think how we could improve it.

> Hohumm. Makes sense.
> 

Sebastian
