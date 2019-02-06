Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAF3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB511218C3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfBFRlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:41:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:51640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730103AbfBFRlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:41:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4175C20B1F;
        Wed,  6 Feb 2019 17:41:11 +0000 (UTC)
Date:   Wed, 6 Feb 2019 12:41:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Damian Tometzki <linux_dti@icloud.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>, Will Deacon <will.deacon@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        deneen.t.dock@intel.com
Subject: Re: [PATCH 08/17] x86/ftrace: set trampoline pages as executable
Message-ID: <20190206124108.07eef568@gandalf.local.home>
In-Reply-To: <5DFA1E3C-A335-4C4B-A86F-904A6CF6D871@gmail.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-9-rick.p.edgecombe@intel.com>
        <20190206112213.2ec9dd5c@gandalf.local.home>
        <5DFA1E3C-A335-4C4B-A86F-904A6CF6D871@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Feb 2019 09:33:35 -0800
Nadav Amit <nadav.amit@gmail.com> wrote:


> >> 	/* Copy ftrace_caller onto the trampoline memory */
> >> 	ret = probe_kernel_read(trampoline, (void *)start_offset, size);
> >> @@ -818,6 +820,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
> >> 	/* ALLOC_TRAMP flags lets us know we created it */
> >> 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
> >> 
> >> +	/*
> >> +	 * Module allocation needs to be completed by making the page
> >> +	 * executable. The page is still writable, which is a security hazard,
> >> +	 * but anyhow ftrace breaks W^X completely.
> >> +	 */  
> > 
> > Perhaps we should set the page to non writable after the page is
> > updated? And set it to writable only when we need to update it.  
> 
> You remember that I sent you a patch that changed all these writes into
> text_poke() and you said that I should defer it until this series is merged?
> 

And I notice that it is set to RO after this call anyway.

-- Steve
