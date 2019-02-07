Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32001C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047AE21902
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfBGLNq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 06:13:46 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:37795 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfBGLNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 06:13:45 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1grhci-0007RM-82; Thu, 07 Feb 2019 12:13:40 +0100
Date:   Thu, 7 Feb 2019 12:13:40 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 11/22] x86/fpu: Make get_xsave_field_ptr() and
 get_xsave_addr() use feature number instead of mask
Message-ID: <20190207111340.xaz7faetcags4qsb@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-12-bigeasy@linutronix.de>
 <20190128184959.GI20487@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190128184959.GI20487@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-28 19:49:59 [+0100], Borislav Petkov wrote:
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -830,15 +830,15 @@ static void *__raw_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
…
> > -void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
> > +void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
> >  {
> > -	int xfeature_nr;
> > +	u64 xfeature_mask = 1ULL << xfeature_nr;
> 
> You can paste directly BIT_ULL(xfeature_nr) where you need it in this
> function...
changed.

> > @@ -850,11 +850,11 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
> >  	 * have not enabled.  Remember that pcntxt_mask is
> >  	 * what we write to the XCR0 register.
> >  	 */
> > -	WARN_ONCE(!(xfeatures_mask & xstate_feature),
> > +	WARN_ONCE(!(xfeatures_mask & xfeature_mask),
> 
> ... and turn this into:
> 
> 	WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr))
>
> which is more readable than the AND of two variables which I had to
> re-focus my eyes to see the difference. :)
> 
you mean with vs without the `s' ?

> Oh and this way, gcc generates better code by doing simply a BT
> directly:
> 
> # arch/x86/kernel/fpu/xstate.c:852:     WARN_ONCE(!(xfeatures_mask & BIT_ULL(xfeature_nr)),
>         .loc 1 852 2 view .LVU258
>         movq    xfeatures_mask(%rip), %rax      # xfeatures_mask, tmp124
>         btq     %rsi, %rax      # xfeature_nr, tmp124

interesting. gcc should know that it can use btq or shift + and because
it has all the raw data.
Anyway, I replaced the two user of xfeature_mask with
BIT_ULL(xfeature_nr).

> Thx.

Sebastian
