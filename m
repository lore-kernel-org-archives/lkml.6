Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754746AbeEWQNs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:13:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751646AbeEWQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:13:45 -0400
Date: Wed, 23 May 2018 09:04:00 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>, byungchul.park@lge.com,
        Ingo Molnar <mingo@redhat.com>, Josh Triplett <josh@joshtriplett.org>,
        kernel-team@android.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zilstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/4] rcu: Add comment documenting how rcu_seq_snap works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180523063815.198302-1-joel@joelfernandes.org>
 <20180523063815.198302-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523063815.198302-3-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052316-0008-0000-0000-000009D7E758
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009072; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036557; UDB=6.00530281; IPR=6.00815684;
 MB=3.00021260; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-23 16:13:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052316-0009-0000-0000-0000476CA3BE
Message-Id: <20180523160400.GL3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805230159
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 11:38:13PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> rcu_seq_snap may be tricky to decipher. Lets document how it works with
> an example to make it easier.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Very good, queued for further review, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h | 34 +++++++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 0453a7d12b3f..5819a37f19fb 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -91,7 +91,39 @@ static inline void rcu_seq_end(unsigned long *sp)
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
>  static inline unsigned long rcu_seq_snap(unsigned long *sp)
>  {
>  	unsigned long s;
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
