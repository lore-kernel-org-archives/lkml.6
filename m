Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A4ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EBC2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 21:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EBC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbeJ0GUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 02:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbeJ0GUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 02:20:18 -0400
Received: from vmware.local.home (unknown [95.87.249.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0067E2064C;
        Fri, 26 Oct 2018 21:41:37 +0000 (UTC)
Date:   Fri, 26 Oct 2018 17:41:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tracing: merge seq_print_sym_short() and
 seq_print_sym_offset()
Message-ID: <20181026174133.46d899f1@vmware.local.home>
In-Reply-To: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
References: <20181026211347.2442-1-linux@rasmusvillemoes.dk>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ramus,

Thanks for sending these patches. I have some small nits though.

First, please send a cover letter whenever sending more than one patch.
It just groups them better in my inbox.

The second is embedded below.

On Fri, 26 Oct 2018 23:13:44 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> These two functions are nearly identical, so we can avoid some code
> duplication by moving the conditional into a common implementation.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
>  kernel/trace/trace_output.c | 34 +++++++---------------------------
>  1 file changed, 7 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> index 6e6cc64faa38..501311dcfca6 100644
> --- a/kernel/trace/trace_output.c
> +++ b/kernel/trace/trace_output.c
> @@ -339,34 +339,17 @@ static inline const char *kretprobed(const char *name)
>  #endif /* CONFIG_KRETPROBES */
>  
>  static void
> -seq_print_sym_short(struct trace_seq *s, const char *fmt, unsigned long address)
> +seq_print_sym(struct trace_seq *s, const char *fmt, unsigned long address,
> +	      bool with_offset)

Just call the variable "offset". It's rather obvious what that means.

The other patches look good, but can you send a v2 of the series, with
these updates?

Thanks!

-- Steve


>  {
>  	char str[KSYM_SYMBOL_LEN];
>  #ifdef CONFIG_KALLSYMS
>  	const char *name;
>  
> -	kallsyms_lookup(address, NULL, NULL, NULL, str);
> -
> -	name = kretprobed(str);
> -
> -	if (name && strlen(name)) {
> -		trace_seq_printf(s, fmt, name);
> -		return;
> -	}
> -#endif
> -	snprintf(str, KSYM_SYMBOL_LEN, "0x%08lx", address);
> -	trace_seq_printf(s, fmt, str);
> -}
> -
> -static void
> -seq_print_sym_offset(struct trace_seq *s, const char *fmt,
> -		     unsigned long address)
> -{
> -	char str[KSYM_SYMBOL_LEN];
> -#ifdef CONFIG_KALLSYMS
> -	const char *name;
> -
> -	sprint_symbol(str, address);
> +	if (with_offset)
> +		sprint_symbol(str, address);
> +	else
> +		kallsyms_lookup(address, NULL, NULL, NULL, str);
>  	name = kretprobed(str);
>  
>  	if (name && strlen(name)) {
> @@ -424,10 +407,7 @@ seq_print_ip_sym(struct trace_seq *s, unsigned long ip, unsigned long sym_flags)
>  		goto out;
>  	}
>  
> -	if (sym_flags & TRACE_ITER_SYM_OFFSET)
> -		seq_print_sym_offset(s, "%s", ip);
> -	else
> -		seq_print_sym_short(s, "%s", ip);
> +	seq_print_sym(s, "%s", ip, sym_flags & TRACE_ITER_SYM_OFFSET);
>  
>  	if (sym_flags & TRACE_ITER_SYM_ADDR)
>  		trace_seq_printf(s, " <" IP_FMT ">", ip);

