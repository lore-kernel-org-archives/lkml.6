Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E33ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACEAA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 07:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACEAA20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbeGWIY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 04:24:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbeGWIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 04:24:57 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 95F17825;
        Mon, 23 Jul 2018 07:25:07 +0000 (UTC)
Date:   Mon, 23 Jul 2018 09:25:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Brian Gerst <brgerst@gmail.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/entry/64: Remove %ebx handling from error_entry/exit
Message-ID: <20180723072505.GA24222@kroah.com>
References: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5010a090d3586b2d6e06c7ad3ec5542d1241c45.1532282627.git.luto@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 11:05:09AM -0700, Andy Lutomirski wrote:
> error_entry and error_exit communicate the user vs kernel status of
> the frame using %ebx.  This is unnecessary -- the information is in
> regs->cs.  Just use regs->cs.
> 
> This makes error_entry simpler and makes error_exit more robust.
> 
> It also fixes a nasty bug.  Before all the Spectre nonsense, The
> xen_failsafe_callback entry point returned like this:
> 
>         ALLOC_PT_GPREGS_ON_STACK
>         SAVE_C_REGS
>         SAVE_EXTRA_REGS
>         ENCODE_FRAME_POINTER
>         jmp     error_exit
> 
> And it did not go through error_entry.  This was bogus: RBX
> contained garbage, and error_exit expected a flag in RBX.
> Fortunately, it generally contained *nonzero* garbage, so the
> correct code path was used.  As part of the Spectre fixes, code was
> added to clear RBX to mitigate certain speculation attacks.  Now,
> depending on kernel configuration, RBX got zeroed and, when running
> some Wine workloads, the kernel crashes.  This was introduced by:
> 
>     commit 3ac6d8c787b8 ("x86/entry/64: Clear registers for
>     exceptions/interrupts, to reduce speculation attack surface")
> 
> With this patch applied, RBX is no longer needed as a flag, and the
> problem goes away.
> 
> I suspect that malicious userspace could use this bug to crash the
> kernel even without the offending patch applied, though.
> 
> [Historical note: I wrote this patch as a cleanup before I was aware
>  of the bug it fixed.]
> 
> [Note to stable maintainers: this should probably get applied to all
>  kernels.  If you're nervous about that, a more conservative fix to
>  add xorl %ebx,%ebx; incl %ebx before the jump to error_exit should
>  also fix the problem.]
> 
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: x86@kernel.org
> Cc: stable@vger.kernel.org
> Fixes: 3ac6d8c787b8 ("x86/entry/64: Clear registers for exceptions/interrupts, to reduce speculation attack surface")
> Reported-and-tested-by: "M. Vefa Bicakci" <m.v.b@runbox.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> 
> I could also submit the conservative fix tagged for -stable and respin
> this on top of it.  Ingo, Greg, what do you prefer?

I don't care, this patch looks good to me to take as-is for the stable
trees.  If you trust it in Linus's tree, it should be fine for others :)

thanks,

greg k-h
