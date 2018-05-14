Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753398AbeENRgx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 13:36:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752474AbeENRgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 13:36:51 -0400
Date: Mon, 14 May 2018 10:38:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH RFC 1/8] rcu: Add comment documenting how rcu_seq_snap
 works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180514031541.67247-1-joel@joelfernandes.org>
 <20180514031541.67247-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514031541.67247-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18051417-0056-0000-0000-0000044E24CA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009025; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000260; SDB=6.01032264; UDB=6.00527713; IPR=6.00811396;
 MB=3.00021110; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-14 17:36:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051417-0057-0000-0000-000008923850
Message-Id: <20180514173816.GA26088@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140177
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 08:15:34PM -0700, Joel Fernandes (Google) wrote:
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

How about something like this?

	This function returns the earliest value of the grace-period
	sequence number that will indicate that a full grace period has
	elapsed since the current time.  Once the grace-period sequence
	number has reached this value, it will be safe to invoke all
	callbacks that have been registered prior to the current time.
	This value is the current grace-period number plus two to the
	power of the number of low-order bits reserved for state, then
	rounded up to the next value in which the state bits are all zero.

> + *
> + * We do this with a single addition and masking.

Please either fold this sentence into rest of the paragraph or add a
blank line after it.

> + * For example, if RCU_SEQ_STATE_MASK=1 and the least significant bit (LSB) of
> + * the seq is used to track if a GP is in progress or not, its sufficient if we
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

Having the explicit numbers is good, but please use RCU_SEQ_STATE_MASK=3,
since that is the current value.  One alternative (or perhaps addition)
is to have a short table of numbers showing the mapping from *sp to the
return value.  (I started from such a table when writing this function,
for whatever that is worth.)

						Thanx, Paul

>  static inline unsigned long rcu_seq_snap(unsigned long *sp)
>  {
>  	unsigned long s;
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
