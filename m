Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166750AbeBOSkO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:40:14 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40140 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166727AbeBOSj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:39:59 -0500
Date: Thu, 15 Feb 2018 18:39:57 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Enrico Weigelt <lkml@metux.net>
Cc: Richard Weinberger <richard.weinberger@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fs_struct refcounting: spinlock vs atomic
Message-ID: <20180215183956.GC30522@ZenIV.linux.org.uk>
References: <7547a9ed-a2e7-e975-a3ba-f41abc16f4bc@metux.net>
 <CAFLxGvz2t8rnEQh4VBJ8v3b66GKA5DY3iMk33jnMP664+RMubw@mail.gmail.com>
 <9cc188a2-406e-bf7c-e769-e982735ba5b6@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cc188a2-406e-bf7c-e769-e982735ba5b6@metux.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 02:46:19PM +0100, Enrico Weigelt wrote:
> On 15.02.2018 10:14, Richard Weinberger wrote:
> > On Wed, Feb 14, 2018 at 10:13 PM, Enrico Weigelt <lkml@metux.net> wrote:
> > > Hi folks,
> > > 
> > > 
> > > in fork.c, a spinlock is held for fs_struct refcounting, while other
> > > places - eg. switch_task_namespaces uses atomic_dec_and_test() on
> > > the nsproxy.
> > > 
> > > What's the exact difference here ? Could the atomic counting also used
> > > for fs_struct ?
> > 
> > Well, the spinlock protects more than just the counter. So atomic won't do it.
> 
> Okay. Is that needed in that case ?
> 
> See unshare() syscall:
> 
> if (new_fs) {
> 	fs = current->fs;
> 	spin_lock(&fs->lock);
> 	current->fs = new_fs;
> 	if (--fs->users)
> 		new_fs = NULL;
> 	else
> 		new_fs = fs;
> 	spin_unlock(&fs->lock);
> }
> 
> Seems to me, that we're just refcounting here, and once it went dont to
> zero, nobody else can access it anymore.

Not true.  We also assume that once fs_struct has been locked, the number of
tasks with reference to it won't change.  See fs/exec.c:check_unsafe_exec(),
for example.
