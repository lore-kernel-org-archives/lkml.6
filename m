Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA92C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3972220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3972220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbeKGWY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 17:24:27 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:63707 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKGWY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 17:24:27 -0500
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA7CsAZB020176;
        Wed, 7 Nov 2018 21:54:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp);
 Wed, 07 Nov 2018 21:54:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav104.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA7Cs3Ke020044
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 7 Nov 2018 21:54:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181106143502.GA32748@tigerII.localdomain>
 <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <c4b4d3df-53c6-e938-122e-c172ba8b2500@i-love.sakura.ne.jp>
Date:   Wed, 7 Nov 2018 21:54:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181107102154.pobr7yrl5il76be6@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/07 19:21, Petr Mladek wrote:
> On Tue 2018-11-06 23:35:02, Sergey Senozhatsky wrote:
>>> Since we want to remove "struct cont" eventually, we will try to remove
>>> both "implicit printk() users who are expecting KERN_CONT behavior" and
>>> "explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
>>> this API is recommended.
>>
>> - The printk-fallback sounds like a hint that the existing 'cont' handling
>>   better stay in the kernel. I don't see how the existing 'cont' is
>>   significantly worse than
>> 		bpr_warn(NULL, ...)->printk() // no 'cont' support
>>   I don't see why would we want to do it, sorry. I don't see "it takes 16
>>   printk-buffers to make a thing go right" as a sure thing.
> 
> I see it the following way:
> 
>    + mixed cont lines are very rare but they happen
> 
>    + 16 buffers are more than 1 so it could only be better [*]
> 
>    + the printk_buffer() code is self-contained and does not
>      complicate the logic of the classic printk() code [**]
> 
> 
> [*] A missing put_printk_buffer() might cause that we would get
>     out of buffers. But the same problem is with locks,
>     disabled preemption, disabled interrupts, seq_buffer,
>     alloc/free. Such problems happen but they are rare.
> 
>     Also I do not expect that the same buffer would be shared
>     between many functions. Therefore it should be easy
>     to use it correctly.

Since we can allocate printk() buffer upon dup_task_struct()
and free it upon free_task_struct(), we can have enough printk()
buffers for task context. Also, since total number of exceptional
contexts (e.g. interrupts, oops) is finite, we can have enough
printk() buffers for exceptional contexts.

Is it possible to identify all locations which should use their own
printk() buffers (e.g. interrupt handlers, oops handlers) ? If yes,
despite Linus's objection, automatically switching printk() buffers
(like memalloc_nofs_save()/memalloc_nofs_restore() instead of
https://lkml.kernel.org/r/201709021512.DJG00503.JHOSOFFMFtVLOQ@I-love.SAKURA.ne.jp )
will be easiest and least error prone.

