Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756218AbeDZNHJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:07:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755671AbeDZNHE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:07:04 -0400
Date: Thu, 26 Apr 2018 15:07:00 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, oleg@redhat.com,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        ebiederm@xmission.com, dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] exit: Make unlikely case in mm_update_next_owner()
 more scalable
Message-ID: <20180426130700.GP17484@dhcp22.suse.cz>
References: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152473763015.29458.1131542311542381803.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-04-18 14:00:19, Kirill Tkhai wrote:
> This function searches for a new mm owner in children and siblings,
> and then iterates over all processes in the system in unlikely case.
> Despite the case is unlikely, its probability growths with the number
> of processes in the system. The time, spent on iterations, also growths.
> I regulary observe mm_update_next_owner() in crash dumps (not related
> to this function) of the nodes with many processes (20K+), so it looks
> like it's not so unlikely case.

Did you manage to find the pattern that forces mm_update_next_owner to
slow paths? This really shouldn't trigger very often. If we can fallback
easily then I suspect that we should be better off reconsidering
mm->owner and try to come up with something more clever. I've had a
patch to remove owner few years back. It needed some work to finish but
maybe that would be a better than try to make non-scalable thing suck
less.

-- 
Michal Hocko
SUSE Labs
