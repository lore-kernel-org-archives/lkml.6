Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeDGXgt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 19:36:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41886 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752283AbeDGXgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 19:36:48 -0400
Date: Sat, 7 Apr 2018 16:37:42 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@kernel.org, boqun.feng@gmail.com, catalin.marinas@arm.com
Subject: Re: [PATCH 02/10] locking/qspinlock: Remove unbounded cmpxchg loop
 from locking slowpath
Reply-To: paulmck@linux.vnet.ibm.com
References: <1522947547-24081-1-git-send-email-will.deacon@arm.com>
 <1522947547-24081-3-git-send-email-will.deacon@arm.com>
 <dc5f5e43-a60a-05f2-16fb-46960c40459e@redhat.com>
 <20180406210953.GA24165@linux.vnet.ibm.com>
 <20180407084732.GO4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180407084732.GO4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18040723-0052-0000-0000-000002D6B15B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008815; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000256; SDB=6.01014635; UDB=6.00517290; IPR=6.00793891;
 MB=3.00020464; MTD=3.00000008; XFM=3.00000015; UTC=2018-04-07 23:36:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040723-0053-0000-0000-00005C405FF8
Message-Id: <20180407233741.GM3948@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-07_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804070250
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 07, 2018 at 10:47:32AM +0200, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 02:09:53PM -0700, Paul E. McKenney wrote:
> > It would indeed be good to not be in the position of having to trade off
> > forward-progress guarantees against performance, but that does appear to
> > be where we are at the moment.
> 
> Depends of course on how unfair cmpxchg is. On x86 we trade one cmpxchg
> loop for another so the patch doesn't cure anything at all there. And
> our cmpxchg has 'some' hardware fairness to it.
> 
> So while the patch is 'good' for platforms that have native fetch-or,
> it doesn't help (or in our case even hurts) those that do not.

Might need different implementations for different architectures, then.
Or take advantage of the fact that x86 can do a native fetch-or to the
topmost bit, if that helps.

							Thanx, Paul
