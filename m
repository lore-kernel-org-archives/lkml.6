Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B15C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8316720666
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8316720666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbeJAR6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 13:58:31 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36378 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbeJAR6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 13:58:31 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w91BLBRe043815;
        Mon, 1 Oct 2018 20:21:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp);
 Mon, 01 Oct 2018 20:21:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav108.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w91BL6pR043803
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 1 Oct 2018 20:21:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
 <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
 <20181001023721.GA6409@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <880ef52f-dff7-af91-5353-f63513265ffe@i-love.sakura.ne.jp>
Date:   Mon, 1 Oct 2018 20:21:05 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001023721.GA6409@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/01 11:37, Sergey Senozhatsky wrote:
> On (09/29/18 20:15), Tetsuo Handa wrote:
>>
>> Because there is no guarantee that memory information is dumped under the
>> oom_lock mutex. The oom_lock is held when calling out_of_memory(), and it
>> cannot be held when reporting GFP_ATOMIC memory allocation failures.
> 
> IOW, static pr_line buffer needs additional synchronization for OOM. Correct?

Yes (assuming that your OOM refer to both out_of_memory() and warn_alloc()).
And since warn_alloc() might be called from atomic/intrrupt contexts, we can't
use locks for synchronization.

> 
> If we are about to have a list of printk buffers then we probably can
> define a list of NR_CPUS cont buffers. And we probably can reuse the
> existing struct cont for buffered printk, having 2 different struct-s
> for the same thing - struct cont and struct printk_buffer - is not very
> cool.

My plan is to remove "struct cont" after most of KERN_CONT users are
converted to use buffered_printk(). There will be 2 different struct-s
only during transition period.

By the way, only up to two threads (the active printer thread and a thread
which is marked as console_waiter) can stall inside printk(), doesn't it?
Then, can you imagine a situation where 1024 (NR_CPUS) threads are stalling
inside printk() waiting for flush? Such system is already dead. All callers
but the two should release printk_buffer as soon as their printk() added their
message to the log buffer.

Maybe "struct printk_buffer" after all becomes identical to "struct cont". But
I guess that even 16 printk_buffer-s is practically sufficient for 1024 CPUs
system, and allocating NR_CPUS printk_buffer-s will be too wasteful.

> 
>> But I don't want line buffered printk() API to truncate upon out of
>> space for line buffered printk() API.
> 
> All printk()-s are limited by LOG_LINE_MAX. Buffered printk() is not
> special.

I'm saying that I don't like discarding overflowed part because you are
using seq_buf_vprintf() which just marks "overflowed" rather than
"flush incomplete line" and "store the new data".

 DEFINE_PR_LINE(pr);

 pr_line(&pr, "1234567890123456789012345678901234567890123456789012345678901234567890");
 pr_line(&pr, "1234567890abcde\n");

will discard "1234567890abcde\n" part, won't it?
I think that getting

 1234567890123456789012345678901234567890123456789012345678901234567890\n
 1234567890abcde\n

is better than getting

 1234567890123456789012345678901234567890123456789012345678901234567890\n

because we can still understand such output by prefixing caller information.

Your DEFINE_PR_LINE() is limiting to far smaller than LOG_LINE_MAX.
Since your version has to worry about "buffer full" (i.e. hitting
seq_buf_set_overflow()) case, it might become a headache for API users.

