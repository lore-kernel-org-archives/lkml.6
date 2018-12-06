Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332E8C5CFFE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3343208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:01:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WpsOaBir"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3343208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeLFKBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:01:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeLFKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=afwQ0qh9MbNdNZ2OyRpkWK2h5apCJ6FvFvOC/iuZX2A=; b=WpsOaBirBGWPB2HmgU91YFISM
        +S1TBRy/7Cn7VGJc+J4XtS5s/Xa1TyQVTiIfXWaWDS7PFcQPjgETC8SKznIJtsL3D3GRwAYq4mBxw
        7UFPopAQFNfXgOROd+jwN/kyni1gewM6CUPX3+xpnQAUwMl1WJENctSlGblAkL8ZDnDpNvh49/GHW
        O062VsxYKhZOcB7w8dJ8D4KNfxEPbOSHgqIKGQIxrR/Brz1gY5EWxtz0xH0bNMnMsxJFSUrFAzlYw
        tRmtDZ4Tl+EJSmeb/eCAk8Mc9MCnQ9raIQFt5rLjclMXgqdHz3gODrnz+GK1/srb3Hhyqv9MHu1xL
        wY07mfWkw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gUqT4-00072a-2M; Thu, 06 Dec 2018 10:01:14 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 933EB200FBC3D; Thu,  6 Dec 2018 11:01:12 +0100 (CET)
Date:   Thu, 6 Dec 2018 11:01:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v7 14/14] module: Prevent module removal racing with
 text_poke()
Message-ID: <20181206100112.GE13538@hirez.programming.kicks-ass.net>
References: <20181205013408.47725-1-namit@vmware.com>
 <20181205013408.47725-15-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205013408.47725-15-namit@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 05:34:08PM -0800, Nadav Amit wrote:
> It seems dangerous to allow code modifications to take place
> concurrently with module unloading. So take the text_mutex while the
> memory of the module is freed.

Fun detail, only x86 seems to actually take text_mutex while poking
text.

> Signed-off-by: Nadav Amit <namit@vmware.com>
> ---
>  kernel/module.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 57c5b23746e7..b45754961143 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -64,6 +64,7 @@
>  #include <linux/bsearch.h>
>  #include <linux/dynamic_debug.h>
>  #include <linux/audit.h>
> +#include <linux/memory.h>
>  #include <uapi/linux/module.h>
>  #include "module-internal.h"
>  
> @@ -2181,6 +2182,9 @@ static void free_module(struct module *mod)
>  	synchronize_sched();
>  	mutex_unlock(&module_mutex);
>  
> +	/* Protect against patching of the module while it is being removed */
> +	mutex_lock(&text_mutex);
> +
>  	/* This may be empty, but that's OK */
>  	module_restore_mappings(&mod->init_layout);
>  	module_arch_freeing_init(mod);
> @@ -2194,6 +2198,7 @@ static void free_module(struct module *mod)
>  	/* Finally, free the core (containing the module structure) */
>  	module_restore_mappings(&mod->core_layout);
>  	module_memfree(mod->core_layout.base);
> +	mutex_unlock(&text_mutex);
>  }
>  
>  void *__symbol_get(const char *symbol)
> -- 
> 2.17.1
> 
