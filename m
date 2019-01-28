Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98373C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1882171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfA1V0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:26:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726878AbfA1V0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:26:44 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SLOcpp042453
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:26:43 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2qa9gkgf23-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 16:26:43 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 21:26:42 -0000
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 21:26:35 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SLQYeY24445024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 21:26:34 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E910B2068;
        Mon, 28 Jan 2019 21:26:34 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1C49B2064;
        Mon, 28 Jan 2019 21:26:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 21:26:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id F0B0F16C62B9; Mon, 28 Jan 2019 13:26:33 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:26:33 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        maged michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] Fix: membarrier: racy access to p->mm in
 membarrier_global_expedited()
Reply-To: paulmck@linux.ibm.com
References: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com>
 <20190128204611.GB4240@linux.ibm.com>
 <231707440.2765.1548709646123.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231707440.2765.1548709646123.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012821-0068-0000-0000-0000038A3C90
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010495; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153149; UDB=6.00601174; IPR=6.00933511;
 MB=3.00025329; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 21:26:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012821-0069-0000-0000-0000474D57EA
Message-Id: <20190128212633.GC4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 04:07:26PM -0500, Mathieu Desnoyers wrote:
> ----- On Jan 28, 2019, at 3:46 PM, paulmck paulmck@linux.ibm.com wrote:
> 
> > On Mon, Jan 28, 2019 at 12:27:03PM -0800, Linus Torvalds wrote:
> >> On Mon, Jan 28, 2019 at 10:27 AM Mathieu Desnoyers
> >> <mathieu.desnoyers@efficios.com> wrote:
> >> >
> >> > Jann Horn identified a racy access to p->mm in the global expedited
> >> > command of the membarrier system call.
> >> >
> >> > The suggested fix is to hold the task_lock() around the accesses to
> >> > p->mm and to the mm_struct membarrier_state field to guarantee the
> >> > existence of the mm_struct.
> >> 
> >> Hmm. I think this is right. You shouldn't access another threads mm
> >> pointer without proper locking.
> >> 
> >> That said, we *could* make the mm_cachep be SLAB_TYPESAFE_BY_RCU,
> >> which would allow speculatively reading data off the mm pointer under
> >> RCU. It might not be the *right* mm if somebody just did an exit, but
> >> for things like this it shouldn't matter.
> > 
> > That sounds much simpler and more effective than the contention-reduction
> > approach that I suggested.  ;-)
> 
> I'd be tempted to stick to the locking approach for a fix, and implement
> Linus' type-safe mm_cachep idea if anyone complains about the overhead
> of membarrier GLOBAL_EXPEDITED (and submit for a future merge window).
> 
> I tested the KASAN splat reproducer from Jann locally, and confirmed that
> my patch fixes the issue it reproduces.
> 
> Please let me know if the task_lock() approach is OK as a fix for now.

Agreed, no need for added complexity until there is a clear need.

> I'm also awaiting a Tested-by from Jann before submitting this for real.

Makes sense to me!

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> > 
> >							Thanx, Paul
> > 
> >> But if this is the only case that might care, it sounds like just
> >> doing the proper locking is the right approach.
> >> 
> >>            Linus
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

