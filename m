Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CBFC32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E7FD2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 01:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7FD2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeKCLFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:05:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63484 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeKCLFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:05:32 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA31tuI5080820;
        Sat, 3 Nov 2018 10:55:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp);
 Sat, 03 Nov 2018 10:55:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav404.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA31tuRv080814
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 3 Nov 2018 10:55:56 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
 <20181102144028.GQ10491@bombadil.infradead.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <865018bd-6352-cb92-1b8a-9254768f0b5c@i-love.sakura.ne.jp>
Date:   Sat, 3 Nov 2018 10:55:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102144028.GQ10491@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/02 23:40, Matthew Wilcox wrote:
> On Fri, Nov 02, 2018 at 10:31:55PM +0900, Tetsuo Handa wrote:
>>   get_printk_buffer() tries to assign a "struct printk_buffer" from
>>   statically preallocated array. get_printk_buffer() returns NULL if
>>   all "struct printk_buffer" are in use, but the caller does not need to
>>   check for NULL.
> 
> This seems like a great way of wasting 16kB of memory.  Since you've
> already made printk_buffered() work with a NULL initial argument, what's
> the advantage over just doing kmalloc(1024, GFP_ATOMIC)?

Like "[PATCH 2/3] mm: Use line-buffered printk() for show_free_areas()."
demonstrates, kzalloc(sizeof(struct printk_buffer), GFP_ATOMIC) can fail.

And using statically preallocated buffers helps avoiding

  (1) out of buffers when memory cannot be allocated

  (2) kernel stack overflow when kernel stack is already tight (e.g.
      a memory allocation attempt from an interrupt handler which was
      invoked from deep inside call chain of a process context)

. Whether

  (A) tuning the number of statically preallocated buffers

  (B) allocating buffers on caller side (e.g. kzalloc() or in .bss section)

are useful is a future decision, for too much concurrent printk() will lockup
the system even if there are enough buffers. I think that starting with
statically preallocated buffers is (at least for now) a good choice for
minimizing risk of (1) (2) while offering practically acceptable result.

