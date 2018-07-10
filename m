Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AD7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82120878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 20:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A82120878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732505AbeGJUag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 16:30:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50484 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732365AbeGJUag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 16:30:36 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6AKO79r092151
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:29:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k5024jd0s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:29:44 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 10 Jul 2018 16:29:43 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Jul 2018 16:29:39 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6AKTcHI12714312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Jul 2018 20:29:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84C8DB206A;
        Tue, 10 Jul 2018 16:29:11 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 641CCB2067;
        Tue, 10 Jul 2018 16:29:11 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jul 2018 16:29:11 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 281A316C39C0; Tue, 10 Jul 2018 13:31:57 -0700 (PDT)
Date:   Tue, 10 Jul 2018 13:31:57 -0700
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
Subject: Re: [PATCH v3] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180710195853.GC3593@linux.vnet.ibm.com>
 <Pine.LNX.4.44L0.1807101621500.1449-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807101621500.1449-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071020-0040-0000-0000-0000044CC199
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009346; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01059455; UDB=6.00543741; IPR=6.00837375;
 MB=3.00022092; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-10 20:29:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071020-0041-0000-0000-00000852E566
Message-Id: <20180710203157.GF3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807100217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 04:24:34PM -0400, Alan Stern wrote:
> On Tue, 10 Jul 2018, Paul E. McKenney wrote:
> 
> > On Tue, Jul 10, 2018 at 02:18:13PM -0400, Alan Stern wrote:
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
> > It now applies, thank you very much!
> > 
> > Is this something that you are comfortable pushing into the upcoming
> > merge window, or should I hold off until the next one?
> 
> Given the concerns that Andrea raised, and given that neither Peter, 
> Will, nor Daniel has commented on v.3 of the patch, I think we should 
> hold off for a little while.

Works for me!

							Thanx, Paul

