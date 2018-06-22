Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2A5C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CA9245DC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73CA9245DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934323AbeFVQix (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:38:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40502 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933376AbeFVQiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:38:52 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5MGcpLc028442
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:38:51 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2js2hq6rm7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 12:38:51 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 22 Jun 2018 12:38:50 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 22 Jun 2018 12:38:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5MGcjPS5439880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Jun 2018 16:38:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E58B2064;
        Fri, 22 Jun 2018 12:38:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F019FB2070;
        Fri, 22 Jun 2018 12:38:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 22 Jun 2018 12:38:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3B3DF16C3888; Fri, 22 Jun 2018 09:40:48 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:40:48 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <Pine.LNX.4.44L0.1806211322160.2381-100000@iolanthe.rowland.org>
 <20180622080928.GB7601@arm.com>
 <20180622095547.GE7601@arm.com>
 <20180622103129.GQ2476@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622103129.GQ2476@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062216-0052-0000-0000-00000302C120
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009239; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000265; SDB=6.01050748; UDB=6.00538514; IPR=6.00829718;
 MB=3.00021808; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-22 16:38:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062216-0053-0000-0000-00005D1AD9FE
Message-Id: <20180622164048.GR3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-22_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=814 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806220185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 12:31:29PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 22, 2018 at 10:55:47AM +0100, Will Deacon wrote:
> > On Fri, Jun 22, 2018 at 09:09:28AM +0100, Will Deacon wrote:
> > > On Thu, Jun 21, 2018 at 01:27:12PM -0400, Alan Stern wrote:
> > > > More than one kernel developer has expressed the opinion that the LKMM
> > > > should enforce ordering of writes by release-acquire chains and by
> > > > locking.  In other words, given the following code:
> > > > 
> > > > 	WRITE_ONCE(x, 1);
> > > > 	spin_unlock(&s):
> > > > 	spin_lock(&s);
> > > > 	WRITE_ONCE(y, 1);
> 
> So this is the one I'm relying on and really want sorted.
> 
> > > > or the following:
> > > > 
> > > > 	smp_store_release(&x, 1);
> > > > 	r1 = smp_load_acquire(&x);	// r1 = 1
> > > > 	WRITE_ONCE(y, 1);
> 
> Reading back some of the old threads [1], it seems the direct
> translation of the first into acquire-release would be:
> 
> 	WRITE_ONCE(x, 1);
> 	smp_store_release(&s, 1);
> 	r1 = smp_load_acquire(&s);
> 	WRITE_ONCE(y, 1);
> 
> Which is I think easier to make happen than the second example you give.
> 
> > > > the stores to x and y should be propagated in order to all other CPUs,
> > > > even though those other CPUs might not access the lock s or be part of
> > > > the release-acquire chain.  In terms of the memory model, this means
> > > > that rel-rf-acq-po should be part of the cumul-fence relation.
> > > > 
> > > > All the architectures supported by the Linux kernel (including RISC-V)
> > > > do behave this way, albeit for varying reasons.  Therefore this patch
> > > > changes the model in accordance with the developers' wishes.
> > > 
> > > Interesting...
> > > 
> > > I think the second example would preclude us using LDAPR for load-acquire,
> > > so I'm surprised that RISC-V is ok with this. For example, the first test
> > > below is allowed on arm64.
> > > 
> > > I also think this would break if we used DMB LD to implement load-acquire
> > > (second test below).
> > > 
> > > So I'm not a big fan of this change, and I'm surprised this works on all
> > > architectures. What's the justification?
> > 
> > I also just realised that this prevents Power from using ctrl+isync to
> > implement acquire, should they wish to do so.
> 
> They in fact do so on chips lacking LWSYNC, see how PPC_ACQUIRE_BARRIER
> (as used by atomic_*_acquire) turns into ISYNC (note however that they
> do not use PPC_ACQUIRE_BARRIER for smp_load_acquire -- because there's
> no CTRL there).

PowerPC -could- use a load-compare-branch-isync sequence to implement
smp_load_acquire(), but as you say it instead uses lwsync, falling
back to sync on CPUs not implementing lwsync.

Locking should work either way because even if lock acquisition uses isync
(leveraging the fact that the "stcwx." instruction affects condition
codes and branches back when someone else already holds the lock),
lock release still uses lwsync (or sync on systems not having lwsync).

							Thanx, Paul

> [1] https://lkml.kernel.org/r/20171128095850.rhtnx6e2qxep5npa@hirez.programming.kicks-ass.net
> 

