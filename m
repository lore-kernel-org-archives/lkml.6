Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CE5ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169C20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DcEw8uQM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731058AbeGQUtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:49:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33737 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbeGQUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:49:17 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so923082pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 13:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PwgDAJA/ohGeic0rELg9CJVSIdskMcxdnYJzKJHcmJs=;
        b=DcEw8uQMjQdoSQErx6e+gLiNFN1RIp7n3eGPNAdao6LRi6QeROv6qwS3jt494KMqj6
         0maWF6n55gO+REstTJVe2vYKuYuMIboO6CJjgE1AYu9LPkP8CH5LkYxlSuOOLVT+ZN/O
         XjHUMsZChafUEjfMObIk8Ia2WyZK9/85rDnr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PwgDAJA/ohGeic0rELg9CJVSIdskMcxdnYJzKJHcmJs=;
        b=n+fQarWVD12u5YXjSkPDq0owQ46rFc8Uhqxsml0gSOuy4Y5CD2OfSL0PoyTF1gYATM
         sGVl+vDsF7FHy8ZUr0JGDshGyJWxo3RO71ezyzHOlk8nNXYwHeX9xR2tvCwgkL2HJFpa
         6IEO4OxmcxN0vy8eJDVDo7df4fpFPGH7RYy0nuIifZC4AB6OBnSyNdf6knqsKe85hCF1
         4FbeSXuvbsMfg6vhMFbk4tCJ0ok/nTJ5BKK+YbYB4UcM6xx25JArNy5wYkGglPvumW2Q
         3w/5cRoPck5J8wfBq2fMgX2QZkWx6sqkwCJ1VpWu/xnN6loJygEEwF/2YiWe/2pql9LH
         k2Uw==
X-Gm-Message-State: AOUpUlEBO92AVGh0qri45pRnc/ULZmSjvhJvX65nLtg7z8ctNp4rMF1Q
        NPX2adWO9frOkW22SqR5e43hVw==
X-Google-Smtp-Source: AAOMgpdBq9XqzzqAXnxvIOibTOeJGiLcM4LN0PP3HGOce9sYE4z00Nrfr1zLChKTaDg+Sxc30XSYaQ==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr2829794pga.181.1531858502000;
        Tue, 17 Jul 2018 13:15:02 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id l4-v6sm2389333pgn.46.2018.07.17.13.15.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 13:15:01 -0700 (PDT)
Date:   Tue, 17 Jul 2018 13:15:00 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Erick Reyes <erickreyes@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Todd Kjos <tkjos@google.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v10 2/3] tracepoint: Make rcuidle tracepoint callers use
 SRCU
Message-ID: <20180717201500.GA164758@joelaf.mtv.corp.google.com>
References: <20180713215547.255620-1-joel@joelfernandes.org>
 <20180713215547.255620-3-joel@joelfernandes.org>
 <20180717182528.GK2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717182528.GK2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 08:25:28PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 13, 2018 at 02:55:46PM -0700, Joel Fernandes wrote:
> > +		/* keep srcu and sched-rcu usage consistent */		\
> > +		preempt_disable_notrace();				\
> > +									\
> > +		/*							\
> > +		 * For rcuidle callers, use srcu since sched-rcu	\
> > +		 * doesn't work from the idle path.			\
> > +		 */							\
> > +		if (rcuidle)						\
> > +			idx = srcu_read_lock_notrace(&tracepoint_srcu);	\
> > +		else							\
> > +			rcu_read_lock_sched_notrace();			\
> 
> That else is completely superfluous. rcu_read_lock_sched_notrace() :=
> prempt_disable_notrace().

Yes, sorry I missed this in your original idea. Will do it this way and
repost. Thanks Peter!

- Joel

