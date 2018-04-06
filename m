Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDFN4V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:56:21 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:28859 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbeDFN4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:56:19 -0400
To: peterz@infradead.org
Cc: viro@zeniv.linux.org.uk, osandov@fb.com, dvyukov@google.com,
        bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com,
        axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, shli@fb.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        mingo@redhat.com, linux-fsdevel@vger.kernel.org, knikanth@suse.de
Subject: Re: INFO: task hung in lo_ioctl
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
        <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
        <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
        <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
        <20180406121411.GJ4082@hirez.programming.kicks-ass.net>
In-Reply-To: <20180406121411.GJ4082@hirez.programming.kicks-ass.net>
Message-Id: <201804062255.HEJ82361.FJOFHVtSLOMOQF@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Fri, 6 Apr 2018 22:55:03 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 09:04:18PM +0900, Tetsuo Handa wrote:
> > +	/* Temporary hack for handling lock imbalance. */
> > +	if (__mutex_owner(&lo->lo_ctl_mutex) == current)
> > +		mutex_unlock(&lo->lo_ctl_mutex);
> 
> ARGGH.. you didn't read the comment we put on that?
> 

Commit 5b52330bbfe63b33 ("audit: fix auditd/kernel connection state tracking")
is using __mutex_owner(). ;-)

Of course, regarding loop module, we will be able to add a flag variable
associated with lo->lo_ctl_mutex. But that will be done after we solved
the deadlock problem. I think whether we need to drop lo->lo_ctl_mutex is
not clear. Maybe

-	err = mutex_lock_killable_nested(&lo->lo_ctl_mutex, 1);
+	err = mutex_lock_killable(&lo->lo_ctl_mutex);

on top of this patch and listen to the lockdep?

Commit f028f3b2f987ebc6 ("loop: fix circular locking in loop_clr_fd()") says

  A simple way to silence lockdep could be to mark the lo_ctl_mutex
  in ioctl to be a sub class, but this might mask some other real bugs.

and we are currently hitting a deadlock problem.
