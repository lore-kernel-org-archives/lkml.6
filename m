Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2299C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB882087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AB882087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbeILBEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:04:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726786AbeILBE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:04:29 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8BJxhsR092542
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:03:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2mejpsc3g6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 16:03:36 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Sep 2018 16:03:34 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Sep 2018 16:03:28 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8BK3SLw27066496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Sep 2018 20:03:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22399B2064;
        Tue, 11 Sep 2018 16:02:07 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4225B2066;
        Tue, 11 Sep 2018 16:02:06 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Sep 2018 16:02:06 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2026B16C1C01; Tue, 11 Sep 2018 13:03:28 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:03:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Daniel Lustig <dlustig@nvidia.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, mingo@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>, akiyks@gmail.com,
        Palmer Dabbelt <palmer@sifive.com>
Subject: Re: [PATCH RFC LKMM 1/7] tools/memory-model: Add extra ordering for
 locks and remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180908095848.GA6272@andrea>
 <Pine.LNX.4.44L0.1809111455420.1461-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.1809111455420.1461-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18091120-0064-0000-0000-0000034B6332
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009704; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01086898; UDB=6.00561204; IPR=6.00866910;
 MB=3.00023236; MTD=3.00000008; XFM=3.00000015; UTC=2018-09-11 20:03:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18091120-0065-0000-0000-00003A9BDAC5
Message-Id: <20180911200328.GA4225@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-11_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809110196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 03:31:53PM -0400, Alan Stern wrote:
> On Thu, 12 Jul 2018, Paul E. McKenney wrote:
> 
> > > > Take for instance the pattern where RCU relies on RCsc locks, this is an
> > > > entirely simple and straight forward use of locks, yet completely fails
> > > > on this subtle point.
> > > 
> > > Do you happen to remember exactly where in the kernel source this 
> > > occurs?
> > 
> > Look for the uses of raw_spin_lock_irq_rcu_node() and friends in
> > kernel/rcu and include/linux/*rcu*, along with the explanation in
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.html
> 
> I just now started looking at this for the first time, and I was struck
> by the sloppy thinking displayed in the very first paragraph of the
> HTML document!  For example, consider the third sentence:
> 
> 	Similarly, any code that happens before the beginning of a 
> 	given RCU grace period is guaranteed to see the effects of all
> 	accesses following the end of that grace period that are within
> 	RCU read-side critical sections.
> 
> Is RCU now a time machine?  :-)

Why not?  ;-)

> I think what you meant to write in the second and third sentences was 
> something more like this:
> 
> 	Any code in an RCU critical section that extends beyond the 
> 	end of a given RCU grace period is guaranteed to see the 
> 	effects of all accesses which were visible to the grace 
> 	period's CPU before the start of the grace period.  Similarly, 
> 	any code that follows an RCU grace period (on the grace 
> 	period's CPU) is guaranteed to see the effects of all accesses 
> 	which were visible to an RCU critical section that began
> 	before the start of the grace period.

That looks to me to be an improvement, other than that the "(on the
grace period's CPU)" seems a bit restrictive -- you could for example
have a release-acquire chain starting after the grace period, right?

> Also, the document doesn't seem to explain how Tree RCU relies on the
> lock-ordering guarantees of raw_spin_lock_rcu_node() and friends.  It
> _says_ that these guarantees are used, but not how or where.  (Unless I 
> missed something; I didn't read the document all that carefully.)

The closest is this sentence: "But the only part of rcu_prepare_for_idle()
that really matters for this discussion are lines 37–39", which
refers to this code:

37     raw_spin_lock_rcu_node(rnp);
38     needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
39     raw_spin_unlock_rcu_node(rnp);

I could add a sentence explaining the importance of the
smp_mb__after_unlock_lock() -- is that what you are getting at?

> In any case, you should bear in mind that the lock ordering provided by
> Peter's raw_spin_lock_rcu_node() and friends is not the same as what we
> have been discussing for the LKMM:
> 
> 	Peter's routines are meant for the case where you release
> 	one lock and then acquire another (for example, locks in 
> 	two different levels of the RCU tree).
> 
> 	The LKMM patch applies only to cases where one CPU releases
> 	a lock and then that CPU or another acquires the _same_ lock 
> 	again.
> 
> As another difference, the litmus test given near the start of the
> "Tree RCU Grace Period Memory Ordering Building Blocks" section would
> not be forbidden by the LKMM, even with RCtso locks, if it didn't use
> raw_spin_lock_rcu_node().  This is because the litmus test is forbidden
> only when locks are RCsc, which is what raw_spin_lock_rcu_node()  
> provides.

Agreed.

> So I don't see how the RCU code can be held up as an example either for
> or against requiring locks to be RCtso.

Agreed again.  The use of smp_mb__after_unlock_lock() instead
provides RCsc.  But this use case is deemed sufficiently rare that
smp_mb__after_unlock_lock() is defined within RCU.

							Thanx, Paul

