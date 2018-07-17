Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D939FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E8320673
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E8320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730203AbeGQUOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:14:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729743AbeGQUOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:14:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HJcxsh046180
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:40:39 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9pg08rk6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:40:39 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 15:40:38 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 15:40:34 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HJeXnY5898860
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 19:40:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF0B1B2064;
        Tue, 17 Jul 2018 15:40:24 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEFC2B205F;
        Tue, 17 Jul 2018 15:40:24 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 15:40:24 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BB0E316C86E1; Tue, 17 Jul 2018 12:42:57 -0700 (PDT)
Date:   Tue, 17 Jul 2018 12:42:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nick Piggin <npiggin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/memory-model: Add extra ordering for locks and
 remove it for ordinary release/acquire
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au>
 <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com>
 <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
 <CA+55aFwTN_qZkpi2pLu3vFqSPA43V049j_Ag=NTiKMz1FhYvhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwTN_qZkpi2pLu3vFqSPA43V049j_Ag=NTiKMz1FhYvhg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071719-2213-0000-0000-000002CC377C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009381; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062228; UDB=6.00545367; IPR=6.00840085;
 MB=3.00022174; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 19:40:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071719-2214-0000-0000-00005ADF4A7F
Message-Id: <20180717194257.GU12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=983 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:49:41AM -0700, Linus Torvalds wrote:
> On Tue, Jul 17, 2018 at 11:44 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >  (a) lwsync is a memory barrier for all the "easy" cases (ie
> > load->store, load->load, and store->load).
> 
> That last one should have been "store->store", of course.

Heh!  I autocorrected without noticing.

> So 'lwsync' gives smp_rmb(), smp_wmb(), and smp_load_acquire()
> semantics (which are the usual "no barrier needed at all" suspects for
> things like x86).

Yes.

> What lwsync lacks is store->load ordering. So:
> 
> >  (b) lwsync is *not* a memory barrier for the store->load case.
> 
> BUT, this is where isync comes in:
> 
> >  (c) isync *is* (when in that *sequence*) a memory barrier for a
> > store->load case (and has to be: loads inside a spinlocked region MUST
> > NOT be done earlier than stores outside of it!).
> 
> which is why I think that a spinlock implementation that uses isync
> would give us the semantics we want, without the use of the crazy
> expensive 'sync' that Michael tested (and which apparently gets
> horrible 10% scheduler performance regressions at least on some
> powerpc CPU's).

Again, although isync orders the store -instruction- -execution- against
later loads, it does nothing to flush the store buffer.  So the prior
stores will not necessarily appear to be ordered from the viewpoint of
other CPUs not holding the lock.

Again, if those other CPUs are holding the lock, they see all memory
accesses from all prior critical sections for that lock, as required.

							Thanx, Paul

