Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1DC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AC420837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AC420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933365AbeFUMFQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:05:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:37781 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932595AbeFUMFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:05:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DBC46AD91;
        Thu, 21 Jun 2018 12:05:13 +0000 (UTC)
Date:   Thu, 21 Jun 2018 14:05:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm,oom: Bring OOM notifier callbacks to outside of OOM
 killer.
Message-ID: <20180621120511.GG10465@dhcp22.suse.cz>
References: <1529493638-6389-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <alpine.DEB.2.21.1806201528490.16984@chino.kir.corp.google.com>
 <20180621073142.GA10465@dhcp22.suse.cz>
 <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8c3056-1bc2-9a32-d745-ab328fd587a1@i-love.sakura.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 20:27:41, Tetsuo Handa wrote:
[....]
> On 2018/06/21 16:31, Michal Hocko wrote:
> > On Wed 20-06-18 15:36:45, David Rientjes wrote:
> > [...]
> >> That makes me think that "oom_notify_list" isn't very intuitive: it can 
> >> free memory as a last step prior to oom kill.  OOM notify, to me, sounds 
> >> like its only notifying some callbacks about the condition.  Maybe 
> >> oom_reclaim_list and then rename this to oom_reclaim_pages()?
> > 
> > Yes agreed and that is the reason I keep saying we want to get rid of
> > this yet-another-reclaim mechanism. We already have shrinkers which are
> > the main source of non-lru pages reclaim. Why do we even need
> > oom_reclaim_pages? What is fundamentally different here? Sure those
> > pages should be reclaimed as the last resort but we already do have
> > priority for slab shrinking so we know that the system is struggling
> > when reaching the lowest priority. Isn't that enough to express the need
> > for current oom notifier implementations?
> > 
> 
> Even if we update OOM notifier users to use shrinker hooks, they will need a
> subtle balance which is currently achieved by mutex_trylock(&oom_lock).

No they do not. They do not want to rely on an unrelated locks to work
properly. That is completely wrong design. We do want locks to protect
specific data rather than code.

> Removing OOM notifier is not doable right now.

I haven't heard any technical argument why.

> It is not suitable as a regression
> fix for commit 27ae357fa82be5ab ("mm, oom: fix concurrent munlock and oom reaper
> unmap, v3").

What is the regression?

> What we could afford for this regression is
> https://patchwork.kernel.org/patch/9842889/ which is exactly what you suggested
> in a thread at https://www.spinics.net/lists/linux-mm/msg117896.html .

-- 
Michal Hocko
SUSE Labs
