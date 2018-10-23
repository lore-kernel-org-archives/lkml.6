Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22182C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59592080A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59592080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeJWQnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:43:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56718 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727470AbeJWQne (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:43:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5B88AAE12;
        Tue, 23 Oct 2018 08:21:13 +0000 (UTC)
Date:   Tue, 23 Oct 2018 10:21:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181023082111.edb3ela4mhwaaimi@pathway.suse.cz>
References: <20181018042739.GA650@jagdpanzerIV>
 <20181018143033.z5gck2enrictqja3@pathway.suse.cz>
 <201810190018.w9J0IGI2019559@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810190018.w9J0IGI2019559@www262.sakura.ne.jp>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-10-19 09:18:16, Tetsuo Handa wrote:
> Petr Mladek wrote:
> > This looks very complex and I see even more problems:
> > 
> >   + You would need to update the rate limit intervals when
> >     new console is attached. Note that the ratelimits might
> >     get initialized early during boot. It might be solvable
> >     but ...
> > 
> >   + You might need to update the length of the message
> >     when the text (code) is updated. It might be hard
> >     to maintain.
> 
> I assumed we calculate the average dynamically, for the amount of
> messages printed by an OOM event is highly unstable (depends on
> hardware configuration such as number of nodes, number of zones,
> and how many processes are there as a candidate for OOM victim).

Is there any idea how the average length can be counted dynamically?

Note that ____ratelimit() currently does not get any
information from printk/console. It would need to be locakless.
We do not want to complicate printk() with even more locks.


> > 
> >   + This approach does not take into account all other
> >     messages that might be printed by other subsystems.
> 
> Yes. And I wonder whether unlimited printk() alone is the cause of RCU
> stalls. I think that printk() is serving as an amplifier for any CPU users.
> That is, the average speed might not be safe enough to guarantee that RCU
> stalls won't occur. Then, there is no safe average value we can use.

This is why I suggested to avoid counting OOM messages and just check
if and when the last OOM message reached console.


> > I have just talked with Michal in person. He pointed out
> > that we primary need to know when and if the last printed
> > message already reached the console.
> 
> I think we can estimate when call_console_drivers() started/completed for
> the last time as when and if the last printed message already reached the
> console. Sometimes callers might append to the logbuf without waiting for
> completion of call_console_drivers(), but the system is already unusable
> if majority of ratelimited printk() users hit that race window.

I am confused. We are talking about ratemiting. We do not want to
wait for anything. The only guestion is whether it makes sense
to print the "same" message Xth time when even the 1st message
have not reached the console yet.

This reminds me another problem. We would need to use the same
decision for all printk() calls that logically belongs to each
other. Otherwise we might get mixed lines that might confuse
poeple. I mean that OOM messages might look like:

  OOM: A
  OOM: B
  OOM: C

If we do not synchronize the rateliting, we might see:

  OOM: A
  OOM: B
  OOM: C
  OOM: B
  OOM: B
  OOM: A
  OOM: C
  OOM: C


> > A solution might be to handle printk and ratelimit together.
> > For example:
> > 
> >    + store log_next_idx of the printed message into
> >      the ratelimit structure
> > 
> >    + eventually store pointer of the ratelimit structure
> >      into printk_log
> > 
> >    + eventually store the timestamp when the message
> >      reached the console into the ratelimit structure
> > 
> > Then the ratelimited printk might take into acount whether
> > the previous message already reached console and even when.
> 
> If printk() becomes asynchronous (e.g. printk() kernel thread), we would
> need to use something like srcu_synchronize() so that the caller waits for
> only completion of messages the caller wants to wait.

I do not understand this. printk() must not block OOM progress.


> > Well, this is still rather complex. I am not persuaded that
> > it is worth it.
> > 
> > I suggest to take a breath, stop looking for a perfect solution
> > for a bit. The existing ratelimit might be perfectly fine
> > in practice. You might always create stress test that would
> > fail but the test might be far from reality. Any complex
> > solution might bring more problems that solve.
> > 
> > Console full of repeated messages need not be a catastrophe
> > when it helps to fix the problem and the system is usable
> > and need a reboot anyway.
> 
> I wish that memcg OOM events do not use printk(). Since memcg OOM is not
> out of physical memory, we can dynamically allocate physical memory for
> holding memcg OOM messages and let the userspace poll it via some interface.

Would the userspace work when the system gets blocked on allocations?

Best Regards,
Petr
