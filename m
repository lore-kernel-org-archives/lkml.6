Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346E9C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6B5123E65
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6B5123E65
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeFVHsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:48:46 -0400
Received: from foss.arm.com ([217.140.101.70]:59116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750934AbeFVHsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:48:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FE0A1435;
        Fri, 22 Jun 2018 00:48:44 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EA703F557;
        Fri, 22 Jun 2018 00:48:44 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id CFD431AE2E48; Fri, 22 Jun 2018 08:49:20 +0100 (BST)
Date:   Fri, 22 Jun 2018 08:49:20 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] locking/qspinlock: Fix build for anonymous union in
 older gcc compilers
Message-ID: <20180622074920.GA7601@arm.com>
References: <20180621203526.172ab5c4@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621203526.172ab5c4@vmware.local.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, Jun 21, 2018 at 08:35:26PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> One of my tests compiles the kernel with gcc 4.5.3, and I hit the
> following build error:
> 
> /work/git/linux-trace.git/include/linux/semaphore.h: In function 'sema_init':
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: error: unknown field 'val' specified in initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: missing braces around initializer
> /work/git/linux-trace.git/include/linux/semaphore.h:35:17: warning: (near initialization for '(anonymous).raw_lock.<anonymous>.val')
> In file included from /work/git/linux-trace.git/include/linux/sched/user.h:7:0,
>                  from /work/git/linux-trace.git/include/linux/cred.h:22,
>                  from /work/git/linux-trace.git/include/linux/seq_file.h:12,
>                  from /work/git/linux-trace.git/include/linux/cgroup.h:18,
>                  from /work/git/linux-trace.git/include/linux/memcontrol.h:22,
>                  from /work/git/linux-trace.git/include/linux/swap.h:9,
>                  from /work/git/linux-trace.git/include/linux/suspend.h:5,
>                  from /work/git/linux-trace.git/arch/x86/kernel/asm-offsets.c:13:
> 
> 
> I bisected it down to the introduction of the commit that makes
> qspinlock have an anonymous union, which makes initializing it special
> for older compilers. By adding strategic brackets, it makes the build
> happy again.
> 
> Fixes: 625e88be1f41 ("locking/qspinlock: Merge 'struct __qspinlock' into 'struct qspinlock'")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---

Cheers for spotting this and fixing it up! I know it's already in -tip, but
anyway:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
