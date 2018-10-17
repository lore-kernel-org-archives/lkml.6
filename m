Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C224BECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B1321526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B1321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeJQTYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:24:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47880 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbeJQTYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:24:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8820AC90;
        Wed, 17 Oct 2018 11:29:32 +0000 (UTC)
Date:   Wed, 17 Oct 2018 13:29:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
Message-ID: <20181017112931.GP18839@dhcp22.suse.cz>
References: <1539770782-3343-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <20181017102821.GM18839@dhcp22.suse.cz>
 <20181017111724.GA459@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017111724.GA459@jagdpanzerIV>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-10-18 20:17:24, Sergey Senozhatsky wrote:
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
> 
> Tetsuo, let's use a well established rate-limit approach both in
> dump_hedaer() and out_of_memory(). I actually was under impression
> that Michal added rate-limiting to both of these functions.

I have http://lkml.kernel.org/r/20181010151135.25766-1-mhocko@kernel.org
Then the discussion took the usual direction of back and forth resulting
in "you do not ratelimit the allocation oom context" and "please do that
as an incremental patch" route and here we are. I do not have time and
energy to argue in an endless loop.

> The appropriate rate-limit value looks like something that printk()
> should know and be able to tell to the rest of the kernel. I don't
> think that middle ground will ever be found elsewhere.

Yes, that makes sense.
-- 
Michal Hocko
SUSE Labs
