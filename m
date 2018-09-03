Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2304120862
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2304120862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeICVSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:18:11 -0400
Received: from foss.arm.com ([217.140.101.70]:58988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727843AbeICVSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:18:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB9A18A;
        Mon,  3 Sep 2018 09:57:13 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1E5843F5BC;
        Mon,  3 Sep 2018 09:57:13 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id D3A001AE3046; Mon,  3 Sep 2018 17:57:26 +0100 (BST)
Date:   Mon, 3 Sep 2018 17:57:26 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     "Haibo.Xu" <haibo.xu@arm.com>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        nd@arm.com, jdike@addtoit.com
Subject: Re: [PATCH] arm64/ptrace: add PTRACE_SYSEMU and
 PTRACE_SYSEMU_SINGLESTEP support
Message-ID: <20180903165726.GJ6954@arm.com>
References: <20180903062310.GA4524@haibo-VirtualBox>
 <20180903163103.GC6954@arm.com>
 <102400624.EOB2phcGqB@blindfold>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102400624.EOB2phcGqB@blindfold>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Mon, Sep 03, 2018 at 06:40:51PM +0200, Richard Weinberger wrote:
> Am Montag, 3. September 2018, 18:31:03 CEST schrieb Will Deacon:
> > On Mon, Sep 03, 2018 at 02:23:17PM +0800, Haibo.Xu wrote:
> > > Add PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP support on ARM64.
> > > This copies the x86 semantics for invoking ptrace hooks, and have
> > > been verified on ARM64 machine.
> > > 
> > > Signed-off-by: Haibo.Xu <haibo.xu@arm.com>
> > > Signed-off-by: Bin.Lu <bin.lu@arm.com>
> > > ---
> > >  arch/arm64/include/asm/thread_info.h |  5 ++++-
> > >  arch/arm64/include/uapi/asm/ptrace.h |  2 ++
> > >  arch/arm64/kernel/ptrace.c           | 17 +++++++++++++++++
> > >  3 files changed, 23 insertions(+), 1 deletion(-)
> > 
> > What is PTRACE_SYSEMU and what is its semantics? Why isn't it done in the
> > core ptrace code?
> 
> It is an optimization added for UserModeLinux many years ago.
> PTRACE_SYSEMU basically allows you to handle system calls in user space
> without the kernel seeing them.
> Before that UML had to render every system call into a no-op, e.h. getpid().
> This was complicated and slow.

Ok, thanks for the insight!

> The ptrace() manpage has a section on PTRACE_SYSEMU, more documentation on the
> semantics is not available.

:( We already have tracehook, seccomp, tracepoint and audit fighting with
each other on syscall entry, so I'm really not keen to add another player to
the game unless we really have to.

Has anybody tried implementing this using tracehook?

> And yes, I think this should also done in the core. Like many other ptrace() areas
> this needs a cleanup. ;-)
> 
> I wonder what Haibo Xu want to do with PTRACE_SYSEMU on arm64.
> Are you porting UML or gvisor to arm64?

That's a good question. Haibo?

Will
