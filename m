Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E924CC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3FE214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 20:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfA1UqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 15:46:24 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbfA1UqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 15:46:23 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0SKhql5138492
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:46:22 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qa7ydk4gn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 15:46:22 -0500
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 28 Jan 2019 20:46:20 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 28 Jan 2019 20:46:13 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0SKkBPq24576028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 20:46:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB299B205F;
        Mon, 28 Jan 2019 20:46:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9921CB206E;
        Mon, 28 Jan 2019 20:46:11 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.57])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 28 Jan 2019 20:46:11 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9FCD816C62B9; Mon, 28 Jan 2019 12:46:11 -0800 (PST)
Date:   Mon, 28 Jan 2019 12:46:11 -0800
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrea Parri <parri.andrea@gmail.com>,
        Andrew Hunter <ahh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Avi Kivity <avi@scylladb.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, David Sehr <sehr@google.com>,
        Greg Hackmann <ghackmann@google.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Maged Michael <maged.michael@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Subject: Re: [RFC PATCH] Fix: membarrier: racy access to p->mm in
 membarrier_global_expedited()
Reply-To: paulmck@linux.ibm.com
References: <20190128182636.18420-1-mathieu.desnoyers@efficios.com>
 <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjmpfXak0pQVu8dZrk2Oma3OxtEoBHfwCAruu0xpSMN4A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19012820-0052-0000-0000-0000037F8D57
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010494; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000277; SDB=6.01153136; UDB=6.00601166; IPR=6.00933498;
 MB=3.00025328; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-28 20:46:18
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012820-0053-0000-0000-00005FA2856E
Message-Id: <20190128204611.GB4240@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-28_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901280153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 12:27:03PM -0800, Linus Torvalds wrote:
> On Mon, Jan 28, 2019 at 10:27 AM Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
> >
> > Jann Horn identified a racy access to p->mm in the global expedited
> > command of the membarrier system call.
> >
> > The suggested fix is to hold the task_lock() around the accesses to
> > p->mm and to the mm_struct membarrier_state field to guarantee the
> > existence of the mm_struct.
> 
> Hmm. I think this is right. You shouldn't access another threads mm
> pointer without proper locking.
> 
> That said, we *could* make the mm_cachep be SLAB_TYPESAFE_BY_RCU,
> which would allow speculatively reading data off the mm pointer under
> RCU. It might not be the *right* mm if somebody just did an exit, but
> for things like this it shouldn't matter.

That sounds much simpler and more effective than the contention-reduction
approach that I suggested.  ;-)

							Thanx, Paul

> But if this is the only case that might care, it sounds like just
> doing the proper locking is the right approach.
> 
>            Linus
> 

