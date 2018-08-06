Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFCCC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643A221987
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 09:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643A221987
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbeHFL4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 07:56:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:53746 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbeHFL4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 07:56:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 391A6AD21;
        Mon,  6 Aug 2018 09:48:28 +0000 (UTC)
Date:   Mon, 6 Aug 2018 11:48:27 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+bab151e82a4e973fa325@syzkaller.appspotmail.com>,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: WARNING in try_charge
Message-ID: <20180806094827.GH19540@dhcp22.suse.cz>
References: <0000000000005e979605729c1564@google.com>
 <20180806091552.GE19540@dhcp22.suse.cz>
 <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Ystnwv4M6Uh+HBKbdADAnJ6otfR0GoA20crzqV+b2onQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-08-18 11:30:37, Dmitry Vyukov wrote:
> On Mon, Aug 6, 2018 at 11:15 AM, Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > More interesting stuff is higher in the kernel log
> > : [  366.435015] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ile0,task_memcg=/ile0,task=syz-executor3,pid=23766,uid=0
> > : [  366.449416] memory: usage 112kB, limit 0kB, failcnt 1605
> >
> > Are you sure you want to have hard limit set to 0?
> 
> syzkaller really does not mind to have it.

So what do you use it for? What do you actually test by this setting?

[...]
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4603ad75c9a9..852cd3dbdcd9 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1388,6 +1388,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >         bool ret;
> >
> >         mutex_lock(&oom_lock);
> > +       pr_info("task=%s pid=%d invoked memcg oom killer. oom_victim=%d\n",
> > +                       current->comm, current->pid, tsk_is_oom_victim(current));
> >         ret = out_of_memory(&oc);
> >         mutex_unlock(&oom_lock);
> >         return ret;
> >
> > Anyway your memcg setup is indeed misconfigured. Memcg with 0 hard limit
> > and basically no memory charged by existing tasks is not going to fly
> > and the warning is exactly to call that out.
> 
> 
> Please-please-please do not mix kernel bugs and notices to user into
> the same bucket:

Well, WARN_ON used to be a standard way to make user aware of a
misbehavior. In this case it warns about a pottential runaway when memcg
is misconfigured. I do not insist on using WARN_ON here of course. If
there is a general agreement that such a condition is better handled by
pr_err then I am fine with it. Users tend to be more sensitive on
WARN_ONs though.

Btw. running with the above diff on top might help us to ideantify
whether this is a pre-mature warning or a valid one. Still useful to
find out.
-- 
Michal Hocko
SUSE Labs
