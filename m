Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeEUEuz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:50:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50378 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750849AbeEUEuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:50:54 -0400
Subject: Re: [PATCH v3 1/4] rcu: Add comment documenting how rcu_seq_snap
 works
To: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org
Cc: Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-2-joel@joelfernandes.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b1f55cf4-c1cc-f755-ad4d-2bd69280cb42@infradead.org>
Date: Sun, 20 May 2018 21:50:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180521044220.123933-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/20/2018 09:42 PM, Joel Fernandes wrote:
> rcu_seq_snap may be tricky to decipher. Lets document how it works with
> an example to make it easier.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu.h | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 0453a7d12b3f..d4396c96f614 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -91,7 +91,38 @@ static inline void rcu_seq_end(unsigned long *sp)
>  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
>  }
>  
> -/* Take a snapshot of the update side's sequence number. */
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
> + *
> + * For example, since RCU_SEQ_STATE_MASK=3 and the least significant bit of
> + * the seq is used to track if a GP is in progress or not, its sufficient if we

                                                              it's

> + * add (6+1) and mask with ~3 to get the next GP. Let's see why with an example:
> + *
> + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> + * to account for the shift due to 2 state bits. Now, if the current seq is
> + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> + * is already in progress so the next GP that a future call back will be queued
> + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> + * the 2 lower bits by adding 0b11. Incase the lower bit was set, the overflow

                                       In case

> + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 incase the

                                                                    in case

> + * overflow didn't occur. This masking is needed because incase RCU was idle

                                                            in case

> + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> + *
> + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> + * which can be generalized to:
> + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> + */
>  static inline unsigned long rcu_seq_snap(unsigned long *sp)
>  {
>  	unsigned long s;
> 

cheers.
-- 
~Randy
