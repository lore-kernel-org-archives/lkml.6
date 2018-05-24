Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033003AbeEXLKK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:10:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36862 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032891AbeEXLKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:10:07 -0400
Date: Thu, 24 May 2018 13:10:02 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 0/2] mm->owner to mm->memcg fixes
Message-ID: <20180524111002.GB20441@dhcp22.suse.cz>
References: <20180504142056.GA26151@redhat.com>
 <87r2mrh4is.fsf@xmission.com>
 <20180504145435.GA26573@redhat.com>
 <87y3gzfmjt.fsf@xmission.com>
 <20180504162209.GB26573@redhat.com>
 <871serfk77.fsf@xmission.com>
 <87tvrncoyc.fsf_-_@xmission.com>
 <20180510121418.GD5325@dhcp22.suse.cz>
 <20180522125757.GL20020@dhcp22.suse.cz>
 <87wovu889o.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wovu889o.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 23-05-18 14:46:43, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Thu 10-05-18 14:14:18, Michal Hocko wrote:
> >> On Fri 04-05-18 12:26:03, Eric W. Biederman wrote:
> >> > 
> >> > Andrew can you pick up these two fixes as well.
> >> > 
> >> > These address the issues Michal Hocko and Oleg Nesterov noticed.
> >> 
> >> I completely got lost in this thread. There are way too many things
> >> discussed at once. Could you repost the full series for a proper review
> >> please?
> >
> > ping
> 
> Quick summary of where things stand.  (Just getting back from vacation
> and catching up with things).
> 
> Andrew has picked up the best version of these patches and you can look
> at his tree to find the current patches.

I would really prefer and appreciate a repost with all the fixes folded
in. Wrapping my head around -fix+ is not something I have time for.

> Looking at my tree the issues that have been looked at above
> the basic patch are:
> !CONFIG_MMU support (code motion)
> Races during exec.  (Roughly solved but I think we can do better by
>                      expanding the scope of
>                      cgroup_threadgroup_change_begin/end in exec and
>                      just making exec atomic wrt to cgroup changes)
> 
> While I was on vacation you posted an old concern about a condtion
> where get_mem_cgroup_from_mm was not guaranteed to complete, and how
> that interacts with charge migration.
> 
> 
> Looking at your description the concern is that cgroup_rmdir can succeed
> when a cgroup has just an mm in it (and no tasks).  The result  is
> that mem_cgroup_try_charge can loop indefinitely in that case.

right

> That is possible with two processes sharing the same mm, but living in
> different memory cgroups.

right

> That is a silly useless configuration but
> something to support at least to the level of making certain kernel's
> don't wedge when it happens by accident or maliciously.

absolutely. Processes sharing the mm without being in the same thread
group is something we should have never allowed IMHO. It just generates
a lot of corner cases. I guess this is a relict from old threading
models so here we are.

> The suggestion of having cgroup_is_populated take this into account
> seems like a good general solution but I don't think that is strictly
> necessary.
> 
> In the spirit of let's make this work.  How about:

Please, repost with the whole series. I really want to see the full
picture.

Thanks!
-- 
Michal Hocko
SUSE Labs
