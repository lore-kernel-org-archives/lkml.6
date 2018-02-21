Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x22761c5XAru+jp3MPbxdPqfklDHfv3RZRW6m8A0PdZuluuDoVrEerJ9kXwRssgiUJcYQkcyi
ARC-Seal: i=1; a=rsa-sha256; t=1519256536; cv=none;
        d=google.com; s=arc-20160816;
        b=YMK7zBUYXRqTzFoGL473MWjt/SEjI7l+ZRPl5MLFfTpmU1vVq/+lUQAqU6sh+XPQ/4
         kb8LPzJRA4b3IMjzMGvoMUfVBHm9kR6h4jwUI2FVCAClKzcOqU+pBlYlDHDEYr5qW4kK
         4PSZ3WogC7geQ013V5YWYteHpbYoB1pzcjyj0R0lU5mvAFcDdGE3qSNBLCzHROEu2FQl
         Qpl4iytrzbnwFu0gRv6ZxzX5O+iJz/dgKARvkqMM3gaFqyyl0c1ce21kOs/FL85HqrrJ
         qrqUmuy1oarftjJqqfZ4Skvy3THIUIKknt45It5Wf/PFToLUj03PeuQvKdRsLL4nd5LY
         e3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=50ypCWYy3r8AgYhVJ3YB9PaXDRzQyiOeEryfDqPRVVs=;
        b=LJvME5Z/eS4HyI89SBajTIckj85QhaeN+1xatD84n4g4m0/h4e3UMuWe80qFHnVAUz
         tvuFES1lMvBiFuCyXM7/W29fzsMXpMUDayQxIxKgNFJrP7yNUFatLCb1bzRV8bfrhivH
         NLxgIS0PCzaCOlvGU3DKb2cjPlzFARMUgOkXhOxBZSYg1lv5AobD4vcc599jIUSaGVIB
         qFseP4dxToSa+/Lm3DTNaic9QwAhGHjfUwBtic/eqS2TmDH5AMvqGz5NgekxzhQltmFs
         Z5GIBORZKQr5J7PKw8nc6Pw4M+Mm99KkEaTt+87NVDEeEzHTB2S0NnzcvU0Rt3igeO0u
         4/IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeBUXmB (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 21 Feb 2018 18:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeBUXl7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Feb 2018 18:41:59 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE3621741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Thu, 22 Feb 2018 08:41:53 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Subject: Re: [PATCH v2 01/17] tracing: probeevent: Fix to support minus
 offset from symbol
Message-Id: <20180222084153.e057d86729063fe39b8232f0@kernel.org>
In-Reply-To: <151922487738.6217.16114601174401123273.stgit@devbox>
References: <151922484560.6217.1143686155616343906.stgit@devbox>
        <151922487738.6217.16114601174401123273.stgit@devbox>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593022783015757505?=
X-GMAIL-MSGID: =?utf-8?q?1593055941793635663?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Steve,

Could you pick this separately since this is a bugfix?

Thank you,

On Wed, 21 Feb 2018 23:54:37 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> In Documentation/trace/kprobetrace.txt, it says
> 
>  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> 
> However, the parser doesn't parse minus offset correctly.
> This fixes the parser to get minus offset correctly.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_kprobe.c |    2 +-
>  kernel/trace/trace_probe.c  |   10 +++++-----
>  kernel/trace/trace_probe.h  |    2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5ce9b8cf7be3..dab4a5b54269 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -754,7 +754,7 @@ static int create_trace_kprobe(int argc, char **argv)
>  		/* a symbol specified */
>  		symbol = argv[1];
>  		/* TODO: support .init module functions */
> -		ret = traceprobe_split_symbol_offset(symbol, &offset);
> +		ret = traceprobe_split_symbol_offset(symbol, (long *)&offset);
>  		if (ret) {
>  			pr_info("Failed to parse either an address or a symbol.\n");
>  			return ret;
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index d59357308677..3e291a754862 100644
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
> @@ -328,13 +328,13 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
>  	if (!offset)
>  		return -EINVAL;
>  
> -	tmp = strchr(symbol, '+');
> +	tmp = strpbrk(symbol, "+-");
>  	if (tmp) {
> -		/* skip sign because kstrtoul doesn't accept '+' */
> -		ret = kstrtoul(tmp + 1, 0, offset);
> +		ret = kstrtoul(tmp + 1, 0, (unsigned long *)offset);
>  		if (ret)
>  			return ret;
> -
> +		if (*tmp == '-')
> +			*offset = -(*offset);
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
