Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA38CC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884EA21928
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409750;
	bh=UeWHiH2d8V8w9VFbrsG27SAmP6PytlU6w1KuCKLZdCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UYPJfxplXp7UW54stHxVGFxTSvpxxCcLuKK9jKwHN/Rt3z4Yi6xWNBwSSOt8kZhzR
	 cirQdJFsD1K+9VkFZIzXsL+wcf2BOotOn9Pk2geCJMUh897PSzr9364FCS0j7OF6yh
	 eIayRpYU94M0DBPb/tdsHhs18UEOcFaged8VjuM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389312AbeLUQ3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:29:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeLUQ3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:29:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED3592087F;
        Fri, 21 Dec 2018 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409747;
        bh=UeWHiH2d8V8w9VFbrsG27SAmP6PytlU6w1KuCKLZdCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ie68SoPlyU0YhJ2iloFfP6poelW93RpbSpY9I+WT1J8i+55RveYxNlWzdGtUHilte
         O756TO4QZ+aX56lr0FKEvBianErqEeBOktWozcaSEa9krd4KAKfU94Wgpov3XqpcWi
         i/RJjWat7SRIK4sroev5yZtEcZ4RVcLYPpmxTUc0=
Date:   Fri, 21 Dec 2018 17:29:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Jari Ruusu <jariruusu@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kvm ML <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?iso-8859-1?B?S3I/beE/?= <rkrcmar@redhat.com>,
        Rik van Riel <riel@surriel.com>, x86-ml <x86@kernel.org>
Subject: Re: [PATCH v4.9 STABLE] x86/fpu: Disable bottom halves while loading
 FPU registers
Message-ID: <20181221162905.GB7797@kroah.com>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103731.697870447@linuxfoundation.org>
 <5C07FC30.43601034@users.sourceforge.net>
 <20181205190020.GO29510@zn.tnic>
 <20181206105407.GH19891@kroah.com>
 <20181221162338.dir7z3c76kucm6uh@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221162338.dir7z3c76kucm6uh@linutronix.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 05:23:38PM +0100, Sebastian Andrzej Siewior wrote:
> The sequence
> 
>   fpu->initialized = 1;		/* step A */
>   preempt_disable();		/* step B */
>   fpu__restore(fpu);
>   preempt_enable();
> 
> in __fpu__restore_sig() is racy in regard to a context switch.
> 
> For 32bit frames, __fpu__restore_sig() prepares the FPU state within
> fpu->state. To ensure that a context switch (switch_fpu_prepare() in
> particular) does not modify fpu->state it uses fpu__drop() which sets
> fpu->initialized to 0.
> 
> After fpu->initialized is cleared, the CPU's FPU state is not saved
> to fpu->state during a context switch. The new state is loaded via
> fpu__restore(). It gets loaded into fpu->state from userland and
> ensured it is sane. fpu->initialized is then set to 1 in order to avoid
> fpu__initialize() doing anything (overwrite the new state) which is part
> of fpu__restore().
> 
> A context switch between step A and B above would save CPU's current FPU
> registers to fpu->state and overwrite the newly prepared state. This
> looks like a tiny race window but the Kernel Test Robot reported this
> back in 2016 while we had lazy FPU support. Borislav Petkov made the
> link between that report and another patch that has been posted. Since
> the removal of the lazy FPU support, this race goes unnoticed because
> the warning has been removed.
> 
> Disable bottom halves around the restore sequence to avoid the race. BH
> need to be disabled because BH is allowed to run (even with preemption
> disabled) and might invoke kernel_fpu_begin() by doing IPsec.
> 
>  [ bp: massage commit message a bit. ]
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Acked-by: Ingo Molnar <mingo@kernel.org>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
> Cc: kvm ML <kvm@vger.kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: stable@vger.kernel.org
> Cc: x86-ml <x86@kernel.org>
> Link: http://lkml.kernel.org/r/20181120102635.ddv3fvavxajjlfqk@linutronix.de
> Link: https://lkml.kernel.org/r/20160226074940.GA28911@pd.tnic
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/kernel/fpu/signal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What is the git commit id of this patch upstream?

thanks,

greg k-h
