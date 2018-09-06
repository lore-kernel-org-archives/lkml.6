Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519F0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0383820659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0383820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeIFKbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:31:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47072 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725850AbeIFKbm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:31:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9ED55AEF7;
        Thu,  6 Sep 2018 05:57:53 +0000 (UTC)
Date:   Thu, 6 Sep 2018 07:57:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc: PF_WQ_WORKER threads must sleep at
 should_reclaim_retry().
Message-ID: <20180906055742.GL14951@dhcp22.suse.cz>
References: <81cc1f29-e42e-7813-dc70-5d6d9e999dd1@i-love.sakura.ne.jp>
 <20180905140451.GG14951@dhcp22.suse.cz>
 <201809060100.w86100i6060716@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201809060100.w86100i6060716@www262.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 06-09-18 10:00:00, Tetsuo Handa wrote:
> Michal Hocko wrote:
> > On Wed 05-09-18 22:53:33, Tetsuo Handa wrote:
> > > On 2018/09/05 22:40, Michal Hocko wrote:
> > > > Changelog said 
> > > > 
> > > > "Although this is possible in principle let's wait for it to actually
> > > > happen in real life before we make the locking more complex again."
> > > > 
> > > > So what is the real life workload that hits it? The log you have pasted
> > > > below doesn't tell much.
> > > 
> > > Nothing special. I just ran a multi-threaded memory eater on a CONFIG_PREEMPT=y kernel.
> > 
> > I strongly suspec that your test doesn't really represent or simulate
> > any real and useful workload. Sure it triggers a rare race and we kill
> > another oom victim. Does this warrant to make the code more complex?
> > Well, I am not convinced, as I've said countless times.
> 
> Yes. Below is an example from a machine running Apache Web server/Tomcat AP server/PostgreSQL DB server.
> An memory eater needlessly killed Tomcat due to this race.

What prevents you from modifying you mem eater in a way that Tomcat
resp. others from being the primary oom victim choice? In other words,
yeah it is not optimal to lose the race but if it is rare enough then
this is something to live with because it can be hardly considered a
new DoS vector AFAICS. Remember that this is always going to be racy
land and we are not going to plumb all possible races because this is
simply not viable. But I am pretty sure we have been through all this
many times already. Oh well...

> I assert that we should fix af5679fbc669f31f.

If you can come up with reasonable patch which doesn't complicate the
code and it is a clear win for both this particular workload as well as
others then why not.
-- 
Michal Hocko
SUSE Labs
