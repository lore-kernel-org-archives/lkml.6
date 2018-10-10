Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93EC3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164552085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:10:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164552085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbeJJUcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 16:32:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:36116 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJJUcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 16:32:51 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9ADAdAo089098;
        Wed, 10 Oct 2018 22:10:39 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Wed, 10 Oct 2018 22:10:39 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157066051.bbtec.net [60.157.66.51])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w9ADAXJR089068
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 10 Oct 2018 22:10:38 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: INFO: rcu detected stall in shmem_fault
To:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
References: <000000000000dc48d40577d4a587@google.com>
 <201810100012.w9A0Cjtn047782@www262.sakura.ne.jp>
 <20181010085945.GC5873@dhcp22.suse.cz>
 <e72f799e-0634-f958-1af0-291f8577f4e8@i-love.sakura.ne.jp>
 <20181010113500.GH5873@dhcp22.suse.cz>
 <20181010114833.GB3949@tigerII.localdomain>
 <20181010122539.GI5873@dhcp22.suse.cz>
 <CACT4Y+ZfVdeB-WNeLCWJvTHNeCUtR3r1R+3Qjv9XjZXPxaV2WA@mail.gmail.com>
 <CACT4Y+bqJeKum7jessccWQF+4BmabnVy48aqHEOypioKwQAMTQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b7727ff0-b34f-25a2-b9e7-56e70d9349c4@i-love.sakura.ne.jp>
Date:   Wed, 10 Oct 2018 22:10:31 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+bqJeKum7jessccWQF+4BmabnVy48aqHEOypioKwQAMTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/10 21:36, Dmitry Vyukov wrote:
> On Wed, Oct 10, 2018 at 2:29 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Oct 10, 2018 at 2:25 PM, Michal Hocko <mhocko@kernel.org> wrote:
>>> On Wed 10-10-18 20:48:33, Sergey Senozhatsky wrote:
>>>> On (10/10/18 13:35), Michal Hocko wrote:
>>>>>> Just flooding out of memory messages can trigger RCU stall problems.
>>>>>> For example, a severe skbuff_head_cache or kmalloc-512 leak bug is causing
>>>>>
>>>>> [...]
>>>>>
>>>>> Quite some of them, indeed! I guess we want to rate limit the output.
>>>>> What about the following?
>>>>
>>>> A bit unrelated, but while we are at it:
>>>>
>>>>   I like it when we rate-limit printk-s that lookup the system.
>>>> But it seems that default rate-limit values are not always good enough,
>>>> DEFAULT_RATELIMIT_INTERVAL / DEFAULT_RATELIMIT_BURST can still be too
>>>> verbose. For instance, when we have a very slow IPMI emulated serial
>>>> console -- e.g. baud rate at 57600. DEFAULT_RATELIMIT_INTERVAL and
>>>> DEFAULT_RATELIMIT_BURST can add new OOM headers and backtraces faster
>>>> than we evict them.
>>>>
>>>> Does it sound reasonable enough to use larger than default rate-limits
>>>> for printk-s in OOM print-outs? OOM reports tend to be somewhat large
>>>> and the reported numbers are not always *very* unique.
>>>>
>>>> What do you think?
>>>
>>> I do not really care about the current inerval/burst values. This change
>>> should be done seprately and ideally with some numbers.
>>
>> I think Sergey meant that this place may need to use
>> larger-than-default values because it prints lots of output per
>> instance (whereas the default limit is more tuned for cases that print
>> just 1 line).

Yes. The OOM killer tends to print a lot of messages (and I estimate that
mutex_trylock(&oom_lock) accelerates wasting more CPU consumption by
preemption).

>>
>> I've found at least 1 place that uses DEFAULT_RATELIMIT_INTERVAL*10:
>> https://elixir.bootlin.com/linux/latest/source/fs/btrfs/extent-tree.c#L8365
>> Probably we need something similar here.

Since printk() is a significantly CPU consuming operation, I think that what
we need to guarantee is interval between the end of an OOM killer messages
and the beginning of next OOM killer messages is large enough. For example,
setup a timer with 5 seconds timeout upon the end of an OOM killer messages
and check whether the timer already fired upon the beginning of next OOM killer
messages.

> 
> 
> In parallel with the kernel changes I've also made a change to
> syzkaller that (1) makes it not use oom_score_adj=-1000, this hard
> killing limit looks like quite risky thing, (2) increase memcg size
> beyond expected KASAN quarantine size:
> https://github.com/google/syzkaller/commit/adedaf77a18f3d03d695723c86fc083c3551ff5b
> If this will stop the flow of hang/stall reports, then we can just
> close all old reports as invalid.

I don't think so. Only this report was different from others because printk()
in this report was from memcg OOM events without eligible tasks whereas printk()
in others are from global OOM events triggered by severe slab memory leak.
