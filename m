Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BE2C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D143626C7B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nt6Mo8IQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D143626C7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeF1FKb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:10:31 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44598 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932329AbeF1FKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:10:30 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so2161921pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 22:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ijMpWL981q+N7asYRk6SO6v6ov8dZ8gi1QPwnOjSjYg=;
        b=nt6Mo8IQ+I0WzCvuOKozunwzfy62JZ12WnvaNJ2H2TSJOgylNCgEvlIIBPVOvxxK/4
         p2/fRrwHSAQteKQ3z/r77MThKcUu9c+Tq0UmOeCbZ6mAGYAUY3Ah4tEzmyzcP8YuDsPh
         TaOw4j1TQmCw9Xorhr5aJbitOI/vIDPl2CjM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ijMpWL981q+N7asYRk6SO6v6ov8dZ8gi1QPwnOjSjYg=;
        b=KWDirURVC4OWd9FkZqnW7g4HjNY/RFx7NSnrRfkXHa8atcbFgXQYs00GCw/7Elynps
         o0zbyQh6zT7lx3pq2TVv9STHhUmhon38NCAPBjnS17OR/ZD8D8OjYcTfFNBTXdAkFsyi
         ArzYCjsK9iKl3I1/gD0emDbvopGcu0PEPTKCQWrfwy4okvJGNecs3220Q2nWI1wg4JDA
         XiXhbOlSJubpd6HB0hB1EZQ1IU4MhewvBx/7s69Dg4CIDl1eDVsJ17CaaEojck2y3fPB
         v0eEskcgl8h9WOtceVw4YkumPJieQAZQBX8Su8BlbdqkbyBNskW9+/JKeSAk2N5r/tIe
         GLLg==
X-Gm-Message-State: APt69E1Yy1DAGvpbN4niyI4ItGhdXTAGzGd89m2UzzFEc4yyxQSZOdCI
        LNUF5JtfMUl5mdFCTyUNfQ67Cg==
X-Google-Smtp-Source: ADUXVKLtPjYnClJduwr9DU0k254UQ5dHU436q6vKnn/FniskCLtDfwhQvHVd6SWzNtOTN5hwi/+bqg==
X-Received: by 2002:a17:902:728a:: with SMTP id d10-v6mr8943171pll.192.1530162629728;
        Wed, 27 Jun 2018 22:10:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id g10-v6sm8212512pfi.148.2018.06.27.22.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 22:10:28 -0700 (PDT)
Date:   Wed, 27 Jun 2018 22:10:28 -0700
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
Message-ID: <20180628051028.GB79165@joelaf.mtv.corp.google.com>
References: <20180626003448.GA26209@linux.vnet.ibm.com>
 <20180626003513.27812-16-paulmck@linux.vnet.ibm.com>
 <20180626173055.GJ2494@hirez.programming.kicks-ass.net>
 <20180627043913.GA177710@joelaf.mtv.corp.google.com>
 <20180627175436.GC3593@linux.vnet.ibm.com>
 <20180627182726.GA79165@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627182726.GA79165@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:27:26AM -0700, Joel Fernandes wrote:
[..]
> > > > 	s = __ALIGN_MASK(s, RCU_SEQ_STATE_MASK);
> > > > 
> > > 
> > > I agree with Peter's suggestions for both the verbiage reduction in the
> > > comments in the header, as the new code he is proposing is more
> > > self-documenting. I believe I proposed a big comment just because the code
> > > wasn't self-documenting or obvious previously so needed an explanation.
> > > 
> > > How would you like to proceed? Let me know what you guys decide, I am really
> > > Ok with anything. If you guys agree, should I write a follow-up patch with
> > > Peter's suggestion that applies on top of this one?  Or do we want to drop
> > > this one in favor of Peter's suggestion?
> > 
> > Shortening the comment would be good, so please do that.

Paul,

Do you want to fold the below patch into the original one? Or do you prefer I
resent the original patch fixed up?

Following is the patch ontop of current 'dev' branch in your tree, with the
excessive comments removed.

Thanks to Peter for suggesting!

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] rcu: Remove excessive commentary on rcu_seq_snap

There isn't a strong need to explain in excessive detail about
rcu_seq_snap with an example. Remove unnecessary and redundant comments.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Fixes: 9701945dd79e ("rcu: Add comment documenting how rcu_seq_snap works")
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0af6ce6d8b66..4d04683c31b2 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -101,28 +101,6 @@ static inline void rcu_seq_end(unsigned long *sp)
  * current time. This value is the current grace-period number plus two to the
  * power of the number of low-order bits reserved for state, then rounded up to
  * the next value in which the state bits are all zero.
- *
- * In the current design, RCU_SEQ_STATE_MASK=3 and the least significant bit of
- * the seq is used to track if a GP is in progress or not. Given this, it is
- * sufficient if we add (6+1) and mask with ~3 to get the next GP. Let's see
- * why with an example:
- *
- * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
- * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
- * to account for the shift due to 2 state bits. Now, if the current seq is
- * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
- * is already in progress so the next GP that a future call back will be queued
- * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
- * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
- * will cause the extra +1 to the GP, along with the usual +1 explained before.
- * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
- * overflow didn't occur. This masking is needed because in case RCU was idle
- * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
- * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
- *
- * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
- * which can be generalized to:
- * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
  */
 static inline unsigned long rcu_seq_snap(unsigned long *sp)
 {
-- 
2.18.0.rc2.346.g013aa6912e-goog

