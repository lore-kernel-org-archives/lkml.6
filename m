Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D79C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0838C20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 12:46:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0838C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409927AbeKWXay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 18:30:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:38494 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390833AbeKWXay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 18:30:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64263AEC0;
        Fri, 23 Nov 2018 12:46:48 +0000 (UTC)
Date:   Fri, 23 Nov 2018 13:46:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
 <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2018-11-10 11:42:03, Tetsuo Handa wrote:
> On 2018/11/10 0:43, Petr Mladek wrote:
> >> + * Line buffered printk() tries to assign a buffer when printk() from a new
> >> + * context identifier comes in. And it automatically releases that buffer when
> >> + * one of three conditions listed below became true.
> >> + *
> >> + *   (1) printk() from that context identifier emitted '\n' as the last
> >> + *       character of output.
> >> + *   (2) printk() from that context identifier tried to print a too long line
> >> + *       which cannot be stored into a buffer.
> >> + *   (3) printk() from a new context identifier noticed that some context
> >> + *       identifier is reserving a buffer for more than 10 seconds without
> >> + *       emitting '\n'.
> >> + *
> >> + * Since (3) is based on a heuristic that somebody forgot to emit '\n' as the
> >> + * last character of output(), pr_cont()/KERN_CONT users are expected to emit
> >> + * '\n' within 10 seconds even if they reserved a buffer.
> > 
> > This is my main concern about this approach. It is so easy to omit
> > the final '\n'.
> 
> If it is so easy to forget the final '\n', there will be a lot of implicit
> pr_cont() users (because pr_cont() assumes that previous printk() omitted the
> final '\n'), and "I am going to investigate much more pr_cont() users." will
> be insufficient for getting meaningful conclusion.
> 
> Checking "lack of the the final '\n'" means that we need to check
> "all printk() users who are not emitting the final '\n'" and evaluate
> "whether there is a possibility that subsequent printk() will not be
>  called from that context due to e.g. conditional branches". That is an
> impossible task for anybody, for there might be out-of-tree code doing it.
> > 
> > They are currently delayed until another printk(). Even this is bad.
> > Unfortunately we could not setup timer from printk() because it
> > would add more locks into the game.
> 
> We could use interval timer for flushing incomplete line.

I am more and more wondering if the buffered printk is worth
the effort. The more buffers we use the more we risk that nobody
would see some important message. Even a part of the line
might be crucial in some situations.

Steven told me on Plumbers conference that even few initial
characters saved him a day few times.


> But updating printk() users to always end with '\n' will be preferable.

This sounds like a whack a mole game. If I get it correctly, you write
that it is "an impossible task for anybody" just few lines above.

Best Regards,
Petr
