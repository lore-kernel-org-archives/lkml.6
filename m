Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbeDFANb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 20:13:31 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34959 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbeDFAN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 20:13:29 -0400
X-Google-Smtp-Source: AIpwx4+s+5tF/j48gCklOvj4OYXHpJY/joMwn3TKUZVpiCQEuhK9jGZy6uxbJ7s5imKFeIiqkOS0Tg==
Date: Thu, 5 Apr 2018 17:13:25 -0700
From: Eric Biggers <ebiggers@google.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in up_write
Message-ID: <20180406001325.GA133204@google.com>
References: <001a1148578c10e4700568e814eb@google.com>
 <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org>
 <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org>
 <20180405223226.GA729@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405223226.GA729@dastard>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 08:32:26AM +1000, Dave Chinner wrote:
> On Wed, Apr 04, 2018 at 08:24:54PM -0700, Matthew Wilcox wrote:
> > On Wed, Apr 04, 2018 at 11:22:00PM -0400, Theodore Y. Ts'o wrote:
> > > On Wed, Apr 04, 2018 at 12:35:04PM -0700, Matthew Wilcox wrote:
> > > > On Wed, Apr 04, 2018 at 09:24:05PM +0200, Dmitry Vyukov wrote:
> > > > > On Tue, Apr 3, 2018 at 4:01 AM, syzbot
> > > > > <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com> wrote:
> > > > > > DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
> > > > > > WARNING: CPU: 1 PID: 4441 at kernel/locking/rwsem.c:133 up_write+0x1cc/0x210
> > > > > > kernel/locking/rwsem.c:133
> > > > > > Kernel panic - not syncing: panic_on_warn set ...
> > > > 
> > > > Message-Id: <1522852646-2196-1-git-send-email-longman@redhat.com>
> > > >
> > > 
> > > We were way ahead of syzbot in this case.  :-)
> > 
> > Not really ... syzbot caught it Monday evening ;-)
> 
> Rather than arguing over who reported it first, I think that time
> would be better spent reflecting on why the syzbot report was
> completely ignored until *after* Ted diagnosed the issue
> independently and Waiman had already fixed it....
> 
> Clearly there is scope for improvement here.
> 
> Cheers,
> 

Well, ultimately a human needed to investigate the syzbot bug report to figure
out what was really going on.  In my view, the largest problem is that there are
simply too many bugs, so many are getting ignored.  If there were only a few
bugs, then Dmitry would investigate each one and send a "real" bug report of
better quality than the automated system can provide, or even send a fix
directly.  But in reality, on the same day this bug was reported, syzbot also
found 10 other bugs, and in the previous 2 days it had found 38 more.  No single
person can keep up with that.  You can see the current bug list, which has 172
open bugs, on the dashboard at https://syzkaller.appspot.com/.  Yes, the kernel
really is that broken.  Though, of course most bugs are in specific modules, not
the core kernel.

And although quite a few of these bugs will end up to be duplicates or even
already fixed, a human still has to look at each one to figure that out.
(Though, I do think that syzbot should try to automatically detect when a
reproducible bug was already fixed, via bisection.  It would cause a few bugs to
be incorrectly considered fixed, but it may be a worthwhile tradeoff.)

These bugs are all over the kernel as well, so most developers don't see the big
picture but rather just see a few bugs for "their" subsystem on "their"
subsystem's mailing list and sometimes demand special attention.  Of course,
it's great when people suggest ways to improve the process.  But it's not great
when people just don't feel responsible for fixing bugs and wait for
Someone Else to do it.

I'm hoping that in the future the syzbot "team", which seems to actually be just
Dmitry now, can get more resources towards helping fix the bugs.  But either
way, in the end Linux is a community effort.

Note also that syzbot wasn't super useful in this particular case because people
running xfstests came across the same bug.  But, this is actually a rare case.
Most syzbot bug reports have been for weird corner cases or races that no one
ever thought of before, so there are no existing tests that find them.

Thanks,

Eric
