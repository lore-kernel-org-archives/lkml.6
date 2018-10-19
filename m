Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E16C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D8DC2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 00:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8DC2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbeJSIVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 04:21:51 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:47586 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeJSIVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 04:21:51 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9J0IGd8019570;
        Fri, 19 Oct 2018 09:18:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp);
 Fri, 19 Oct 2018 09:18:16 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav109.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9J0IGK3019561;
        Fri, 19 Oct 2018 09:18:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9J0IGI2019559;
        Fri, 19 Oct 2018 09:18:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810190018.w9J0IGI2019559@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no eligible
 task.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
MIME-Version: 1.0
Date:   Fri, 19 Oct 2018 09:18:16 +0900
References: <20181018042739.GA650@jagdpanzerIV> <20181018143033.z5gck2enrictqja3@pathway.suse.cz>
In-Reply-To: <20181018143033.z5gck2enrictqja3@pathway.suse.cz>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Mladek wrote:
> This looks very complex and I see even more problems:
> 
>   + You would need to update the rate limit intervals when
>     new console is attached. Note that the ratelimits might
>     get initialized early during boot. It might be solvable
>     but ...
> 
>   + You might need to update the length of the message
>     when the text (code) is updated. It might be hard
>     to maintain.

I assumed we calculate the average dynamically, for the amount of
messages printed by an OOM event is highly unstable (depends on
hardware configuration such as number of nodes, number of zones,
and how many processes are there as a candidate for OOM victim).

> 
>   + You would need to take into account also console_level
>     and the level of the printed messages

Isn't that counted by call_console_drivers() ?

> 
>   + This approach does not take into account all other
>     messages that might be printed by other subsystems.

Yes. And I wonder whether unlimited printk() alone is the cause of RCU
stalls. I think that printk() is serving as an amplifier for any CPU users.
That is, the average speed might not be safe enough to guarantee that RCU
stalls won't occur. Then, there is no safe average value we can use.

> 
> 
> I have just talked with Michal in person. He pointed out
> that we primary need to know when and if the last printed
> message already reached the console.

I think we can estimate when call_console_drivers() started/completed for
the last time as when and if the last printed message already reached the
console. Sometimes callers might append to the logbuf without waiting for
completion of call_console_drivers(), but the system is already unusable
if majority of ratelimited printk() users hit that race window.

> 
> A solution might be to handle printk and ratelimit together.
> For example:
> 
>    + store log_next_idx of the printed message into
>      the ratelimit structure
> 
>    + eventually store pointer of the ratelimit structure
>      into printk_log
> 
>    + eventually store the timestamp when the message
>      reached the console into the ratelimit structure
> 
> Then the ratelimited printk might take into acount whether
> the previous message already reached console and even when.

If printk() becomes asynchronous (e.g. printk() kernel thread), we would
need to use something like srcu_synchronize() so that the caller waits for
only completion of messages the caller wants to wait.

> 
> 
> Well, this is still rather complex. I am not persuaded that
> it is worth it.
> 
> I suggest to take a breath, stop looking for a perfect solution
> for a bit. The existing ratelimit might be perfectly fine
> in practice. You might always create stress test that would
> fail but the test might be far from reality. Any complex
> solution might bring more problems that solve.
> 
> Console full of repeated messages need not be a catastrophe
> when it helps to fix the problem and the system is usable
> and need a reboot anyway.

I wish that memcg OOM events do not use printk(). Since memcg OOM is not
out of physical memory, we can dynamically allocate physical memory for
holding memcg OOM messages and let the userspace poll it via some interface.
