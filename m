Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F51C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4B99207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 14:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fupqxE4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B99207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeJWXBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 19:01:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeJWXBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 19:01:08 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FF1720652;
        Tue, 23 Oct 2018 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540305445;
        bh=9TXO6j94b2Lcpw9i+7BOPrMo0XSB7M1BSJsdyKpUmVY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fupqxE4GM3JJaLA8DUgsbCirJIxLL4Ym5ngg+7NYhjHlo8VHTKlO3WCtcSgC6JpE2
         RZa1Ddv4DY6TWuEEf1LmkLzQkZ+Mlf4SOOOXivG3o7ug/IZp7TqTO86dr4PEyXotPc
         pGwi+zebWBGci3g1aMtoV0I1DsjCfPZ34s0Ys00s=
Date:   Tue, 23 Oct 2018 23:37:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v6 07/15] tracing: Move hist trigger key printing into a
 separate function
Message-Id: <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
In-Reply-To: <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
        <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Thu, 11 Oct 2018 16:02:04 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Future patches will want to print a histogram key outside a histogram
> - add and use hist_trigger_print_key() for that purpose.

Hmm, I think this change should be done with such user code, because without
the user code I can not decide it is good or not.

Thank you,

> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---
>  kernel/trace/trace_events_hist.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 3712200dc670..5ec462cb7672 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -4849,10 +4849,10 @@ static void hist_trigger_stacktrace_print(struct seq_file *m,
>  	}
>  }
>  
> -static void
> -hist_trigger_entry_print(struct seq_file *m,
> -			 struct hist_trigger_data *hist_data, void *key,
> -			 struct tracing_map_elt *elt)
> +static void hist_trigger_print_key(struct seq_file *m,
> +				   struct hist_trigger_data *hist_data,
> +				   void *key,
> +				   struct tracing_map_elt *elt)
>  {
>  	struct hist_field *key_field;
>  	char str[KSYM_SYMBOL_LEN];
> @@ -4928,6 +4928,17 @@ hist_trigger_entry_print(struct seq_file *m,
>  		seq_puts(m, " ");
>  
>  	seq_puts(m, "}");
> +}
> +
> +static void hist_trigger_entry_print(struct seq_file *m,
> +				     struct hist_trigger_data *hist_data,
> +				     void *key,
> +				     struct tracing_map_elt *elt)
> +{
> +	const char *field_name;
> +	unsigned int i;
> +
> +	hist_trigger_print_key(m, hist_data, key, elt);
>  
>  	seq_printf(m, " hitcount: %10llu",
>  		   tracing_map_read_sum(elt, HITCOUNT_IDX));
> -- 
> 2.14.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
