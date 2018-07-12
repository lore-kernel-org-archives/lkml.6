Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02F6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8BB20C0C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nkq2gEUV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D8BB20C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388832AbeGLAhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:37:55 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34661 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388210AbeGLAhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:37:55 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so9864147plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+97etUtP013AecFBM16XO2nOIeL0x4x8tbuNSddqzq4=;
        b=nkq2gEUVZ/WfvsYaOJIKAYVrH65E7TmDP1gmJ/nYEUuC/cF69ef4wqgQexmbl6spcY
         YrpYXxNH7H5GAG5vEmb69ALK25brBrqkExdPuRGfz6JosrQ7/e6skFDNXI3XcqXpl05Q
         Y/JInp0mYXeZwTyeQrPLna3p4Ow5I4jqOWSew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+97etUtP013AecFBM16XO2nOIeL0x4x8tbuNSddqzq4=;
        b=lTsP57+psO6YYVuX5MJ+cYJ4zL/gQhhH979SFzORiN8NyAEepQExxUKiRRrY/ar6EJ
         95r2PyN8BWNuKfbJySC6eYCz8TLi/hSioSBdqa8rJZLPUI3JVZHIPufEC3ltQ4Mcw7VY
         dvuymUVDBvjQy7B8w2OabM+dPyUFgk/d1KI9nHks2zhwYG4Mrv3P+rM03h6m+ccIwGeQ
         WQZLKFUzcjUR4Xw8Pp0ec5nOh4i5nAPwcan3U8TMFEWMUFBZIYiDLJYSWzHRMj724mrL
         HY8cjQaPmymFWMsvF9y0WJD17er+dXFb387HbuuQYxTZts+QQSNMwH+1IMVkXbsVgR+e
         YRYQ==
X-Gm-Message-State: AOUpUlFuexni+BrB7BW78U+l6DU17iSwLDmJT1XxkdxqaTPlMbQzTb2K
        VBgwd5J3aIfIdQRhUmyYz/VpWw==
X-Google-Smtp-Source: AAOMgpeefuJycxwyQB4Oq5SDIEk4pVI4GPCjXSr5CJBfBYVq9wtUQsSvEooEpVbGHKEEZqSPTt+UGg==
X-Received: by 2002:a17:902:2924:: with SMTP id g33-v6mr86288plb.26.1531355462014;
        Wed, 11 Jul 2018 17:31:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n16-v6sm31860834pfi.127.2018.07.11.17.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 17:31:01 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:31:00 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 4/7] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180712003100.GC32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-5-joel@joelfernandes.org>
 <20180711125647.GG2476@hirez.programming.kicks-ass.net>
 <20180711090649.68af40f9@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711090649.68af40f9@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 09:06:49AM -0400, Steven Rostedt wrote:
> On Wed, 11 Jul 2018 14:56:47 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Jun 28, 2018 at 11:21:46AM -0700, Joel Fernandes wrote:
> > >  static inline void tracepoint_synchronize_unregister(void)
> > >  {
> > > +	synchronize_srcu(&tracepoint_srcu);
> > >  	synchronize_sched();
> > >  }  
> > 
> > Given you below do call_rcu_sched() and then call_srcu(), isn't the
> > above the wrong way around?
> 
> Good catch!
> 
> 	release_probes()
> 		call_rcu_sched()
> 			---> rcu_free_old_probes() queued
> 
> 	tracepoint_synchronize_unregister()
> 		synchronize_srcu(&tracepoint_srcu);
> 			< finishes right away >
> 		synchronize_sched()
> 			--> rcu_free_old_probes()
> 				--> srcu_free_old_probes() queued
> 	
> Here tracepoint_synchronize_unregister() returned before the srcu
> portion ran.

But isn't the point of synchronize_rcu to make sure that we're no longer in
an RCU read-side section, not that *all* queued callbacks already ran? So in that
case, I think it doesn't matter which order the 2 synchronize functions are
called in. Please let me know if if I missed something!

I believe what we're trying to guarantee here is that no tracepoints using
either flavor of RCU are active after tracepoint_synchronize_unregister
returns.

thanks!

- Joel

