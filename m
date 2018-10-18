Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F9CC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ADC22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 06:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADC22098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJROyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 10:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:60726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727337AbeJROyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 10:54:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 187CBAFF9;
        Thu, 18 Oct 2018 06:55:21 +0000 (UTC)
Date:   Thu, 18 Oct 2018 08:55:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, guro@fb.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        rientjes@google.com, yang.s@alibaba-inc.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzbot <syzbot+77e6b28a7a7106ad0def@syzkaller.appspotmail.com>
Subject: Re: [PATCH v3] mm: memcontrol: Don't flood OOM messages with no
 eligible task.
Message-ID: <20181018065519.GV18839@dhcp22.suse.cz>
References: <20181017102821.GM18839@dhcp22.suse.cz>
 <20181017111724.GA459@jagdpanzerIV>
 <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810180246.w9I2koi3011358@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 18-10-18 11:46:50, Tetsuo Handa wrote:
> Sergey Senozhatsky wrote:
> > On (10/17/18 12:28), Michal Hocko wrote:
> > > > Michal proposed ratelimiting dump_header() [2]. But I don't think that
> > > > that patch is appropriate because that patch does not ratelimit
> > > > 
> > > >   "%s invoked oom-killer: gfp_mask=%#x(%pGg), nodemask=%*pbl, order=%d, oom_score_adj=%hd\n"
> > > >   "Out of memory and no killable processes...\n"
> > [..]
> > > > Let's make sure that next dump_header() waits for at least 60 seconds from
> > > > previous "Out of memory and no killable processes..." message.
> > > 
> > > Could you explain why this is any better than using a well established
> > > ratelimit approach?
> 
> This is essentially a ratelimit approach, roughly equivalent with:
> 
>   static DEFINE_RATELIMIT_STATE(oom_no_victim_rs, 60 * HZ, 1);
>   oom_no_victim_rs.flags |= RATELIMIT_MSG_ON_RELEASE;
> 
>   if (__ratelimit(&oom_no_victim_rs)) {
>     dump_header(oc, NULL);
>     pr_warn("Out of memory and no killable processes...\n");
>     oom_no_victim_rs.begin = jiffies;
>   }

Then there is no reason to reinvent the wheel. So use the standard
ratelimit approach. Or put it in other words, this place is no special
to any other that needs some sort of printk throttling. We surely do not
want an ad-hoc solutions all over the kernel.

And once you realize that the ratelimit api is the proper one (put aside
any potential improvements in the implementation of this api) then you
quickly learn that we already do throttle oom reports and it would be
nice to unify that and ... we are back to a naked patch. So please stop
being stuborn and try to cooperate finally.
-- 
Michal Hocko
SUSE Labs
