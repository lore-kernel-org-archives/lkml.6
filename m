Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A91C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08D720869
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 14:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08D720869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbeKOAcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 19:32:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbeKOAcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 19:32:46 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 689212D818;
        Wed, 14 Nov 2018 14:29:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 865475D9CC;
        Wed, 14 Nov 2018 14:29:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 14 Nov 2018 15:29:18 +0100 (CET)
Date:   Wed, 14 Nov 2018 15:29:13 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Chanho Min <chanho.min@lge.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian@brauner.io>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Seungho Park <seungho1.park@lge.com>,
        Inkyu Hwang <inkyu.hwang@lge.com>,
        Donghwan Jung <donghwan.jung@lge.com>,
        Jongsung Kim <neidhard.kim@lge.com>
Subject: Re: [PATCH v2] exec: make de_thread() freezable
Message-ID: <20181114142913.GA13885@redhat.com>
References: <1541994885-20059-1-git-send-email-chanho.min@lge.com>
 <20181113145339.GD16182@dhcp22.suse.cz>
 <20181113161858.GE30990@redhat.com>
 <20181113180058.GT15120@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113180058.GT15120@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 14 Nov 2018 14:29:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13, Michal Hocko wrote:
>
> > > >
> > > > To fix this, make de_thread() freezable. It looks safe and works fine.
> > >
> > > It's been some time since I have looked into this code so bear with me.
> > > One thing is not really clear to me. Why does it help to exclude this
> > > particular task from the freezer
> >
> > we don't exclude it,
> >
> > > when it is not sleeping in the freezer.
> >
> > Yes, it is not sleeping in __refrigerator(), but it does
> >
> > 	schedule();
> > 	freezer_count();
> >
> > so it will enter __refrigerator() right after wakeup. If it won't be woken
> > up we do not care, we can consider it "frozen".
>
> Right, but this is just silencing the freezing code to exclude this
> task, right?

Well yes... but I'd say this tells the freezing code that the caller is frozen,
because it can do nothing till thaw_processes(). Except it can actually call
__refrigerator() if, say, it is killed.

> > > I can see how other threads need to be zapped and TASK_WAKEKILL doesn't
> > > do that but shouldn't we fix that instead?
> >
> > Not sure I understand, but unlikely we can (or want) to make __refrigerator()
> > killable.
>
> Why would that be a problem. If the kill is fatal then why to keep the
> killed task in the fridge?

This is the question to Rafael, but I think that uninterruptible fridge
makes sense.

Because the exiting task can do a lot of things, say IO. So at least we need
to ensure that nobody can be killed after try_to_freeze_tasks() succeeds, and
this needs the changes in kernel/power/process.c and can lead to other problems.

And it is not clear to me why would we want to do this.

> > Otherwise, how can we fix that?
>
> We can mark all threads PF_NOFREEZE and wake them up.

We can't mark them PF_NOFREEZE but of course we could do something else
for de_thread() in particular, see the 1st version of Chanho's fix:
https://lore.kernel.org/lkml/1541671796-8725-1-git-send-email-chanho.min@lge.com/

> This would require
> some more changes of course

Yes,

> but wouldn't that be a more appropriate
> solution? Do we want to block exec for ever just because some threads
> are in the fridge?

Why not?

------------------------------------------------------------------------------
To clarify. speaking of de_thread() in particular, this change can not solve
all problems with freezer because de_thread() is called with cred_guard_mutex
held. And this obviously means that try_to_freeze_tasks() still can fail if
another task waits for this mutex.

But. freezable_schedule() doesn't make the thing worse, we have a lot more
problems (deadlocks) exactly because de_thread() sleeps wating for other threads
with this mutex held.

So I didn't even mention this problem, we need to narrow the scope of this mutex
in any case, so imo this has nothing to do with s/schedule/freezable_schedule/.

Oleg.

