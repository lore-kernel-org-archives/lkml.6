Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD71ECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD721208CE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 05:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD721208CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbeGNFi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 01:38:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:35884 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbeGNFi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 01:38:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 13FE4AE07;
        Sat, 14 Jul 2018 05:21:14 +0000 (UTC)
Date:   Sat, 14 Jul 2018 07:21:10 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>
Subject: Re: [PATCH 10/39] x86/entry/32: Handle Entry from Kernel-Mode on
 Entry-Stack
Message-ID: <20180714052110.cobtew6rms23ih37@suse.de>
References: <1531308586-29340-1-git-send-email-joro@8bytes.org>
 <1531308586-29340-11-git-send-email-joro@8bytes.org>
 <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUg_4q8a2Tt_Z+GtVuBwj3Ct3=j7M-YhiK06=XjxOG82A@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:31:02PM -0700, Andy Lutomirski wrote:
> What you're really doing is keeping it available for an extra flag.
> Please update the comment as such.  But see below.

Thanks, will do.

> > +.macro PARANOID_EXIT_TO_KERNEL_MODE
> > +
> > +       /*
> > +        * Test if we entered the kernel with the entry-stack. Most
> > +        * likely we did not, because this code only runs on the
> > +        * return-to-kernel path.
> > +        */
> > +       testl   $CS_FROM_ENTRY_STACK, PT_CS(%esp)
> > +       jz      .Lend_\@
> > +
> > +       /* Unlikely slow-path */
> > +
> > +       /* Clear marker from stack-frame */
> > +       andl    $(~CS_FROM_ENTRY_STACK), PT_CS(%esp)
> > +
> > +       /* Copy the remaining task-stack contents to entry-stack */
> > +       movl    %esp, %esi
> > +       movl    PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %edi
> 
> I'm confused.  Why do we need any special handling here at all?  How
> could we end up with the contents of the stack frame we interrupted in
> a corrupt state?
> 
> I guess I don't understand why this patch is needed.

The patch is needed because we can get exceptions in kernel-mode while
we are already on user-cr3 and entry-stack. In this case we need to
return with user-cr3 and entry-stack to the kernel too, otherwise we
would go to user-space with kernel-cr3.

So based on that, I did the above because the entry-stack is a per-cpu
data structure and I am not sure that we always return from the exception
on the same CPU where we got it. Therefore the path is called
PARANOID_... :)


Regards,

	Joerg

