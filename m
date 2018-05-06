Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeEFOk0 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 10:40:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:21443 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeEFOkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 10:40:24 -0400
To: tytso@mit.edu
Cc: syzbot+a9a45987b8b2daabdc88@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel panic: EXT4-fs (device loop0): panic forced after error
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <000000000000019f50056b7f0890@google.com>
        <20180506022428.GQ29205@thunk.org>
        <d295f575-ba4b-b0ba-a856-405f9d393c9d@I-love.SAKURA.ne.jp>
        <20180506133154.GS29205@thunk.org>
In-Reply-To: <20180506133154.GS29205@thunk.org>
Message-Id: <201805062340.HFC78625.VFFFOHSOtQMOJL@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Sun, 6 May 2018 23:40:10 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Y. Ts'o wrote:
> On Sun, May 06, 2018 at 02:03:57PM +0900, Tetsuo Handa wrote:
> > 
> > Since syzbot is hitting this error path inside mount() request, calling
> > panic() when something went wrong inside mount() request might be
> > overkill. We can recover without shutting down the system, can't we?
> 
> We could add a full kernel-mode fsck which gets run before mount ---
> the question is how much complexity we want to add.  If SELinux is
> enabled, then we have to check xattr consinsistency, etc., etc.

You are thinking too complicated. I'm not asking for kernel-mode fsck.
I'm just suggesting that mount() request returns an error to the caller
(and the administrator invokes fsck etc. as needed).

We are fixing bugs which occur during mount operation (e.g.

  https://groups.google.com/d/msg/syzkaller-bugs/Yp4q8n-MijM/yDX3zl1XBQAJ
  https://groups.google.com/d/msg/syzkaller-bugs/4C4oiBX8vZ0/W6pi8NdbBgAJ
  https://groups.google.com/d/msg/syzkaller-bugs/QBnHAQBy2pI/ccf-yL5bBgAJ

). And extX filesystem is different from other filesystems that it invokes
error action specified by errors= parameter rather than return an error to
the caller.
