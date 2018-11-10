Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D156DC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4835520855
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 02:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4835520855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbeKJMZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 07:25:35 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:25207 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbeKJMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 07:25:35 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wAA2gB1U014314;
        Sat, 10 Nov 2018 11:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 10 Nov 2018 11:42:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wAA2g69T014219
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sat, 10 Nov 2018 11:42:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
To:     Petr Mladek <pmladek@suse.com>
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
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181107151900.gxmdvx42qeanpoah@pathway.suse.cz>
 <20181108044510.GC2343@jagdpanzerIV>
 <9648a384-853c-942e-6a8d-80432d943aae@i-love.sakura.ne.jp>
 <20181109061204.GC599@jagdpanzerIV>
 <07dcbcb8-c5a7-8188-b641-c110ade1c5da@i-love.sakura.ne.jp>
 <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <deb8d78b-0593-2b8e-1c7a-9203aa77005f@i-love.sakura.ne.jp>
Date:   Sat, 10 Nov 2018 11:42:03 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181109154326.apqkbsojmbg26o3b@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/10 0:43, Petr Mladek wrote:
>> + * Line buffered printk() tries to assign a buffer when printk() from a new
>> + * context identifier comes in. And it automatically releases that buffer when
>> + * one of three conditions listed below became true.
>> + *
>> + *   (1) printk() from that context identifier emitted '\n' as the last
>> + *       character of output.
>> + *   (2) printk() from that context identifier tried to print a too long line
>> + *       which cannot be stored into a buffer.
>> + *   (3) printk() from a new context identifier noticed that some context
>> + *       identifier is reserving a buffer for more than 10 seconds without
>> + *       emitting '\n'.
>> + *
>> + * Since (3) is based on a heuristic that somebody forgot to emit '\n' as the
>> + * last character of output(), pr_cont()/KERN_CONT users are expected to emit
>> + * '\n' within 10 seconds even if they reserved a buffer.
> 
> This is my main concern about this approach. It is so easy to omit
> the final '\n'.

If it is so easy to forget the final '\n', there will be a lot of implicit
pr_cont() users (because pr_cont() assumes that previous printk() omitted the
final '\n'), and "I am going to investigate much more pr_cont() users." will
be insufficient for getting meaningful conclusion.

Checking "lack of the the final '\n'" means that we need to check
"all printk() users who are not emitting the final '\n'" and evaluate
"whether there is a possibility that subsequent printk() will not be
 called from that context due to e.g. conditional branches". That is an
impossible task for anybody, for there might be out-of-tree code doing it.

> 
> They are currently delayed until another printk(). Even this is bad.
> Unfortunately we could not setup timer from printk() because it
> would add more locks into the game.

We could use interval timer for flushing incomplete line.
But updating printk() users to always end with '\n' will be preferable.

> 
> This patch will make it worse. They might get delayed by 10s or even
> more. Many other lines might appear in between. Also the code is
> more tricky[*].

If there are a lot of implicit pr_cont() users (who are omitting
the final '\n' in previous printk()), we can try to find them (and
fix them) by "reporting the location of printk() which omitted the
final '\n'" instead of "flushing the partial line from different
processes" when "try_buffered_printk() (or an interval timer) found
that some buffer is holding a partial line for more than 10 seconds".

> 
> 
> Sign, I am really unhappy how the buffered_printk() conversion
> looks in lockdep.c. But I still think that the approach is more
> reliable. I am going to investigate much more pr_cont() users.

If there is a possibility that subsequent printk() will not be called from
that context due to e.g. conditional branches, we will need to flush after
previous printk() in order to eliminate possibility of failing to flush.

That is asking printk() users to fix previous printk() so that partial
line is always flushed (with '\n' or without '\n').

> I wonder how many would be that complicated. I do not want
> to give up just because one use-case that was complicated
> even before.
> 
> 
> [*] The buffer can get written and flushed by different processes.
>     It is not trivial to do it correctly a lockless way.
> 
>     The proposed locking looks right on the first glance. But
>     the code is a bit scary ;-)

try_buffered_printk() will be a good hook for finding implicit
pr_cont() users who are omitting the final '\n', for we can find them
without making changes to printk() users.

try_buffered_printk() hook can offload atomic-but-complicated task
(converting e.g. %pSOMETHING to %s) to outside of logbuf_lock, and
reduce the period of holding logbuf_lock.

Since try_buffered_printk() serves as a hook, if we ignore the offloading
atomic-but-complicated task, we can eliminate try_buffered_printk() after
we updated printk() users to always end with '\n'.
