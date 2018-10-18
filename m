Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F536ECDE44
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECD52087A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:19:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DECD52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeJRTUT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:20:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34176 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbeJRTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:20:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gD6L7-0005ml-PG; Thu, 18 Oct 2018 13:19:41 +0200
Date:   Thu, 18 Oct 2018 13:19:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Christophe de Dinechin <christophe.de.dinechin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 03/11] x86/fpu: make __raw_xsave_addr() use feature
 number instead of mask
Message-ID: <20181018111941.og4jg4yzg53f2nnt@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-4-bigeasy@linutronix.de>
 <m1murk75nk.fsf@dinechin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <m1murk75nk.fsf@dinechin.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-11 19:30:07 [+0200], Christophe de Dinechin wrote:
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index 87a57b7642d36..38d0b5ea40425 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -811,10 +811,8 @@ void fpu__resume_cpu(void)
> >   *
> >   * Note: does not work for compacted buffers.
> >   */
> > -void *__raw_xsave_addr(struct xregs_state *xsave, int xstate_feature_mask)
> > +void *__raw_xsave_addr(struct xregs_state *xsave, int feature_nr)
> 
> It might be clearer to offer both interfaces, since both are used?
> 
…
> > @@ -869,7 +868,8 @@ void *get_xsave_addr(struct xregs_state *xsave, int xstate_feature)
> >  	if (!(xsave->header.xfeatures & xstate_feature))
> >  		return NULL;
> >
> > -	return __raw_xsave_addr(xsave, xstate_feature);
> > +	feature_nr = fls64(xstate_feature) - 1;
> > +	return __raw_xsave_addr(xsave, feature_nr);
> 
> and then move that to a wrapper function that takes a mask?

made another patch this fls is gone now and everyone is using a number
instead of a mask.

Sebastian
