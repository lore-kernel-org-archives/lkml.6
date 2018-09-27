Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F89C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8C32156D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YPJZpiAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8C32156D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeI0OEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:04:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44063 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeI0OEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:04:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id t11-v6so4145645edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 00:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HuKjMrg0WeGN/c5JSB/5cjkE+o0BvsjWfFc8n8EwdKM=;
        b=YPJZpiAhfrvanS/D/MtCTZjofHvbRrXdHuBmgyGqs/uoCDB0oAaudM4lDieC2+bafi
         28p2znYA8F19AlH3jbNyF6D8f/GHhQXX4lghslLhvKzfkKkj+TzJq5f23Or5T+WLlbqr
         1O3/cpM42kZg8GxRulG7mxVFC7C/vQD1UlrTQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HuKjMrg0WeGN/c5JSB/5cjkE+o0BvsjWfFc8n8EwdKM=;
        b=HHxvpPYpoPEif0evhuBdirj9TkVgcgJef6U6tt1z0JMx7FjHWxGvADSDOckJ19axcF
         /uJ68Z8h54vlh0k+gvM/QgvuYTK4VwrRwgXolcMAcbTZTZyHVeKSKj7kMlDW0EUhrjuE
         dr0MhUB/2YssoNI1v1K2ErL2uVFKkPTDY0KVaWlj9WUdCJQFxVubITDKP9egLh0CWbQN
         NxVhT9oltQCmKGYdAiGwSexQKAhfuQGglfKU95+J8cxjmZEAjxmRS4MChDoJHIjf3LlI
         TM1gJIDjEf7ioNaX0LurksRqRrJy+tCtXfqvi71lvnaTKVRz0gLHJemnFS3hoqBCFt4M
         kLuQ==
X-Gm-Message-State: ABuFfoiKnlzMSWMFbs2Rlqfl9IoSm4brJkEFYnS9MrwigoLg6k2bvAEl
        iXIm5Z/ZbPvtR4RN6iwRAYl0Zg==
X-Google-Smtp-Source: ACcGV63+7hORdMPgIV12QrR4UNs+cp3JI9ssgXa5EMYF3B/h7mniq1nKkABbWSnjUeuRf6EEfMM93g==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr16510645edd.120.1538034475671;
        Thu, 27 Sep 2018 00:47:55 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id h3-v6sm1213207ede.42.2018.09.27.00.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 00:47:55 -0700 (PDT)
Date:   Thu, 27 Sep 2018 09:47:48 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     will.deacon@arm.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        tglx@linutronix.de
Subject: Re: [RFC][PATCH 3/3] locking/qspinlock: Optimize for x86
Message-ID: <20180927074748.GA7939@andrea>
References: <20180926110117.405325143@infradead.org>
 <20180926111307.513429499@infradead.org>
 <20180926205208.GA4864@andrea>
 <20180927071747.GD5254@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927071747.GD5254@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 09:17:47AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 26, 2018 at 10:52:08PM +0200, Andrea Parri wrote:
> > On Wed, Sep 26, 2018 at 01:01:20PM +0200, Peter Zijlstra wrote:
> > > On x86 we cannot do fetch_or with a single instruction and end up
> > > using a cmpxchg loop, this reduces determinism. Replace the fetch_or
> > > with a very tricky composite xchg8 + load.
> > > 
> > > The basic idea is that we use xchg8 to test-and-set the pending bit
> > > (when it is a byte) and then a load to fetch the whole word. Using
> > > two instructions of course opens a window we previously did not have.
> > > In particular the ordering between pending and tail is of interrest,
> > > because that is where the split happens.
> > > 
> > > The claim is that if we order them, it all works out just fine. There
> > > are two specific cases where the pending,tail state changes:
> > > 
> > >  - when the 3rd lock(er) comes in and finds pending set, it'll queue
> > >    and set tail; since we set tail while pending is set, the ordering
> > >    is split is not important (and not fundamentally different form
> > >    fetch_or). [*]
> > > 
> > >  - when the last queued lock holder acquires the lock (uncontended),
> > >    we clear the tail and set the lock byte. By first setting the
> > >    pending bit this cmpxchg will fail and the later load must then
> > >    see the remaining tail.
> > > 
> > > Another interesting scenario is where there are only 2 threads:
> > > 
> > > 	lock := (0,0,0)
> > > 
> > > 	CPU 0			CPU 1
> > > 
> > > 	lock()			lock()
> > > 	  trylock(-> 0,0,1)       trylock() /* fail */
> > > 	    return;               xchg_relaxed(pending, 1) (-> 0,1,1)
> > > 				  mb()
> > > 				  val = smp_load_acquire(*lock);
> > > 
> > > Where, without the mb() the load would've been allowed to return 0 for
> > > the locked byte.
> > 
> > If this were true, we would have a violation of "coherence":
> 
> The thing is, this is mixed size, see:

The accesses to ->val are not, and those certainly have to meet the
"coherence" constraint (no matter the store to ->pending).


> 
>   https://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
> 
> If I remember things correctly (I've not reread that paper recently) it
> is allowed for:
> 
> 	old = xchg(pending,1);
> 	val = smp_load_acquire(*lock);
> 
> to be re-ordered like:
> 
> 	val = smp_load_acquire(*lock);
> 	old = xchg(pending, 1);
> 
> with the exception that it will fwd the pending byte into the later
> load, so we get:
> 
> 	val = (val & _Q_PENDING_MASK) | (old << _Q_PENDING_OFFSET);
> 
> for 'free'.
> 
> LKMM in particular does _NOT_ deal with mixed sized atomics _at_all_.

True, but it is nothing conceptually new to deal with: there're Cat
models that handle mixed-size accesses, just give it time.

  Andrea


> 
> With the addition of smp_mb__after_atomic(), we disallow the load to be
> done prior to the xchg(). It might still fwd the more recent pending
> byte from its store buffer, but at least the other bytes must not be
> earlier.
