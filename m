Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeFAN5g (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 09:57:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:58813 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbeFAN53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 09:57:29 -0400
Date: Fri, 1 Jun 2018 15:57:25 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        peterz@infradead.org, oleg@redhat.com, viro@zeniv.linux.org.uk,
        mingo@kernel.org, paulmck@linux.vnet.ibm.com, keescook@chromium.org,
        riel@redhat.com, tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
Message-ID: <20180601135725.GE15278@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
 <20180426130700.GP17484@dhcp22.suse.cz>
 <877enj9uwf.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877enj9uwf.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-05-18 20:07:28, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Thu 26-04-18 14:00:19, Kirill Tkhai wrote:
> >> This function searches for a new mm owner in children and siblings,
> >> and then iterates over all processes in the system in unlikely case.
> >> Despite the case is unlikely, its probability growths with the number
> >> of processes in the system. The time, spent on iterations, also growths.
> >> I regulary observe mm_update_next_owner() in crash dumps (not related
> >> to this function) of the nodes with many processes (20K+), so it looks
> >> like it's not so unlikely case.
> >
> > Did you manage to find the pattern that forces mm_update_next_owner to
> > slow paths? This really shouldn't trigger very often. If we can fallback
> > easily then I suspect that we should be better off reconsidering
> > mm->owner and try to come up with something more clever. I've had a
> > patch to remove owner few years back. It needed some work to finish but
> > maybe that would be a better than try to make non-scalable thing suck
> > less.
> 
> Reading through the code I just found a trivial pattern that triggers
> this.  Create a multi-threaded process.  Have the thread group leader
> (the first thread) exit.

Hmm, I thought that we try to iterate over threads in the same thread
group first. But we are not doing that. Anyway just CLONE_VM without
CLONE_THREAD would achieve the same pathological path but that should be
rare. Group leader exiting early without tearing down the whole thread
group should be quite rare as well. No question that somebody might do
that on purpose though...

-- 
Michal Hocko
SUSE Labs
