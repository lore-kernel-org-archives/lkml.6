Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14880C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52A126E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hyg2SFCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52A126E8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933723AbeFZRbI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:31:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53346 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751102AbeFZRbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2QPWdQq/AHbNzeE6fkifLk607RtW337QFXuOQNKLDv0=; b=hyg2SFCfFF0P0AdZTPtww4QZg
        ZBWBPnBL9RRuhtl12z5yZ9bJfaC9T964VnB7YLjcCOEc7TTYJOuB4qLI2J4l9UJ+QbFlx2RfXfueZ
        qefLNHY1LpNymibwRCxhmD+BmKNw/Vi5UDbiQiwdgl51y08SggmVp2cKZW2313COft7O2nnzkB2O4
        +228MmPpLKYu66FaKuIKDKrkutUZe71CqN/LY0LjOnrJ4aDdzErYH0fNxJ7dWkKgHQYwOm5oMYkPs
        3iv6XbTOlL/MbusLJ/AGSQmH3szOS5Po2cg/Acf+UF3CGogra4hOiFY2/1jP3NzriVhjHzMa8W2PK
        eVznBZFNw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fXrnt-0000eI-V1; Tue, 26 Jun 2018 17:30:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BEDD62029FA0A; Tue, 26 Jun 2018 19:30:55 +0200 (CEST)
Date:   Tue, 26 Jun 2018 19:30:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 16/27] rcu: Add comment documenting how
 rcu_seq_snap works
Message-ID: <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 05:35:02PM -0700, Paul E. McKenney wrote:
> +/*
> + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> + *
> + * This function returns the earliest value of the grace-period sequence number
> + * that will indicate that a full grace period has elapsed since the current
> + * time.  Once the grace-period sequence number has reached this value, it will
> + * be safe to invoke all callbacks that have been registered prior to the
> + * current time. This value is the current grace-period number plus two to the
> + * power of the number of low-order bits reserved for state, then rounded up to
> + * the next value in which the state bits are all zero.

If you complete that by saying _why_ you need to round up there, then
the below verbiage is completely redundant.

> + * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
> + * the seq is used to track if a GP is in progress or not. Given this, it is
> + * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
> + * why with an example:
> + *
> + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> + * to account for the shift due to 2 state bits. Now, if the current seq is
> + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> + * is already in progress so the next GP that a future call back will be queued
> + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> + * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
> + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
> + * overflow didn't occur. This masking is needed because in case RCU was idle
> + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> + *
> + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> + * which can be generalized to:
> + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> + */

Is the below not much simpler:

>  static inline unsigned long rcu_seq_snap(unsigned long *sp)
>  {
>  	unsigned long s;

	s = smp_load_aquire(sp);

	/* Add one GP */
	s += 1 << RCU_SEQ_CTR_SHIFT;

	/* Complete any pending state by rounding up */
	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);

	return s;
}


