Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BABC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24EED2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 20:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24EED2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJIECT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 00:02:19 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:61949 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIECS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 00:02:18 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w98Kmg7L024557;
        Tue, 9 Oct 2018 05:48:42 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Tue, 09 Oct 2018 05:48:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w98Kmb7G024549
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 9 Oct 2018 05:48:41 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Petr Mladek <pmladek@suse.com>
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
 <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3ce1695b-9c47-40cc-602b-7c5ffb593024@i-love.sakura.ne.jp>
Date:   Tue, 9 Oct 2018 05:48:33 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008160310.ldwryudzkvp5de3b@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/09 1:03, Petr Mladek wrote:
> On Mon 2018-10-08 19:31:58, Tetsuo Handa wrote:
>>   A structure named "struct printk_buffer" is introduced for buffering
>>   up to LOG_LINE_MAX bytes of printk() output which did not end with '\n'.
>>
>>   A caller is allowed to allocate/free "struct printk_buffer" using
>>   kzalloc()/kfree() if that caller is in a location where it is possible
>>   to do so.
>>
>>   A macro named "DEFINE_PRINTK_BUFFER()" is defined for allocating
>>   "struct printk_buffer" from the stack memory or in the .bss section.
>>
>>   But since sizeof("struct printk_buffer") is nearly 1KB, it might not be
>>   preferable to allocate "struct printk_buffer" from the stack memory.
>>   In that case, a caller can use best-effort buffering mode. Two functions
>>   get_printk_buffer() and put_printk_buffer() are provided for that mode.
>>
>>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>>   statically preallocated array. It returns NULL if all static
>>   "struct printk_buffer" are in use.
>>
>>   put_printk_buffer() flushes and releases the "struct printk_buffer".
>>   put_printk_buffer() must match corresponding get_printk_buffer() as with
>>   rcu_read_unlock() must match corresponding rcu_read_lock().
> 
> One problem with this API is when it is used in more complicated code
> and put_printk_buffer() is not called in some path. I mean leaking.
> We might get out of buffers easily.

Then, as an debugging config option for statically preallocated buffers,
we could record how get_printk_buffer() was called, like lockdep records
where a lock was taken.

> 
> A solution might be to store some information about the owner and
> put the buffer also when a non-buffered printk is called from
> the same context.
> 
> It might even make it easier to use. If we are able to guess the
> buffer by the context, we do not need to pass it as an argument.

It would be nice if we can omit passing "struct printk_buffer" argument.
But that results in "implicit contexts" which Linus has rejected
( https://lkml.kernel.org/CA+55aFx+5R-vFQfr7+Ok9Yrs2adQ2Ma4fz+S6nCyWHY_-2mrmw@mail.gmail.com ).

> 
> Well, I would like to avoid having the buffer connected with CPU.
> It would require to disable preemption in get_printk_buffer().
> IMHO, it would be a unintuitive and even unwanted side effect.

get_printk_buffer() is connected with the context who called "struct printk_buffer".
There is no need to disable preemption.

> 
> Best Regards,
> Petr
> 
> 
> PS: I am sorry for the late reply. I was busy with some other
> important stuff. I still have to think more about it and look
> mode deeply into the implementation.

No problem. Thank you for replying.

> 
> In each case, we need to be careful about the design.
> The API has to be easy and safe to use. Also the implementation
> should not complicate the printk design too much.
> 
> It looks promising. Also there is a high chance that it would
> be much more straightforward than the current code around
> the cont buffer ;-)
> 

We could eventually remove "struct cont" buffer.

