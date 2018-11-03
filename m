Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07262C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5476204FD
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 16:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJtAJXuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5476204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbeKDBdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbeKDBdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:33:40 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E5A2204FD;
        Sat,  3 Nov 2018 16:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541262114;
        bh=OLA5z9tYVQ4CmQZlgUn1pe5Ohccc/hnaeweWA07lYgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jJtAJXuEACm6WGPp/b51zTt2VSqaIoxXA7xQ8nJrIMl/JvnEAU2P96z4te5HVvPye
         AAUMCW7C3mGDs/CtRhUovmktAnLkyqkdOVsSEat6jXKOH6eaVEdN0pkpc1892zmQkj
         edMm4YxmnZ1YvV2AjtLanbeUD9OdHuNbUB0LL7aI=
Date:   Sun, 4 Nov 2018 01:21:52 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix strpbrk() argument order
Message-Id: <20181104012152.fba4c3a75ccc9dce416988ec@kernel.org>
In-Reply-To: <20181103091754.33189927@vmware.local.home>
References: <154108256792.2604.1816052586385217811.stgit@devbox>
        <20181101151014.2feccd51@gandalf.local.home>
        <20181102161459.86f0622bd01518a2eb06e1d5@kernel.org>
        <20181102095424.20c500ea@gandalf.local.home>
        <20181103205448.15b667077e0b72fcd6147239@kernel.org>
        <20181103091754.33189927@vmware.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 09:17:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:


> > > Then I tested with this:
> > > 
> > > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > > index 3ef15a6683c0..4ddafddf1343 100644
> > > --- a/kernel/trace/trace_probe.c
> > > +++ b/kernel/trace/trace_probe.c
> > > @@ -516,6 +516,7 @@ void traceprobe_free_probe_arg(struct probe_arg
> > > *arg) kfree(code->data);
> > >  		code++;
> > >  	}
> > > +	printk("free arg->code %s\n", arg->code);
> > >  	kfree(arg->code);
> > >  	kfree(arg->name);
> > >  	kfree(arg->comm);
> > > @@ -535,11 +536,15 @@ int traceprobe_update_arg(struct probe_arg *arg)
> > >  			if (code[1].op != FETCH_OP_IMM)
> > >  				return -EINVAL;
> > >  
> > > +			tmp = strpbrk(code->data, "+-");
> > > +			printk("first tmp tmp=%s\n", tmp);
> > >  			tmp = strpbrk("+-", code->data);
> > > +			printk("second tmp=%s data=%s\n", tmp,
> > > code->data); if (tmp)
> > >  				c = *tmp;
> > >  			ret =
> > > traceprobe_split_symbol_offset(code->data, &offset);
> > > +			printk("third data=%s\n", code->data);
> > >  			if (ret)
> > >  				return ret;
> > >  
> > > @@ -547,6 +552,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
> > >  				(unsigned
> > > long)kallsyms_lookup_name(code->data); if (tmp)
> > >  				*tmp = c;
> > > +			printk("forth data=%s\n", code->data);
> > >  			if (!code[1].immediate)
> > >  				return -ENOENT;
> > >  			code[1].immediate += offset;
> > > 
> > > And I don't see where that code->data is used elsewhere. That is, why
> > > even bother saving the character?  
> > 
> > Would you mean parsing the symbol+offs every time is useless?
> > It needs to solve the symbol address always because  traceprobe_update_arg
> > is called when new symbols added on the kernel (by loading modules).
> 
> OK, so it is called multiple times? That is when a module is loaded?
> Because I couldn't get this called multiple times.

Sorry I mislead you.
See trace_kprobe_module_callback(), which calls __register_trace_kprobe()
if the probepoint is on the module. And __register_trace_kprobe() calls
traceprobe_update_arg().
So, if you call it multiple time, it should be with the probe point is
on the module too.

e.g.

 echo "p newmod:function @var_symbol+offset" > kprobe_events

can be called multiple times if we load/unload "newmod" module.

> I'll try that out and if that's the case, then yeah, this needs to be
> fixed (otherwise, I was thinking we could just remove the strpbrk()
> altogether).
> 
> 
> > 
> > Hmm, maybe I can introduce a struct like 
> > 
> > struct symbol_offset {
> > 	long offset;
> > 	char symbol[];
> > };
> > 
> > and use it instead of parsing the symbol+offset always.
> 
> The parsing should be fine. The issue I had was that I couldn't trigger
> it to happen more than once. That's why this passed testing. We didn't
> do something that required it to be called more than once and that is
> here the bug would trigger.

Hmm, I hit it by kprobe_args_syntax.tc, so hit once is enough to kick
this bug. Maybe some config option makes "+-" readonly, which previously
didn't enabled.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
