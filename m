Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A96C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD8B20C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD8B20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbeJHXPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:15:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:49854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbeJHXPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:15:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D6E64ADF1;
        Mon,  8 Oct 2018 16:03:11 +0000 (UTC)
Date:   Mon, 8 Oct 2018 18:03:10 +0200
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
Message-ID: <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
References: <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
 <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
 <20181002063851.GF598@jagdpanzerIV>
 <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a958a1b-a986-014a-5908-816e0a3ef4ff@i-love.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-08 19:31:58, Tetsuo Handa wrote:
> On 2018/10/02 15:38, Sergey Senozhatsky wrote:
> > I have sketched a very silly, quick-and-dirty implementation using
> > struct cont. It derives all the good features of the existing pr_cont.
> > I didn't spend enough time on this. It's just a sketch... which compiles
> > and that's it.
> 
> Sergey and I had off-list discussion about an implementation above. But
> I concluded that I should update my version than updating Sergey's sketch.
> 
> The origin ( https://groups.google.com/forum/#!topic/syzkaller/ttZehjXiHTU ) is
> how to prefix caller information to each line of printk() messages so that syzbot
> can group messages from each context and do the better processing.
> 
> We know that Linus has refused injecting extra data into message body
> ( https://lkml.kernel.org/r/CA+55aFynkjSL1NNZbx6m1iE2HjZagGK09rAr5-HaZ4Ep2eWKOg@mail.gmail.com )
> 
>   On 2017/09/18 0:35, Linus Torvalds wrote:
>   > On Sat, Sep 16, 2017 at 11:26 PM, Sergey Senozhatsky
>   > <sergey.senozhatsky@gmail.com> wrote:
>   >>
>   >> so... I think we don't have to update 'struct printk_log'. we can store
>   >> that "extended data" at the beginning of every message, right after the
>   >> prefix.
>   > 
>   > No, we really can't. That just means that all the tools would have to
>   > be changed to get the normal messages without the extra crud. And
>   > since it will have lost the difference, that's not even easy to do.
>   > 
>   > So this is exactly the wrong way around.
>   > 
>   > If people want to see the extra data, it really should be extra data
>   > that you can get with a new interface from the kernel logs. Not a
>   > "let's just a add it to all lines and make every line uglier and
>   > harder to read.
>   > 
>   >               Linus
> 
> but we also know that syzbot cannot count on a new interface
> ( https://lkml.kernel.org/r/CACT4Y+aFO+yZ7ovkxJOJfz=JgsE3yr+ywLQ9kVUrOHYMBgfWdg@mail.gmail.com )
> 
>   On 2018/05/18 22:08, Dmitry Vyukov wrote:
>   > On Fri, May 18, 2018 at 2:54 PM, Petr Mladek <pmladek@suse.com> wrote:
>   >> On Fri 2018-05-18 14:25:57, Dmitry Vyukov wrote:
>   >>>> On Thu 2018-05-17 20:21:35, Sergey Senozhatsky wrote:
>   >>>>> Dunno...
>   >>>>> For instance, can we store context tracking info as a extended record
>   >>>>> data? We have that dict/dict_len thing. So may we can store tracking
>   >>>>> info there? Extended records will appear on the serial console /* if
>   >>>>> console supports extended data */ or can be read in via devkmsg_read().
>   >>>
>   >>> What consoles do support it?
>   >>> We are interested at least in qemu console, GCE console and Android
>   >>> phone consoles. But it would be pity if this can't be used on various
>   >>> development boards too.
>   >>
>   >> Only the netconsole is able to show the extended (dict)
>   >> information at the moment. Search for CON_EXTENDED flag.
>   > 
>   > Then we won't be able to use it. And we can't pipe from devkmsg_read
>   > in user-space, because we need this to work when kernel is broken in
>   > various ways...
> 
> and we have to allow normal consoles to inject caller information into message
> body. Since syzbot can modify kernel configurations and kernel boot command
> line options, if Linus permits, we can enable injecting caller information to
> only syzbot environments.
> 
> Regarding a concern Linus mentioned
> ( https://lkml.kernel.org/r/CA+55aFwmwdY_mMqdEyFPpRhCKRyeqj=+aCqe5nN108v8ELFvPw@mail.gmail.com ),
> we would be able to convert
> 
>      printk("Testing feature XYZ..");
>      this_may_blow_up_because_of_hw_bugs();
>      printk(KERN_CONT " ... ok\n");
> 
> to
> 
>      printk("Testing feature XYZ..\n");
>      this_may_blow_up_because_of_hw_bugs();
>      printk("... feature XYZ ok\n");
> 
> and eventually remove pr_cont/printk(KERN_CONT) support (i.e. printk() will always
> emit '\n').
> 
> 
> 
> >From df59a431b18888af3bdc9a90d03f1a9d63a12c3e Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Sun, 7 Oct 2018 10:20:38 +0900
> Subject: [PATCH v3] printk: Add line-buffered printk() API.
> 
> Sometimes we want to print a whole line without being disturbed by
> concurrent printk() from interrupts and/or other threads, for printk()
> which does not end with '\n' can be disturbed.
> 
> Mixed printk() output makes it hard to interpret. Assuming that we will go
> to a direction that we allow prefixing context identifier to each line of
> printk() output (so that we can group multiple lines into one block when
> parsing), this patch introduces API for line-buffered printk() output
> (so that we can make sure that printk() ends with '\n').
> 
> Since functions introduced by this patch are merely wrapping
> printk()/vprintk() calls in order to minimize possibility of using
> "struct cont", it is safe to replace printk()/vprintk() with this API.
> 
> Details:
> 
>   A structure named "struct printk_buffer" is introduced for buffering
>   up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.
> 
>   A caller is allowed to allocate/free "struct printk_buffer" using
>   kzalloc()/kfree() if that caller is in a location where it is possible
>   to do so.
> 
>   A macro named "DEFINE_PRINTK_BUFFER()" is defined for allocating
>   "struct printk_buffer" from the stack memory or in the .bss section.
> 
>   But since sizeof("struct printk_buffer") is nearly 1KB, it might not be
>   preferable to allocate "struct printk_buffer" from the stack memory.
>   In that case, a caller can use best-effort buffering mode. Two functions
>   get_printk_buffer() and put_printk_buffer() are provided for that mode.
> 
>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>   statically preallocated array. It returns NULL if all static
>   "struct printk_buffer" are in use.
> 
>   put_printk_buffer() flushes and releases the "struct printk_buffer".
>   put_printk_buffer() must match corresponding get_printk_buffer() as with
>   rcu_read_unlock() must match corresponding rcu_read_lock().

One problem with this API is when it is used in more complicated code
and put_printk_buffer() is not called in some path. I mean leaking.
We might get out of buffers easily.

A solution might be to store some information about the owner and
put the buffer also when a non-buffered printk is called from
the same context.

It might even make it easier to use. If we are able to guess the
buffer by the context, we do not need to pass it as an argument.

Well, I would like to avoid having the buffer connected with CPU.
It would require to disable preemption in get_printk_buffer().
IMHO, it would be a unintuitive and even unwanted side effect.

Best Regards,
Petr


PS: I am sorry for the late reply. I was busy with some other
important stuff. I still have to think more about it and look
mode deeply into the implementation.

In each case, we need to be careful about the design.
The API has to be easy and safe to use. Also the implementation
should not complicate the printk design too much.

It looks promising. Also there is a high chance that it would
be much more straightforward than the current code around
the cont buffer ;-)
