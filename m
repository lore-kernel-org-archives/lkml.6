Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42312ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0820206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0820206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbeGQTFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:05:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726424AbeGQTFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:05:18 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6HINdt8118857
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:31:24 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k9k2wpn56-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:31:24 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 17 Jul 2018 14:31:23 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 17 Jul 2018 14:31:18 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6HIVIi65046530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Jul 2018 18:31:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42B77B2065;
        Tue, 17 Jul 2018 14:31:09 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 231D1B2064;
        Tue, 17 Jul 2018 14:31:09 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jul 2018 14:31:09 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EEE9216C86BA; Tue, 17 Jul 2018 11:33:41 -0700 (PDT)
Date:   Tue, 17 Jul 2018 11:33:41 -0700
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
References: <20180712172838.GU3593@linux.vnet.ibm.com>
 <20180712180511.GP2476@hirez.programming.kicks-ass.net>
 <CA+55aFxwez8zSa2f2GpcaAkFX27Vt-s0nWdd0mZ6yGM8ipCR0A@mail.gmail.com>
 <20180713110851.GY2494@hirez.programming.kicks-ass.net>
 <87tvp3xonl.fsf@concordia.ellerman.id.au>
 <20180713164239.GZ2494@hirez.programming.kicks-ass.net>
 <87601fz1kc.fsf@concordia.ellerman.id.au>
 <CA+55aFzjcKv40hT_aD4jsdERi+a1pLU2SWPTwvyT2PDnoOmSpQ@mail.gmail.com>
 <87va9dyl8y.fsf@concordia.ellerman.id.au>
 <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFyFLzH71Tke858x0cjCiRO48vc1W9oVmVkO43rtjezqOg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18071718-0060-0000-0000-0000028D9596
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009381; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01062205; UDB=6.00545353; IPR=6.00840062;
 MB=3.00022173; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-17 18:31:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18071718-0061-0000-0000-000045D516DC
Message-Id: <20180717183341.GQ12945@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-17_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=643 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807170192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 09:19:15AM -0700, Linus Torvalds wrote:
> On Tue, Jul 17, 2018 at 7:45 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> >
> > Interesting. I don't see anything as high as 18%, it's more spread out:
> >
> >      7.81%  context_switch  [kernel.kallsyms]  [k] cgroup_rstat_updated
> 
> Oh, see that's the difference.
> 
> You're running in a non-root cgroup, I think.
> 
> That also means that your scheduler overhead has way more spinlocks,
> and in particular, you have that
> 
>         raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
>         ..
>         raw_spin_lock_irqsave(cpu_lock, flags);
> 
> there too.
> 
> So you have at least twice the spinlocks that my case had, and yes,
> the costs are way more spread out because your case has all that
> cgroup accounting too.
> 
> That said, I don't understand the powerpc memory ordering. I thought
> the rules were "isync on lock, lwsync on unlock".
> 
> That's what the AIX docs imply, at least.
> 
> In particular, I find:
> 
>   "isync is not a memory barrier instruction, but the
> load-compare-conditional branch-isync sequence can provide this
> ordering property"
> 
> so why are you doing "sync/lwsync", when it sounds like "isync/lwsync"
> (for lock/unlock) is the right thing and would already give memory
> barrier semantics?

The PowerPC guys will correct me if I miss something here...

The isync provides ordering roughly similar to lwsync, but nowhere near
as strong as sync, and it is sync that would be needed to cause lock
acquisition to provide full ordering.  The reason for using lwsync instead
of isync is that the former proved to be faster on recent hardware.
The reason that the kernel still has the ability to instead generate
isync instructions is that some older PowerPC hardware does not provide
the lwsync instruction.  If the hardware does support lwsync, the isync
instructions are overwritten with lwsync at boot time.

							Thanx, Paul

