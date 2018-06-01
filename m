Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753154AbeFAQul (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:50:41 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:37242 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeFAQui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:50:38 -0400
X-Google-Smtp-Source: ADUXVKIz3JC6H9DcST2wXPljHFkXA/ZN3ESUngeh14F72O9mNLkJ8JhXuzOpaB6y9pAO1W5tjHx1gw==
Date: Fri, 1 Jun 2018 09:50:34 -0700
From: Tejun Heo <tj@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org, paulmck@linux.vnet.ibm.com,
        keescook@chromium.org, riel@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, marcos.souza.org@gmail.com,
        hoeun.ryu@gmail.com, pasha.tatashin@oracle.com, gs051095@gmail.com,
        dhowells@redhat.com, rppt@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, Balbir Singh <balbir@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in
 the same memory cgroup
Message-ID: <20180601165034.GX1351649@devbig577.frc2.facebook.com>
References: <20180510121418.GD5325@dhcp22.suse.cz>
 <20180522125757.GL20020@dhcp22.suse.cz>
 <87wovu889o.fsf@xmission.com>
 <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sh66wobu.fsf_-_@xmission.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Eric.

On Fri, Jun 01, 2018 at 09:53:09AM -0500, Eric W. Biederman wrote:
> 
> From a userspace perspective the cgroup of a mm is determined by which
> the cgroup the task belongs too.  As practically an mm can only belong to
> a single memory cgroup having multiple tasks with the same mm in different
> memory cgroups is not well defined.
> 
> Avoid the difficulties of dealing with crazy semantics and restrict all
> tasks that share a single mm to the same memory cgroup.
> 
> This is accomplished by adding a new function mem_cgroup_mm_can_attach
> that checks this condition with a straight forward algorithm.  In the worst
> case it is O(N^2).  In the common case it should be O(N) in the number of
> tasks being migrated.  As typically only a single process and thus a single
> process is being migrated and it is optimized for that case.
> 
> There are users of mmget such as proc that can create references to an
> mm this function can not find.  This results in an unnecessary
> migration failure.  It does not break the invariant that every task of
> an mm stays in the same memory cgroup.  So this condition is annoying
> but harmelss.
> 
> This requires multi-threaded mm's to be migrated using the procs file.
> 
> This effectively forbids process with mm's shared processes being migrated.
> Although enabling the control file might work.

So, I don't think we need to support putting tasks which share a mm in
different cgroups.  That said, if we're gonna put in that restriction,
I think it should be in cgroup core rather than memcg can_attach.  The
only thing we'd need to do is widening what cgroup migration considers
to be a process.

Thanks.

-- 
tejun
