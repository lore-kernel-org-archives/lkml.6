Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224Eqy9ZdieKtO1zsTt8LkBLQp5ciygBU4rpDEy1KDbmKxRDTR6nRp5ZrmlgxuCLsGuArl1r
ARC-Seal: i=1; a=rsa-sha256; t=1519605506; cv=none;
        d=google.com; s=arc-20160816;
        b=bTnADzwcVwh9mszS+xQB4037PrG905XRcMde3qGJNb2AjYwc2W+ziuB/KoUCkb/sn/
         S6SDRDXp+qINJJ5s5n39tHb5xI4vsKf4bJkzJbaiyVzh37ZASIMpXYUNFSPIbtNnwJY/
         CWyX2rca7L9Aey5S/cOfJK2o4h1S2xhUcrL/xoHfb0NvsGnjddJj88ec+/gCLyk2iwB9
         XxQJO4YjpU8HjpYHyBKA9fRxCbyIW3pgMcrDl4QpcgHMYbm0gdeNs3GeXRtA6cAcNDuX
         4OE7Tc29FFKqXCIKQ+ZteicTOcvaNvLPxmSQ9v5Gtbi9b1gp4l9Yjt++3Bkp8Svx7cN8
         UFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=YopX6U7RusWSbBu/mNAJ07WiSaRj1pYzH9qyZv3kcEw=;
        b=ooW/g4PEmlQtSxEUScWkHp4PuQghhOzyhBpzJcAa4THmSOlVtRC3fTKkaAfehSk9ol
         E99vg3OAIaNQjgD58qYg9BlwYIFVFaoi8we+AFPPf4/Qbg+gUpRTh4ZH558HZSQHSwQb
         3VJ2qwfrH+zmGIwV0DMKzLRGsCrMKdxlSUwzWmKQLC60R1DKEevBqCD0Hy0JhnJxbPBz
         QGiwGsVbR00ZGkQac3Ey53V89D2D/rHlxu6sL3IXo68pVQtGhO/Urd/O1NVE062W1eE+
         cbS1CB8YbyxS6s/dxV4ifOkzFkeBuhvDW3Ct6/9Iy0yJ24i6NsE+UbAs0IY95Crm6M5H
         9Giw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751928AbeBZAiZ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 25 Feb 2018 19:38:25 -0500
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:38928 "EHLO
        lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbeBZAiY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Feb 2018 19:38:24 -0500
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 26 Feb 2018 09:38:18 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v3 01/18] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-ID: <20180226003818.GA1972@sejong>
References: <151945010287.27508.6226184958678620828.stgit@devbox>
 <151945013281.27508.4068021929757474274.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <151945013281.27508.4068021929757474274.stgit@devbox>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593258969628938667?=
X-GMAIL-MSGID: =?utf-8?q?1593421863496659659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On Sat, Feb 24, 2018 at 02:28:52PM +0900, Masami Hiramatsu wrote:
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
> 
> Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
> ---
>  kernel/trace/trace_kprobe.c |    4 ++--
>  kernel/trace/trace_probe.c  |    8 +++-----
>  kernel/trace/trace_probe.h  |    2 +-
>  3 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 5ce9b8cf7be3..b5b1d8aa47d6 100644
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
> +		if (ret || offset < 0) {

Hmm.. is minus offset an error?  Then why not removing it from the
documentation?  And the 'ret' would be 0 in that case.


>  			pr_info("Failed to parse either an address or a symbol.\n");
>  			return ret;
>  		}
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index d59357308677..d3d1ee820336 100644
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
> +		ret = kstrtol(tmp + 1, 0, offset);

It should not skip the sign anymore.

Thanks,
Namhyung


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
