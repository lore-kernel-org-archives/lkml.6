Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16E5C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AA82081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWUFuOrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AA82081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeKBWnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:43:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33798 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbeKBWnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=381qpIJdfNrwhAI5Ppy/E9Kd3jq145yTVK2ml+2Oc4Q=; b=qWUFuOrHWWFo5/kQX0EPt7D8n
        Pr0YJ8YnzYXbq7TlpNDdVeucZLEo4JoZfjbo3delqG1CaPvfKiB5mmrfXfBW2KbMCtW6qt4rrKtnV
        CVAP8075vmoj6SpLokSvCFJv1tlT5kU+VGvilUsYdb/+9g2yJ6ggTfe5+PMg1Y9vQG3ngq5TZ8+47
        JxAZtXB7Z82u7u09AtcoAm/VTGaT5+jXdiAEFgu9nnPKjp0uVrzaXXssiwCspt3n9HV2ej1IEG9gM
        IhEbjVDBTsnksQvv4UEnDt4roOUlf9W2TPduiovE77oJqg5qY2XmxmXsXpiiPe/ul8kovJWEd2LVd
        0t/etYdGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIZcm-0006Y5-H6; Fri, 02 Nov 2018 13:36:32 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D377E2029F9FF; Fri,  2 Nov 2018 14:36:29 +0100 (CET)
Date:   Fri, 2 Nov 2018 14:36:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181102133629.GN3178@hirez.programming.kicks-ass.net>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 10:31:57PM +0900, Tetsuo Handa wrote:
> syzbot is sometimes getting mixed output like below due to concurrent
> printk(). Mitigate such output by using line-buffered printk() API.
> 
>   RCU used illegally from idle CPU!
>   rcu_scheduler_active = 2, debug_locks = 1
>   RSP: 0018:ffffffff88007bb8 EFLAGS: 00000286
>   RCU used illegally from extended quiescent state!
>    ORIG_RAX: ffffffffffffff13
>   1 lock held by swapper/1/0:
>   RAX: dffffc0000000000 RBX: 1ffffffff1000f7b RCX: 0000000000000000
>    #0: 
>   RDX: 1ffffffff10237b8 RSI: 0000000000000001 RDI: ffffffff8811bdc0
>   000000004b34587c
>   RBP: ffffffff88007bb8 R08: ffffffff88075e00 R09: 0000000000000000
>    (
>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   rcu_read_lock
>   R13: ffffffff88007c78 R14: 0000000000000000 R15: 0000000000000000
>   ){....}
>    arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>    default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
>   , at: trace_call_bpf+0xf8/0x640 kernel/trace/bpf_trace.c:46

WTH is that buffered aPI, and no, that breaks my earlyprintk stuff.
