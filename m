Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B9AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01B920842
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfBZKZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:25:01 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:20490 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfBZKZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:25:00 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1QAOwwa000239;
        Tue, 26 Feb 2019 19:24:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp);
 Tue, 26 Feb 2019 19:24:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav103.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1QAOvCb000234
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 26 Feb 2019 19:24:58 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Ratelimit messages printed by console drivers
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, akpm@linux-foundation.org,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
References: <20180420140157.2nx5nkojj7l2y7if@pathway.suse.cz>
 <20180420101751.6c1c70e8@gandalf.local.home>
 <20180420145720.hb7bbyd5xbm5je32@pathway.suse.cz>
 <20180420111307.44008fc7@gandalf.local.home>
 <20180423103232.k23yulv2e7fah42r@pathway.suse.cz>
 <20180423073603.6b3294ba@gandalf.local.home>
 <20180423124502.423fb57thvbf3zet@pathway.suse.cz>
 <20180425053146.GA25288@jagdpanzerIV>
 <20180426094211.okftwdzgfn72rik3@pathway.suse.cz>
 <20180427102245.GA591@jagdpanzerIV>
 <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <63adb127-bb4b-d952-73f4-764d0cd78c52@i-love.sakura.ne.jp>
Date:   Tue, 26 Feb 2019 19:24:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20180509120050.eyuprdh75grhdsh4@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/05/09 21:00, Petr Mladek wrote:
>>>> But we first need a real reason. Right now it looks to me like
>>>> we have "a solution" to a problem which we have never witnessed.
>>>
>>> I am trying to find a "simple" and generic solution for the problem
>>> reported by Tejun:
>> [..]
>>> 1. Console is IPMI emulated serial console.  Super slow.  Also
>>>    netconsole is in use.
>>> 2. System runs out of memory, OOM triggers.
>>> 3. OOM handler is printing out OOM debug info.
>>> 4. While trying to emit the messages for netconsole, the network stack
>>>    / driver tries to allocate memory and then fail, which in turn
>>>    triggers allocation failure or other warning messages.  printk was
>>>    already flushing, so the messages are queued on the ring.
>>> 5. OOM handler keeps flushing but 4 repeats and the queue is never
>>>    shrinking.  Because OOM handler is trapped in printk flushing, it
>>>    never manages to free memory and no one else can enter OOM path
>>>    either, so the system is trapped in this state.
>>> </paste>
> 
> IMHO, we do not need to chase down this particular problem. It was
> already "solved" by the commit 400e22499dd92613821 ("mm: don't warn
> about allocations which stall for too long").

Does memory allocation by network stack / driver while trying to emit
the messages include __GFP_DIRECT_RECLAIM flag (e.g. GFP_KERNEL) ?
Commit 400e22499dd92613821 handles only memory allocations with
__GFP_DIRECT_RECLAIM flag. If memory allocation when trying to emit
the messages does not include __GFP_DIRECT_RECLAIM flag (e.g.
GFP_ATOMIC / GFP_NOWAIT), doesn't this particular problem still exist?

