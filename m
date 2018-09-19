Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5A1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E4F2150E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78E4F2150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732867AbeISWoI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:44:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33029 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731592AbeISWoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:44:08 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g2fue-0006Un-30; Wed, 19 Sep 2018 19:05:16 +0200
Date:   Wed, 19 Sep 2018 19:05:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [RFC PATCH 10/10] x86/fpu: defer FPU state load until return to
 userspace
Message-ID: <20180919170515.ptqmmpsxrdjsi64j@linutronix.de>
References: <20180912133353.20595-1-bigeasy@linutronix.de>
 <20180912133353.20595-11-bigeasy@linutronix.de>
 <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <650FC457-7E4C-473A-9E5F-EAFC74F6444B@amacapital.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-12 08:47:19 [-0700], Andy Lutomirski wrote:
> > --- a/arch/x86/kernel/fpu/core.c
> > +++ b/arch/x86/kernel/fpu/core.c
> > @@ -101,14 +101,14 @@ void __kernel_fpu_begin(void)
> > 
> >    kernel_fpu_disable();
> > 
> > -    if (fpu->initialized) {
> > +    __cpu_invalidate_fpregs_state();
> > +
> > +    if (!test_and_set_thread_flag(TIF_LOAD_FPU)) {
> 
> Since the already-TIF_LOAD_FPU path is supposed to be fast here, use test_thread_flag() instead. test_and_set operations do unconditional RMW operations and are always full barriers, so they’re slow.
okay.

> Also, on top of this patch, there should be lots of cleanups available. In particular, all the fpu state accessors could probably be reworked to take TIF_LOAD_FPU into account, which would simplify the callers and maybe even the mess of variables tracking whether the state is in regs.

Do you refer to the fpu.initilized check or something else?

Sebastian
