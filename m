Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6194C32789
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86B222082D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 02:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B222082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbeKCLJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 07:09:45 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:48851 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeKCLJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 07:09:45 -0400
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wA3208Fh083047;
        Sat, 3 Nov 2018 11:00:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp);
 Sat, 03 Nov 2018 11:00:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav403.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wA3208xQ083035
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 3 Nov 2018 11:00:08 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 3/3] lockdep: Use line-buffered printk() for lockdep
 messages.
To:     Peter Zijlstra <peterz@infradead.org>
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
        Will Deacon <will.deacon@arm.com>
References: <1541165517-3557-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <1541165517-3557-3-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181102133629.GN3178@hirez.programming.kicks-ass.net>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <80eb808d-4c17-9b1f-f866-3e22b9b2b18e@i-love.sakura.ne.jp>
Date:   Sat, 3 Nov 2018 11:00:10 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181102133629.GN3178@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/02 22:36, Peter Zijlstra wrote:
> On Fri, Nov 02, 2018 at 10:31:57PM +0900, Tetsuo Handa wrote:
>> syzbot is sometimes getting mixed output like below due to concurrent
>> printk(). Mitigate such output by using line-buffered printk() API.
>>
>>   RCU used illegally from idle CPU!
>>   rcu_scheduler_active = 2, debug_locks = 1
>>   RSP: 0018:ffffffff88007bb8 EFLAGS: 00000286
>>   RCU used illegally from extended quiescent state!
>>    ORIG_RAX: ffffffffffffff13
>>   1 lock held by swapper/1/0:
>>   RAX: dffffc0000000000 RBX: 1ffffffff1000f7b RCX: 0000000000000000
>>    #0: 
>>   RDX: 1ffffffff10237b8 RSI: 0000000000000001 RDI: ffffffff8811bdc0
>>   000000004b34587c
>>   RBP: ffffffff88007bb8 R08: ffffffff88075e00 R09: 0000000000000000
>>    (
>>   R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>   rcu_read_lock
>>   R13: ffffffff88007c78 R14: 0000000000000000 R15: 0000000000000000
>>   ){....}
>>    arch_safe_halt arch/x86/include/asm/paravirt.h:94 [inline]
>>    default_idle+0xc2/0x410 arch/x86/kernel/process.c:498
>>   , at: trace_call_bpf+0xf8/0x640 kernel/trace/bpf_trace.c:46
> 
> WTH is that buffered aPI, and no, that breaks my earlyprintk stuff.
> 

This API is nothing but a wrapper for reducing frequency of directly
calling printk() by using snprintf() if possible. Thus, whatever your
earlyprintk stuff is, this API should not affect it.
