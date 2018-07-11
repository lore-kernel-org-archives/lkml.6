Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B72C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FBD20877
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdLmZPo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FBD20877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbeGKNbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:31:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732469AbeGKNbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:31:02 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBFC20652;
        Wed, 11 Jul 2018 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531315601;
        bh=XtlaNgrQQ4SnlL6t/9Awk4iA4LacABs6dbwLDpmmNpY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OdLmZPo5tz5RUpry0ps14fVTG5HgvvrDM8kNzJYDzo80J7cq/ZoAoYBh3W2YW+zGY
         IOc1FWVx5xH1LcmJA5YT6OaXzcqCpBb6V+OBjvQMKXoSXh81O0989YXDq5nIUgcEVw
         Xoo3Fg5THziVx5mXIs2j3L3l5QVzCfAwmZAUH6Xk=
Date:   Wed, 11 Jul 2018 22:26:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yonghong Song <yhs@fb.com>, Josef Bacik <jbacik@fb.com>,
        daniel@iogearbox.net, davem@davemloft.net,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] tracing/kprobe: Release kprobe print_fmt properly
Message-Id: <20180711222637.2836ee45b4fe3bfa9fb22a0e@kernel.org>
In-Reply-To: <20180711085429.08437b77@gandalf.local.home>
References: <20180709141906.2390-1-jolsa@kernel.org>
        <20180710090417.21423b1b@gandalf.local.home>
        <20180711085429.08437b77@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 08:54:29 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Masami,
> 
> Can you ack this? If I don't hear from you by tomorrow, I'm going to
> push it to Linus, because I'll be on PTO after that.
> 

Sorry for later, yes, it seems correct.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!


> Thanks!
> 
> -- Steve
> 
> 
> On Tue, 10 Jul 2018 09:04:17 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon,  9 Jul 2018 16:19:06 +0200
> > Jiri Olsa <jolsa@kernel.org> wrote:
> > 
> > > We don't release tk->tp.call.print_fmt when destroying
> > > local uprobe. Also there's missing print_fmt kfree in
> > > create_local_trace_kprobe error path.  
> > 
> > OK, I finished testing and I'm all ready to push, but then I noticed
> > that Masami wasn't Cc'd. I like to get his ack before pushing to Linus.
> > 
> > -- Steve
> > 
> > 
> > > 
> > > Fixes: e12f03d7031a ("perf/core: Implement the 'perf_kprobe' PMU")
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  kernel/trace/trace_kprobe.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index daa81571b22a..21f718472942 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -1480,8 +1480,10 @@ create_local_trace_kprobe(char *func, void *addr, unsigned long offs,
> > >  	}
> > >  
> > >  	ret = __register_trace_kprobe(tk);
> > > -	if (ret < 0)
> > > +	if (ret < 0) {
> > > +		kfree(tk->tp.call.print_fmt);
> > >  		goto error;
> > > +	}
> > >  
> > >  	return &tk->tp.call;
> > >  error:
> > > @@ -1501,6 +1503,8 @@ void destroy_local_trace_kprobe(struct trace_event_call *event_call)
> > >  	}
> > >  
> > >  	__unregister_trace_kprobe(tk);
> > > +
> > > +	kfree(tk->tp.call.print_fmt);
> > >  	free_trace_kprobe(tk);
> > >  }
> > >  #endif /* CONFIG_PERF_EVENTS */  
> > 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
