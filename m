Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D9AC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50BB26769
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 04:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="BFyxeEmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D50BB26769
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeF0EjQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 00:39:16 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43271 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752702AbeF0EjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 00:39:15 -0400
Received: by mail-pl0-f68.google.com with SMTP id c41-v6so414587plj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 21:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tmAmrTNB9Z+ptkQtfDbaSc0g4Ln9popkLS3zRUrN7k4=;
        b=BFyxeEmDSTNxz5lpza2zj+4zevwFA0vfkLlsm/8zrXc4kNXiUm6xisQMvqsHHl+/k4
         uXMhszEHDStEAIwoDctag9YAWiw6w/tTIhMM5IssEEQAkeiIRImJwjQg5UFQuP/PusYF
         6PogaHHN2UZQCIIR30dw7C0RDYnPwdwq4L9qU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tmAmrTNB9Z+ptkQtfDbaSc0g4Ln9popkLS3zRUrN7k4=;
        b=D4EXK0MPQLA3EE1YDA9SgUXlp52LPU0a+a5by2+SGc41b00BBvO2/0OR7Yuy6Y6CvH
         xKl0xtxuW1WKlXKXHdxMOHTXRNuwOUgtiBg2A/48qg5MqZwd5FSEEE4GXD+aHOpSIAs5
         smC5K37KDcpeKFYhLw5eDSnErzQHhuBWLGkpTCtiHxstlci8uce8LZ6Va+qn4+uJcYsu
         GIVIZ7FA8cZ3fXTjo2RpFQLvlV8VfKIqoFpb6vdHLMKZNdRNsfYXmoYb268LMAiAgip9
         fVmNBPanK3a4xUFn8jgs4dAmCRcMk6gjot/OggFRuc5fj6lW53TAxzxQ0s4QLSx6DpO4
         wefA==
X-Gm-Message-State: APt69E0wO//tvrBQq/JMYpSqmo3g4vu0Wgg00SliV2YsdbnDkaCI+igf
        xtcNFiIf6Y5AfAK+tHWiP1rZIA==
X-Google-Smtp-Source: ADUXVKKphCH4IWCULEp9k1H5Y7AlfWv0C1VYcE142RYb1MQRg0cl3ofZtJlud2pihI137SYp9p5bXA==
X-Received: by 2002:a17:902:1005:: with SMTP id b5-v6mr4505441pla.207.1530074355007;
        Tue, 26 Jun 2018 21:39:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id u1-v6sm4350252pfn.59.2018.06.26.21.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 21:39:13 -0700 (PDT)
Date:   Tue, 26 Jun 2018 21:39:13 -0700
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, kernel-team@android.com
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Message-ID: <20180627043913.GA177710@joelaf.mtv.corp.google.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 07:30:55PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> > +/*
> > + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> > + *
> > + * This function returns the earliest value of the grace-period sequence number
> > + * that will indicate that a full grace period has elapsed since the current
> > + * time.  Once the grace-period sequence number has reached this value, it will
> > + * be safe to invoke all callbacks that have been registered prior to the
> > + * current time. This value is the current grace-period number plus two to the
> > + * power of the number of low-order bits reserved for state, then rounded up to
> > + * the next value in which the state bits are all zero.
> 
> If you complete that by saying _why_ you need to round up there, then
> the below verbiage is completely redundant.
> 
> > + * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > + * the seq is used to track if a GP is in progress or not. Given this, it is
> > + * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
> > + * why with an example:
> > + *
> > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > + * is already in progress so the next GP that a future call back will be queued
> > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > + * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
> > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
> > + * overflow didn't occur. This masking is needed because in case RCU was idle
> > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > + *
> > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > + * which can be generalized to:
> > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > + */
> 
> Is the below not much simpler:
> 
> >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> >  {
> >  	unsigned long s;
> 
> 	s = smp_load_aquire(sp);
> 
> 	/* Add one GP */
> 	s += 1 << RCU_SEQ_CTR_SHIFT;
> 
> 	/* Complete any pending state by rounding up */

I would suggest this comment be changed to "Add another GP if there was a
pending state".

> 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> 

I agree with Peter's suggestions for both the verbiage reduction in the
comments in the header, as the new code he is proposing is more
self-documenting. I believe I proposed a big comment just because the code
wasn't self-documenting or obvious previously so needed an explanation.

How would you like to proceed? Let me know what you guys decide, I am really
Ok with anything. If you guys agree, should I write a follow-up patch with
Peter's suggestion that applies on top of this one?  Or do we want to drop
this one in favor of Peter's suggestion?

I guess we also have to conclude the other part about using memory barriers,
but I think that should be a separate patch.

thanks!

 - Joel

