Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDFBht (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 21:37:49 -0400
Received: from imap.thunk.org ([74.207.234.97]:38150 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbeDFBhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 21:37:46 -0400
Date: Thu, 5 Apr 2018 21:37:41 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Eric Biggers <ebiggers@google.com>
Cc: Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in up_write
Message-ID: <20180406013741.GA7345@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
References: <001a1148578c10e4700568e814eb@google.com>
 <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org>
 <20180405032200.GC22358@thunk.org>
 <20180405032454.GD9301@bombadil.infradead.org>
 <20180405223226.GA729@dastard>
 <20180406001325.GA133204@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406001325.GA133204@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 05, 2018 at 05:13:25PM -0700, Eric Biggers wrote:
> Well, ultimately a human needed to investigate the syzbot bug report to figure
> out what was really going on.  In my view, the largest problem is that there are
> simply too many bugs, so many are getting ignored.  If there were only a few
> bugs, then Dmitry would investigate each one and send a "real" bug report of
> better quality than the automated system can provide, or even send a fix
> directly.  But in reality, on the same day this bug was reported, syzbot also
> found 10 other bugs, and in the previous 2 days it had found 38 more.  No single
> person can keep up with that.  You can see the current bug list, which has 172
> open bugs, on the dashboard at https://syzkaller.appspot.com/.  Yes, the kernel
> really is that broken.  Though, of course most bugs are in specific modules, not
> the core kernel.

There are a lot of bugs, so it needs to be easier for humans to figure
out which ones they should care about.  And not all bugs are created
equal.  Some are WARN_ON's that aren't all that important.  Others
will hard crash the kernel, but are not likely to be something that
can be turned into a privilege escalation attack.  Some bugs are
trivially reproducible, and some take a lot more effort.  Making it
easier for humans to decide which ones should be looked at first would
certainly be helpful.y

For me the prioritization goes as follows.

1)  Is it a regression?  If it's a regression, I want to fix it fast.

2)  Is it something that can be easily escalated to a privilege escalation attack?
    Again, if so, I want to fix it fast.

3)  Is it going to get in the way of my development process?  Things
    that trigger new xfstests failures are important, because it's how I
    detect (1).

So I ignored the Syzkaller reports this week because it's hard to
differentiate important bugs from less important ones, and after the
merge window, I want to make sure that I have not introduced any
regressions, and I also want to make sure that commits getting merged
by others have not introduced any regressions in the testing suite
that I use, which is xfstests.

This is why I've been asking for the bisection feature --- not to find
out when a bug has been fixed, but to find out when a bug has been
*introduced*.  If I know that this a bug which has recently
introduced, especially if it has been recently introduced by commits
in my tree, or which I have recently pushed to Linus, I'm going to
care a lot more.  If I can't make that determination, I'm going to
deprioritize that bug in favor of those that definitely do meet these
criteria.

It's not a matter of waiting for someone else to fix it (although I
won't complain if someone does :-).  It's that I'm overloaded, and I
have to prioritize the work that I do.  If syzbot reports are hard to
parse or hard to prioritize, then I may end up prioritizing other work
as being more important.   Sorry, but that's just the way that it is.

Note that I haven't just been complaining about it.  I've been working
on ways so that the gce-xfstests and kvm-xfstests test appliances can
more easily be used to work on Syzbot reports.  If I can make myself
more efficient, or help other people be more efficient, that's
arguably more important than trying to fix some of the 174 currently
open Syzbot issues --- unless you can tell me that certain ones are
super urgent because they (for example) result in CVSS score > 8.

Cheers,

					- Ted
