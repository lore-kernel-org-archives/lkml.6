Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754017AbeCFVGG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 16:06:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52022 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753466AbeCFVGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 16:06:05 -0500
Date: Tue, 6 Mar 2018 13:06:24 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: Simplifying our RCU models
Reply-To: paulmck@linux.vnet.ibm.com
References: <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
 <20180306090050.zslv7g37dh6a5kpz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306090050.zslv7g37dh6a5kpz@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030621-0048-0000-0000-00000245377E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008628; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00999350; UDB=6.00508301; IPR=6.00778668;
 MB=3.00019880; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-06 21:05:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030621-0049-0000-0000-000044599FF9
Message-Id: <20180306210624.GB3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 10:00:50AM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> >    I.e. the new RCU namespace would be something like:
> > 
> >      call_rcu                     => rcu_call_rcu
> 
> typo: rcu_call().
> 
> >      synchronize_rcu              => rcu_wait_
> 
> typo: rcu_wait().
> 
> Here's the updated table:
> 
>      # RCU APIs:
> 
>      rcu_read_lock                => rcu_read_lock        # unchanged
>      rcu_read_unlock              => rcu_read_unlock      # unchanged
> 
>      call_rcu                     => rcu_call
>      call_rcu_bh                  => rcu_call_bh
>      call_rcu_sched               => rcu_call_sched

	call_rcu_tasks			=> rcu_call_tasks ?

>      synchronize_rcu              => rcu_wait
>      synchronize_rcu_bh           => rcu_wait_bh
>      synchronize_rcu_bh_expedited => rcu_wait_expedited_bh
>      synchronize_rcu_expedited    => rcu_wait_expedited
>      synchronize_rcu_mult         => rcu_wait_mult

The consolidation of RCU, RCU-bh, and RCU-sched would eliminate the
only use of synchronize_rcu_mult().  Should we simply remove it?

>      synchronize_rcu_sched        => rcu_wait_sched
>      synchronize_rcu_tasks        => rcu_wait_tasks
> 
>      get_state_synchronize_rcu    => rcu_get_state
>      cond_synchronize_rcu         => rcu_wait_state

All of rcu_barrier, rcu_barrier_bh, rcu_barrier_sched, rcu_barrier_tasks,
and srcu_barrier remain unchanged, correct?

>      # SRCU APIs:
> 
>      srcu_read_lock               => srcu_read_lock       # unchanged
>      srcu_read_unlock             => srcu_read_unlock     # unchanged
> 
>      synchronize_srcu             => srcu_wait
>      synchronize_srcu_expedited   => srcu_wait_expedited

	call_srcu			=> srcu_call ?

And rcu_assign_pointer, rcu_access_pointer(), and rcu_dereference*()
remain unchanged, correct?  I wouldn't expect RCU's list API to change,
but if we are going to change something, this would be the time...  

On the other hand, the ones you list above are the ones that get used,
hence the ones for which the names are most important.  That said...

The following list is a bit out of date, but is not too far off:

	https://lwn.net/Articles/609973/

Yeah, I know, causing trouble for myself.  ;-)

							Thanx, Paul
