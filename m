Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745F2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1562064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C1562064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIFOZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:25:10 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45696 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728001AbeIFOZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:25:10 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gqeSp7fZXRYG; Thu,  6 Sep 2018 11:50:12 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCBB900329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bcb:b900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C612E1EC02C1;
        Thu,  6 Sep 2018 11:50:11 +0200 (CEST)
Date:   Thu, 6 Sep 2018 11:50:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/3] x86/entry/64: Document idtentry
Message-ID: <20180906095005.GC10768@zn.tnic>
References: <cover.1536015544.git.luto@kernel.org>
 <6e56c3ad94879e41afe345750bc28ccc0e820ea8.1536015544.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e56c3ad94879e41afe345750bc28ccc0e820ea8.1536015544.git.luto@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 03:59:42PM -0700, Andy Lutomirski wrote:
> The idtentry macro is complicated and magical.  Document what it
> does to help future readers and to allow future patches to adjust
> the code and docs at the same time.
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/entry/entry_64.S | 35 +++++++++++++++++++++++++++++++++++
>  arch/x86/kernel/traps.c   |  4 ++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 957dfb693ecc..1796c42e08af 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -900,6 +900,41 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
>   */
>  #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + ((x) - 1) * 8)
>  
> +/**
> + * idtentry - Generate an IDT entry stub
> + * @sym: Name of the generated entry point
> + * @do_sym: C function to be called
> + * @has_error_code: True if this IDT vector has an error code on the stack
> + * @paranoid: non-zero means that this vector may be invoked from kernel
> + *            mode with user GSBASE and/or user CR3.  2 is special -- see below.
> + * @shift_ist: Set to an IST index if entries from kernel mode should
> + *             decrement the IST stack so that nested entries get a fresh
> + *             stack.  (This is for #DB, which has a nasty habit of
> + *             recursing.)
> + *
> + * idtentry generates an IDT stub that sets up a usable kernel context,
> + * creates struct pt_regs, and calls @do_sym.  The stub has the following
> + * special behaviors:
> + *
> + * On an entry from user mode, the stub switches from the trampoline or
> + * IST stack to the normal thread stack.  On an exit to user mode, the
> + * normal exit-to-usermode path is invoked.
> + *
> + * On an exit to kernel mode, if paranoid == 0, we check for preemption,

				   @paranoid

Otherwise, documenting our entry maze is always a good idea!

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
