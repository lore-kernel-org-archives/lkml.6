Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeDEDWE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 23:22:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:34802 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750890AbeDEDWD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 23:22:03 -0400
Date: Wed, 4 Apr 2018 23:22:00 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Matthew Wilcox <willy@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: WARNING in up_write
Message-ID: <20180405032200.GC22358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com, Al Viro <viro@zeniv.linux.org.uk>
References: <001a1148578c10e4700568e814eb@google.com>
 <CACT4Y+bL_+3ZJLE_1KzGNrz4hi=Si-KKsKLCd09TMD1Ux2jpgg@mail.gmail.com>
 <20180404193504.GA7715@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404193504.GA7715@bombadil.infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:35:04PM -0700, Matthew Wilcox wrote:
> On Wed, Apr 04, 2018 at 09:24:05PM +0200, Dmitry Vyukov wrote:
> > On Tue, Apr 3, 2018 at 4:01 AM, syzbot
> > <syzbot+dc5ab2babdf22ca091af@syzkaller.appspotmail.com> wrote:
> > > DEBUG_LOCKS_WARN_ON(sem->owner != get_current())
> > > WARNING: CPU: 1 PID: 4441 at kernel/locking/rwsem.c:133 up_write+0x1cc/0x210
> > > kernel/locking/rwsem.c:133
> > > Kernel panic - not syncing: panic_on_warn set ...
> 
> Message-Id: <1522852646-2196-1-git-send-email-longman@redhat.com>
>

We were way ahead of syzbot in this case.  :-)

I reported the problem Tuesday morning:

	https://lkml.org/lkml/2018/4/4/814

And within a few hours Waiman had proposed a fix:

	https://patchwork.kernel.org/patch/10322639/

Note also that it's not ext4 specific.  It can be trivially reproduced using any one of:

kvm-xfstests -c ext4 generic/068
kvm-xfstests -c btrfs generic/068
kvm-xfstests -c xfs generic/068

(Basically, any file system that supports freeze/thaw.)

Cheers,

						- Ted
