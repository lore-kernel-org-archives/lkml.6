Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA81C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3B920BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tSI0CUHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3B920BEC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389763AbeGLAvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:51:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42685 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388901AbeGLAvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:51:07 -0400
Received: by mail-pf0-f196.google.com with SMTP id l9-v6so7840472pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LgxhXobKd6LEtBHBe70IGBZfbXwGbOBPn5FXcYjR3ps=;
        b=tSI0CUHajWGz3Bq/8guRSeKzOlPqKAyDkLPegOMakORlLT3qYYKWmeE8YylDxt/ukw
         qreWRakQdO+MqZ138a6cAg7roqcWfCHSIx2/avIuQBCpC7SYvRNY/VbRA7NrNuygtoJ/
         QTrfP4lnrk6kI0eoVg37kN/aD6CBLdLgUici0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LgxhXobKd6LEtBHBe70IGBZfbXwGbOBPn5FXcYjR3ps=;
        b=dP/BYl+yX8FsMWSNj0w4ARcdYIFxktkIqPgbVumexBPziPRWvEOPtiEbD9l3yCj4Fe
         8UEuYeFIIuOOvZ4ZOgiiJnLFUbhP3KIBWoQ/vn+cBvpPpbMhOiEAX4VqyImTC7e0S66f
         m2afi8qx6d/Hg+UHnDR1oRyTQ5+XJ96gb7rufsPFD+1dGTJ9eJbvRN3NV9QrVq1ejlve
         86lq7gp1t8ZciZAZjzJ9qvdNsCekIDFNoDS74zapcjnE/v/p4yIAEncUbt7gZ454fxZE
         jtuZb3Z83DK5g/+3BgbkcH7y0yoTTebE7l0SDTYsp+lOtnb00aYGo5XES9dTbVTAxbHG
         xNxg==
X-Gm-Message-State: AOUpUlE8TuQ9bDLaUQaOQbZYdzeOIpcGeo2czu0oCOWe5gjLki9A085K
        4Y7Qt86SCQQlipIWQKF4ysW0Fw==
X-Google-Smtp-Source: AAOMgpciEMO01yk5k0xI74KRShLSjV/JRFBH0DEvVDjHp01xa3UMKun31WW9onuyfr0hGVjgT0SxZw==
X-Received: by 2002:a62:c699:: with SMTP id x25-v6mr127904pfk.16.1531356253152;
        Wed, 11 Jul 2018 17:44:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id d22-v6sm11450360pfk.69.2018.07.11.17.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 17:44:12 -0700 (PDT)
Date:   Wed, 11 Jul 2018 17:44:11 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v9 5/7] tracing: Centralize preemptirq tracepoints and
 unify their usage
Message-ID: <20180712004411.GD32091@joelaf.mtv.corp.google.com>
References: <20180628182149.226164-1-joel@joelfernandes.org>
 <20180628182149.226164-6-joel@joelfernandes.org>
 <20180711131256.GH2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711131256.GH2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 03:12:56PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 11:21:47AM -0700, Joel Fernandes wrote:
> > One note, I have to check for lockdep recursion in the code that calls
> > the trace events API and bail out if we're in lockdep recursion
> 
> I'm not seeing any new lockdep_recursion checks...

I meant its this part:

void trace_hardirqs_on(void)
{
	if (lockdep_recursing(current) || !this_cpu_read(tracing_irq_cpu))
		return;

> > protection to prevent something like the following case: a spin_lock is
> > taken. Then lockdep_acquired is called.  That does a raw_local_irq_save
> > and then sets lockdep_recursion, and then calls __lockdep_acquired. In
> > this function, a call to get_lock_stats happens which calls
> > preempt_disable, which calls trace IRQS off somewhere which enters my
> > tracepoint code and sets the tracing_irq_cpu flag to prevent recursion.
> > This flag is then never cleared causing lockdep paths to never be
> > entered and thus causing splats and other bad things.
> 
> Would it not be much easier to avoid that entirely, afaict all
> get/put_lock_stats() callers already have IRQs disabled, so that
> (traced) preempt fiddling is entirely superfluous.

Let me try to apply Peter's diff and see if I still don't need lockdep
recursion checking. I believe it is still harmless to still check for lockdep
recursion just to be safe. But I'll give it a try and let you know how it
goes.

thanks!

- Joel


> ---
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 5fa4d3138bf1..8f5ce0048d15 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -248,12 +248,7 @@ void clear_lock_stats(struct lock_class *class)
>  
>  static struct lock_class_stats *get_lock_stats(struct lock_class *class)
>  {
> -	return &get_cpu_var(cpu_lock_stats)[class - lock_classes];
> -}
> -
> -static void put_lock_stats(struct lock_class_stats *stats)
> -{
> -	put_cpu_var(cpu_lock_stats);
> +	return &this_cpu_ptr(&cpu_lock_stats)[class - lock_classes];
>  }
>  
>  static void lock_release_holdtime(struct held_lock *hlock)
> @@ -271,7 +266,6 @@ static void lock_release_holdtime(struct held_lock *hlock)
>  		lock_time_inc(&stats->read_holdtime, holdtime);
>  	else
>  		lock_time_inc(&stats->write_holdtime, holdtime);
> -	put_lock_stats(stats);
>  }
>  #else
>  static inline void lock_release_holdtime(struct held_lock *hlock)
> @@ -4090,7 +4084,6 @@ __lock_contended(struct lockdep_map *lock, unsigned long ip)
>  		stats->contending_point[contending_point]++;
>  	if (lock->cpu != smp_processor_id())
>  		stats->bounces[bounce_contended + !!hlock->read]++;
> -	put_lock_stats(stats);
>  }
>  
>  static void
> @@ -4138,7 +4131,6 @@ __lock_acquired(struct lockdep_map *lock, unsigned long ip)
>  	}
>  	if (lock->cpu != cpu)
>  		stats->bounces[bounce_acquired + !!hlock->read]++;
> -	put_lock_stats(stats);
>  
>  	lock->cpu = cpu;
>
