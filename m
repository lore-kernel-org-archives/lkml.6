Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbeEUFs3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 01:48:29 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37800 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeEUFs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 01:48:28 -0400
X-Google-Smtp-Source: AB8JxZohr2QSN8svG4EIVHM/wJORw1vAYtebz3OPsMXC4HfAtI9huVHslPZDhw7LmZA/Or9B5oQVDQ==
Date: Sun, 20 May 2018 22:48:26 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/4] rcu: Add comment documenting how rcu_seq_snap
 works
Message-ID: <20180521054826.GA137980@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-2-joel@joelfernandes.org>
 <b1f55cf4-c1cc-f755-ad4d-2bd69280cb42@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f55cf4-c1cc-f755-ad4d-2bd69280cb42@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 09:50:25PM -0700, Randy Dunlap wrote:
> On 05/20/2018 09:42 PM, Joel Fernandes wrote:
> > rcu_seq_snap may be tricky to decipher. Lets document how it works with
> > an example to make it easier.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/rcu/rcu.h | 33 ++++++++++++++++++++++++++++++++-
> >  1 file changed, 32 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > index 0453a7d12b3f..d4396c96f614 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -91,7 +91,38 @@ static inline void rcu_seq_end(unsigned long *sp)
> >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> >  }
> >  
> > -/* Take a snapshot of the update side's sequence number. */
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
> > + *
> > + * For example, since RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > + * the seq is used to track if a GP is in progress or not, its sufficient if we
> 
>                                                               it's
> 
> > + * add (6+1) and mask with ~3 to get the next GP. Let's see why with an example:
> > + *
> > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > + * is already in progress so the next GP that a future call back will be queued
> > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > + * the 2 lower bits by adding 0b11. Incase the lower bit was set, the overflow
> 
>                                        In case
> 
> > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 incase the
> 
>                                                                     in case
> 
> > + * overflow didn't occur. This masking is needed because incase RCU was idle
> 
>                                                             in case
> 
> > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > + *
> > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > + * which can be generalized to:
> > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > + */
> >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> >  {
> >  	unsigned long s;
> > 
> 
> cheers.
> -- 
> ~Randy

Thanks Randy. Fixed, updated patch below. Paul, let me know if you want
me to send it separately or if you can pick it up from below.

Also I realize I need some better automated tools to catch these issues
(spelling errors in commit, diffs etc). Probably checkpatch.pl should
have such checks for these common things too.

----------8<----------

>From 1c1f8ce04bca656a3c07e555048545d4a59e44cf Mon Sep 17 00:00:00 2001
From: Joel Fernandes <joel@joelfernandes.org>
Date: Sun, 20 May 2018 19:37:18 -0700
Subject: [PATCH v3.5] rcu: Add comment documenting how rcu_seq_snap works

rcu_seq_snap may be tricky to decipher. Lets document how it works with
an example to make it easier.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu.h | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0453a7d12b3f..00df3da98317 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -91,7 +91,38 @@ static inline void rcu_seq_end(unsigned long *sp)
 	WRITE_ONCE(*sp, rcu_seq_endval(sp));
 }
 
-/* Take a snapshot of the update side's sequence number. */
+/*
+ * rcu_seq_snap - Take a snapshot of the update side's sequence number.
+ *
+ * This function returns the earliest value of the grace-period sequence number
+ * that will indicate that a full grace period has elapsed since the current
+ * time.  Once the grace-period sequence number has reached this value, it will
+ * be safe to invoke all callbacks that have been registered prior to the
+ * current time. This value is the current grace-period number plus two to the
+ * power of the number of low-order bits reserved for state, then rounded up to
+ * the next value in which the state bits are all zero.
+ *
+ * For example, since RCU_SEQ_STATE_MASK=3 and the least significant bit of
+ * the seq is used to track if a GP is in progress or not, its sufficient if we
+ * add (6+1) and mask with ~3 to get the next GP. Let's see why with an example:
+ *
+ * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
+ * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
+ * to account for the shift due to 2 state bits. Now, if the current seq is
+ * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
+ * is already in progress so the next GP that a future call back will be queued
+ * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
+ * the 2 lower bits by adding 0b11. In case the lower bit was set, the overflow
+ * will cause the extra +1 to the GP, along with the usual +1 explained before.
+ * This gives us GP+2. Finally we mask the lower to bits by ~0x3 in case the
+ * overflow didn't occur. This masking is needed because in case RCU was idle
+ * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
+ * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
+ *
+ * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
+ * which can be generalized to:
+ * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
+ */
 static inline unsigned long rcu_seq_snap(unsigned long *sp)
 {
 	unsigned long s;
-- 
2.17.0.441.gb46fe60e1d-goog
