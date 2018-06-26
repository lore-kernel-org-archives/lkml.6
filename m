Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314F2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E762689C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SCv44MHE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E762689C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933996AbeFZKJw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:09:52 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44449 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932964AbeFZKJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:09:50 -0400
Received: by mail-wr0-f196.google.com with SMTP id p12-v6so14981499wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eonnP3gBNaNVgOaf43AXZKv7MQZqC1aYO0BipT40ypI=;
        b=SCv44MHElc9Sxb9KrKeFmk+NAGHmlIE8oVNq5W9LnVDPx+eimDc5mCim+2pSzGdTxy
         FY1I0vwJI7PHSGgOB0hGP1sJw0Bl5e4alpdyyN2rSFtDJ5kCaKbIcZunkzQi1QZ7eaeF
         g+fYowhbYi+P2z3cqKxUUeNlzC0Bp5HVUbR7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eonnP3gBNaNVgOaf43AXZKv7MQZqC1aYO0BipT40ypI=;
        b=UUQMtZM+ZOJz9GOmagfcypZ1P1l3V1UpwZ92NLwwuD2L7U3SUz/RVg9WVGS+nKNtfN
         xlOqjSectY5//BNjLtGpQofuYsf8sf/oETFz2zJcYnI1HwqXLxBSZRaBGCFIr8S/g4Bn
         jhyufoqtEuSM73ULzKGdoiMJxAUDyE4EGiVsyeqfoy5WMCOxRCRxN+Gf7LrWryudHKMG
         j0Q77W1LeGjsniIFpfQVRqunlUPK9JmQU3nXzBWI3OwHmhFE0Uqx56ciY9bt7TOLb347
         bO5E6Uqq22+bc+NP+rPsZZCy7wXVxXUM1pK+06qZ+Qj5fs6NFFK7oD2ow2VK5AVraIhz
         FBlQ==
X-Gm-Message-State: APt69E1Qg+rb/ecc0o+uJemzykWfMlvgjoGTYtOOzLivEHNalLpVkgze
        X6gpPnGxLcrpNiKtBffFGVKZ1w==
X-Google-Smtp-Source: AAOMgpcA9409O0vw0rB6PFkDpiw5ziwOBxlZtaiXSl/CuoiCL06EUZNjvo98vo9JHeZGj1+DAof40Q==
X-Received: by 2002:adf:aca7:: with SMTP id o36-v6mr922731wrc.258.1530007788859;
        Tue, 26 Jun 2018 03:09:48 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1566789wme.42.2018.06.26.03.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 03:09:48 -0700 (PDT)
Date:   Tue, 26 Jun 2018 12:09:42 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] doc: Update wake_up() & co. memory-barrier guarantees
Message-ID: <20180626100942.GA8295@andrea>
References: <1529918258-7295-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20180625095031.GX2494@hirez.programming.kicks-ass.net>
 <20180625105618.GA12676@andrea>
 <20180625123121.GY2494@hirez.programming.kicks-ass.net>
 <20180625131643.GA15126@andrea>
 <20180625141830.GC2494@hirez.programming.kicks-ass.net>
 <20180625145611.GA16333@andrea>
 <20180625163705.GE2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625163705.GE2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > For example, the second comment says:
> > 
> >   /*
> >    * The below implies an smp_mb(), it too pairs with the smp_wmb() from
> >    * woken_wake_function() such that we must either observe the wait
> >    * condition being true _OR_ WQ_FLAG_WOKEN such that we will not miss
> >    * an event.
> >    */
> > 
> > From this I understand:
> > 
> >    wq_entry->flags &= ~WQ_FLAG_WOKEN;      condition = true;
> >    smp_mb() // B                           smp_wmb(); // C
> >    [next iteration of the loop]            wq_entry->flags |= WQ_FLAG_WOKEN;
> >    if (condition)
> >       break;
> > 
> >    BUG_ON(!condition && !(wq_entry->flags & WQ_FLAG_WOKEN))
> 
> Right, basically if we get a spurious wakeup and our ttwu() 'fails', we
> must either see condition on the next iteration, or ensure the next
> iteration doesn't sleep, so we'll loop around and test condition yet
> again.
> 
> > IOW, this is an R-like pattern: if this is the case, the smp_wmb() does
> > _not_ prevent the BUG_ON() from firing; according to LKMM (and powerpc)
> > a full barrier would be needed.
> 
> Hmmm, how come? store-store collision? Yes I suppose you're right.

Ehh, the corresponding powerpc test is architecturally allowed; in the
operational model, the BUG_ON() state can be reached by following the
following steps:

 1. let the writes all reach the storage subsystem,

 2. commit the partial coherence order from "->flags |= WQ_FLAG_WOKEN"
    to "->flags &= ~WQ_FLAG_WOKEN"

 3. propagate "->flags &= ~WQ_FLAG_WOKEN" to the other thread

 4. commit and acknowledge the sync (B)

 5. satisfy the read

 6. propagate "condition = true" and the lwsync (C) to the other thread.

AFAICT, this state remains _unobserved_ via litmus7 experiments.


> 
> > Same RFC for the first comment:
> > 
> >   /*
> >    * The above implies an smp_mb(), which matches with the smp_wmb() from
> >    * woken_wake_function() such that if we observe WQ_FLAG_WOKEN we must
> >    * also observe all state before the wakeup.
> >    */
> > 
> > What is the corresponding snippet & BUG_ON()?
> 
> The comment there suggest:
> 
> 	if (condition)
> 		break;
> 
> 	set_current_state(UNINTERRUPTIBLE);		condition = true;
> 	/* smp_mb() */					smp_wmb();
> 							wq_entry->flags |= WQ_FLAG_WOKEN;
> 	if (!wq_entry->flags & WQ_FLAG_WOKEN)
> 		schedule();
> 
> 
> 	BUG_ON((wq_entry->flags & WQ_FLAG_WOKEN) && !condition);
> 
> 
> But looking at that now, I think that's wrong. Because the the purpose
> was that, if we don't do the try_to_wake_up(), our task still needs to
> observe the condition store.
> 
> But for that we need a barrier between the wq_entry->flags load and the
> second condition test, which would (again) be B, not A.

Agreed.  Now that I stared at the code a bit more, I think that (A) is
still needed for the synchronization on "->state" and "->flags" (an SB
pattern seems again to be hidden in the call to try_to_wake_up()):

  p->state = mode;                           wq_entry->flags |= WQ_FLAG_WOKEN;
  smp_mb(); // A                             try_to_wake_up():
  if (!(wq_entry->flags & WQ_FLAG_WOKEN))      <full barrier>
     schedule()                                if (!(p->state & mode))
                                                 goto out;

  BUG_ON(!(wq_entry->flags & WQ_FLAG_WOKEN) && !(p->state & mode))

So, I think that we should keep (A).

I am planning to send these changes (smp_mb() in woken_wake_function()
and fixes to the comments) as a separate patch.

Thanks,
  Andrea
