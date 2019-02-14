Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4263CC10F04
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4142229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fx1rpYHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393804AbfBNKhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:37:42 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54332 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfBNKhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:37:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7yZM4QttJ1fb4ZQ7Mabo7VnLkRDJj+lx0G2X8XXS/q0=; b=fx1rpYHBqJrLjmSSs1gePTKzK
        Ni/DauvFgKLMitkNhK5aW9m4wpH6Xo6Rn7SO+LZool3ojYYBe0dsltLVAgUPMw9zlAWx39NxZLo3n
        e7DTq12YagL1S9+b1JtJSmTbkuZ8pcAUfrr6AY/BHVxNPrLBYwQWW8NdefDr6gS8H9Lxxkbitnu0Q
        VupOqNRJPsPjHUuNI2y93XB8buCKOfO0sxZXubBWy8FtYbq0u2cn9KdQp9/Ttih4UzYwFrsFhla9R
        iOdEi8vQQJ+6bmKp3FVg9Z+ptgbw3Znx9sxvKOfICpLgcc4ogCklFEcHlZZiG0A4rWpwJEP7Iq8N6
        uxvBePSeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1guEOK-00014P-W4; Thu, 14 Feb 2019 10:37:17 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFC8020298375; Thu, 14 Feb 2019 11:37:15 +0100 (CET)
Date:   Thu, 14 Feb 2019 11:37:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
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
Message-ID: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550095217-12047-1-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> v4:
>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> 
> v3:
>  - Optimize __down_read_trylock() for the uncontended case as suggested
>    by Linus.
> 
> v2:
>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
>  - Update performance test data in patch 1.
> 
> The goal of this patchset is to remove the architecture specific files
> for rwsem-xadd to make it easer to add enhancements in the later rwsem
> patches. It also removes the legacy rwsem-spinlock.c file and make all
> the architectures use one single implementation of rwsem - rwsem-xadd.c.
> 
> Waiman Long (3):
>   locking/rwsem: Remove arch specific rwsem files
>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
>     archs
>   locking/rwsem: Optimize down_read_trylock()

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

with the caveat that I'm happy to exchange patch 3 back to my earlier
suggestion in case Will expesses concerns wrt the ARM64 performance of
Linus' suggestion.
