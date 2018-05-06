Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751407AbeEFNcB (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 09:32:01 -0400
Received: from imap.thunk.org ([74.207.234.97]:46732 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbeEFNb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 09:31:59 -0400
Date: Sun, 6 May 2018 09:31:54 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic: EXT4-fs (device loop0): panic forced after error
Message-ID: <20180506133154.GS29205@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <000000000000019f50056b7f0890@google.com>
 <20180506022428.GQ29205@thunk.org>
 <d295f575-ba4b-b0ba-a856-405f9d393c9d@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d295f575-ba4b-b0ba-a856-405f9d393c9d@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 06, 2018 at 02:03:57PM +0900, Tetsuo Handa wrote:
> 
> Since syzbot is hitting this error path inside mount() request, calling
> panic() when something went wrong inside mount() request might be
> overkill. We can recover without shutting down the system, can't we?

We could add a full kernel-mode fsck which gets run before mount ---
the question is how much complexity we want to add.  If SELinux is
enabled, then we have to check xattr consinsistency, etc., etc.

> > I could mark this as a one-off invalid bug, but if syzkaller is going
> > to be generating classes of corrupted file systems like this, and are
> > going to be complaing about how this causes the kernel to crash, then
> > we have a fundamental syzkaller BUG.
> > 
> If we won't try to recover this case, this specific report would be
> marked as "#syz invalid".

I can do that for this specific case.  Howevre, I'd rather not have to
mark a large number of reports as invalid, if syz is going to produce
a large number of such things.  Which is why I'm raising the questihon
--- is there any way we can make syz smart enough to not raise false
positvies in this case?

In the future I can see the repro attempting to actually do stuff with
the mounted file system, which is why I want to put my foot down now
before the only answer really is adding a kernel-mode fsck before the
file system is allowed to be mounted.

Root is always going to be able to crash the system.  For example,
suppose syzkaller creates a repros which opens /dev/mem and starts
scribbling all over it.  Would we be happy if it started creating
large number of reports for that class of "bug"?

						- Ted
