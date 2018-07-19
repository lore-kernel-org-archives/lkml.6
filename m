Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE350ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8368720673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBde9M4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8368720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731759AbeGSOy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:54:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38972 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731532AbeGSOy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A/9m7t98uzIV50h/L+yGntdXFVOdyEZIpqEVJR7L8FE=; b=BBde9M4xPMc7FWiPqGRbC6poY
        H5goNBUte9ejuFLnPxKs/BqheiyRRABSHcZ0aIm02abmEbwqpdxUZwVHQI0+G76JIdSZGJ7+X76Xx
        Fa9lFwSfEvNZxYsS5Lx6Yri0ShmrL4X1qVrYQ6FHYBKdvDvME66QGhXcZqtjPvH8ovqB9317TejyS
        QeebFOUAGlcWYPnOjkU+nWsD8oSIHR8XmspZxj1ZYVE3LXGx5hzsOSS5i5JGQmuSsztiUwbgAFGfX
        5gi3ZJOFz7Mi/WASNtzTiDGVJZAII36WDchtxA+nuFADgVTDT1I6Wip/9RGbxjdzKm434QR4ZW1VM
        T8a4WBpwA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fg9eM-0003lW-7H; Thu, 19 Jul 2018 14:11:22 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F128520275F36; Thu, 19 Jul 2018 16:11:20 +0200 (CEST)
Date:   Thu, 19 Jul 2018 16:11:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     mingo@redhat.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        joe@perches.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7] x86: Avoid pr_cont() in show_opcodes().
Message-ID: <20180719141120.GI2494@hirez.programming.kicks-ass.net>
References: <1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532009278-5953-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 11:07:58PM +0900, Tetsuo Handa wrote:
> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> 
> Since syzbot is confused by concurrent printk() messages [1],
> this patch changes show_opcodes() to use %ph format string.
> 
> When we start adding prefix to each line of printk() output,
> we will be able to handle concurrent printk() messages.
> 
> [1] https://syzkaller.appspot.com/text?tag=CrashReport&x=139d342c400000
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@amacapital.net>

Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
