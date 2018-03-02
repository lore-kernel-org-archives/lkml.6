Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsiVzutbbDhTh7eJRyFchW4tOV3ooHoEUr48FKDFMcAAfTteQnLxDGo1+8D44T7Qz7RvpoZ
ARC-Seal: i=1; a=rsa-sha256; t=1519966198; cv=none;
        d=google.com; s=arc-20160816;
        b=Z2/yUpclu4Chgfd9szAhmVGAD0gm7hJcFgXMaPh+Y0pNjfJdi9YuED0TzoZMdeScwc
         rSdzZpTEYKPe2xxrL6eyd42KHwPl9GW4RjW8rWSLcjVg6OE7Ek2NzA27/71FaGVRB7Yd
         LjRDv8kU7a/q/TvFccPg0JwW+eTVFC0LR28T9ecPPx+jWF9zhgdmz7+OyIdC/qJVIs/A
         p1CdxrQMw/Efg/D1Gl5OSGCH8fFfkqLzLtTdwN4/cz8sXfLbZmrn30TNcWViJV/Vir+f
         oivu3BqK3a8jMGiKyWJhIaffmR6nI24fGFbV6Nib/uNLkpF8FPEaFeMgsfGZWUEm28A2
         aZOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=BA6FRJIk1Aj+j7eM1COmC5x2H9hN2wuiuCX4lHkzG+w=;
        b=sZUiKl+WXNB7ZSgzyZ4J/TkaU2TsEgYGEiSDk1q70bJWgTyhfAJo1UDxYXVYDNGKW8
         CcHcHboDPxfWJtRP90I/3wALR0tTiOgfz8G4QlTMjmtTaTQ0t6LCYXt4+qxZukBzZ0gd
         tNfNGdAaJgmGMTDCyZlD5kz7qUXwLQKe2snmUW1dKCnSmUhycfjC09Ni68HMyYd3Bl7x
         aGWhxbprSWBljlsUCQ9E/sujxaHn92FTFVCGwqYCDqMNIlVycT/KZvuCnJuT/k4WlU0o
         pkLIRzSN/i6OphstjrZ/SnjgM895HdvxCURtYiDRJOHZFl+5vthybMTlGndPibogtyg4
         OUdw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422664AbeCBEt5 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 1 Mar 2018 23:49:57 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:37321 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164967AbeCBEtx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Mar 2018 23:49:53 -0500
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Fri, 2 Mar 2018 13:49:51 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 01/19] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-ID: <20180302044951.GA31540@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
 <151978799370.2577.9456049827647614166.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151978799370.2577.9456049827647614166.stgit@devbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613247827918493?=
X-GMAIL-MSGID: =?utf-8?q?1593800077171867595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On Wed, Feb 28, 2018 at 12:19:53PM +0900, Masami Hiramatsu wrote:
> In Documentation/trace/kprobetrace.txt, it says
> 
>  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> 
> However, the parser doesn't parse minus offset correctly, since
> commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
> unsigned") drops minus ("-") offset support for kprobe probe
> address usage.
> 
> This fixes the traceprobe_split_symbol_offset() to parse minus
> offset again with checking the offset range, and add a minus
> offset check in kprobe probe address usage.

It now parses a minus offset but doesn't allow it, right?
Then I still think it's better to fix the documentation.


> 
> Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
>  Changes in v4:
>   - Fix to decode sign. (Thanks Namhyung!)
>   - Fix to check UINT_MAX for kprobe offset.
> ---
>  kernel/trace/trace_kprobe.c |    4 ++--
>  kernel/trace/trace_probe.c  |    8 +++-----
>  kernel/trace/trace_probe.h  |    2 +-
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5ce9b8cf7be3..1cd3fb4d70f8 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -667,7 +667,7 @@ static int create_trace_kprobe(int argc, char **argv)
>  	char *symbol = NULL, *event = NULL, *group = NULL;
>  	int maxactive = 0;
>  	char *arg;
> -	unsigned long offset = 0;
> +	long offset = 0;
>  	void *addr = NULL;
>  	char buf[MAX_EVENT_NAME_LEN];
>  
> @@ -755,7 +755,7 @@ static int create_trace_kprobe(int argc, char **argv)
>  		symbol = argv[1];
>  		/* TODO: support .init module functions */
>  		ret = traceprobe_split_symbol_offset(symbol, &offset);
> -		if (ret) {
> +		if (ret || offset < 0 || offset > UINT_MAX) {
>  			pr_info("Failed to parse either an address or a symbol.\n");
>  			return ret;

Wouldn't it be confusing if it returns 0 for an invalid input?

Thanks,
Namhyung


>  		}
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index d59357308677..daf54bda4dc8 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -320,7 +320,7 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
>  }
>  
>  /* Split symbol and offset. */
> -int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> +int traceprobe_split_symbol_offset(char *symbol, long *offset)
>  {
>  	char *tmp;
>  	int ret;
> @@ -328,13 +328,11 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
>  	if (!offset)
>  		return -EINVAL;
>  
> -	tmp = strchr(symbol, '+');
> +	tmp = strpbrk(symbol, "+-");
>  	if (tmp) {
> -		/* skip sign because kstrtoul doesn't accept '+' */
> -		ret = kstrtoul(tmp + 1, 0, offset);
> +		ret = kstrtol(tmp, 0, offset);
>  		if (ret)
>  			return ret;
> -
>  		*tmp = '\0';
>  	} else
>  		*offset = 0;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 0745f895f780..75daff22ccea 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -365,7 +365,7 @@ extern int traceprobe_conflict_field_name(const char *name,
>  extern void traceprobe_update_arg(struct probe_arg *arg);
>  extern void traceprobe_free_probe_arg(struct probe_arg *arg);
>  
> -extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
> +extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
>  
>  /* Sum up total data length for dynamic arraies (strings) */
>  static nokprobe_inline int
> 
