Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDECBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A0C208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544101769;
	bh=f1bDdZtr9VDioZCEqAt/67HERLJ0WUZkqRvMMmrNW1o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZXeQD5Oguk8rE0zoti/tRzj/Zs8lcf9J+5oLr8UHvKdbeGqBped5DyyhpokYPJQh7
	 CmdYG3xubSyr1kkNLpr9+BCKyyP6giodPqzNCrFpNhP3JV6MR2fDsO4epsux+FHsKa
	 w0Ixy+Jll6uJ1hdQcQFA0SwPaubIFd1htvpjhTBs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A0C208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbeLFNJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 08:09:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729369AbeLFNJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 08:09:28 -0500
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F33120838;
        Thu,  6 Dec 2018 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544101767;
        bh=f1bDdZtr9VDioZCEqAt/67HERLJ0WUZkqRvMMmrNW1o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1A89uC6A8NndbXNSvzeYdVf8ddPOA/wq6ZGM1zzExAPJ8kR5EtVj3/D5xySCWJttj
         2wqJj34wrSoGQxPo7VgyyFms+2mkYWLxiVPGL4fvVmdob+0bAyL474RRv7R4HZZ47Z
         dpdUAMyX5wSHOKvGrYfS8xHwOl2wsQijmSIg+9bs=
Date:   Thu, 6 Dec 2018 22:09:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, <linux_dti@icloud.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7 09/14] x86/kprobes: Instruction pages initialization
 enhancements
Message-Id: <20181206220923.20e5b0593fa1a8038eb710fd@kernel.org>
In-Reply-To: <20181205013408.47725-10-namit@vmware.com>
References: <20181205013408.47725-1-namit@vmware.com>
        <20181205013408.47725-10-namit@vmware.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018 17:34:03 -0800
Nadav Amit <namit@vmware.com> wrote:

> This patch is a preparatory patch for a following patch that makes
> module allocated pages non-executable. The patch sets the page as
> executable after allocation.
> 
> In the future, we may get better protection of executables. For example,
> by using hypercalls to request the hypervisor to protect VM executable
> pages from modifications using nested page-tables. This would allow
> us to ensure the executable has not changed between allocation and
> its write-protection.

Sounds interesting!

> 
> While at it, do some small cleanup of what appears to be unnecessary
> masking.

Looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


Thanks!

> 
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index c33b06f5faa4..ca0118d3b3e8 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -431,8 +431,20 @@ void *alloc_insn_page(void)
>  	void *page;
>  
>  	page = module_alloc(PAGE_SIZE);
> -	if (page)
> -		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
> +	if (page == NULL)
> +		return NULL;
> +
> +	/*
> +	 * First make the page read-only, and then only then make it executable
> +	 * to prevent it from being W+X in between.
> +	 */
> +	set_memory_ro((unsigned long)page, 1);
> +
> +	/*
> +	 * TODO: Once additional kernel code protection mechanisms are set, ensure
> +	 * that the page was not maliciously altered and it is still zeroed.
> +	 */
> +	set_memory_x((unsigned long)page, 1);
>  
>  	return page;
>  }
> @@ -440,8 +452,12 @@ void *alloc_insn_page(void)
>  /* Recover page to RW mode before releasing it */
>  void free_insn_page(void *page)
>  {
> -	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
> -	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
> +	/*
> +	 * First make the page non-executable, and then only then make it
> +	 * writable to prevent it from being W+X in between.
> +	 */
> +	set_memory_nx((unsigned long)page, 1);
> +	set_memory_rw((unsigned long)page, 1);
>  	module_memfree(page);
>  }
>  
> -- 
> 2.17.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
