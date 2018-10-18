Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B06ECDE42
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8D52083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 02:46:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8D52083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i-love.sakura.ne.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbeJRKpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 06:45:33 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:63094 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeJRKpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 06:45:33 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9I2koHY011364;
        Thu, 18 Oct 2018 11:46:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp);
 Thu, 18 Oct 2018 11:46:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav101.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w9I2koeJ011359;
        Thu, 18 Oct 2018 11:46:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id w9I2koi3011358;
        Thu, 18 Oct 2018 11:46:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no eligible
 task.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
MIME-Version: 1.0
Date:   Thu, 18 Oct 2018 11:46:50 +0900
References: <20181017102821.GM18839@dhcp22.suse.cz> <20181017111724.GA459@jagdpanzerIV>
In-Reply-To: <20181017111724.GA459@jagdpanzerIV>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Senozhatsky wrote:
> On (10/17/18 12:28), Michal Hocko wrote:
> > > Michal proposed ratelimiting dump_header() [2]. But I don't think that
> > > that patch is appropriate because that patch does not ratelimit
> > > 
> > >   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
> > >   "Out of memory and no killable processes...\n"
> [..]
> > > Let's make sure that next dump_header() waits for at least 60 seconds from
> > > previous "Out of memory and no killable processes..." message.
> > 
> > Could you explain why this is any better than using a well established
> > ratelimit approach?

This is essentially a ratelimit approach, roughly equivalent with:

  static DEFINE_RATELIMIT_STATE(oom_no_victim_rs, 60 * HZ, 1);
  oom_no_victim_rs.flags |= RATELIMIT_MSG_ON_RELEASE;

  if (__ratelimit(&oom_no_victim_rs)) {
    dump_header(oc, NULL);
    pr_warn("Out of memory and no killable processes...\n");
    oom_no_victim_rs.begin = jiffies;
  }

> 
> Tetsuo, let's use a well established rate-limit approach both in
> dump_hedaer() and out_of_memory(). I actually was under impression
> that Michal added rate-limiting to both of these functions.

Honestly speaking, I wonder whether rate-limit approach helps.
Using a late-limit is a runaround at best.

The fundamental problem here is that we are doing

  while (!fatal_signal_pending(current) && !(current->flags & PF_EXITING)) {
      pr_warn("Help me! I can't kill somebody...\n");
      cond_resched();
  }

when we are under memcg OOM situation and we can't OOM-kill some process
(i.e. we can make no progress). No matter how we throttle pr_warn(), this
will keep consuming CPU resources until the memcg OOM situation is solved.

We call panic() if this is global OOM situation. But for memcg OOM situation,
we do nothing and just hope that the memcg OOM situation is solved shortly.

Until commit 3100dab2aa09dc6e ("mm: memcontrol: print proper OOM header when
no eligible victim left."), we used WARN(1) to report that we are in a bad
situation. And since syzbot happened to hit this WARN(1) with panic_on_warn == 1,
that commit removed this WARN(1) and instead added dump_header() and pr_warn().
And then since syzbot happened to hit RCU stalls at dump_header() added by
that commit, we are trying to mitigate this problem.

But what happens if threads hitting this path are SCHED_RT priority and deprived
threads not hitting this path (e.g. administrator's console session) of all CPU
resources for doing recovery operation? We might succeed with reducing frequency
of messing up the console screens with printk(), but we might fail to solve this
memcg OOM situation after all...

> 
> The appropriate rate-limit value looks like something that printk()
> should know and be able to tell to the rest of the kernel. I don't
> think that middle ground will ever be found elsewhere.
> 
> 
> printk() knows what consoles are registered, and printk() also knows
> (sometimes) what console="..." options the kernel was provided with.
> If baud rates ware not provided as console= options, then serial
> consoles usually use some default value. We can probably ask consoles.
> 
> So *maybe* we can do something like this
> 
> //
> // WARNING: this is just a sketch. A silly idea.
> //          I don't know if we can make it usable.
> //
> 
> ---
> 
> int printk_ratelimit_interval(void)
> {
>        int ret = DEFAULT_RATELIMIT_INTERVAL;
>        struct tty_driver *driver = NULL;
>        speed_t min_baud = MAX_INT;
> 
>        console_lock();
>        for_each_console(c) {
>                speed_t br;
> 
>                if (!c->device)
>                        continue;
>                if (!(c->flags & CON_ENABLED))
>                        continue;
>                if (!c->write)
>                        continue;
>                driver = c->device(c, index);
>                if (!driver)
>                        continue;
> 
>                br = tty_get_baud_rate(tty_driver to tty_struct [???]);
>                min_baud = min(min_baud, br);
>        }
>        console_unlock();
> 
>        switch (min_baud) {
>        case 115200:
>                return ret;
> 
>        case ...blah blah...:
>                return ret * 2;
> 
>        case 9600:
>                return ret * 4;
>        }
>        return ret;
> }

I don't think that baud rate is relevant. Writing to console messes up
operations by console users. What matters is that we don't mess up consoles
to the level (or frequency) where console users cannot do their operations.
That is, interval between the last moment we wrote to a console and the
first moment we will write to a console for the next time matters. Roughly
speaking, remember the time stamp when we called call_console_drivers() for
the last time, and compare with that stamp before trying to call a sort of
ratelimited printk(). My patch is doing it using per call-site stamp recording.

