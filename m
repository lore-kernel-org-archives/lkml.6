Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F00BC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8158216C4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8158216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeJUFQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 01:16:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726162AbeJUFQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 01:16:04 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KL3smI006615
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 17:04:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2n80f12hx5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 17:04:18 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 17:04:17 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Oct 2018 17:04:14 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9KL4Dks32833762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Oct 2018 21:04:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 222A6B205F;
        Sat, 20 Oct 2018 21:04:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09E6FB2070;
        Sat, 20 Oct 2018 21:04:13 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.122])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 20 Oct 2018 21:04:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8ED2416C3598; Sat, 20 Oct 2018 14:04:13 -0700 (PDT)
Date:   Sat, 20 Oct 2018 14:04:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        davidtgoldblatt@gmail.com, andrea.parri@amarulasolutions.com,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
References: <20181020161049.GA13756@linux.ibm.com>
 <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1810201612530.28059-100000@netrider.rowland.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102021-2213-0000-0000-00000306F18E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009909; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105575; UDB=6.00572436; IPR=6.00885625;
 MB=3.00023841; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-20 21:04:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102021-2214-0000-0000-00005BF7403B
Message-Id: <20181020210413.GB2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=647 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810200196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 04:18:37PM -0400, Alan Stern wrote:
> On Sat, 20 Oct 2018, Paul E. McKenney wrote:
> 
> > The second (informal) litmus test has a more interesting Linux-kernel
> > counterpart:
> > 
> > 	void t1_interrupt(void)
> > 	{
> > 		r0 = READ_ONCE(y);
> > 		smp_store_release(&x, 1);
> > 	}
> > 
> > 	void t1(void)
> > 	{
> > 		smp_store_release(&y, 1);
> > 	}
> > 
> > 	void t2(void)
> > 	{
> > 		r1 = smp_load_acquire(&x);
> > 		r2 = smp_load_acquire(&y);
> > 	}
> > 
> > On store-reordering architectures that implement smp_store_release()
> > as a memory-barrier instruction followed by a store, the interrupt could
> > arrive betweentimes in t1(), so that there would be no ordering between
> > t1_interrupt()'s store to x and t1()'s store to y.  This could (again,
> > in paranoid theory) result in the outcome r0==0 && r1==0 && r2==1.
> 
> This is disconcerting only if we assume that t1_interrupt() has to be
> executed by the same CPU as t1().  If the interrupt could be fielded by
> a different CPU then the paranoid outcome is perfectly understandable,
> even in an SC context.
> 
> So the question really should be limited to situations where a handler 
> is forced to execute in the context of a particular thread.  While 
> POSIX does allow such restrictions for user programs, I'm not aware of 
> any similar mechanism in the kernel.

Good point, and I was in fact assuming that t1() and t1_interrupt()
were executing on the same CPU.

This sort of thing happens naturally in the kernel when both t1()
and t1_interrupt() are accessing per-CPU variables.

							Thanx, Paul

