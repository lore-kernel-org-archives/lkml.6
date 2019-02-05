Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED342C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62C12077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 11:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbfBELSF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 06:18:05 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:58796 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfBELSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 06:18:04 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gqyjl-00038e-NN; Tue, 05 Feb 2019 12:17:57 +0100
Date:   Tue, 5 Feb 2019 12:17:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 05/22] x86/fpu: Remove fpu->initialized usage in
 copy_fpstate_to_sigframe()
Message-ID: <20190205111757.oieqgdcdnctoegav@linutronix.de>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190109114744.10936-6-bigeasy@linutronix.de>
 <20190116193603.GK15409@zn.tnic>
 <20190116224037.xkfnevzkwrck5dtt@linutronix.de>
 <20190117122253.GC5023@zn.tnic>
 <20190118211401.4komqsnvuof7563p@linutronix.de>
 <33f0e144-1eec-b1a1-8858-58f20d5e477d@intel.com>
 <20190121112117.GA32538@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190121112117.GA32538@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-21 12:21:17 [+0100], Oleg Nesterov wrote:
> > This is part of our ABI for *sure*.  Inspecting that state is how
> > userspace makes sense of MPX or protection keys faults.  We even use
> > this in selftests/.
> 
> Yes.
> 
> And in any case I do not understand the idea to use the second in-kernel struct fpu.
> A signal handler can be interrupted by another signal, this will need to save/restore
> the FPU state again.

So I assumed that while SIGUSR1 is handled SIGUSR2 will wait until the
current signal is handled. So no interruption. But then SIGSEGV is
probably the exception which will interrupt SIGUSR1. So we would need a
third one…

The idea was to save the FPU state in-kernel so we don't have to
revalidate everything because userspace had access to it and could do
things.
Some things are complicated and not documented why they are the way they
are. For instance on 64bit (based on the code) the signal handler can
remove SSE from the state-mask and the kernel loads the "default-empty"
SSE registers and the enabled states from user. This isn't done on
32bit. Also: we save with XSAVE and allocate the buffer on stack. But if
we can't find the FP_XSTATE_MAGIC* or the buffer is not properly aligned
then we fallback to FXSR and assume that we have a FXSR buffer in front
of us.

> Oleg.

Sebastian
