Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F29E1C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD1D620891
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUfRPWdP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1D620891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeGYQrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:39110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728360AbeGYQrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:47:39 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5428820843;
        Wed, 25 Jul 2018 15:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532532928;
        bh=1bXEJvFObp3RhoaJZKqUD/l+lQmwlm98uLUxbViaNxA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HUfRPWdPYfrB1UrSK10ftJai7xXjj6RE6qIFT+rbnQJwssqva7bJyJFTBiAvy2u/I
         jUUDihMwP4KJRrS3U/6cU2ujD3siP++BauSw/KRd8cn6Qq7TLU3fi9ogV5W+xT0jUy
         NIJhh5sVrnCQ4KFnuX29L2IF9O32ZUXIXmZyfquw=
Date:   Thu, 26 Jul 2018 00:35:24 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Artem Savkov <asavkov@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: fix trace_probe flags in enable_trace_kprobe
Message-Id: <20180726003524.e5ad32fc6b30476ccb0ebdc5@kernel.org>
In-Reply-To: <20180725092151.11b9f2e1@gandalf.local.home>
References: <20180725102826.8300-1-asavkov@redhat.com>
        <20180725092151.11b9f2e1@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 09:21:51 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Adding Masami to Cc ]
> 
> On Wed, 25 Jul 2018 12:28:26 +0200
> Artem Savkov <asavkov@redhat.com> wrote:
> 
> > If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> > it returns an error, but does not unset the tp flags it set previosly.
> > This results in a probe being considered enabled and failures like being
> > unable to remove the probe through kprobe_events file since probes_open()
> > expects every probe to be disabled.
> > 
> 
> Looks good to me. Masami, want to ack it?

Yes, looks good to me too.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks Artem!

> 
> -- Steve
> 
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> > ---
> >  kernel/trace/trace_kprobe.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 21f718472942..fb887ced5056 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -400,11 +400,10 @@ static struct trace_kprobe *find_trace_kprobe(const char *event,
> >  static int
> >  enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> >  {
> > +	struct event_file_link *link;
> >  	int ret = 0;
> >  
> >  	if (file) {
> > -		struct event_file_link *link;
> > -
> >  		link = kmalloc(sizeof(*link), GFP_KERNEL);
> >  		if (!link) {
> >  			ret = -ENOMEM;
> > @@ -424,6 +423,16 @@ enable_trace_kprobe(struct trace_kprobe *tk, struct trace_event_file *file)
> >  		else
> >  			ret = enable_kprobe(&tk->rp.kp);
> >  	}
> > +
> > +	if (ret) {
> > +		if (file) {
> > +			list_del(&link->list);
> > +			kfree(link);
> > +			tk->tp.flags &= ~TP_FLAG_TRACE;
> > +		} else {
> > +			tk->tp.flags &= ~TP_FLAG_PROFILE;
> > +		}
> > +	}
> >   out:
> >  	return ret;
> >  }
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
