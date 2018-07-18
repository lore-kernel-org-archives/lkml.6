Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0536ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6842084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:27:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6842084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbeGRKEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:04:44 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:57727 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbeGRKEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:04:44 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ffikI-0003C7-0f; Wed, 18 Jul 2018 11:27:42 +0200
Date:   Wed, 18 Jul 2018 11:27:41 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
Message-ID: <20180718092741.pah2lubzo2a7tkmu@linutronix.de>
References: <20180517124006.ohygrrpg7z2moqqt@linutronix.de>
 <20180522131004.3012953c@gandalf.local.home>
 <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <1531519424.23898.68.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531519424.23898.68.camel@gmx.de>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-14 00:03:44 [+0200], Mike Galbraith wrote:
> > This seems to make work (crypto chacha20-neon + cyclictest). I have no
> > EFI so I have no clue if saving SIMD while calling to EFI works.
> 
> All is not well on cavium test box.  I'm seeing random errors ala...
> 
> ./include/linux/fs.h:3137:11: internal compiler error: Segmentation fault
> ./include/linux/bio.h:175:1: internal compiler error: in grokdeclarator, at c/c-decl.c:7023
> 
> ...during make -j96 (2*cpus) kbuild.  Turns out 4.14-rt has this issue
> as well, which is unsurprising if it's related to fpsimd woes.  Box
> does not exhibit the issue with NONRT kernels, PREEMPT or NOPREEMPT.
> 
> To file under FWIW, arm64 configured SLE15-RT, 4.12 based kernel
> containing virgin @stable arch/arm64/kernel/fpsimd.c, does not exhibit
> the problem. (relevant? dunno, it may be unrelated to fpsimd.c).

Okay, so you did not test this because you can't compile. But the
"internal compiler error" is usually something the gcc folks are
interested in :)

> 	-Mike

Sebastian
