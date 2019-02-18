Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A348C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BAE20851
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731221AbfBRO6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:58:36 -0500
Received: from foss.arm.com ([217.140.101.70]:32874 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfBRO6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:58:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B193A78;
        Mon, 18 Feb 2019 06:58:30 -0800 (PST)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1D53F675;
        Mon, 18 Feb 2019 06:58:25 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:58:20 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Message-ID: <20190218145820.GA16091@fuggles.cambridge.arm.com>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
 <20190214103715.GI32494@hirez.programming.kicks-ass.net>
 <20190215184056.GC15084@fuggles.cambridge.arm.com>
 <a45d8b68-5623-d6fe-8080-072994f7625e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45d8b68-5623-d6fe-8080-072994f7625e@redhat.com>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 01:58:34PM -0500, Waiman Long wrote:
> On 02/15/2019 01:40 PM, Will Deacon wrote:
> > On Thu, Feb 14, 2019 at 11:37:15AM +0100, Peter Zijlstra wrote:
> >> On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> >>> v4:
> >>>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> >>>
> >>> v3:
> >>>  - Optimize __down_read_trylock() for the uncontended case as suggested
> >>>    by Linus.
> >>>
> >>> v2:
> >>>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
> >>>  - Update performance test data in patch 1.
> >>>
> >>> The goal of this patchset is to remove the architecture specific files
> >>> for rwsem-xadd to make it easer to add enhancements in the later rwsem
> >>> patches. It also removes the legacy rwsem-spinlock.c file and make all
> >>> the architectures use one single implementation of rwsem - rwsem-xadd.c.
> >>>
> >>> Waiman Long (3):
> >>>   locking/rwsem: Remove arch specific rwsem files
> >>>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
> >>>     archs
> >>>   locking/rwsem: Optimize down_read_trylock()
> >> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >>
> >> with the caveat that I'm happy to exchange patch 3 back to my earlier
> >> suggestion in case Will expesses concerns wrt the ARM64 performance of
> >> Linus' suggestion.
> > Right, the current proposal doesn't work well for us, unfortunately. Which
> > was your earlier suggestion?
> >
> > Will
> 
> In my posting yesterday, I showed that most of the trylocks done were
> actually uncontended. Assuming that pattern hold for the most of the
> workloads, it will not that bad after all.

That's fair enough; if you're going to sit in a tight trylock() loop like the
benchmark does, then you're much better off just calling lock() if you care
at all about scalability.

Will
