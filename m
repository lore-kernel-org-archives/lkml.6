Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C76C67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A29216FC
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 21:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A29216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeJUFSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 01:18:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726630AbeJUFSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 01:18:38 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9KL3pvZ019305
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 17:06:52 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7xh4p4q1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 20 Oct 2018 17:06:52 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 20 Oct 2018 17:06:51 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 20 Oct 2018 17:06:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9KL6kKN41025724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Oct 2018 21:06:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69FF0B2067;
        Sat, 20 Oct 2018 21:06:46 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47B66B205F;
        Sat, 20 Oct 2018 21:06:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.122])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 20 Oct 2018 21:06:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D161E16C087A; Sat, 20 Oct 2018 14:06:46 -0700 (PDT)
Date:   Sat, 20 Oct 2018 14:06:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        davidtgoldblatt@gmail.com, stern@rowland.harvard.edu,
        will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com
Subject: Re: Interrupts, smp_load_acquire(), smp_store_release(), etc.
Reply-To: paulmck@linux.ibm.com
References: <20181020161049.GA13756@linux.ibm.com>
 <20181020202229.GA10526@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181020202229.GA10526@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18102021-0040-0000-0000-00000483EBB1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009909; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01105575; UDB=6.00572437; IPR=6.00885626;
 MB=3.00023841; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-20 21:06:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102021-0041-0000-0000-0000088C042A
Message-Id: <20181020210646.GC2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-20_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=931 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810200196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 10:22:29PM +0200, Andrea Parri wrote:
> [...]
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
> FWIW, I'd rather call "paranoid" the act of excluding such outcome ;-)
> but I admit that I've only run this test in *my mind*: in an SC world,
> 
>   CPU1				CPU2
> 
>   t1()
>     t1_interrupt()
>       r0 = READ_ONCE(y); // =0
> 				t2()
> 				  r1 = smp_load_acquire(&x); // =0
>       smp_store_release(&x, 1);
>     smp_store_release(&y, 1);
> 				  r2 = smp_load_acquire(&y); // =1

OK, so did I get the outcome messed up again?  :-/

							Thanx, Paul

> > So how paranoid should we be with respect to interrupt handlers for
> > smp_store_release(), smp_load_acquire(), and the various RMW atomic
> > operations that are sometimes implemented with separate memory-barrier
> > instructions?  ;-)
> 
> Good question! ;-)
> 
>   Andrea
> 
> 
> > 
> > 							Thanx, Paul
> > 
> 

