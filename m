Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD35720B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD35720B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732496AbeGKKYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:24:01 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60954 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbeGKKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:24:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05C43ED1;
        Wed, 11 Jul 2018 03:20:25 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C9AA43F589;
        Wed, 11 Jul 2018 03:20:24 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D21111AE3828; Wed, 11 Jul 2018 11:21:06 +0100 (BST)
Date:   Wed, 11 Jul 2018 11:21:06 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?B?6ZmI5Y2O5omN?= <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        wuzhangjin <wuzhangjin@gmail.com>,
        stable <stable@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] MIPS: implement smp_cond_load_acquire() for Loongson-3
Message-ID: <20180711102106.GG13963@arm.com>
References: <1531103198-16764-1-git-send-email-chenhc@lemote.com>
 <tencent_26F8B9E004D4512B2225FCE1@qq.com>
 <20180710121727.GK2476@hirez.programming.kicks-ass.net>
 <5471216.FKXZRxKFUI@flygoat-ry>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5471216.FKXZRxKFUI@flygoat-ry>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 06:05:51PM +0800, Jiaxun Yang wrote:
> On 2018-7-10 Tue at 20:17:27，Peter Zijlstra Wrote：
> 
> Hi Peter
> Since Huacai unable to send email via client, I'm going to reply for him 
>  
> > Sure.. we all got that far. And no, this isn't the _real_ problem. This
> > is a manifestation of the problem.
> > 
> > The problem is that your SFB is broken (per the Linux requirements). We
> > require that stores will become visible. That is, they must not
> > indefinitely (for whatever reason) stay in the store buffer.
> > 
> > > I don't think this is a hardware bug, in design, SFB will flushed to
> > > L1 cache in three cases:
> > > 
> > > 1, data in SFB is full (be a complete cache line);
> > > 2, there is a subsequent read access in the same cache line;
> > > 3, a 'sync' instruction is executed.
> > 
> > And I think this _is_ a hardware bug. You just designed the bug instead
> > of it being by accident.
> Yes, we understood that this hardware feature is not supported by LKML,
> so it should be a hardware bug for LKML.
> > 
> > It doesn't happen an _any_ other architecture except that dodgy
> > ARM11MPCore part. Linux hard relies on stores to become available
> > _eventually_.
> > 
> > Still, even with the rules above, the best work-around is still the very
> > same cpu_relax() hack.
> 
> As you say, SFB makes Loongson not fully SMP-coherent.
> However, modify cpu_relax can solve the current problem,
> but not so straight forward. On the other hand, providing a Loongson-specific 
> WRITE_ONCE looks more reasonable, because it the eliminate the "non-cohrency".
> So we can solve the bug from the root.

Curious, but why is it not straight-forward to hack cpu_relax()? If you try
to hack WRITE_ONCE, you also need to hack atomic_set, atomic64_set and all
the places that should be using WRITE_ONCE but aren't ;~)

Will
