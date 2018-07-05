Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0609CC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA07824104
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA07824104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbeGEQxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:53:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753437AbeGEQxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:53:53 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w65GnN1K119104
        for <linux-kernel@vger.kernel.org>; Thu, 5 Jul 2018 12:53:53 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k1mab8ejv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 12:53:52 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 5 Jul 2018 12:53:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Jul 2018 12:53:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w65Grkwe64421950
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Jul 2018 16:53:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 536A6B2066;
        Thu,  5 Jul 2018 12:53:27 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3245DB2065;
        Thu,  5 Jul 2018 12:53:27 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.104])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  5 Jul 2018 12:53:27 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5ACB816CA477; Thu,  5 Jul 2018 09:56:02 -0700 (PDT)
Date:   Thu, 5 Jul 2018 09:56:02 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
 <20180705153140.GO3593@linux.vnet.ibm.com>
 <b41849a8-76cd-2375-dd80-c1bdeb9ea7d2@nvidia.com>
 <20180705162225.GH14470@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705162225.GH14470@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18070516-0072-0000-0000-0000037A86C4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009314; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01056983; UDB=6.00542257; IPR=6.00834904;
 MB=3.00022012; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-05 16:53:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070516-0073-0000-0000-0000489A6445
Message-Id: <20180705165602.GQ3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-05_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=812 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807050190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 05:22:26PM +0100, Will Deacon wrote:
> On Thu, Jul 05, 2018 at 08:44:39AM -0700, Daniel Lustig wrote:
> > On 7/5/2018 8:31 AM, Paul E. McKenney wrote:
> > > On Thu, Jul 05, 2018 at 10:21:36AM -0400, Alan Stern wrote:
> > >> At any rate, it looks like instead of strengthening the relation, I
> > >> should write a patch that removes it entirely.  I also will add new,
> > >> stronger relations for use with locking, essentially making spin_lock
> > >> and spin_unlock be RCsc.
> > > 
> > > Only in the presence of smp_mb__after_unlock_lock() or
> > > smp_mb__after_spinlock(), correct?  Or am I confused about RCsc?
> > > 
> > > 							Thanx, Paul
> > > 
> > 
> > In terms of naming...is what you're asking for really RCsc?  To me,
> > that would imply that even stores in the first critical section would
> > need to be ordered before loads in the second critical section.
> > Meaning that even x86 would need an mfence in either lock() or unlock()?
> 
> I think a LOCK operation always implies an atomic RmW, which will give
> full ordering guarantees on x86. I know there have been interesting issues
> involving I/O accesses in the past, but I think that's still out of scope
> for the memory model.
> 
> Peter will know.

Agreed, x86 locked operations imply full fences, so x86 will order the
accesses in consecutive critical sections with respect to an observer
not holding the lock, even stores in earlier critical sections against
loads in later critical sections.  We have been discussing tightening
LKMM to make an unlock-lock pair order everything except earlier stores
vs. later loads.  (Of course, if everyone holds the lock, they will see
full ordering against both earlier and later critical sections.)

Or are you pushing for something stronger?

							Thanx, Paul

