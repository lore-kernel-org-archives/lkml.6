Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751419AbeDEKvV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:51:21 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37319 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751097AbeDEKvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:51:20 -0400
X-Google-Smtp-Source: AIpwx48ksyuuoJRPI90nKFYWtJ15gottngtgM/p0i4BeeAlxQnma4X0lJ5Zo5SwVfIdORdltIKQ23A==
From: Christian Brauner <christian.brauner@ubuntu.com>
To: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/3 RESEND] namei: add follow_up_bind()
Date: Thu,  5 Apr 2018 12:51:00 +0200
Message-Id: <20180405105103.21572-1-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

(Resending since Linus email got mangled on my terminal. Sorry.)

Back when we fixed TIOCGPTPEER again in

commit a319b01d9095 ("devpts: resolve devpts bind-mounts")

we discovered [1] that the code for bind-mount resolution we needed to add
in devpts_mtnget() was already duplicated in nfsd code. So we briefly
discussed [2] adding a helper to namei.{c,h} that would resolve
bind-mounts. The bind-mount resolution code is replicated in at least two
places:
- fs/nfsd/vfs.c:follow_to_parent()
- fs/devpts/inode.c:devpts_mntget()

This series adds:
- follow_up_bind() to namei.{c,h}
- switches fs/nfsd/vfs.c:follow_to_parent() to use follow_up_bind()
- switches fs/devpts/inode.c:devpts_mntget() to use follow_up_bind()

I just wanted to wait until the devpts patches I sent would make it into
mainline. Seems to me that this helper might be worth having around. Not
just because it avoids (granted rather trivial) code duplication but also
because it makes the concept of resolving a bind-mount up to the origin
mountpoint of the vfs's mount obvious (which at least to me wasn't
obivous before).

[1]: https://lkml.org/lkml/2018/3/11/219
[2]: https://lkml.org/lkml/2018/3/12/486

Thanks!
Christian

Christian Brauner (3):
  namei: add follow_up_bind()
  devpts: use follow_up_bind() helper
  nfsd: use follow_up_bind() helper

 fs/devpts/inode.c     |  4 +---
 fs/namei.c            | 10 ++++++++++
 fs/nfsd/vfs.c         |  4 ++--
 include/linux/namei.h |  1 +
 4 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.15.1
