Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC43C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE0720882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H+faEIhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbfA3MyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:54:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727227AbfA3MyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:54:00 -0500
Received: from zn.tnic (p200300EC2BCAED00D014CE199A91CB87.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:d014:ce19:9a91:cb87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 257AD1EC01B6;
        Wed, 30 Jan 2019 13:53:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548852839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i1nKKmixvpU3VQCSPc9sqckUm8YSUIHU0495NNAo8rY=;
        b=H+faEIhIxPcFW1HSeShqVSaGCC9ujnmAO38bu0zoEmXU6NMuTOcnEX4ACl93nRXMcjX0NC
        iV0yeSUid9DWz1M3It20g9Z/GzN+goJpCt1uj7i7CAyZYNxWytrWRRoE//xjQImIFIvubp
        AFVZrVcAOfR2Baaah5uXkEhMCNgQ4F4=
Date:   Wed, 30 Jan 2019 13:53:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 17/22] x86/fpu: Prepare copy_fpstate_to_sigframe() for
 TIF_NEED_FPU_LOAD
Message-ID: <20190130125351.GH18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-18-bigeasy@linutronix.de>
 <20190130115614.GF18383@zn.tnic>
 <20190130122820.qyyn4vbtkqelmp54@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130122820.qyyn4vbtkqelmp54@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:28:20PM +0100, Sebastian Andrzej Siewior wrote:
> > > +	/*
> > > +	 * If we do not need to load the FPU registers at return to userspace
> > > +	 * then the CPU has the current state and we need to save it. Otherwise
> > > +	 * it is already done and we can skip it.
> > > +	 */
> > > +	if (!test_thread_flag(TIF_NEED_FPU_LOAD))
> > > +		copy_fpregs_to_fpstate(fpu);
> > 
> > I wonder if this flag would make the code more easy to follow by calling
> > it
> > 
> > 	TIF_FPU_REGS_VALID
> > 
> > instead, to denote that the FPU registers in the CPU have a valid
> > content.
> > 
> > Then the test becomes:
> > 
> > 	if (test_thread_flag(TIF_FPU_REGS_VALID))
> > 		copy_fpregs_to_fpstate(fpu);
> 
> I've been asked to add comment above the sequence so it is understood. I
> think the general approach is easy to follow once the concept is
> understood. I don't mind renaming the TIF_ thingy once again (it
> happend once or twice and I think the current one was suggested by Andy
> unless I mixed things up).
> The problem I have with the above is that
> 
> 	if (test_thread_flag(TIF_NEED_FPU_LOAD))
> 		do_that()
> 
> becomes
> 	if (!test_thread_flag(TIF_FPU_REGS_VALID))
> 		do_that()

Err, above it becomes

	if (test_thread_flag(TIF_FPU_REGS_VALID))
		copy_fpregs_to_fpstate(fpu);

without the "!". I.e., CPU's FPU regs are valid and we need to save them.

Or am I misreading the comment above?

> and you could argue again the other way around. So do we want NEED_LOAD
> or NEED_SAVE flag which is another way of saying REGS_VALID?

All fine and dandy except NEED_FPU_LOAD is ambiguous to me: we need to
load them where? Into the CPU? Or into the FPU state save area?

TIF_FPU_REGS_VALID is clearer in the sense that the CPU's FPU registers
are currently valid for the current task. As there are no other FPU
registers except the CPU's.

> More importantly the logic is changed when the bit is set and this
> requires more thinking than just doing sed on the patch series.

Sure.

And I'll get accustomed to the logic whatever the name is - this is just
a "wouldn't it be better" thing.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
