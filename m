Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE4220825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 12:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RrnwQV+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE4220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729708AbeKEV7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:59:46 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36176 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeKEV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 16:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UOpDLTXAtnnzTE/vKm8sfJOjSgQ2KHxQQ3HhKFWQ9J8=; b=RrnwQV+XZueYT88CbnNdx2pTV
        gQwtzEwI1MMlw9F/eEgwTjVP5FrKui4quOkeLqJ+h21uNkBuwcR6DuAUSO3APVyLfbesYpssMjVXt
        jHjhF2XjCtnIfSsg6/y4BmqfkE7X/h/5COxYVXpNY0LKlV7X7fpcTgDi9nOnb5EpfKs54h0+wg6iQ
        w3lE4PpJzPGOxpfhV7iV1Q2GSo7ww/v4oVP5fjFSx7lCJZvvZY9Cj7oifM6t16VOnur0+yug5KQdo
        ldxADe7FalimceGziEGt5uyM8bB2bg+J8eip2EFd4NNp2VVAv1EcnEg5KNxHiLGItRKCzKKU5TAhn
        foUemamZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gJeAe-0005TX-RK; Mon, 05 Nov 2018 12:39:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06EE82029F9FF; Mon,  5 Nov 2018 13:39:54 +0100 (CET)
Date:   Mon, 5 Nov 2018 13:39:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 2/7] x86/jump_label: Use text_poke_early() during
 early_init
Message-ID: <20181105123953.GA22467@hirez.programming.kicks-ass.net>
References: <20181102232946.98461-1-namit@vmware.com>
 <20181102232946.98461-3-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181102232946.98461-3-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 04:29:41PM -0700, Nadav Amit wrote:
> diff --git a/init/main.c b/init/main.c
> index a664246450d1..b0fa26637496 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -117,6 +117,8 @@ extern void radix_tree_init(void);
>   */
>  bool early_boot_irqs_disabled __read_mostly;
>  
> +u8 early_boot_done __read_mostly;
> +
>  enum system_states system_state __read_mostly;
>  EXPORT_SYMBOL(system_state);

Should this not be using system_state ^ ? The site is very close to
SYSTEM_SCHEDULING, can we use that or should we add another state ?

> @@ -735,6 +737,8 @@ asmlinkage __visible void __init start_kernel(void)
>  		efi_free_boot_services();
>  	}
>  
> +	early_boot_done = true;
> +
>  	/* Do the rest non-__init'ed, we're now alive */
>  	rest_init();
>  }
> -- 
> 2.17.1
> 
