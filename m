Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 00:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3AC20020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 00:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KdP+3fDI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3AC20020
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754504AbeFRAPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 20:15:50 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36677 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754411AbeFRAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 20:15:47 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so8044487plp.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+3Yy088ci3nAjW4MeMftDns+Is1kiImcM22W5nU1ro8=;
        b=KdP+3fDISridbzOMLlpQjBGP6BsuzRZXcpbFAtJq/rkjoiUbtAL6bgQuEywSE+Seda
         vQs4UYNGee1OTXdlIMquz3oLdCwxUg3ggItdeBLWtDtPwtFg99wSYBJdrggyTcyQab+X
         HhbVD47aC1MUEidttIBp/J79ZSacLs70RdagI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+3Yy088ci3nAjW4MeMftDns+Is1kiImcM22W5nU1ro8=;
        b=I7rT418EforiRK9TS7J7H/drsrFIo2ABv6B8lei56Jdz91/wzs4MDbTDRlS5QiQ2z5
         dxpmGyT+yX2KwEVlQy2vgAEEglfZDv/KANczHUjwUyDRDLRiCMRI8nlGcbKq5LM0w106
         BFyOM8KjgdBdPd0bvdHqCtVkkb8trzj/9qYOGx4gZogql3lhZ7HkoZhBpHxWmK7JFRTF
         t04u5cexdKiFmWZBo5SEXqEI8AxXbcNDwIfTpAcCvqqta5tD4cQK7DpzRz8r9avVqSyF
         +Oy1R2sHO7D1y1goLR4vBbjqm1qZMeCRUt2AtjIXippdvxGK0+NyHCU6ciC7WAnaELwH
         XmQg==
X-Gm-Message-State: APt69E0mHx1apkMD+KpDvck/94xG+E06mDkqN0J9IX4yaFEVuyqOadu/
        dppAjhMlgEonpnmDoq0DH/OAuA==
X-Google-Smtp-Source: ADUXVKJZRIXnNXQZl6oyVOszx87aa12twlrlpqiag8wof8YJ7FTFXvM5I9dzLo6DtWJ0T3ylhCSj+w==
X-Received: by 2002:a17:902:4424:: with SMTP id k33-v6mr11683418pld.242.1529280946886;
        Sun, 17 Jun 2018 17:15:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id j15-v6sm28571400pfk.40.2018.06.17.17.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Jun 2018 17:15:45 -0700 (PDT)
Date:   Sun, 17 Jun 2018 17:15:45 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Ingo Molnar <mingo@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
        namhyung@kernel.org, mathieu.desnoyers@efficios.com,
        linux-rt-users@vger.kernel.org,
        Tom Zanussi <tom.zanussi@linux.intel.com>, peterz@infradead.org
Subject: Re: [PATCH RFC] tracing: Call triggers only if event passes filter
 checks
Message-ID: <20180618001545.GA187086@joelaf.mtv.corp.google.com>
References: <20180615010113.127718-1-joel@joelfernandes.org>
 <20180616224329.02e37ef4aee72c7d5685818e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616224329.02e37ef4aee72c7d5685818e@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 10:43:29PM +0900, Masami Hiramatsu wrote:
> On Thu, 14 Jun 2018 18:01:13 -0700
> Joel Fernandes <joelaf@google.com> wrote:
> 
> > From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> > 
> > Currently, trace event triggers are called regardless of if the event
> > filter checks pass or fail. Thus if one were to enable event triggers
> > and filters at the same time, then the triggers will always be called
> > even if the filter checks didn't pass.
> > 
> > This is a problem for a usecase I was experimenting with: measuring the
> > time preemption is disabled using synthetic events and dump the stack
> > using the stacktrace trigger if the total preempt off time was greater
> > than a threshold. Following are the commands for the same:
> > 
> > Create synthetic event:
> > 
> > echo 'preemptdisable u64 lat' >> \
> > 	      /sys/kernel/debug/tracing/synthetic_events
> > 
> > echo 'hist:keys=cpu:ts0=common_timestamp.usecs:scpu=cpu' >> \
> > 	      /sys/kernel/debug/tracing/events/preemptirq/preempt_disable/trigger
> > 
> > echo 'hist:keys=cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
> > onmatch(preemptirq.preempt_disable).preemptdisable($wakeup_lat)' >> \
> > 	        /sys/kernel/debug/tracing/events/preemptirq/preempt_enable/trigger
> > 
> > Enable synthetic event:
> > 
> > echo stacktrace > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> > echo 'lat > 400' > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/filter
> 
> Have you tried if statement as below?
> 
> echo "stacktrace if lat > 400" > /sys/kernel/debug/tracing/events/synthetic/preemptdisable/trigger
> 

Yes I tried this and it works, thanks!

Steven also suggested the same thing in his reply as well.

thanks,

 - Joel

