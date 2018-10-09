Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D98C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023F1214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023F1214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeJIWJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbeJIWJu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:09:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7589CB005;
        Tue,  9 Oct 2018 14:52:30 +0000 (UTC)
Date:   Tue, 9 Oct 2018 16:52:29 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
Message-ID: <20181009145229.3lv5vl2ypz5i45cq@pathway.suse.cz>
References: <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
 <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
 <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
 <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-10-09 05:48:33, Tetsuo Handa wrote:
> On 2018/10/09 1:03, Petr Mladek wrote:
> > On Mon 2018-10-08 19:31:58, Tetsuo Handa wrote:
> >>   A structure named "struct printk_buffer" is introduced for buffering
> >>   up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.
> >>
> >>   A caller is allowed to allocate/free "struct printk_buffer" using
> >>   kzalloc()/kfree() if that caller is in a location where it is possible
> >>   to do so.
> >>
> >>   A macro named "DEFINE_PRINTK_BUFFER()" is defined for allocating
> >>   "struct printk_buffer" from the stack memory or in the .bss section.
> >>
> >>   But since sizeof("struct printk_buffer") is nearly 1KB, it might not be
> >>   preferable to allocate "struct printk_buffer" from the stack memory.
> >>   In that case, a caller can use best-effort buffering mode. Two functions
> >>   get_printk_buffer() and put_printk_buffer() are provided for that mode.
> >>
> >>   get_printk_buffer() tries to assign a "struct printk_buffer" from
> >>   statically preallocated array. It returns NULL if all static
> >>   "struct printk_buffer" are in use.
> >>
> >>   put_printk_buffer() flushes and releases the "struct printk_buffer".
> >>   put_printk_buffer() must match corresponding get_printk_buffer() as with
> >>   rcu_read_unlock() must match corresponding rcu_read_lock().
> > 
> > One problem with this API is when it is used in more complicated code
> > and put_printk_buffer() is not called in some path. I mean leaking.
> > We might get out of buffers easily.
> 
> Then, as an debugging config option for statically preallocated buffers,
> we could record how get_printk_buffer() was called, like lockdep records
> where a lock was taken.

Another solution might be to store some timestamp (jiffies?) into
struct printk_buffer when a new message is added. Then we could flush
stalled buffers in get_printk_buffer() with some warning.

Unfortunately, it might be unsafe to put the stalled buffers.
Well, it might be safe if there is a lock less access. I wonder
if we could reuse the printk_safe code here.

Anyway, I would like to have a solution before we add the new
API into the kernel. We would need it sooner or later anyway.
And I would like to be sure that the API is sane.


> > A solution might be to store some information about the owner and
> > put the buffer also when a non-buffered printk is called from
> > the same context.
> > 
> > It might even make it easier to use. If we are able to guess the
> > buffer by the context, we do not need to pass it as an argument.
> 
> It would be nice if we can omit passing "struct printk_buffer" argument.
> But that results in "implicit contexts" which Linus has rejected
> ( https://lkml.kernel.org/CA+55aFx+5R-vFQfr7+Ok9Yrs2adQ2Ma4fz+S6nCyWHY_-2mrmw@mail.gmail.com ).

Yeah and the arguments for explicit context make sense when
I reread them again.

Best Regards,
Petr
