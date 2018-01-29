Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751744AbeA3Jmv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:42:51 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751457AbeA3Jms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:42:48 -0500
Date: Mon, 29 Jan 2018 15:43:47 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] hrtimer: Reset hrtimer cpu base proper on CPU hotplug
Reply-To: paulmck@linux.vnet.ibm.com
References: <alpine.DEB.2.20.1801261447590.2067@nanos>
 <20180126220917.GI3741@linux.vnet.ibm.com>
 <20180129082047.hash3pnhpztzcg22@linutronix.de>
 <20180129095738.GU3741@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180129095738.GU3741@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18013009-0048-0000-0000-0000022E114E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008452; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00978112; UDB=6.00495877; IPR=6.00757813;
 BA=6.00005786; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019285; XFM=3.00000015;
 UTC=2018-01-30 09:42:45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18013009-0049-0000-0000-000043F48EF7
Message-Id: <20180129234347.GA26365@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1801300124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2018 at 01:57:38AM -0800, Paul E. McKenney wrote:
> On Mon, Jan 29, 2018 at 09:20:48AM +0100, Sebastian Sewior wrote:
> > On 2018-01-26 14:09:17 [-0800], Paul E. McKenney wrote:
> > > find this one.  ;-)  But it did pass rcutorture testing for a great many
> > > years, didn't it?  :-/
> > 
> > It started to trigger better (or at all) on our test box with
> > 	modprobe kvm_intel preemption_timer=n
> > 
> > on the host kernel so maybe a completely unrelated change helped to
> > trigger this.
> 
> Good point!
> 
> And testing continues, currently at 108 hours of TREE01 without any
> waylayed timers, so looking good!  ;-)
> 
> Just kicked off another 70 hours worth.

And those completed without incident for a total of 178 hours.  I believe
we can call this one fixed.  Thank you all!!!

One question...  Is the patch shown below needed, or is this just yet
another case of me being confused?  (The lack of it is not triggering,
but...)

							Thanx, Paul

------------------------------------------------------------------------

commit accb0edb85526a05b934eac49658d05ea0216fc4
Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Date:   Thu Dec 7 13:18:44 2017 -0800

    timers: Ensure that timer_base ->clk accounts for time offline
    
    The timer_base ->must_forward_clk is set to indicate that the next timer
    operation on that timer_base must check for passage of time.  One instance
    of time passage is when the timer wheel goes idle, and another is when
    the corresponding CPU is offline.  Note that it is not appropriate to set
    ->is_idle because that could result in IPIing an offline CPU.  Therefore,
    this commit instead sets ->must_forward_clk at CPU-offline time.
    
    Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index ffebcf878fba..94cce780c574 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1875,6 +1875,7 @@ int timers_dead_cpu(unsigned int cpu)
 
 		BUG_ON(old_base->running_timer);
 
+		old_base->must_forward_clk = true;
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
 
