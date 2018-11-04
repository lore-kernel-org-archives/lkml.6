Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B53EC0044C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EBE2082E
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 02:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBqTM++/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8EBE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeKDL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 06:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:32868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeKDL03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 06:26:29 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F32F2082E;
        Sun,  4 Nov 2018 02:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541297598;
        bh=2pBmTKr0Mj1DuT8q6LHwX+3/bG8sIGECYp3R7Cj0Uxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VBqTM++/badxD22KpL0Tyv1mT2ozKUWLF7LWrSrJI3O/er8ADwuchaNvHOt2J5Kfd
         9o8twUIdVL0w/yI5Y/DOplC9BL4w3L9S58gH7qB7Fh+O6xz3dqcEUPN1Zf0tYElpqX
         oQew0BHJwcXkzq1gZVi57v+fBGizZ49InmUb/M/k=
Date:   Sun, 4 Nov 2018 11:13:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tracing/kprobes: Avoid parsing symbol+offset when
 updating arguments
Message-Id: <20181104111315.c065079b88477e62bedc127d@kernel.org>
In-Reply-To: <20181103134317.68873bd8@vmware.local.home>
References: <20181103205448.15b667077e0b72fcd6147239@kernel.org>
        <154126101356.14912.1379688281618914741.stgit@devbox>
        <20181103134317.68873bd8@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 13:43:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun,  4 Nov 2018 01:03:34 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Introduce symbol_offset data structure for avoiding symbol+offset
> > parsing when updating arguments.
> > 
> > For kprobe events, "@symbol+offset" is supported, that requires
> > to be updated when new module is loaded because @symbol address
> > can be solved at that point. Currently kprobe events saves
> > the "symbol+offset" string and parse it repeatedly, but that
> > is inefficient.
> 
> Do we care if it's inefficient? It's only done on module load and at
> the beginning. That's far from a fast path.
> 
> If anything, the original solution saves memory, which is a bigger
> concern than speed in this case.

OK, and original one saves lines too. Please drop it :)

Thank you,

> 
> -- Steve
> 
> 
> > This introduces symbol_offset data structure which can save the
> > offset and symbol separated, so that we don't need to parse it
> > anymore.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_probe.c |   49 +++++++++++++++++++++++++-------------------
> >  kernel/trace/trace_probe.h |    7 +++++-
> >  2 files changed, 34 insertions(+), 22 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index bd30e9398d2a..0a3af7d6e133 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -201,6 +201,26 @@ static int parse_probe_vars(char *arg, const struct fetch_type *t,
> >  	return ret;
> >  }
> >  
> > +static struct symbol_offset *allocate_symbol_offset(char *sym_offs_str)
> > +{
> > +	int ret;
> > +	long offset = 0;
> > +	struct symbol_offset *sof;
> > +
> > +	ret = traceprobe_split_symbol_offset(sym_offs_str, &offset);
> > +	if (ret)
> > +		return ERR_PTR(ret);
> > +
> > +	sof = kzalloc(sizeof(struct symbol_offset) + strlen(sym_offs_str) + 1,
> > +			GFP_KERNEL);
> > +	if (!sof)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	sof->offset = offset;
> > +	strcpy(sof->symbol, sym_offs_str);
> > +	return sof;
> > +}
> > +
> >  /* Recursive argument parser */
> >  static int
> >  parse_probe_arg(char *arg, const struct fetch_type *type,
> > @@ -253,9 +273,9 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
> >  
> >  			/* Preserve symbol for updating */
> >  			code->op = FETCH_NOP_SYMBOL;
> > -			code->data = kstrdup(arg + 1, GFP_KERNEL);
> > -			if (!code->data)
> > -				return -ENOMEM;
> > +			code->symoffs = allocate_symbol_offset(arg + 1);
> > +			if (IS_ERR(code->symoffs))
> > +				return PTR_ERR(code->symoffs);
> >  			if (++code == end)
> >  				return -E2BIG;
> >  
> > @@ -483,7 +503,7 @@ int traceprobe_parse_probe_arg(char *arg, ssize_t *size,
> >  	if (ret) {
> >  		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
> >  			if (code->op == FETCH_NOP_SYMBOL)
> > -				kfree(code->data);
> > +				kfree(code->symoffs);
> >  	}
> >  	kfree(tmp);
> >  
> > @@ -513,7 +533,7 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
> >  
> >  	while (code && code->op != FETCH_OP_END) {
> >  		if (code->op == FETCH_NOP_SYMBOL)
> > -			kfree(code->data);
> > +			kfree(code->symoffs);
> >  		code++;
> >  	}
> >  	kfree(arg->code);
> > @@ -525,31 +545,18 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
> >  int traceprobe_update_arg(struct probe_arg *arg)
> >  {
> >  	struct fetch_insn *code = arg->code;
> > -	long offset;
> > -	char *tmp;
> > -	char c;
> > -	int ret = 0;
> >  
> >  	while (code && code->op != FETCH_OP_END) {
> >  		if (code->op == FETCH_NOP_SYMBOL) {
> >  			if (code[1].op != FETCH_OP_IMM)
> >  				return -EINVAL;
> >  
> > -			tmp = strpbrk(code->data, "+-");
> > -			if (tmp)
> > -				c = *tmp;
> > -			ret = traceprobe_split_symbol_offset(code->data,
> > -							     &offset);
> > -			if (ret)
> > -				return ret;
> > -
> >  			code[1].immediate =
> > -				(unsigned long)kallsyms_lookup_name(code->data);
> > -			if (tmp)
> > -				*tmp = c;
> > +				(unsigned long)kallsyms_lookup_name(
> > +						code->symoffs->symbol);
> >  			if (!code[1].immediate)
> >  				return -ENOENT;
> > -			code[1].immediate += offset;
> > +			code[1].immediate += code->symoffs->offset;
> >  		}
> >  		code++;
> >  	}
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 974afc1a3e73..942424d05427 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -103,6 +103,11 @@ enum fetch_op {
> >  	FETCH_NOP_SYMBOL,	/* Unresolved Symbol holder */
> >  };
> >  
> > +struct symbol_offset {
> > +	long offset;
> > +	char symbol[];
> > +};
> > +
> >  struct fetch_insn {
> >  	enum fetch_op op;
> >  	union {
> > @@ -117,7 +122,7 @@ struct fetch_insn {
> >  			unsigned char rshift;
> >  		};
> >  		unsigned long immediate;
> > -		void *data;
> > +		struct symbol_offset *symoffs;
> >  	};
> >  };
> >  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
