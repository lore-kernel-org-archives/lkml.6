Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeEUXlU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 19:41:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59054 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751195AbeEUXlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 19:41:19 -0400
Date: Mon, 21 May 2018 16:42:50 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
        Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 1/4] rcu: Add comment documenting how rcu_seq_snap
 works
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-2-joel@joelfernandes.org>
 <b1f55cf4-c1cc-f755-ad4d-2bd69280cb42@infradead.org>
 <20180521054826.GA137980@joelaf.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521054826.GA137980@joelaf.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18052123-0036-0000-0000-000002F85118
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009063; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01035746; UDB=6.00529795; IPR=6.00814874;
 MB=3.00021229; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-21 23:41:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052123-0037-0000-0000-0000446A2684
Message-Id: <20180521234250.GM3803@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210270
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2018 at 10:48:26PM -0700, Joel Fernandes wrote:
> On Sun, May 20, 2018 at 09:50:25PM -0700, Randy Dunlap wrote:
> > On 05/20/2018 09:42 PM, Joel Fernandes wrote:
> > > rcu_seq_snap may be tricky to decipher. Lets document how it works with
> > > an example to make it easier.
> > > 
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/rcu.h | 33 ++++++++++++++++++++++++++++++++-
> > >  1 file changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> > > index 0453a7d12b3f..d4396c96f614 100644
> > > --- a/kernel/rcu/rcu.h
> > > +++ b/kernel/rcu/rcu.h
> > > @@ -91,7 +91,38 @@ static inline void rcu_seq_end(unsigned long *sp)
> > >  	WRITE_ONCE(*sp, rcu_seq_endval(sp));
> > >  }
> > >  
> > > -/* Take a snapshot of the update side's sequence number. */
> > > +/*
> > > + * rcu_seq_snap - Take a snapshot of the update side's sequence number.
> > > + *
> > > + * This function returns the earliest value of the grace-period sequence number
> > > + * that will indicate that a full grace period has elapsed since the current
> > > + * time.  Once the grace-period sequence number has reached this value, it will
> > > + * be safe to invoke all callbacks that have been registered prior to the
> > > + * current time. This value is the current grace-period number plus two to the
> > > + * power of the number of low-order bits reserved for state, then rounded up to
> > > + * the next value in which the state bits are all zero.
> > > + *
> > > + * For example, since RCU_SEQ_STATE_MASK=3 and the least significant bit of
> > > + * the seq is used to track if a GP is in progress or not, its sufficient if we
> > 
> >                                                               it's
> > 
> > > + * add (6+1) and mask with ~3 to get the next GP. Let's see why with an example:
> > > + *
> > > + * Say the current seq is 12 which is 0b1100 (GP is 3 and state bits are 0b00).
> > > + * To get to the next GP number of 4, we have to add 0b100 to this (0x1 << 2)
> > > + * to account for the shift due to 2 state bits. Now, if the current seq is
> > > + * 13 (GP is 3 and state bits are 0b01), then it means the current grace period
> > > + * is already in progress so the next GP that a future call back will be queued
> > > + * to run at is GP+2 = 5, not 4. To account for the extra +1, we just overflow
> > > + * the 2 lower bits by adding 0b11. Incase the lower bit was set, the overflow
> > 
> >                                        In case
> > 
> > > + * will cause the extra +1 to the GP, along with the usual +1 explained before.
> > > + * This gives us GP+2. Finally we mask the lower to bits by ~0x3 incase the
> > 
> >                                                                     in case
> > 
> > > + * overflow didn't occur. This masking is needed because incase RCU was idle
> > 
> >                                                             in case
> > 
> > > + * (no GP in progress so lower 2 bits are 0b00), then the overflow of the lower
> > > + * 2 state bits wouldn't occur, so we mask to zero out those lower 2 bits.
> > > + *
> > > + * In other words, the next seq can be obtained by (0b11 + 0b100) & (~0b11)
> > > + * which can be generalized to:
> > > + * seq + (RCU_SEQ_STATE_MASK + (RCU_SEQ_STATE_MASK + 1)) & (~RCU_SEQ_STATE_MASK)
> > > + */
> > >  static inline unsigned long rcu_seq_snap(unsigned long *sp)
> > >  {
> > >  	unsigned long s;
> > > 
> > 
> > cheers.
> > -- 
> > ~Randy
> 
> Thanks Randy. Fixed, updated patch below. Paul, let me know if you want
> me to send it separately or if you can pick it up from below.
> 
> Also I realize I need some better automated tools to catch these issues
> (spelling errors in commit, diffs etc). Probably checkpatch.pl should
> have such checks for these common things too.

Indeed it does!

Please resend this with the updated rnp_start patch, with the additional
change noted by Randy.  Or just change to "it is", which allows you to
have one less situation where you need to worry about the apostrophes.

							Thanx, Paul

> ----------8<----------
> 
> >From 1c1f8ce04bca656a3c07e555048545d4a59e44cf Mon Sep 17 00:00:00 2001
> From: Joel Fernandes <joel@joelfernandes.org>
> Date: Sun, 20 May 2018 19:37:18 -0700
> Subject: [PATCH v3.5] rcu: Add comment documenting how rcu_seq_snap works
> 
> rcu_seq_snap may be tricky to decipher. Lets document how it works with
> an example to make it easier.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/rcu.h | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 0453a7d12b3f..00df3da98317 100644
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
> + * add (6+1) and mask with ~3 to get the next GP. Let's see why with an example:
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
