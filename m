Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90E8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8852086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8852086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbeK1EQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:16:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbeK1EQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:16:28 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARHDk9A002799
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:17:52 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2p18h6n0ea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:17:52 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 27 Nov 2018 17:17:51 -0000
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 17:17:47 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARHHl1d19071230
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 17:17:47 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00E7CB2067;
        Tue, 27 Nov 2018 17:17:47 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D63AEB2066;
        Tue, 27 Nov 2018 17:17:46 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.38])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 17:17:46 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A315F16C33D9; Tue, 27 Nov 2018 09:17:46 -0800 (PST)
Date:   Tue, 27 Nov 2018 09:17:46 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tools/memory-model: Add SRCU support
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1811151101310.1308-100000@iolanthe.rowland.org>
 <20181119120120.GA5092@andrea>
 <20181126223509.GM4170@linux.ibm.com>
 <20181127002642.GA4087@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127002642.GA4087@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18112717-2213-0000-0000-0000032040A9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010131; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123582; UDB=6.00583290; IPR=6.00903712;
 MB=3.00024356; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 17:17:51
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112717-2214-0000-0000-00005C675643
Message-Id: <20181127171746.GP4170@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 01:26:42AM +0100, Andrea Parri wrote:
> > commit 72f61917f12236514a70017d1ebafb9b8d34a9b6
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Mon Nov 26 14:26:43 2018 -0800
> > 
> >     tools/memory-model: Update README for addition of SRCU
> >     
> >     This commit updates the section on LKMM limitations to no longer say
> >     that SRCU is not modeled, but instead describe how LKMM's modeling of
> >     SRCU departs from the Linux-kernel implementation.
> >     
> >     TL;DR:  There is no known valid use case that cares about the Linux
> >     kernel's ability to have partially overlapping SRCU read-side critical
> >     sections.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
> 
> Indeed!,
> 
> Acked-by: Andrea Parri <andrea.parri@amarulasolutions.com>

Thank you, applied!

I moved this commit and Alan's three SRCU commits to the branch destined
for the upcoming merge window.

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > diff --git a/tools/memory-model/README b/tools/memory-model/README
> > index 0f2c366518c6..9d7d4f23503f 100644
> > --- a/tools/memory-model/README
> > +++ b/tools/memory-model/README
> > @@ -221,8 +221,29 @@ The Linux-kernel memory model has the following limitations:
> >  		additional call_rcu() process to the site of the
> >  		emulated rcu-barrier().
> >  
> > -	e.	Sleepable RCU (SRCU) is not modeled.  It can be
> > -		emulated, but perhaps not simply.
> > +	e.	Although sleepable RCU (SRCU) is now modeled, there
> > +		are some subtle differences between its semantics and
> > +		those in the Linux kernel.  For example, the kernel
> > +		might interpret the following sequence as two partially
> > +		overlapping SRCU read-side critical sections:
> > +
> > +			 1  r1 = srcu_read_lock(&my_srcu);
> > +			 2  do_something_1();
> > +			 3  r2 = srcu_read_lock(&my_srcu);
> > +			 4  do_something_2();
> > +			 5  srcu_read_unlock(&my_srcu, r1);
> > +			 6  do_something_3();
> > +			 7  srcu_read_unlock(&my_srcu, r2);
> > +
> > +		In contrast, LKMM will interpret this as a nested pair of
> > +		SRCU read-side critical sections, with the outer critical
> > +		section spanning lines 1-7 and the inner critical section
> > +		spanning lines 3-5.
> > +
> > +		This difference would be more of a concern had anyone
> > +		identified a reasonable use case for partially overlapping
> > +		SRCU read-side critical sections.  For more information,
> > +		please see: https://paulmck.livejournal.com/40593.html
> >  
> >  	f.	Reader-writer locking is not modeled.  It can be
> >  		emulated in litmus tests using atomic read-modify-write
> > 
> 

