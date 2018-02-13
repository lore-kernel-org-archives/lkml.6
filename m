Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935201AbeBMM3m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:29:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:37391 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935022AbeBMM3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:29:41 -0500
Date: Tue, 13 Feb 2018 13:29:40 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Chris Wilson <chris@chris-wilson.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] khungtaskd: Kick stuck processes
Message-ID: <20180213122940.GS3443@dhcp22.suse.cz>
References: <20180208190753.17690-1-chris@chris-wilson.co.uk>
 <20180213115642.GR3443@dhcp22.suse.cz>
 <151852369261.8633.4809735220536862770@mail.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151852369261.8633.4809735220536862770@mail.alporthouse.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 13-02-18 12:08:12, Chris Wilson wrote:
> Quoting Michal Hocko (2018-02-13 11:56:42)
> > On Thu 08-02-18 19:07:53, Chris Wilson wrote:
> > > After spotting a stuck process, and having decided not to panic, give
> > > the task a kick to see if that helps it to recover (e.g. to paper over a
> > > missed wake up).
> > 
> > huh, this is just no-no. watchdog is there to report problems not
> > interfere. You cannot never know whether the sleeper is prepared for
> > spurious wakeups. Do not paper over bugs...
> 
> Aside from khungtaskd being a debug feature, we want to identify the bug
> by kicking the stuck process and seeing what squeals. Being told that
> khugepaged is stuck over and over again doesn't help resolve who is
> holding onto that lock_page, or if it was just a missed wakeup as all
> other processes are asleep.

And how exactly does kicking helps here? If the waiter uses lock_page
then it would go sleep again because of PG_locked. If the page is not
locked and this is a missed wake up then either unlock_page is wrong
(which doesn't seem to be the case AFAICS) or somebody messes up with
the page locking and this patch doesn't achieve anything.

> We are trying to paper over other bugs so that we can fix ours.

But you do not want to break existing code which might be sensible to
spurious wakeups. You could argue that such a code is broken already and
I would tend to agree, but an artificial wake up is just nogo.
-- 
Michal Hocko
SUSE Labs
