Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDQPnF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:43:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49210 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752695AbeDQPnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:43:03 -0400
Date: Tue, 17 Apr 2018 08:43:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: rcu_process_callbacks irqsoff latency caused by taking spinlock
 with irqs disabled
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180405093414.2273203e@roar.ozlabs.ibm.com>
 <20180405001358.GK3948@linux.vnet.ibm.com>
 <20180405104512.25ada2bb@roar.ozlabs.ibm.com>
 <20180405155320.GN3948@linux.vnet.ibm.com>
 <20180407074042.0c50a59a@roar.ozlabs.ibm.com>
 <20180408210618.GT3948@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180408210618.GT3948@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18041715-0044-0000-0000-00000405ECF5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008871; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000257; SDB=6.01019272; UDB=6.00519979; IPR=6.00798513;
 MB=3.00020619; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-17 15:43:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041715-0045-0000-0000-00000837F149
Message-Id: <20180417154357.GA24235@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-17_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804170139
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 02:06:18PM -0700, Paul E. McKenney wrote:
> On Sat, Apr 07, 2018 at 07:40:42AM +1000, Nicholas Piggin wrote:
> > On Thu, 5 Apr 2018 08:53:20 -0700
> > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

[ . . . ]

> > > > Note that rcu doesn't show up consistently at the top, this was
> > > > just one that looked *maybe* like it can be improved. So I don't
> > > > know how reproducible it is.  
> > > 
> > > Ah, that leads me to wonder whether the hypervisor preempted whoever is
> > > currently holding the lock.  Do we have anything set up to detect that
> > > sort of thing?
> > 
> > In this case it was running on bare metal, so it was a genuine latency
> > event. It just hasn't been consistently at the top (scheduler has been
> > there, but I'm bringing that down with tuning).
> 
> OK, never mind about vCPU preemption, then!  ;-)
> 
> It looks like I will have other reasons to decrease rcu_node lock
> contention, so let me see what I can do.

And the intermittent contention behavior you saw makes is plausible
given the current code structure, which avoids contention in the common
case where grace periods follow immediately one after the other, but
does not in the less-likely case where RCU is idle and a bunch of CPUs
simultaneously see the need for a new grace period.  I have a fix in
the works which occasionally actually makes it through rcutorture.  ;-)

I expect to have something robust enough to post to LKML by the end
of this week.

							Thanx, Paul
