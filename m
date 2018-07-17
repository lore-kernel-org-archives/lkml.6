Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD6EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEE020693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 19:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEE020693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730245AbeGQUKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:10:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729730AbeGQUKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:10:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HJYYI6109577
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:36:09 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9k3xh764-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:36:09 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 15:36:07 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 15:36:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HJa1rg66125998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 19:36:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E946B205F;
        Tue, 17 Jul 2018 15:35:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D025B2065;
        Tue, 17 Jul 2018 15:35:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 15:35:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0083616CA211; Tue, 17 Jul 2018 12:38:25 -0700 (PDT)
Date:   Tue, 17 Jul 2018 12:38:25 -0700
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
References: <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au>
 <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
 <20180717183341.GQ12945@linux.vnet.ibm.com>
 <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwA=TmJJkKvskX3wL9Rs1j8xZJDJVghv=G0spYufK9kYg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071719-0040-0000-0000-0000045031A4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009381; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062226; UDB=6.00545366; IPR=6.00840084;
 MB=3.00022174; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 19:36:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071719-0041-0000-0000-000008565C5C
Message-Id: <20180717193825.GS12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170203
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 11:44:23AM -0700, Linus Torvalds wrote:
> On Tue, Jul 17, 2018 at 11:31 AM Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> >
> > The isync provides ordering roughly similar to lwsync, but nowhere near
> > as strong as sync, and it is sync that would be needed to cause lock
> > acquisition to provide full ordering.
> 
> That's only true when looking at isync in isolation.
> 
> Read the part I quoted. The AIX documentation implies that the
> *sequence* of load-compare-conditional branch-isync is a memory
> barrier, even if isync on its own is now.

You are referring to this URL, correct?

https://www.ibm.com/developerworks/systems/articles/powerpc.html

If so, the "this ordering property" refers to the ordering needed to
ensure that the later accesses happen after the "load global flag",
and lwsync suffices for that.  (As does the branch-isync, as you say.)
The sync instruction provides much stronger ordering due to the fact
that sync flushes the store buffer and waits for acknowledgments from all
other CPUs (or, more accurately makes it appear as if it had done so --
speculative execution can be and is used to hide some of the latency).

In contrast, isync (with or without the load and branch) does not
flush the store buffer nor does it cause any particular communication
with the other CPUs.  The ordering that isync provides is therefore
quite a bit weaker than that of the sync instruction.

> So I'm just saying that
> 
>  (a) isync-on-lock is supposed to be much cheaper than sync-on-lock

Completely agreed.

>  (b) the AIX documentation at least implies that isync-on-lock (when
> used together the the whole locking sequence) is actually a memory
> barrier

Agreed, but the ordering properties that it provides are similar to
those of the weaker lwsync memory-barrier instruction, and nowhere near
as strong of those of the sync memory-barrier instruction.

> Now, admittedly the powerpc barrier instructions are unfathomable
> crazy stuff, so who knows. But:
> 
>  (a) lwsync is a memory barrier for all the "easy" cases (ie
> load->store, load->load, and store->load).

Yes.

>  (b) lwsync is *not* a memory barrier for the store->load case.

Agreed.

>  (c) isync *is* (when in that *sequence*) a memory barrier for a
> store->load case (and has to be: loads inside a spinlocked region MUST
> NOT be done earlier than stores outside of it!).

Yes, isync will wait for the prior stores to -execute-, but it doesn't
necessarily wait for the corresponding entries to leave the store buffer.
And this suffices to provide ordering from the viewpoint of some other
CPU holding the lock.

> So a unlock/lock sequence where the unlock is using lwsync, and the
> lock is using isync, should in fact be a full memory barrier (which is
> the semantics we're looking for).
> 
> So doing performance testing on sync/lwsync (for lock/unlock
> respectively) seems the wrong thing to do.  Please test the
> isync/lwsync case instead.
> 
> Hmm? What am I missing?

That the load-branch-isync has ordering properties similar to the lwsync
memory-barrier instruction, not to the sync memory-barrier instruction.
This means that the isync/lwsync case simply won't provide full ordering
from the viewpoint of CPUs not holding the lock.  (As with lwsync,
CPUs holding the lock do see full ordering, as is absolutely required.)

You absolutely must use sync/lwsync or lwsync/sync to get the strong
order that is visible to other CPUs not holding the lock.

The PowerPC hardware verification tools agree, as shown below.

							Thanx, Paul

------------------------------------------------------------------------

The PPCMEM tools (which the Power hardware guys helped to develop) agrees.
For the following litmus test, in which P0 does the lwsync-unlock and
isync-lock, and for which P1 checks the ordering, but without acquiring
the lock, PPCMEM says "no ordering".

------------------------------------------------------------------------

PPC lock-1thread-WR-barrier.litmus
""
{
l=1;
0:r1=1; 0:r3=42; 0:r4=x; 0:r5=y; 0:r10=0; 0:r11=0; 0:r12=l;
1:r1=1;          1:r4=x; 1:r5=y;
}
 P0                | P1           ;
 stw r1,0(r4)      | stw r1,0(r5) ;
 lwsync            | sync         ;
 stw r10,0(r12)    | lwz r7,0(r4) ;
 lwarx r11,r10,r12 |              ;
 cmpwi r11,0       |              ;
 bne Fail1         |              ;
 stwcx. r1,r10,r12 |              ;
 bne Fail1         |              ;
 isync             |              ;
 lwz r3,0(r5)      |              ;
 Fail1:            |              ;


exists
(0:r3=0 /\ 1:r7=0)

------------------------------------------------------------------------

Here is the output of running the tool locally:

------------------------------------------------------------------------

0:r3=0; 1:r7=0;
0:r3=0; 1:r7=1;
0:r3=1; 1:r7=0;
0:r3=1; 1:r7=1;
0:r3=42; 1:r7=0;
0:r3=42; 1:r7=1;
Ok
Condition exists (0:r3=0 /\ 1:r7=0)
Hash=16c3d58e658f6c16bc3df7d6233d8bf8
Observation SB+lock+sync-Linus Sometimes 1 5

------------------------------------------------------------------------

And you can see the "0:r3=0; 1:r7=0;" state, which indicates that neither
process's loads saw the other process's stores, which in turn indicates
no ordering.

That said, if P1 actually acquired the lock, there would be ordering.

Or you can get the same result manually using this web site:

https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html

