Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A90BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169DC20856
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 06:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547707891;
	bh=3pFFsGboE3NeLPavibg9ccKIbA+KASAPuMJu0N0lT6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SkEvrRr0ZhKsyYdxK39Ea3CpKW50rHtbU7BBYLNrdhwwb52xP0Aflxn9Pa7/tze+Z
	 FbiNOBefKnSDToG5AJ67B3CWsibEWR+T9PVfg1/BEkfSUUS1ME2ayNH1AIuVrX7jkl
	 KJDKWcTmE31GCLMlvrIC4qRUqFq06dbfnPZxzLKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfAQGv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 01:51:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:54636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfAQGv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 01:51:29 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71EF320657;
        Thu, 17 Jan 2019 06:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547707887;
        bh=3pFFsGboE3NeLPavibg9ccKIbA+KASAPuMJu0N0lT6Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cqou7RJ3WeQX6iJzoKHW5+b2gpIS04SgaKTwdmeJ5A9/3XwKxow/eifoYpAI/sPut
         OXT0khucqzxmOza+R+KqGRFPpQPHHhyjd/7eR27j8XdLZmKTIACaO6T3fgKfhVvx8S
         SYQmovRKQVmaa7u7PqZTAF16vidRUWol3+nPyV1Y=
Date:   Thu, 17 Jan 2019 15:51:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, linux_dti@icloud.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Nadav Amit <namit@vmware.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 09/17] x86/kprobes: Instruction pages initialization
 enhancements
Message-Id: <20190117155122.46058c707d6d07237ad913d0@kernel.org>
In-Reply-To: <20190117003259.23141-10-rick.p.edgecombe@intel.com>
References: <20190117003259.23141-1-rick.p.edgecombe@intel.com>
        <20190117003259.23141-10-rick.p.edgecombe@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 16:32:51 -0800
Rick Edgecombe <rick.p.edgecombe@intel.com> wrote:

> From: Nadav Amit <namit@vmware.com>
> 
> This patch is a preparatory patch for a following patch that makes
> module allocated pages non-executable. The patch sets the page as
> executable after allocation.
> 
> In the future, we may get better protection of executables. For example,
> by using hypercalls to request the hypervisor to protect VM executable
> pages from modifications using nested page-tables. This would allow
> us to ensure the executable has not changed between allocation and
> its write-protection.
> 
> While at it, do some small cleanup of what appears to be unnecessary
> masking.
> 

OK, then this should be done.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 4ba75afba527..fac692e36833 100644
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
