Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D9C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675922077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675922077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbeICVBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:01:48 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:47080 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeICVBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:01:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C5D7A6067F20;
        Mon,  3 Sep 2018 18:40:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P1zU4tYbeVNc; Mon,  3 Sep 2018 18:40:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5F119603B546;
        Mon,  3 Sep 2018 18:40:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bKHdY_fYQ64K; Mon,  3 Sep 2018 18:40:52 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 06D306060979;
        Mon,  3 Sep 2018 18:40:51 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Will Deacon <will.deacon@arm.com>
Cc:     "Haibo.Xu" <haibo.xu@arm.com>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com, jdike@addtoit.com
Subject: Re: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support
Date:   Mon, 03 Sep 2018 18:40:51 +0200
Message-ID: <102400624.EOB2phcGqB@blindfold>
In-Reply-To: <20180903163103.GC6954@arm.com>
References: <20180903062310.GA4524@haibo-VirtualBox> <20180903163103.GC6954@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. September 2018, 18:31:03 CEST schrieb Will Deacon:
> On Mon, Sep 03, 2018 at 02:23:17PM +0800, Haibo.Xu wrote:
> > Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on ARM64.
> > This copies the x86 semantics for invoking ptrace hooks, and have
> > been verified on ARM64 machine.
> > 
> > Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> > Signed-off-by: Bin.Lu <bin.lu@arm.com>
> > ---
> >  arch/arm64/include/asm/thread_info.h |  5 ++++-
> >  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
> >  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
> >  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> What is PTRACE_SYSEMU and what is its semantics? Why isn't it done in the
> core ptrace code?

It is an optimization added for UserModeLinux many years ago.
PTRACE_SYSEMU basically allows you to handle system calls in user space
without the kernel seeing them.
Before that UML had to render every system call into a no-op, e.h. getpid().
This was complicated and slow.

The ptrace() manpage has a section on PTRACE_SYSEMU, more documentation on the
semantics is not available.

And yes, I think this should also done in the core. Like many other ptrace() areas
this needs a cleanup. ;-)

I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
Are you porting UML or gvisor to arm64?

Thanks,
//richard


