Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6553CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5572087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5572087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbeKLUfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:35:06 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:18157 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbeKLUfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:35:05 -0500
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id wACAgNmC060463;
        Mon, 12 Nov 2018 19:42:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp);
 Mon, 12 Nov 2018 19:42:23 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav405.sakura.ne.jp)
Received: from [192.168.1.8] (softbank060157065137.bbtec.net [60.157.65.137])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id wACAgIFd060425
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Mon, 12 Nov 2018 19:42:23 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v6 1/3] printk: Add line-buffered printk() API.
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
 <20181108022138.GA2343@jagdpanzerIV>
 <20181108112443.huqkju4uwrenvtnu@pathway.suse.cz>
 <20181108123049.GA30440@jagdpanzerIV>
 <20181109141012.accx62deekzq5gh5@pathway.suse.cz>
 <20181112075920.GA497@jagdpanzerIV>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <a09073bb-78b3-b056-e976-c90e41f1b00d@i-love.sakura.ne.jp>
Date:   Mon, 12 Nov 2018 19:42:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181112075920.GA497@jagdpanzerIV>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/11/12 16:59, Sergey Senozhatsky wrote:
> Tetsuo, lockdep report with buffered printks looks a bit different:
> 
>  kernel:  Possible unsafe locking scenario:
>  kernel:        CPU0                    CPU1
>  kernel:        ----                    ----
>  kernel:   lock(bar_lock);
>  kernel:                                lock(
>  kernel: foo_lock);
>  kernel:                                lock(bar_lock);
>  kernel:   lock(foo_lock);
>  kernel: 
> 

Yes. That is because vprintk_buffered() eliminated KERN_CONT.
Since there was pending partial printk() output, vprintk_buffered()
should not eliminate KERN_CONT. Petr Mladek commented

  1. The mixing of normal and buffered printk calls is a bit confusing
     and error prone. It would make sense to use the buffered printk
     everywhere in the given section of code even when it is not
     strictly needed.

and I made a draft version for how the code would look like if we try to
avoid the mixing of normal and buffered printk calls. The required changes
seem to be too large to apply tree wide. And I suggested try_buffered_printk().
