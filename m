Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8212081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 07:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPLwG/om"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E8212081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeKBQVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 12:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbeKBQVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 12:21:11 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103452081B;
        Fri,  2 Nov 2018 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541142901;
        bh=+uvA0j+/s13IzeiplFZwsyZytoTU0uCf9AsT3aO17k0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EPLwG/om+c7gDGizlN/E0UpiowO7P+rr8kdAZlGRQQg5+R8SHSwyj29hc8MMyeUDV
         rSNkyeLDJaBoVWxysobb4wozrc1YY6R4loXmHEYqEuGqn69WqQld2Fhf6ePbuTjJur
         QCNQjWemu/6YI4NvEx22bZzV1OS5uTzi8b3s/s9M=
Date:   Fri, 2 Nov 2018 16:14:59 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [BUGFIX PATCH] tracing/kprobes: Fix strpbrk() argument order
Message-Id: <20181102161459.86f0622bd01518a2eb06e1d5@kernel.org>
In-Reply-To: <20181101151014.2feccd51@gandalf.local.home>
References: <154108256792.2604.1816052586385217811.stgit@devbox>
        <20181101151014.2feccd51@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2018 15:10:14 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu,  1 Nov 2018 23:29:28 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Fix strpbrk()'s argument order, it must pass acceptable string
> > in 2nd argument. Note that this can cause a kernel panic where
> > it recovers backup character to code->data.
> > 
> > Fixes: a6682814f371 ("tracing/kprobes: Allow kprobe-events to record module symbol")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks Masami,
> 
> I'm pulling this and starting to test it.

Thank you! I still couldn't believe how this bug passed through the tests...

> 
> -- Steve
> 
> > ---
> >  kernel/trace/trace_probe.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> > index 3ef15a6683c0..bd30e9398d2a 100644
> > --- a/kernel/trace/trace_probe.c
> > +++ b/kernel/trace/trace_probe.c
> > @@ -535,7 +535,7 @@ int traceprobe_update_arg(struct probe_arg *arg)
> >  			if (code[1].op != FETCH_OP_IMM)
> >  				return -EINVAL;
> >  
> > -			tmp = strpbrk("+-", code->data);
> > +			tmp = strpbrk(code->data, "+-");
> >  			if (tmp)
> >  				c = *tmp;
> >  			ret = traceprobe_split_symbol_offset(code->data,
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
