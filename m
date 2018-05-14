Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeENDrk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 23:47:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:44902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751847AbeENDrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 23:47:39 -0400
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d13d5fca-d98c-c657-316d-aed10fd3eff0@infradead.org>
Date: Sun, 13 May 2018 20:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180514031541.67247-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13/2018 08:15 PM, Joel Fernandes (Google) wrote:
> rcu_seq_snap may be tricky for someone looking at it for the first time.
> Lets document how it works with an example to make it easier.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu.h | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 003671825d62..fc3170914ac7 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -91,7 +91,29 @@ static inline void rcu_seq_end(unsigned long *sp)
>  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
>  }
>  
> -/* Take a snapshot of the update side's sequence number. */
> +/*
> + * Take a snapshot of the update side's sequence number.
> + *
> + * This function predicts what the grace period number will be the next
> + * time an RCU callback will be executed, given the current grace period's
> + * number. This can be gp+1 if RCU is idle, or gp+2 if a grace period is
> + * already in progress.
> + *
> + * We do this with a single addition and masking.
> + * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
> + * the seq is used to track if a GP is in progress or not, its sufficient if we

                                                              it's

> + * add (2+1) and mask with ~1. Let's see why with an example:
> + *
> + * Say the current seq is 6 which is 0b110 (gp is 3 and state bit is 0).
> + * To get the next GP number, we have to at least add 0b10 to this (0x1 << 1)
> + * to account for the state bit. However, if the current seq is 7 (gp is 3 and
> + * state bit is 1), then it means the current grace period is already in
> + * progress so the next time the callback will run is at the end of grace
> + * period number gp+2. To account for the extra +1, we just overflow the LSB by
> + * adding another 0x1 and masking with ~0x1. In case no GP was in progress (RCU
> + * is idle), then the addition of the extra 0x1 and masking will have no
> + * effect. This is calculated as below.
> + */
>  static inline unsigned long rcu_seq_snap(unsigned long *sp)
>  {
>  	unsigned long s;
> 


-- 
~Randy
