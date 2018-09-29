Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBEEC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55032064D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 11:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55032064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbeI2RnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 13:43:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:42325 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbeI2RnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 13:43:18 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8TBFEEV012400;
        Sat, 29 Sep 2018 20:15:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Sat, 29 Sep 2018 20:15:14 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8TBFD19012395
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 29 Sep 2018 20:15:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: inject caller information into the body of
 message
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kbuild test robot <fengguang.wu@intel.com>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20180913142802.GB517@tigerII.localdomain>
 <20180914065728.GA515@jagdpanzerIV>
 <49d22738-17ad-410a-be0a-d27d76ba9f37@i-love.sakura.ne.jp>
 <20180914115028.GB20572@tigerII.localdomain>
 <e855cbef-03ff-b4ac-3e06-d2f2f48cfb1f@i-love.sakura.ne.jp>
 <20180914122217.GA518@tigerII.localdomain>
 <a661ed7f-889a-1811-0ada-111cc5185d05@i-love.sakura.ne.jp>
 <7dadfa8c-1f69-ae0f-d747-dbbc9f97c2b6@i-love.sakura.ne.jp>
 <20180928090939.GE1160@jagdpanzerIV>
 <3b378c7d-c613-4a8d-67f8-946fac8ad0b0@i-love.sakura.ne.jp>
 <20180929105151.GA1392@tigerII.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <91efcff8-dc6d-b7b4-9ac8-2f3882289f95@i-love.sakura.ne.jp>
Date:   Sat, 29 Sep 2018 20:15:14 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180929105151.GA1392@tigerII.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/09/29 19:51, Sergey Senozhatsky wrote:
> On (09/28/18 20:01), Tetsuo Handa wrote:
>>> Yes, this makes sense. At the same time we can keep pr_line buffer
>>> in .bss
>>>
>>> 	static char buffer[1024];
>>> 	static DEFINE_PR_LINE_BUF(..., buffer);
>>>
>>> just like you have already mentioned. But that's going to require a
>>> case-by-case handling; so a big list of printk buffers is a simpler
>>> option. Fallback, tho, can be painful. On a system with 1024 CPUs can
>>> one have more than 16 concurrent cont printks? If the answer is yes,
>>> then we are looking at the same broken cont output as before.
>>
>> I'm OK with making "16" configurable (at kernel configuration and/or
>> at kernel boot like log_buf_len= kernel command line parameter).
> 
> Do we really want this? Why .bss placement doesn't work for you?
> 
> 	void oom(...)
> 	{
> 		static DEFINE_PR_LINE(KERN_ERR, pr);
> 
> 		pr_line(&pr, ....);
> 		pr_line(&pr, "\n");
> 	}
> 
> the underlying buffer will be static; the pr_line will get re-init
> (offset = 0) every time we call the function, which is OK. And we can
> pass &pr to any function oom() invokes. What am I missing?

Because there is no guarantee that memory information is dumped under the
oom_lock mutex. The oom_lock is held when calling out_of_memory(), and it
cannot be held when reporting GFP_ATOMIC memory allocation failures.

> 
>> We could even allow each "struct task_struct" to have corresponding
>> "struct printk_buffer".
> 
> Tetsuo, realistically, we can't. Sorry. No one will let us to have a printk
> buffer on per-task_struct basis. Even if someone will let us to do this,
> a miracle, a single per-task_struct buffer won't work. Because, then
> someone will discover that a very simple API
> 
> 	buffered_printk(current->printk_buffer, "......");
> 
> does not work if buffered_printk() gets interrupted by IRQ, etc. in case
> if that new context also does
> 
> 	buffered_printk(current->printk_buffer, "......");
> 
> So then we will have per-context per-task_struct printk buffer: for task,
> for exceptions, for softirq, for hardirq, for NMI, etc. This is not worth
> it.

The number of "struct task_struct" instances is volatile. But number of non
"struct task_struct" contexts is finite which can be determined at boot (or
initialization) time.

My intention is that allocate "struct printk_buffer" when "struct task_struct"
is created (i.e. upon dup_task_struct()) and release "struct printk_buffer"
when "struct task_struct" is destroyed (i.e. upon free_task_struct()), and
allocate "struct printk_buffer" for non "struct task_struct" contexts when a
CPU is onlined and release "struct printk_buffer" for non "struct task_struct"
contexts when a CPU is offlined. Then, it will be guaranteed that there is
enough "struct printk_buffer" for any callers.

> 
> Let's just have a very simple seq_buf based pr_line API. No config options,
> no command line arguments - heap, bss or stack for buffer placement. Or even
> simpler.

We cannot avoid "** %u printk messages dropped **\n" inside printk() upon out
of space. But I don't want line buffered printk() API to truncate upon out of
space for line buffered printk() API. I want buffered printk() API to flush
incomplete line even if it resulted in printed in multiple lines.
Injecting caller information can mitigate "printed in multiple lines" case.

