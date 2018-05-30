Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbeE3NsS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:48:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39590 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751568AbeE3NsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:48:15 -0400
Date: Wed, 30 May 2018 06:49:52 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, joel@joelfernandes.org
Subject: Re: [RFC] rcu: Check the range of jiffies_till_xxx_fqs on setting
 them
Reply-To: paulmck@linux.vnet.ibm.com
References: <1527578616-5595-1-git-send-email-byungchul.park@lge.com>
 <20180529120155.GC3803@linux.vnet.ibm.com>
 <ec3f99af-902d-4a12-f533-07de97dab310@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3f99af-902d-4a12-f533-07de97dab310@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18053013-0008-0000-0000-0000030EA663
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009098; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01039841; UDB=6.00532237; IPR=6.00818975;
 MB=3.00021375; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-30 13:48:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053013-0009-0000-0000-000039686920
Message-Id: <20180530134952.GF7063@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-30_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805300154
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:06:52PM +0900, Byungchul Park wrote:
> 
> 
> On 2018-05-29 21:01, Paul E. McKenney wrote:
> >On Tue, May 29, 2018 at 04:23:36PM +0900, Byungchul Park wrote:
> >>Hello Paul and folks,
> >>
> >>I've thought the code should've been like the below since the range
> >>checking of jiffies_till_first_fqs and jiffies_till_next_fqs everytime
> >>in the loop of rcu_gp_kthread are unnecessary at all. However, it's ok
> >>even if you don't think it's worth doing it.
> >
> >Nice!
> >
> >>Secondly, I also think jiffies_till_first_fqs = 0 is meaningless so
> >>added checking and adjusting it as what's done on jiffies_till_next_fqs.
> >>Thought?
> >
> >Actually, jiffies_till_first_fqs == 0 is very useful for cases where
> >at least one CPU is expected to be idle and grace-period latency is
> >important.  In this case, doing the first scan immediately gets the
> >dyntick-idle state recorded immediately, getting the idle CPUs out of
> >the way of the grace period immediately.
> 
> Hi Paul~
> 
> You might want to handle it through sysfs. Otherwise, we can do it with
> force_quiescent_state() IMHO.

I agree that sysfs would be better than debugfs because these parameters
are about tuning, not debugging, so good point!

> >So why not do this scan as part of grace-period initialization?  Because
> >doing so consumes extra CPU and results in extra cache misses, which is
> >the opposite of what you want on a completely busy system, especially
> >one where the CPUs are context switching quickly.  Thus no scan during
> >grace-period initialization.
> 
> I am sorry I don't understand this paragraph. :(

Let me try again.  ;-)

I could change RCU to avoid the need for jiffies_till_first_fqs == 0,
but doing that would increase CPU consumption for workloads that are
already bottlenecked on the CPU.  So I won't be making that change,
so we still need jiffies_till_first_fqs == 0.

> >But I can see the desire to share code.
> >
> >One approach would be to embed the kernel_params_ops structure inside
> >another structure containing the limits, then just have two structures.
> >Perhaps something like this already exists?  I don't see it right off,
> >but then again, I am not exactly an expert on module_param.
> 
> It would be much nicer if we can as you said. I will check it.

Sounds very good!

							Thanx, Paul

> Thanks a lot Paul.
> 
> -- 
> Thanks,
> Byungchul
> 
