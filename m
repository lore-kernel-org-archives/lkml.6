Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646AFECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EC120871
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="MDXCl9uI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EC120871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeGMLKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:10:32 -0400
Received: from 8bytes.org ([81.169.241.247]:37790 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbeGMLKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:10:32 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 41A7D377; Fri, 13 Jul 2018 12:56:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1531479382; bh=IVDS67gxDLpxLVOnjfwZeRj3wAP+sX1YyMfHVCuQ0hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MDXCl9uI9bElWv58JHqetUcdV1Mp6y1V6YUcY5AuZ1fv6zmwuJ4FMH61JFM1ffUp6
         ABqSgELL5Sijuune6kGXi9Rhh8E2SlcNZxdywCn+cyEjJh9U7eowq8AhWLIPAnOvYY
         ObPE/GFdnR8qDg/02kdBEe0LOqiiVW1+lsi1M+R2csHTaIu1I+Z2YC9rZY0pv1zHV2
         0v1mc3Z0Nwc+ztVY8SScZyLTLsr1ZQzR/2SqbxfZcv1CLZNB698VU2ppy/qAo7dtmo
         biaW2EfyMvGjutIROaNQx20f2HOygwbE0/hCulTuFJ58BZyccnWp/oay+YdRVIxCS7
         0x26oV7N81SlA==
Date:   Fri, 13 Jul 2018 12:56:20 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
        daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>, jroedel@suse.de
Subject: Re: [PATCH 07/39] x86/entry/32: Enter the kernel via trampoline stack
Message-ID: <20180713105620.z6bjhqzfez2hll6r@8bytes.org>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-8-git-send-email-joro@8bytes.org>
 <A66D58A6-3DC6-4CF3-B2A5-433C6E974060@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A66D58A6-3DC6-4CF3-B2A5-433C6E974060@amacapital.net>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

thanks for you valuable feedback.

On Thu, Jul 12, 2018 at 02:09:45PM -0700, Andy Lutomirski wrote:
> > On Jul 11, 2018, at 4:29 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > -.macro SAVE_ALL pt_regs_ax=%eax
> > +.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
> >    cld
> > +    /* Push segment registers and %eax */
> >    PUSH_GS
> >    pushl    %fs
> >    pushl    %es
> >    pushl    %ds
> >    pushl    \pt_regs_ax
> > +
> > +    /* Load kernel segments */
> > +    movl    $(__USER_DS), %eax
> 
> If \pt_regs_ax != %eax, then this will behave oddly. Maybe it’s okay.
> But I don’t see why this change was needed at all.

This is a left-over from a previous approach I tried and then abandoned
later. You are right, it is not needed.

> > +/*
> > + * Called with pt_regs fully populated and kernel segments loaded,
> > + * so we can access PER_CPU and use the integer registers.
> > + *
> > + * We need to be very careful here with the %esp switch, because an NMI
> > + * can happen everywhere. If the NMI handler finds itself on the
> > + * entry-stack, it will overwrite the task-stack and everything we
> > + * copied there. So allocate the stack-frame on the task-stack and
> > + * switch to it before we do any copying.
> 
> Ick, right. Same with machine check, though. You could alternatively
> fix it by running NMIs on an irq stack if the irq count is zero.  How
> confident are you that you got #MC right?

Pretty confident, #MC uses the exception entry path which also handles
entry-stack and user-cr3 correctly. It might go through through the slow
paranoid exit path, but that's okay for #MC I guess.

And when the #MC happens while we switch to the task stack and do the
copying the same precautions as for NMI apply.

> > + */
> > +.macro SWITCH_TO_KERNEL_STACK
> > +
> > +    ALTERNATIVE     "", "jmp .Lend_\@", X86_FEATURE_XENPV
> > +
> > +    /* Are we on the entry stack? Bail out if not! */
> > +    movl    PER_CPU_VAR(cpu_entry_area), %edi
> > +    addl    $CPU_ENTRY_AREA_entry_stack, %edi
> > +    cmpl    %esp, %edi
> > +    jae    .Lend_\@
> 
> That’s an alarming assumption about the address space layout. How
> about an xor and an and instead of cmpl?  As it stands, if the address
> layout ever changes, the failure may be rather subtle.

Right, I implement a more restrictive check.

> Anyway, wouldn’t it be easier to solve this by just not switching
> stacks on entries from kernel mode and making the entry stack bigger?
> Stick an assertion in the scheduling code that we’re not on an entry
> stack, perhaps.

That'll save us the check whether we are on the entry stack and replace
it with a check whether we are coming from user/vm86 mode. I don't think
that this will simplify things much and I am a bit afraid that it'll
break unwritten assumptions elsewhere. It is probably something we can
look into later separatly from the basic pti-x32 enablement.


Thanks,

	Joerg

