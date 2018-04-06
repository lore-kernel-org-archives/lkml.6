Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751862AbeDFP7K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 11:59:10 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36607 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbeDFP7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 11:59:08 -0400
X-Google-Smtp-Source: AIpwx49YIdnNfgYYmAjKK7B2thpMWN32ZOJWc+QvXC4nX4m0ihOoc23k3WiBsgcvbHa3uuAnjaZ61g==
Date: Fri, 6 Apr 2018 08:59:05 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        viro@zeniv.linux.org.uk, osandov@fb.com, dvyukov@google.com,
        bot+abdba5bc6de135d7622f00756da97998425b6de5@syzkaller.appspotmail.com,
        axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, shli@fb.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        mingo@redhat.com, linux-fsdevel@vger.kernel.org, knikanth@suse.de
Subject: Re: INFO: task hung in lo_ioctl
Message-ID: <20180406155905.GA11697@vader>
References: <94eb2c0810d04f5a46055ffc71aa@google.com>
 <CACT4Y+Y6UhNQOc7VUPgvXZ3yGPusjg2WJ9-OXMCRGM2Q1bx7ZQ@mail.gmail.com>
 <6012a726-069a-13a5-9c8d-6a11730d8414@I-love.SAKURA.ne.jp>
 <468f7418-a02d-79cc-3d94-91bbe146567e@I-love.SAKURA.ne.jp>
 <20180406121411.GJ4082@hirez.programming.kicks-ass.net>
 <201804062255.HEJ82361.FJOFHVtSLOMOQF@I-love.SAKURA.ne.jp>
 <20180406154343.GK4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406154343.GK4082@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 05:43:43PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 06, 2018 at 10:55:03PM +0900, Tetsuo Handa wrote:
> > Peter Zijlstra wrote:
> > > On Fri, Apr 06, 2018 at 09:04:18PM +0900, Tetsuo Handa wrote:
> > > > +	/* Temporary hack for handling lock imbalance. */
> > > > +	if (__mutex_owner(&lo->lo_ctl_mutex) == current)
> > > > +		mutex_unlock(&lo->lo_ctl_mutex);
> > > 
> > > ARGGH.. you didn't read the comment we put on that?
> > > 
> > 
> > Commit 5b52330bbfe63b33 ("audit: fix auditd/kernel connection state tracking")
> > is using __mutex_owner(). ;-)
> 
> That got removed and the warning added.

Seems easy enough to fix without resorting to __mutex_owner() (untested):


diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 264abaaff662..cee258d12a1e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1300,12 +1300,13 @@ loop_get_status_old(struct loop_device *lo, struct loop_info __user *arg) {
 static int
 loop_get_status64(struct loop_device *lo, struct loop_info64 __user *arg) {
 	struct loop_info64 info64;
-	int err = 0;
+	int err;
 
-	if (!arg)
-		err = -EINVAL;
-	if (!err)
-		err = loop_get_status(lo, &info64);
+	if (!arg) {
+		mutex_unlock(&lo->lo_ctl_mutex);
+		return -EINVAL;
+	}
+	err = loop_get_status(lo, &info64);
 	if (!err && copy_to_user(arg, &info64, sizeof(info64)))
 		err = -EFAULT;
 

I'll test it and send it up when I get into the office.
