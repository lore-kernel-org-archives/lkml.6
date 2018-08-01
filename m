Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FBFC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A4320840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 23:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nClaOk0c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A4320840
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbeHBBFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 21:05:15 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43014 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbeHBBFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 21:05:15 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so117224plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 16:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=765guztrD0pEOHMJAzdK4YxzsodKWJcq6Ai0IPUawI0=;
        b=nClaOk0cxKoD2XojJVDWxSyDMxr9kpNVIs5op8D4eeyWG8HddSRjQoI0nbRTQTtX6H
         BjXudvQHSVwHoEZ+5Y3kbsQS9T2fdu1hUMXQKO63P1AH4wSMnYSDiKXmMDMFmC6a8U70
         KFTh4UqH2+KE0ExAU4eKK6VrgQSrKIxSchrVWkcyd+UqB+u+U5Ul3NTJ9Yr/KvIhSKUC
         qV510Mbc6ncda4eEhnYecfBeMIlL9hReK+Iq73Nhvej4/d2zipenjU7awTualjFIhwJE
         hiWYUaQ2mHM/zwWOkaVWyC/sE+G6zYBDN9AwQ40XzwQlETnSR5UkI/X809L+Ex2eSPWr
         zTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=765guztrD0pEOHMJAzdK4YxzsodKWJcq6Ai0IPUawI0=;
        b=gTTh+YvrCHVJYN14vw362AzfKrkxm1oHCtFAYxtChGPUBfSQbAcmYi9v8K/Mm7pQT1
         3XOhMbAY6K85Pj/djhB12esFcLFzXgXmT69qxrKwVrXc/KrC4y+nqESN82tmeR1iUG8G
         /AtJPRkX6MmZgqtcey5Xk/Y1PnrI0ZpBujU4QA83nnHQP5dCtOsUiL4ImOcIi4Jmh8D8
         MDADtWuRl3HjyY07k+4DEwy7le7TrqUUcd7foldQCpKlboNRm4lyK/4VgiS5d0jwBZEN
         2NOtlAuTKoofifd3LCUiLPtWQVXWJ5xy2pQ3qaoDIH0+fODD1nsQctD9nA1pmY8uybK3
         Bcng==
X-Gm-Message-State: AOUpUlF1TmknIHrIwNAvv2/3DO2W0Z10zB5ekaDdY+G7N+Zhxly7cjLx
        4OWTaEOPMXHhX8nHmqWvptWs9UQP4v4=
X-Google-Smtp-Source: AAOMgpfKLwA+4/0uXKyFNeNY+B5RXJDOjgeGPcSzFBFvEQwj1A3Qr0R7uCya8O9RZA1Pudiot0Gp7A==
X-Received: by 2002:a17:902:5856:: with SMTP id f22-v6mr280923plj.266.1533165423812;
        Wed, 01 Aug 2018 16:17:03 -0700 (PDT)
Received: from [100.112.75.99] ([104.133.8.99])
        by smtp.gmail.com with ESMTPSA id j27-v6sm218341pfj.91.2018.08.01.16.17.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 16:17:01 -0700 (PDT)
Date:   Wed, 1 Aug 2018 16:16:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, keescook@google.com,
        tglx@linutronix.de, mingo@kernel.org, aarcange@redhat.com,
        jgross@suse.com, jpoimboe@redhat.com, gregkh@linuxfoundation.org,
        peterz@infradead.org, hughd@google.com,
        torvalds@linux-foundation.org, bp@alien8.de, luto@kernel.org,
        ak@linux.intel.com
Subject: Re: [PATCH 5/5] x86/mm/init: remove freed kernel image areas from
 alias mapping
In-Reply-To: <20180801180105.5A40FA31@viggo.jf.intel.com>
Message-ID: <alpine.LSU.2.11.1808011604270.1173@eggly.anvils>
References: <20180801180058.EC46D963@viggo.jf.intel.com> <20180801180105.5A40FA31@viggo.jf.intel.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kernel image is mapped into two places in the virtual address
> space (addresses without KASLR, of course):
> 
> 	1. The kernel direct map (0xffff880000000000)
> 	2. The "high kernel map" (0xffffffff81000000)
> 
> We actually execute out of #2.  If we get the address of a kernel
> symbol, it points to #2, but almost all physical-to-virtual
> translations point to #1.
> 
> Parts of the "high kernel map" alias are mapped in the userspace
> page tables with the Global bit for performance reasons.  The
> parts that we map to userspace do not (er, should not) have
> secrets.
> 
> This is fine, except that some areas in the kernel image that
> are adjacent to the non-secret-containing areas are unused holes.
> We free these holes back into the normal page allocator and
> reuse them as normal kernel memory.  The memory will, of course,
> get *used* via the normal map, but the alias mapping is kept.
> 
> This otherwise unused alias mapping of the holes will, by default
> keep the Global bit, be mapped out to userspace, and be
> vulnerable to Meltdown.
> 
> Remove the alias mapping of these pages entirely.  This is likely
> to fracture the 2M page mapping the kernel image near these areas,
> but this should affect a minority of the area.
> 
> This unmapping behavior is currently dependent on PTI being in
> place.  Going forward, we should at least consider doing this for
> all configurations.  Having an extra read-write alias for memory
> is not exactly ideal for debugging things like random memory
> corruption and this does undercut features like DEBUG_PAGEALLOC
> or future work like eXclusive Page Frame Ownership (XPFO).
> 
> Before this patch:
> 
> current_kernel:---[ High Kernel Mapping ]---
> current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
> current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
> current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
> current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
> current_kernel-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
> current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
> current_kernel-0xffffffff82c00000-0xffffffff82e00000           2M     RW                     NX pte
> current_kernel-0xffffffff82e00000-0xffffffff83200000           4M     RW         PSE         NX pmd
> current_kernel-0xffffffff83200000-0xffffffffa0000000         462M                               pmd
> 
>   current_user:---[ High Kernel Mapping ]---
>   current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
>   current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
>   current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
>   current_user-0xffffffff81e11000-0xffffffff82000000        1980K     RW                     NX pte
>   current_user-0xffffffff82000000-0xffffffff82600000           6M     ro         PSE     GLB NX pmd
>   current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd
> 
> 
> After this patch:
> 
> current_kernel:---[ High Kernel Mapping ]---
> current_kernel-0xffffffff80000000-0xffffffff81000000          16M                               pmd
> current_kernel-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
> current_kernel-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
> current_kernel-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
> current_kernel-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
> current_kernel-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte
> current_kernel-0xffffffff82488000-0xffffffff82600000        1504K                               pte
> current_kernel-0xffffffff82600000-0xffffffff82c00000           6M     RW         PSE         NX pmd
> current_kernel-0xffffffff82c00000-0xffffffff82c0d000          52K     RW                     NX pte
> current_kernel-0xffffffff82c0d000-0xffffffff82dc0000        1740K                               pte
> 
>   current_user:---[ High Kernel Mapping ]---
>   current_user-0xffffffff80000000-0xffffffff81000000          16M                               pmd
>   current_user-0xffffffff81000000-0xffffffff81e00000          14M     ro         PSE     GLB x  pmd
>   current_user-0xffffffff81e00000-0xffffffff81e11000          68K     ro                 GLB x  pte
>   current_user-0xffffffff81e11000-0xffffffff82000000        1980K                               pte
>   current_user-0xffffffff82000000-0xffffffff82400000           4M     ro         PSE     GLB NX pmd
>   current_user-0xffffffff82400000-0xffffffff82488000         544K     ro                     NX pte
>   current_user-0xffffffff82488000-0xffffffff82600000        1504K                               pte
>   current_user-0xffffffff82600000-0xffffffffa0000000         474M                               pmd
> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Kees Cook <keescook@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> ---
> 
>  b/arch/x86/mm/init.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff -puN arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image arch/x86/mm/init.c
> --- a/arch/x86/mm/init.c~x86-unmap-freed-areas-from-kernel-image	2018-07-30 09:53:14.862915689 -0700
> +++ b/arch/x86/mm/init.c	2018-07-30 09:53:14.866915689 -0700
> @@ -778,8 +778,26 @@ void free_init_pages(char *what, unsigne
>   */
>  void free_kernel_image_pages(void *begin, void *end)
>  {
> -	free_init_pages("unused kernel image",
> -			(unsigned long)begin, (unsigned long)end);
> +	unsigned long begin_ul = (unsigned long)begin;
> +	unsigned long end_ul = (unsigned long)end;
> +	unsigned long len_pages = (end_ul - begin_ul) >> PAGE_SHIFT;
> +
> +
> +	free_init_pages("unused kernel image", begin_ul, end_ul);
> +
> +	/*
> +	 * PTI maps some of the kernel into userspace.  For
> +	 * performance, this includes some kernel areas that
> +	 * do not contain secrets.  Those areas might be
> +	 * adjacent to the parts of the kernel image being
> +	 * freed, which may contain secrets.  Remove the
> +	 * "high kernel image mapping" for these freed areas,
> +	 * ensuring they are not even potentially vulnerable
> +	 * to Meltdown regardless of the specific optimizations
> +	 * PTI is currently using.
> +	 */
> +	if (cpu_feature_enabled(X86_FEATURE_PTI))
> +		set_memory_np(begin_ul, len_pages);
>  }
>  
>  void __ref free_initmem(void)
> _

Ironically, that set_memory_np() is giving me a problem.

I don't see it when booting the 8GB laptop normally, but when booting
with "mem=1G", I get a not-present fault when ext4_iget() is trying to
do its business in starting init.  But boots fine with "mem=1G nopti".

I get the feeling that set_memory_np() is marking those freed pages
as not-present in the direct map, so they're no longer usable at all.

I can jot down some console messages if you need, but hope I've said
enough for you to see it immediately, and just say whoops, forget 5/5?

Hugh
