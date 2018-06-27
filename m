Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2C8C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66DE25CB5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lt37kbHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66DE25CB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965823AbeF0S1a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:27:30 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34735 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754551AbeF0S12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:27:28 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so1449137plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JkAy19HoYDdbqw7qT8i5SHx5nehn42OAz0Tsa2B3K/Y=;
        b=lt37kbHHRR9g3SBeQ1z8WoNsL/o2862if6PT1eOP4ycDLiADWQR/TVfX+Y6ZDC1T5S
         llj/8DTt0CSaZezqb4pK83hwjNzfg9Ho91L3++LbYAczJJ0hL1NrpC2GqLty/gQE6y5q
         xoGt6N94uBJCfFfj6GkNT7DA5g7+WFycT9gmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JkAy19HoYDdbqw7qT8i5SHx5nehn42OAz0Tsa2B3K/Y=;
        b=BT7D3wt2hLp4MbVsMrylLHD3m6+t4EzgEGg5NNfd8y/6NTPWaJY+g7FCMX7uSDN6U/
         NJ32A+o7r4TRE4uAsUdcKF9sM+JAyCtqCyNDqzCQF30i6KA/t8qdxNFQIa0G8rUQJXj5
         LMiyDS9299qH8gG3+uCjkM6oiJ4mwfRuzthC1PY1yuKrjxf394NO+HUkQ+CrEduuWdNT
         V1jOFCE20aoPbglh4HmywphZ5N+GigD0Ad99Uzp/ooG9ruJMNrAg0yvCN6W7ATisl3xa
         N3ZvVq02QWi7wRAUvGooffagYkRUaRoQxMkczIAZG65pRuljDagzWmQFrUEvtiAOXqj9
         ZL9Q==
X-Gm-Message-State: APt69E3qA55UtAc/3VuNHObiHvJOsDfmM0RFkMrgL0qb7MM1R/IFu3IW
        NuHSG0dYDawFdCnXVDAHwNsOlQ==
X-Google-Smtp-Source: ADUXVKLmW8ort08criQlpM8Pe3yN5IuDjgZqBJqgIf70+APy6dA2yZgCpuKeK6gfK0MwzvYyuTp3zg==
X-Received: by 2002:a17:902:24a5:: with SMTP id w34-v6mr7272124pla.52.1530124048042;
        Wed, 27 Jun 2018 11:27:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id n25-v6sm6977950pff.119.2018.06.27.11.27.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:27:27 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:27:26 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, kernel-team@android.com
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Message-ID: <20180627182726.GA79165@joelaf.mtv.corp.google.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
 <20180627043913.GA177710@joelaf.mtv.corp.google.com>
 <20180627175436.GC3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627175436.GC3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:54:36AM -0700, Paul E. McKenney wrote:
> On Tue, Jun 26, 2018 at 09:39:13PM -0700, Joel Fernandes wrote:
> > On Tue, Jun 26, 2018 at 07:30:55PM +0200, Peter Zijlstra wrote:
> > > On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> > > > +/*
> > > > + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> > > > + *
> > > > + * This function returns the earliest value of the grace-period sequence number
> > > > + * that will indicate that a full grace period has elapsed since the current
> > > > + * time.  Once the grace-period sequence number has reached this value, it will
> > > > + * be safe to invoke all callbacks that have been registered prior to the
> > > > + * current time. This value is the current grace-period number plus two to the
> > > > + * power of the number of low-order bits reserved for state, then rounded up to
> > > > + * the next value in which the state bits are all zero.
> > > 
> > > If you complete that by saying _why_ you need to round up there, then
> > > the below verbiage is completely redundant.
> > > 
> > > > + * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > > > + * the seq is used to track if a GP is in progress or not. Given this, it is
> > > > + * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
> > > > + * why with an example:
> > > > + *
> > > > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > > > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > > > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > > > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > > > + * is already in progress so the next GP that a future call back will be queued
> > > > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > > > + * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
> > > > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > > > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
> > > > + * overflow didn't occur. This masking is needed because in case RCU was idle
> > > > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > > > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > > > + *
> > > > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > > > + * which can be generalized to:
> > > > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > > > + */
> > > 
> > > Is the below not much simpler:
> > > 
> > > >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> > > >  {
> > > >  	unsigned long s;
> > > 
> > > 	s = smp_load_aquire(sp);
> > > 
> > > 	/* Add one GP */
> > > 	s += 1 << RCU_SEQ_CTR_SHIFT;
> > > 
> > > 	/* Complete any pending state by rounding up */
> > 
> > I would suggest this comment be changed to "Add another GP if there was a
> > pending state".
> > 
> > > 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> > > 
> > 
> > I agree with Peter's suggestions for both the verbiage reduction in the
> > comments in the header, as the new code he is proposing is more
> > self-documenting. I believe I proposed a big comment just because the code
> > wasn't self-documenting or obvious previously so needed an explanation.
> > 
> > How would you like to proceed? Let me know what you guys decide, I am really
> > Ok with anything. If you guys agree, should I write a follow-up patch with
> > Peter's suggestion that applies on top of this one?  Or do we want to drop
> > this one in favor of Peter's suggestion?
> 
> Shortening the comment would be good, so please do that.
> 
> I cannot say that I am much of a fan of the suggested change to the
> computation, but I don't feel all that strongly about it.  If the two

Did you mean a code generation standpoint or from a higher level coding standpoint?

From a code generation perspective, the code is identical, I did a quick
test to confirm that:

0000000000000000 <rcu_seq_snap_old>:
       0:       e8 00 00 00 00          callq  5 <rcu_seq_snap_old+0x5>
       5:       48 8b 07                mov    (%rdi),%rax
       8:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
       e:       48 83 c0 07             add    $0x7,%rax
      12:       48 83 e0 fc             and    $0xfffffffffffffffc,%rax
      16:       c3                      retq
      17:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
      1e:       00 00

0000000000000020 <rcu_seq_snap_new>:
      20:       e8 00 00 00 00          callq  25 <rcu_seq_snap_new+0x5>
      25:       48 8b 07                mov    (%rdi),%rax
      28:       f0 83 44 24 fc 00       lock addl $0x0,-0x4(%rsp)
      2e:       48 83 c0 07             add    $0x7,%rax
      32:       48 83 e0 fc             and    $0xfffffffffffffffc,%rax
      36:       c3                      retq
      37:       66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
      3e:       00 00

> of you agree on a formulation and get at least one other RCU maintainer
> or reviewer to agree as well, I will take the change.
> 

Cool, sounds good.

thanks!

- Joel

