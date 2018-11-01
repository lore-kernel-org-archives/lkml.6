Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE80C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC623205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fF8vuQy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC623205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeKAOBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:01:44 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42033 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbeKAOBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:01:43 -0400
Received: by mail-pl1-f175.google.com with SMTP id t6-v6so8330629plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 22:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vezr3EUbKR1l3OrodJHQfW4NsCeIMSygd8VeZd14bTY=;
        b=fF8vuQy43dVx08AKzCvQR49K+CeXMj7JVbFsWhbPvnS/QEeH5a3AtPpx+gpPphpAZO
         7LAYO/dG7tNMGfkWb6FojeRHLmDBnHnpCuMDjvwdNhAjf/YhQdl7MOzHzdpnHwex/Dxc
         CDIQbHnoSFQEzpgzvVit5RaO5tXGPpD7x3FVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vezr3EUbKR1l3OrodJHQfW4NsCeIMSygd8VeZd14bTY=;
        b=nycWyvTslPuIVjXFN/TOAfKbY9Pppi5Xxs6oCVokOb/FKUsgsLIxEELq5g4LvIq13x
         wkeWbd+NVcR1SXwFnFVkRWmKN/8MkyAvk7ChXhMtJHLDJZ3dF0dnr3/HKVdF4oNKYWHF
         CYJWQKduQH3qn5N8ty8PqxZmCJHT0MdrcrYfKty0/mz/8n0KK4I906s79KwrwO1TI5kF
         Xuk+pLdt4ic/JDeTcf6jhmuOqQo/id3ryVYQuEUFVW4/N+aW3WPVCM9Z4WntGN8tF7uF
         Jhr2FFsuXGpe7/PjIOP0HnchdHwV8F1hMrBwiZh0OlxVpPu2RZfoZeJPWkTZ8yc3yLJL
         tOjA==
X-Gm-Message-State: AGRZ1gJoE/Z1h+wDklfMsCMWvCtknNUowWoDjg89RrAKYD0CxZI2IW9J
        WIbloa9v0zOnqibSS316OHp1k9cOmf8=
X-Google-Smtp-Source: AJdET5faers9dI0qWHe5XSApgQqB6EEvzfqNj61nljZNs2eU7pw/JHqpzauc0pkNt0vc+jRWXqlhQQ==
X-Received: by 2002:a17:902:e089:: with SMTP id cb9-v6mr6057110plb.196.1541048421760;
        Wed, 31 Oct 2018 22:00:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id 67-v6sm35249910pfk.134.2018.10.31.22.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 22:00:20 -0700 (PDT)
Date:   Wed, 31 Oct 2018 22:00:19 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC] doc: rcu: remove note on smp_mb during synchronize_rcu
Message-ID: <20181101050019.GA45865@google.com>
References: <20181028043046.198403-1-joel@joelfernandes.org>
 <20181030222649.GA105735@joelaf.mtv.corp.google.com>
 <20181030234336.GW4170@linux.ibm.com>
 <20181031011119.GF224709@google.com>
 <20181031181748.GG4170@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031181748.GG4170@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:17:48AM -0700, Paul E. McKenney wrote:
> On Tue, Oct 30, 2018 at 06:11:19PM -0700, Joel Fernandes wrote:
> > Hi Paul,
> > 
> > On Tue, Oct 30, 2018 at 04:43:36PM -0700, Paul E. McKenney wrote:
> > > On Tue, Oct 30, 2018 at 03:26:49PM -0700, Joel Fernandes wrote:
> > > > Hi Paul,
> > > > 
> > > > On Sat, Oct 27, 2018 at 09:30:46PM -0700, Joel Fernandes (Google) wrote:
> > > > > As per this thread [1], it seems this smp_mb isn't needed anymore:
> > > > > "So the smp_mb() that I was trying to add doesn't need to be there."
> > > > > 
> > > > > So let us remove this part from the memory ordering documentation.
> > > > > 
> > > > > [1] https://lkml.org/lkml/2017/10/6/707
> > > > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > I was just checking about this patch. Do you feel it is correct to remove
> > > > this part from the docs? Are you satisified that a barrier isn't needed there
> > > > now? Or did I miss something?
> > > 
> > > Apologies, it got lost in the shuffle.  I have now applied it with a
> > > bit of rework to the commit log, thank you!
> > 
> > No worries, thanks for taking it!
> > 
> > Just wanted to update you on my progress reading/correcting the docs. The
> > 'Memory Ordering' is taking a bit of time so I paused that and I'm focusing
> > on finishing all the other low hanging fruit. This activity is mostly during
> > night hours after the baby is asleep but some times I also manage to sneak it
> > into the day job ;-)
> 
> If there is anything I can do to make this a more sustainable task for
> you, please do not keep it a secret!!!

Thanks a lot, that means a lot to me! Will do!

> > BTW I do want to discuss about this smp_mb patch above with you at LPC if you
> > had time, even though we are removing it from the documentation. I thought
> > about it a few times, and I was not able to fully appreciate the need for the
> > barrier (that is even assuming that complete() etc did not do the right
> > thing).  Specifically I was wondering same thing Peter said in the above
> > thread I think that - if that rcu_read_unlock() triggered all the spin
> > locking up the tree of nodes, then why is that locking not sufficient to
> > prevent reads from the read-side section from bleeding out? That would
> > prevent the reader that just unlocked from seeing anything that happens
> > _after_ the synchronize_rcu.
> 
> Actually, I recall an smp_mb() being added, but am not seeing it anywhere
> relevant to wait_for_completion().  So I might need to add the smp_mb()
> to synchronize_rcu() and remove the patch (retaining the typo fix).  :-/

No problem, I'm glad atleast the patch resurfaced the topic of the potential
issue :-)

> The short form answer is that anything before a grace period on any CPU
> must be seen by any CPU as being before anything on any CPU after that
> same grace period.  This guarantee requires a rather big hammer.
> 
> But yes, let's talk at LPC!

Sounds great, looking forward to discussing this.

> > Also about GP memory ordering and RCU-tree-locking, I think you mentioned to
> > me that the RCU reader-sections are virtually extended both forward and
> > backward and whereever it ends, those paths do heavy-weight synchronization
> > that should be sufficient to prevent memory ordering issues (such as those
> > you mentioned in the Requierments document). That is exactly why we don't
> > need explicit barriers during rcu_read_unlock. If I recall I asked you why
> > those are not needed. So that answer made sense, but then now on going
> > through the 'Memory Ordering' document, I see that you mentioned there is
> > reliance on the locking. Is that reliance on locking necessary to maintain
> > ordering then?
> 
> There is a "network" of locking augmented by smp_mb__after_unlock_lock()
> that implements the all-to-all memory ordering mentioned above.  But it
> also needs to handle all the possible complete()/wait_for_completion()
> races, even those assisted by hypervisor vCPU preemption.

I see, so it sounds like the lock network is just a partial solution. For
some reason I thought before that complete() was even called on the CPU
executing the callback, all the CPUs would have acquired and released a lock
in the "lock network" atleast once thus ensuring the ordering (due to the
fact that the quiescent state reporting has to travel up the tree starting
from the leaves), but I think that's not necessarily true so I see your point
now.

Did you feel this will violate condition 1. or condition 2. in "Memory-Barrier
Guarantees"? Or both?
https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Memory-Barrier%20Guarantees

> > ----------------------
> > TODO list of the index file marking which ones I have finished perusing:
> > 
> > arrayRCU.txt			DONE
> > checklist.txt			DONE
> > listRCU.txt			DONE
> > lockdep.txt			DONE
> > lockdep-splat.txt		DONE
> > NMI-RCU.txt
> > rcu_dereference.txt
> > rcubarrier.txt
> > rculist_nulls.txt
> > rcuref.txt
> > rcu.txt
> > RTFP.txt			DONE
> > stallwarn.txt			DONE
> > torture.txt
> > UP.txt
> > whatisRCU.txt			DONE
> > 
> > Design
> >  - Data-Structures		DONE
> >  - Requirements			DONE
> >  - Expedited-Grace-Periods
> >  - Memory Ordering		next
> 
> Great progress, and again, thank you!!!

Thanks and you're welcome!

 - Joel

