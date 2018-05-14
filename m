Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeENCrb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 22:47:31 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:45776 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751219AbeENCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 22:47:30 -0400
Date: Mon, 14 May 2018 03:47:27 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: syzbot <syzbot+481ad819c717f6b78df9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        gregkh@linuxfoundation.org, tj@kernel.org
Subject: Re: general protection fault in kernfs_kill_sb (2)
Message-ID: <20180514024726.GB30522@ZenIV.linux.org.uk>
References: <0000000000008fa9d3056c053291@google.com>
 <14892403-d680-dc5d-1927-bc4a279514fb@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14892403-d680-dc5d-1927-bc4a279514fb@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 11:19:46AM +0900, Tetsuo Handa wrote:

> This is what I reported at
> https://groups.google.com/d/msg/syzkaller-bugs/ISOJlV2I2QM/qHslGMi3AwAJ .
> 
> We are currently waiting for comments from Al Viro.

1) the damn thing is unusable without javashit.  Which gets about
the same reaction as sending something.doc in attachment.  Please,
find a less obnoxious way to archive the thing (or to generate
URLs that would work without that garbage).

2) deactivate_locked_super() *WILL* be called when fill_super() fails.
Live with it; it allows to simplify a whole lot of cleanup logics
in various filesystems.  Again, we are not going for a model where
->kill_sb() is not called for something returned by sget().
Rationale: rarely exercised paths tend to rot, so anything that increases
the duplication of bits and pieces of normal teardown into failure exits
of foo_fill_super() is a bloody bad idea.  If anything, we want to take
a lot of stuff out of ->put_super() instances directly into ->kill_sb()
ones, precisely because ->put_super() is only called for fully set up
filesystems.

3) kernfs needs to be fixed.  The rest of the dropped commits were
made redundant by 8e04944f0ea8; this one wasn't.  Mea culpa.
