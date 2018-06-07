Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SWY8AWEiGVvWSgAAmS7hNA
	; Thu, 07 Jun 2018 12:19:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 24E36608B8; Thu,  7 Jun 2018 12:19:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9362260115;
	Thu,  7 Jun 2018 12:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9362260115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753553AbeFGMTR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:19:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753037AbeFGMTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:19:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id BEB05ABF9;
        Thu,  7 Jun 2018 12:19:14 +0000 (UTC)
Date: Thu, 7 Jun 2018 14:19:13 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, peterz@infradead.org,
        viro@zeniv.linux.org.uk, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, keescook@chromium.org, riel@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        marcos.souza.org@gmail.com, hoeun.ryu@gmail.com,
        pasha.tatashin@oracle.com, gs051095@gmail.com, dhowells@redhat.com,
        rppt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        Balbir Singh <balbir@linux.vnet.ibm.com>,
        Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [RFC][PATCH 1/2] memcg: Ensure every task that uses an mm is in
 the same memory cgroup
Message-ID: <20180607121913.GO32433@dhcp22.suse.cz>
References: <87wovu889o.fsf@xmission.com>
 <20180524111002.GB20441@dhcp22.suse.cz>
 <20180524141635.c99b7025a73a709e179f92a2@linux-foundation.org>
 <20180530121721.GD27180@dhcp22.suse.cz>
 <87wovjacrh.fsf@xmission.com>
 <87wovj8e1d.fsf_-_@xmission.com>
 <87y3fywodn.fsf_-_@xmission.com>
 <87sh66wobu.fsf_-_@xmission.com>
 <20180606111333.GF32433@dhcp22.suse.cz>
 <87wova6cw6.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wova6cw6.fsf@xmission.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-06-18 06:42:49, Eric W. Biederman wrote:
> Michal Hocko <mhocko@kernel.org> writes:
[...]
> > Btw. MMF_ALIEN_MM could be used in the OOM proper as well.
> 
> There are two big issues I see with your suggested alternative.
> 1) cgroupv1 the task interface.  We still need to deny migrating
>    part of a thread group.

Hmm. Can we simply check the migrating tsk to be the thread group
leader in can_attach and keep the silent migration skip?

> 2) vfork.  That uses CLONE_MM and it gets used.

Right. MMF_ALIEN_MM would need a better check. I've forgot about this
case.
+		if (unlikely(!(clone_flags & (CLONE_THREAD|CLONE_VFORK)))
+			set_bit(MMF_ALIEN_MM, &mm->flags);

this would still allow to migrate mm via vforked task which is wrong
so can_attach would have to special case vforked task as well. Which is,
ehm, fuggly but that is something we have to handle regardless of
MMF_ALIEN_MM... I will have to check your other patch but I suspect you
haven't done that. Btw. neither did I when trying to work on this
previously.

>    At a quick look
>    I am seeing gcc, g++, cpp, emacs24, strace, calendar, nm, telnet, gdb,
>    and several other programs I don't recognize.
> 
> I believe your proposal will prevent onlining the memcgroup if there

did you mean s@onlining@offlining@ ?

> is a compile running, because of failure to support vfork.
> 
> Further I expect we would need a count rather than a bit that gets set
> and never gets cleared.  Or else even when the mm is no longer shared by
> vfork we will still think it is.

Yes, but does that actually matter all that much to warrant an
additional complexity? If somebody uses the funny threading model and
want to migrate then the failure will likely get noticed regardless
whether there is one or more processes sharing the mm. One failing while
other succeeding sounds confusing.
 
> Michal do you have an opinion on my previous patch?

I guess you mean http://lkml.kernel.org/r/87wovj8e1d.fsf_-_@xmission.com
Yes, I definitely plan to review this. I just need to find some time to
focus on this without being interrupted by many other small things.

> I just want to make certain that this fun work does not get all of the
> attention, and the bug fix actually gets reviewed.

Sure thing!
-- 
Michal Hocko
SUSE Labs
