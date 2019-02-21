Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E6BC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4293620818
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfBUQcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:47062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbfBUQcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:32:54 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A127E20818;
        Thu, 21 Feb 2019 16:32:53 +0000 (UTC)
Date:   Thu, 21 Feb 2019 11:32:51 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
Message-ID: <20190221113251.60ca29be@gandalf.local.home>
In-Reply-To: <20190222011643.3e19ade84a3db3e83518648f@kernel.org>
References: <20190215174712.372898450@goodmis.org>
        <20190215174945.557218316@goodmis.org>
        <20190221165252.4a9033b3348f30f9d973dbc4@kernel.org>
        <20190221093625.56afccd2@gandalf.local.home>
        <20190222005812.04c5940c693b14cfdbe6ede7@kernel.org>
        <20190222011643.3e19ade84a3db3e83518648f@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


[ Linus, you may want to read this ]

On Fri, 22 Feb 2019 01:16:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


Yep, I'll take this patch. Hmm, my for-next isn't based on my urgent
branch, and this would go on top of urgent. I can do one of three
things to push this to Linus for the merge window:

 1) Create a separate branch to add updates for on my urgent branch.
    This would have me do two pull requests to Linus.

 2) Cherry pick the urgent commit that this updates.
    But that has a stable tag, which could confuse things as it would
    create the same commit twice, both with stable tags (I could take
    the stable tag off of the cherry pick though).

 3) Merge the urgent branch into my for-next branch at that commit,
    with a message to why I'm doing this. The urgent branch is based
    off of a older tag in Linus's tree, so that would only pull in
    tracing changes (my stuff), and wont pull in anyone else's work.

I may go with option 3, because I believe this may be one of the cases
that is allowed to have merges in pull requests.

 a) Only my stuff got merged
 b) Have a dependency on something that already went into Linus's tree
    (prevent me from having to rebase already tested work).
 c) Have it documented in the merge commit to why its being merged

Unless Linus feels otherwise (use one of the other options?), I may go
ahead and do that.

-- Steve

> ---------
> tracing/kprobes: Use probe_kernel_read instead of probe_mem_read
> 
> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Use probe_kernel_read() instead of probe_mem_read() because
> probe_mem_read() is a kind of wrapper for switching memory
> read function between uprobes and kprobes.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9eaf07f99212..99592c27465e 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -865,7 +865,7 @@ fetch_store_strlen(unsigned long addr)
>  	u8 c;
>  
>  	do {
> -		ret = probe_mem_read(&c, (u8 *)addr + len, 1);
> +		ret = probe_kernel_read(&c, (u8 *)addr + len, 1);
>  		len++;
>  	} while (c && ret == 0 && len < MAX_STRING_SIZE);
>  
> 

