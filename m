Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465ABC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1185A2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1185A2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbeKCAvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:51:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59367 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeKCAvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:51:54 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gIbcO-0000X4-9V; Fri, 02 Nov 2018 16:44:16 +0100
Date:   Fri, 2 Nov 2018 16:44:16 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@surriel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 10/11] x86/fpu: prepare copy_fpstate_to_sigframe for
 TIF_LOAD_FPU
Message-ID: <20181102154416.bgtueiy65o6d23ni@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
 <20181004140547.13014-11-bigeasy@linutronix.de>
 <ef6012c0-52b9-14bb-c581-97627fdd5cb5@linux.intel.com>
 <20181015152431.GD11434@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181015152431.GD11434@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-15 17:24:31 [+0200], Borislav Petkov wrote:
> On Fri, Oct 12, 2018 at 12:40:19PM -0700, Dave Hansen wrote:
> > > +	__fpregs_changes_end();
> > 
> > Do we really need the __fpregs_changes_*() abstraction for this single
> > call site?
> 
> Yap, I'm staring at those in patch 2, there's no documentation there what
> they're supposed to do, only the commit message of patch 11 says:
> 
> "The __fpregs_changes_{begin|end}() section ensures that the register
> remain unchanged. Otherwise a context switch or a BH could save the
> registers to its FPU context and processor's FPU register would remain
> random."
> 
> So I'd say we should drop that abstraction, use preempt_* and put that
> text above the single usage site.

There are more than one caller and this function disables preemption and
BH in the end. Therefore I would like to keep it. But as suggested in
the previous patch I will think about renaming it.

> Thx.

Sebastian
