Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0212C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945E820827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 10:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 945E820827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbeKGUWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:22:46 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:37578 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeKGUWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:22:45 -0500
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA7AqsUD035380;
        Wed, 7 Nov 2018 19:52:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Wed, 07 Nov 2018 19:52:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA7Aqrvc035374
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 7 Nov 2018 19:52:54 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
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
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <42f33aae-a1d1-197f-a1d5-8c5ec88e88d1@i-love.sakura.ne.jp>
Date:   Wed, 7 Nov 2018 19:52:53 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181106143502.GA32748@tigerII.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/06 23:35, Sergey Senozhatsky wrote:
>> Since we want to remove "struct cont" eventually, we will try to remove
>> both "implicit printk() users who are expecting KERN_CONT behavior" and
>> "explicit pr_cont()/printk(KERN_CONT) users". Therefore, converting to
>> this API is recommended.
> 
> - The printk-fallback sounds like a hint that the existing 'cont' handling
>   better stay in the kernel. I don't see how the existing 'cont' is
>   significantly worse than
> 		bpr_warn(NULL, ...)->printk() // no 'cont' support
>   I don't see why would we want to do it, sorry. I don't see "it takes 16
>   printk-buffers to make a thing go right" as a sure thing.

Existing 'cont' handling will stay for a while. After majority of
pr_cont()/KERN_CONT users are converted, 'cont' support will be removed
(e.g. KERN_CONT becomes "").

> 
> A question.
> 
> How bad would it actually be to:
> 
> - Allocate seq_buf 512-bytes buffer (GFP_ATOMIC) just-in-time, when we
>   need it.
>     // How often systems cannot allocate a 512-byte buffer? //

It is a very bad thing to do GFP_ATOMIC without __GFP_NOWARN. See
"[PATCH 2/3] mm: Use line-buffered printk() for show_free_areas()."
which helps exactly when GFP_ATOMIC without __GFP_NOWARN failed.
Without __GFP_NOWARN, GFP_ATOMIC for printk() can trigger infinite
recursion and kernel stack overflow.

Even without recursion, doing kmalloc(GFP_ATOMIC | __GFP_NOWARN) temporarily
consumes some kernel stack. I don't know the exact amount needed for
kmalloc(GFP_ATOMIC | __GFP_NOWARN), but it might still emit memory allocation
fault injection messages. What GFP_ATOMIC can guarantee is nothing but
"it does not sleep". Not suitable for printk() which might be called from
critically dangerous situations.

> 
> - OK, assuming that systems around the world are so badly OOM like all the
>   time and even kmalloc(512) is absolutely impossible, then have a fallback
>   to the existing 'cont' handling; it just looks to me better than a plain
>   printk()-fallback with removed 'cont' support.

Since I want to eventually remove 'cont' support inside printk(),
I dropped KERN_CONT in patch [2/3] and [3/3].

> 
> - Do not allocate seq_buf if we are in printk-safe or in printk-nmi mode.
>   To avoid "buffering for the sake of buffering". IOW, when in printk-safe
>   use printk-safe.

Why? Since printk_safe_flush_buffer() forcibly flushes the partial line,
calling printk_safe_log_store() after line buffering can reduce possibility of
flushing partial lines, can't it?

