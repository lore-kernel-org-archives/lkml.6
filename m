Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72874C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E56208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E56208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934586AbeGJQXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:23:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934544AbeGJQXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:23:44 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AGJR8k139361
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:23:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k50248t1y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 12:23:43 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 12:23:42 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 12:23:37 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AGNamq64094236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 16:23:36 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6418FB205F;
        Tue, 10 Jul 2018 12:23:10 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44DBAB2064;
        Tue, 10 Jul 2018 12:23:10 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 12:23:10 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8767716C1AF9; Tue, 10 Jul 2018 09:25:55 -0700 (PDT)
Date:   Tue, 10 Jul 2018 09:25:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180709214514.GJ3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807100954490.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807100954490.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071016-0040-0000-0000-0000044CA8CB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009345; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059373; UDB=6.00543692; IPR=6.00837293;
 MB=3.00022089; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 16:23:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071016-0041-0000-0000-00000852CC73
Message-Id: <20180710162555.GV3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 09:57:17AM -0400, Alan Stern wrote:
> On Mon, 9 Jul 2018, Paul E. McKenney wrote:
> 
> > On Mon, Jul 09, 2018 at 04:01:57PM -0400, Alan Stern wrote:
> > > More than one kernel developer has expressed the opinion that the LKMM
> > > should enforce ordering of writes by locking.  In other words, given
> > > the following code:
> > > 
> > > 	WRITE_ONCE(x, 1);
> > > 	spin_unlock(&s):
> > > 	spin_lock(&s);
> > > 	WRITE_ONCE(y, 1);
> > > 
> > > the stores to x and y should be propagated in order to all other CPUs,
> > > even though those other CPUs might not access the lock s.  In terms of
> > > the memory model, this means expanding the cumul-fence relation.
> > > 
> > > Locks should also provide read-read (and read-write) ordering in a
> > > similar way.  Given:
> > > 
> > > 	READ_ONCE(x);
> > > 	spin_unlock(&s);
> > > 	spin_lock(&s);
> > > 	READ_ONCE(y);		// or WRITE_ONCE(y, 1);
> > > 
> > > the load of x should be executed before the load of (or store to) y.
> > > The LKMM already provides this ordering, but it provides it even in
> > > the case where the two accesses are separated by a release/acquire
> > > pair of fences rather than unlock/lock.  This would prevent
> > > architectures from using weakly ordered implementations of release and
> > > acquire, which seems like an unnecessary restriction.  The patch
> > > therefore removes the ordering requirement from the LKMM for that
> > > case.
> > > 
> > > All the architectures supported by the Linux kernel (including RISC-V)
> > > do provide this ordering for locks, albeit for varying reasons.
> > > Therefore this patch changes the model in accordance with the
> > > developers' wishes.
> > > 
> > > Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Nice!
> > 
> > However, it doesn't apply against current -rcu.  Am I missing a patch?
> > Or is this supposed to apply against origin/lkmm?
> 
> I wrote it based on 4.18-rc.  However, I can rebase it against your
> current dev branch.

Could you please?  Against either the dev or lkmm branch should well.

If you don't have time for this, my approach would be to apply against
4.18-rc, then cherry-pick onto my branch, resolving the conflicts and
emailing you both the "<<<<"-marked file and my proposed resolution.
(Or git might just resolve everything automatically -- that does
sometimes happen.  But it would still be good to double-check its work,
as it sometimes does "interesting" resolutions.)

							Thanx, Paul

