Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BFD20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GC0AGOGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfANNhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:37:04 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47680 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfANNhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Qal0PUFvWTbUYJh0AvSVzXC1h5jOFqVcEmQjsSGaBZ0=; b=GC0AGOGY20jbexgER4nS8NgRD
        IREV3LepU3yGrekqyocwL/PzMpSu1NYQCw/xFWulM+Yz7PmSN7v+cd2UqtFw7UC29Qw+fI2OpfNqz
        Z1aSgZITBWAiVn7rYb4LmyMdD8480+yxQJT203WJjHKU0kcuakO+mTALEFnAQvzZNriA8HjsYmEjo
        D5Jv9iy+o/ovFU7WSTEZLlmFRO+CTrjiTAWJ9xydU0nItHdCuBvAnhJ/o9MEzCXLb161SgOeLKpN1
        Kd15/VKUaZ2oB95w/kijinO9BH6y67wvZsz+32xCWaf5TACMWitvyCHd5QOSWJDbv383cDiomiDis
        +TgjpCJEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gj2Q8-0005Mt-OS; Mon, 14 Jan 2019 13:36:53 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3BF7420195215; Mon, 14 Jan 2019 14:36:50 +0100 (CET)
Date:   Mon, 14 Jan 2019 14:36:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] locking/lockdep: Add debug_locks check in
 __lock_downgrade()
Message-ID: <20190114133650.GC10486@hirez.programming.kicks-ass.net>
References: <1547093005-26085-1-git-send-email-longman@redhat.com>
 <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YJYSo5GtSvMSqh4y_w7jWC1S-RYu+exuR3DU9NyrpJqA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 11:21:13AM +0100, Dmitry Vyukov wrote:
> On Thu, Jan 10, 2019 at 5:04 AM Waiman Long <longman@redhat.com> wrote:
> >
> > Tetsuo Handa had reported he saw an incorrect "downgrading a read lock"
> > warning right after a previous lockdep warning. It is likely that the
> > previous warning turned off lock debugging causing the lockdep to have
> > inconsistency states leading to the lock downgrade warning.
> >
> > Fix that by add a check for debug_locks at the beginning of
> > __lock_downgrade().
> >
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> 
> Please also add:
> 
> Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com
> 
> for tracking purposes. But Tetsuo deserves lots of credit for debugging it.

I made that:

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Debugged-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzbot+53383ae265fb161ef488@syzkaller.appspotmail.com

> > index 9593233..e805fe3 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -3535,6 +3535,9 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
> >         unsigned int depth;
> >         int i;
> >
> > +       if (unlikely(!debug_locks))
> > +               return 0;
> > +
> 
> Are we sure this resolves the problem rather than makes the
> inconsistency window smaller?
> I don't understand all surrounding code, but looking just at this
> function it looks like it may just pepper over the problem. Say, we
> pass this check when lockdep was still turned on. Then this thread is
> preempted for some time (e.g. a virtual CPU), then another thread
> started reporting a warning, turned lockdep off, some information
> wasn't collected, and this this task resumes and reports a false
> warning.

Theoretically possible I suppose; but this is analogous to many of the
other lockdep hooks.

> Or we are holding the mutex here, and the fact that we are holding it
> ensures that no other task will take it and no information will be
> lost?

There is no lock here; for performance reasons we prefer not to acquire
a global spinlock on every lockdep hook, that would be horrific.

