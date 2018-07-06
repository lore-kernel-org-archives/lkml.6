Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE66EC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EE022BD3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 21:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EE022BD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753993AbeGFVIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 17:08:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753529AbeGFVIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 17:08:45 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w66L3RbA115528
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 17:08:44 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k2en23q2b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 17:08:44 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 6 Jul 2018 17:08:44 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 17:08:40 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w66L8dZh10289566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 21:08:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 985D6B2064;
        Fri,  6 Jul 2018 17:08:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79288B2066;
        Fri,  6 Jul 2018 17:08:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 17:08:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 64CDC16CA5F5; Fri,  6 Jul 2018 14:10:55 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:10:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180705150945.GA3699@andrea>
 <Pine.LNX.4.44L0.1807061629280.1396-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807061629280.1396-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070621-0072-0000-0000-0000037C1440
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009321; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057548; UDB=6.00542596; IPR=6.00835468;
 MB=3.00022032; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 21:08:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070621-0073-0000-0000-0000489E82A7
Message-Id: <20180706211055.GN3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060237
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 04:37:21PM -0400, Alan Stern wrote:
> On Thu, 5 Jul 2018, Andrea Parri wrote:
> 
> > > At any rate, it looks like instead of strengthening the relation, I
> > > should write a patch that removes it entirely.  I also will add new,
> > > stronger relations for use with locking, essentially making spin_lock
> > > and spin_unlock be RCsc.
> > 
> > Thank you.
> > 
> > Ah let me put this forward: please keep an eye on the (generic)
> > 
> >   queued_spin_lock()
> >   queued_spin_unlock()
> > 
> > (just to point out an example). Their implementation (in part.,
> > the fast-path) suggests that if we will stick to RCsc lock then
> > we should also stick to RCsc acq. load from RMW and rel. store.
> 
> A very good point.  The implementation of those routines uses
> atomic_cmpxchg_acquire() to acquire the lock.  Unless this is
> implemented with an operation or fence that provides write-write
> ordering (in conjunction with a suitable release), qspinlocks won't
> have the ordering properties that we want.
> 
> I'm going to assume that the release operations used for unlocking
> don't need to have any extra properties; only the lock-acquire
> operations need to be special (i.e., stronger than a normal
> smp_load_acquire). This suggests that atomic RMW functions with acquire
> semantics should also use this stronger form of acquire.
> 
> Does anybody have a different suggestion?

The approach you suggest makes sense to me.  Will, Peter, Daniel, any
reasons why this approach would be a problem for you guys?

							Thanx, Paul

