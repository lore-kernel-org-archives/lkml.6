Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELv0wI27dXRVqWXX5p+2arBI9vYsIGugSyBOs48UlBRXti1c/amK3OxJ0THImF+wzxmIMRN3
ARC-Seal: i=1; a=rsa-sha256; t=1519972354; cv=none;
        d=google.com; s=arc-20160816;
        b=zHWZ/o5JIAvHyyMjxDb6magEgBYUQ9zw4C57niUV5Z7Qa2MnCB5hQoz9C/z5KRP4gx
         64rk4z8twldx9uildSb6rGBySV7jX+UXVHJ9QW63KBcuAKmEelnz81bzFHhXS5JAcJSF
         3HtOfApcDNPa/KO7JLGuEcglXFx/OSkpFPhEyq+2U//+993VOZOztGA92L2OqZAgtAtL
         1L/Pp1fO1Bkf7tFUl3Q9/5LMHQSUm8luc06pPSHqLbw4YoZXjw+1Qtq+p7xPMLzIKqTn
         B+MuAtZdvffxGdFPiU5/NbsamF63D9Nfvi4p1+IEyYTthP45k/gHFGUcxVrnwVkHFU6x
         ETdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=fBm1CmOpazP16XD7e8Um55KZ1ya7p3GK4W5ioyMrRgY=;
        b=UVizSM8FclX0D9em34UX17aQSM0IiN/OQtFoopGXZhSXctYUZacjr71ugIpL2GfD4p
         tmIyVpvKe01RB+B8vResVJSx08Z96i8erSaFg3/CFkNH6EjwjDNx0IWn1IhjLJrZcucY
         kqISAE5tmif+PTArzmm/aq3zpeYMMNh+EO8EHSxWsLhBYZVhR0WoKUtoiBCF/4CVzxgF
         ehArwSZ6jdpBEF0Vspeuu7LGzrjmzeREJLK11dsb9fP8wtZ+ckvPzMgM/PQKGJCeFVys
         x90zMh3MM25rn+q69LXAcFUJyO0jsDDog6RS4kd1lmczHSw6vrFbEchRT2WejJwz+qyF
         VkLg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164477AbeCBGce (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 2 Mar 2018 01:32:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164291AbeCBGcd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Mar 2018 01:32:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42B472133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 2 Mar 2018 15:32:29 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v4 01/19] [BUGFIX] tracing: probeevent: Fix to support
 minus offset from symbol
Message-Id: <20180302153229.dbc4dc9be90a0132b7010010@kernel.org>
In-Reply-To: <20180302044951.GA31540@sejong>
References: <151978796240.2577.6531711990653677529.stgit@devbox>
        <151978799370.2577.9456049827647614166.stgit@devbox>
        <20180302044951.GA31540@sejong>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593613247827918493?=
X-GMAIL-MSGID: =?utf-8?q?1593806532092758181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 13:49:51 +0900
Namhyung Kim <namhyung@kernel.org> wrote:

> Hi Masami,
> 
> On Wed, Feb 28, 2018 at 12:19:53PM +0900, Masami Hiramatsu wrote:
> > In Documentation/trace/kprobetrace.txt, it says
> > 
> >  @SYM[+|-offs] : Fetch memory at SYM +|- offs (SYM should be a data symbol)
> > 
> > However, the parser doesn't parse minus offset correctly, since
> > commit 2fba0c8867af ("tracing/kprobes: Fix probe offset to be
> > unsigned") drops minus ("-") offset support for kprobe probe
> > address usage.
> > 
> > This fixes the traceprobe_split_symbol_offset() to parse minus
> > offset again with checking the offset range, and add a minus
> > offset check in kprobe probe address usage.
> 
> It now parses a minus offset but doesn't allow it, right?

No, split_symbol_offset() is used for 2 cases
 - kprobe-event probe point
 - kporbe-event symbol-based argument

Former one doesn't accept a minus offset, but latter accepts it.

(Frankly to say, I guess no one care about supporting minus offset :P)

Thanks,

> Then I still think it's better to fix the documentation.
> 
> 
> > 
> > Fixes: 2fba0c8867af ("tracing/kprobes: Fix probe offset to be unsigned")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  Changes in v3:
> >   - Use kstrtol instead of kstrtoul. (Thanks Namhyung!)
> >  Changes in v4:
> >   - Fix to decode sign. (Thanks Namhyung!)
> >   - Fix to check UINT_MAX for kprobe offset.
> > ---
> >  kernel/trace/trace_kprobe.c |    4 ++--
> >  kernel/trace/trace_probe.c  |    8 +++-----
> >  kernel/trace/trace_probe.h  |    2 +-
> >  3 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 5ce9b8cf7be3..1cd3fb4d70f8 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -667,7 +667,7 @@ static int create_trace_kprobe(int argc, char **argv)
> >  	char *symbol = NULL, *event = NULL, *group = NULL;
> >  	int maxactive = 0;
> >  	char *arg;
> > -	unsigned long offset = 0;
> > +	long offset = 0;
> >  	void *addr = NULL;
> >  	char buf[MAX_EVENT_NAME_LEN];
> >  
> > @@ -755,7 +755,7 @@ static int create_trace_kprobe(int argc, char **argv)
> >  		symbol = argv[1];
> >  		/* TODO: support .init module functions */
> >  		ret = traceprobe_split_symbol_offset(symbol, &offset);
> > -		if (ret) {
> > +		if (ret || offset < 0 || offset > UINT_MAX) {
> >  			pr_info("Failed to parse either an address or a symbol.\n");
> >  			return ret;
> 
> Wouldn't it be confusing if it returns 0 for an invalid input?
> 
> Thanks,
> Namhyung
> 
> 
> >  		}
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index d59357308677..daf54bda4dc8 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -320,7 +320,7 @@ static fetch_func_t get_fetch_size_function(const struct fetch_type *type,
> >  }
> >  
> >  /* Split symbol and offset. */
> > -int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> > +int traceprobe_split_symbol_offset(char *symbol, long *offset)
> >  {
> >  	char *tmp;
> >  	int ret;
> > @@ -328,13 +328,11 @@ int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset)
> >  	if (!offset)
> >  		return -EINVAL;
> >  
> > -	tmp = strchr(symbol, '+');
> > +	tmp = strpbrk(symbol, "+-");
> >  	if (tmp) {
> > -		/* skip sign because kstrtoul doesn't accept '+' */
> > -		ret = kstrtoul(tmp + 1, 0, offset);
> > +		ret = kstrtol(tmp, 0, offset);
> >  		if (ret)
> >  			return ret;
> > -
> >  		*tmp = '\0';
> >  	} else
> >  		*offset = 0;
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 0745f895f780..75daff22ccea 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -365,7 +365,7 @@ extern int traceprobe_conflict_field_name(const char *name,
> >  extern void traceprobe_update_arg(struct probe_arg *arg);
> >  extern void traceprobe_free_probe_arg(struct probe_arg *arg);
> >  
> > -extern int traceprobe_split_symbol_offset(char *symbol, unsigned long *offset);
> > +extern int traceprobe_split_symbol_offset(char *symbol, long *offset);
> >  
> >  /* Sum up total data length for dynamic arraies (strings) */
> >  static nokprobe_inline int
> > 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
