Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AEDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A402177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 14:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfAJOuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 09:50:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727000AbfAJOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 09:50:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0AEoGLn062749
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:50:38 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2px483bqnt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:50:36 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 10 Jan 2019 14:50:34 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 10 Jan 2019 14:50:30 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0AEoT0E25428162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Jan 2019 14:50:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20423B2066;
        Thu, 10 Jan 2019 14:50:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 018D3B2065;
        Thu, 10 Jan 2019 14:50:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 10 Jan 2019 14:50:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B57D616C5F90; Thu, 10 Jan 2019 06:50:29 -0800 (PST)
Date:   Thu, 10 Jan 2019 06:50:29 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Luc Maranget <luc.maranget@inria.fr>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: seqcount usage in xt_replace_table()
Reply-To: paulmck@linux.ibm.com
References: <20190109000214.GA5907@andrea>
 <CAOMFOmUSttpLyeiRLjxw4rSN0tOiAq1jbwK=kRdCkuOKPOC3Rg@mail.gmail.com>
 <20190109112432.GA6351@andrea>
 <CACT4Y+YAr1XuwAy1qRL678VHZjzsbAQ05o1zoN9ZfC0muYzK8g@mail.gmail.com>
 <20190109121126.GA7141@andrea>
 <CACT4Y+azpzvjmUTdWj6H4qe4mELx924pGrY_VFZD9Hi+4VMj5g@mail.gmail.com>
 <20190109171053.GY1215@linux.ibm.com>
 <CACT4Y+ZZYxE5z4_wZ_Na3z6Y-RmhfrHt3y3sQzUcdUuR35Xc_g@mail.gmail.com>
 <20190110123008.GA13625@andrea>
 <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZMcQ3aF+mJws2mzbHww=ZGB9XQkPU5YUsicNS9SKwD_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19011014-2213-0000-0000-0000033A3A98
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010379; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144484; UDB=6.00595914; IPR=6.00924749;
 MB=3.00025068; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-10 14:50:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011014-2214-0000-0000-00005CEA896D
Message-Id: <20190110145029.GL1215@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-10_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901100117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 01:38:11PM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 10, 2019 at 1:30 PM Andrea Parri
> <andrea.parri@amarulasolutions.com> wrote:
> >
> > > For seqcounts we currently simply ignore all accesses within the read
> > > section (thus the requirement to dynamically track read sections).
> > > What does LKMM say about seqlocks?
> >
> > LKMM does not currently model seqlocks, if that's what you're asking;
> > c.f., tools/memory-model/linux-kernel.def for a list of the currently
> > supported synchronization primitives.
> >
> > LKMM has also no notion of "data race", it insists that the code must
> > contain no unmarked accesses; we have been discussing such extensions
> > since at least Dec'17 (we're not quite there!, as mentioned by Paul).
> 
> How does it call cases that do contain unmarked accesses then? :)
> 
> > My opinion is that ignoring all accesses within a given read section
> > _can_ lead to false negatives
> 
> Absolutely. But this is a deliberate decision.
> For our tools we consider priority 1: no false positives. Period.
> Priority 2: also report some true positives in best effort manner.
> 
> > (in every possible definition of "data
> > race" and "read sections" I can think of at the moment ;D):
> >
> >         P0                              P1
> >         read_seqbegin()                 x = 1;
> >         r0 = x;
> >         read_seqretry() // =0
> >
> > ought to be "racy"..., right?  (I didn't audit all the callsites for
> > read_{seqbegin,seqretry}(), but I wouldn't be surprised to find such
> > pattern ;D ... "legacy", as you recalled).

One approach would be to forgive data races in the seqlock read-side
critical section only if:

o	There was a later matching read_seqretry() that returned true, and

o	There were no dereferences of any data-racy load.  (Yeah, this
	one should be good clean fun to model!)

Do people nest read_seqbegin(), and if so, what does that mean?  ;-)

							Thanx, Paul

