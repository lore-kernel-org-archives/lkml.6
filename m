Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B6EC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5258F2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 16:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5258F2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeLADLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:11:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:56266 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726595AbeLADLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:11:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E4C9DB0C1;
        Fri, 30 Nov 2018 16:01:48 +0000 (UTC)
Date:   Fri, 30 Nov 2018 17:01:47 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        'Steven Rostedt' <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
Message-ID: <20181130160147.r6idgsr2biy5rwap@pathway.suse.cz>
References: <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
 <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
 <20181123124647.jmewvgrqdpra7wbm@pathway.suse.cz>
 <20181123105634.4956c255@vmware.local.home>
 <d630011ed50140b082e15ddc05d0c640@AcuMS.aculab.com>
 <1d29f61a-8f36-ab1c-bb92-402ee9ad161d@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d29f61a-8f36-ab1c-bb92-402ee9ad161d@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-11-29 19:09:26, Tetsuo Handa wrote:
> On 2018/11/28 22:29, David Laight wrote:
> > I also spent a week trying to work out why a customer kernel was
> > locking up - only to finally find out that the distro they were
> > using set 'panic on opps' - making it almost impossible to find
> > out what was happening.

Did the machine rebooted before the messages reached console or
did it produced crash-dump or frozen?

panic() tries relatively hard to flush the messages to the console,
see printk_safe_flush_on_panic() and console_flush_on_panic().
It is less aggressive when crashdump is called. It might deadlock
in console drivers.

Hmm, it might also fail when another CPU is still running and
steals console_lock. We might want to disable
console_trylock_spinning() if the caller is not
panic_cpu.


> On 2018/11/26 13:34, Sergey Senozhatsky wrote:
> > Or... Instead.
> > We can just leave pr_cont() alone for now. And make it possible to
> > reconstruct messages - IOW, inject some info to printk messages. We
> > do this at Samsung (inject CPU number at the beginning of every
> > message. `cat serial.0 | grep "\[1\]"` to grep for all messages from
> > CPU1). Probably this would be the simplest thing.
> 
> Yes, I sent a patch which helps reconstructing messages at
> http://lkml.kernel.org/r/1543045075-3008-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp .

All the buffering approaches have problems that cannot be solved
easily. The prefix-based approach looks like the best alternative
at the moment.

Best Regards,
Petr
