Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226mEYa/P5vbWfT4Fpa9mqNz1C6afBz3WTQ45CP1iwaCIF9+iy5CleharCLuopudNlk3E9Vj
ARC-Seal: i=1; a=rsa-sha256; t=1519609535; cv=none;
        d=google.com; s=arc-20160816;
        b=fC92ZYmVzhaA2+2Y1JUOW5zJBMn7Ys4eh6oUxGSmpl9xSorTYyAShuhP9WNTOlqMVF
         AfeHCGuB7abDat5/2rBPjhTusHoQjYumVJXW9L002fFm3aBVAYW6/8bbpNdRojsuPViR
         QGKbmGC7g2XIBByiIkm0ZaRj43HUGCNxM9BIr2GS8zPagHszRXQbjWRyeOtUAyGPbfi9
         dANt88Pgl72nP9OIz/O5dKRSTbLhHN4aHVscVm7y7VA6lUzQSb56V072Uu9l0arrdtpe
         10GV0Fg1MqQ9F7l2GVAJXyNQpBODfrMKk77fALQiRK34s+pZCJma7aY/tqzTqzcIc6Cc
         7wgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=Mk64wtyguhYzsthwd5UY7Ywjvqu5yGBArHVGC9bWdTc=;
        b=aSxDeuuZFFgcPYBvxdhMJBxu+qj/jnMo6lesw8EhSAVkV5gYrZ09ZB1U8JlO6ss0PH
         Xf77QaXNZ1dGUGHhU3UmYBEYijXpmrtJPCKtxa6gJbRukNW+hrmAd2SEIpdJcn4zJd13
         guxvORBeV6X4Xhl5oAVbsxiNUP8a2kwhsKB6Cm6KHSLouMd2FFqBOVuDccPQMKVYNKIn
         gmoO4bqJ+W3QItn+fMeA9wwivy/Lnz6TLd7aZM7IKBkpMc4XJ1hwPULEJmrOw/gFdZxq
         YbPmRBlPYATWuWOVMWcveEE+2jAEWgXshi5FLS+yNtoeJzUFkQ9s0lZiuXe7KKLkqGkN
         k7yA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeBZBpf (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 25 Feb 2018 20:45:35 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:48754 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbeBZBpe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Feb 2018 20:45:34 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 26 Feb 2018 10:45:32 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 15/18] tracing: probeevent: Add array type support
Message-ID: <20180226014532.GB1972@sejong>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
 <151945054003.27508.54078842635361756.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151945054003.27508.54078842635361756.stgit@devbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593259396862036062?=
X-GMAIL-MSGID: =?utf-8?q?1593426088086022543?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 24, 2018 at 02:35:40PM +0900, Masami Hiramatsu wrote:
> Add array type support for probe events.
> This allows user to get arraied types from memory address.
> The array type syntax is
> 
> 	TYPE[N]
> 
> Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
> x8/16/32/64, symbol, string) and N is a fixed value less
> than 64.
> 
> The string array type is a bit different from other types. For
> other base types, <base-type>[1] is equal to <base-type>
> (e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
> equal to string. The string type itself represents "char array",
> but string array type represents "char * array". So, for example,
> +0(%di):string[1] is equal to +0(+0(%di)):string.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Add array description in README file
>   - Fix to init s3 code out of loop.
>   - Fix to proceed code when the last code is OP_ARRAY.
>   - Add string array type and bitfield array type.
> ---

[SNIP]
> @@ -546,11 +610,16 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
>  	/* Set argument names as fields */
>  	for (i = 0; i < tp->nr_args; i++) {
>  		struct probe_arg *parg = &tp->args[i];
> -
> -		ret = trace_define_field(event_call, parg->type->fmttype,
> -					 parg->name,
> +		const char *fmt = parg->type->fmttype;
> +		int size = parg->type->size;
> +
> +		if (parg->fmt)
> +			fmt = parg->fmt;
> +		if (parg->count)
> +			size *= parg->count;
> +		ret = trace_define_field(event_call, fmt, parg->name,
>  					 offset + parg->offset,
> -					 parg->type->size,
> +					 parg->type->size * parg->count,

It should use the 'size' variable, otherwise scalar types will have 0 size.

Thanks,
Namhyung


>  					 parg->type->is_signed,
>  					 FILTER_OTHER);
