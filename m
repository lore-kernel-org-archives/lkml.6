Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X5DrEHMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA8DC6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752751AbeFFSaG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 14:30:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33768 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeFFSaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 14:30:04 -0400
X-Google-Smtp-Source: ADUXVKKk8vsrZ5lpTUaxwjIBbTPnjidT7qERo0mbxRKeJEXKg8znuCNps0cDbfET+YwE0buvPF+23Q==
Date: Wed, 6 Jun 2018 20:29:59 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [GIT PULL] fuse update for 4.18
Message-ID: <20180606182959.GE23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-4.18

The most interesting part of this update is user namespace support, mostly
done by Eric Biederman.  This enables safe unprivileged fuse mounts within
a user namespace.

There are also a couple of fixes for bugs found by syzbot and miscellaneous
fixes and cleanups.

Thanks,
Miklos

---
Eric W. Biederman (5):
      fuse: Remove the buggy retranslation of pids in fuse_dev_do_read
      fuse: Fail all requests with invalid uids or gids
      fuse: Support fuse filesystems outside of init_user_ns
      fuse: Ensure posix acls are translated outside of init_user_ns
      fuse: Allow fully unprivileged mounts

Miklos Szeredi (5):
      fuse: atomic_o_trunc should truncate pagecache
      fuse: honor AT_STATX_DONT_SYNC
      fuse: honor AT_STATX_FORCE_SYNC
      fuse: add writeback documentation
      fuse: fix control dir setup and teardown

Seth Forshee (1):
      fuse: Restrict allow_other to the superblock's namespace or a descendant

Szymon Lukasz (1):
      fuse: return -ECONNABORTED on /dev/fuse read after abort

Tejun Heo (1):
      fuse: fix congested state leak on aborted connections

Tetsuo Handa (1):
      fuse: don't keep dead fuse_conn at fuse_fill_super().

---
 Documentation/filesystems/fuse-io.txt | 38 ++++++++++++++++++++++++++
 fs/fuse/acl.c                         |  4 +--
 fs/fuse/control.c                     | 15 ++++++++---
 fs/fuse/cuse.c                        | 11 +++++---
 fs/fuse/dev.c                         | 43 +++++++++++++++---------------
 fs/fuse/dir.c                         | 45 ++++++++++++++++++++++---------
 fs/fuse/fuse_i.h                      | 15 +++++++++--
 fs/fuse/inode.c                       | 50 ++++++++++++++++++++++++-----------
 fs/fuse/xattr.c                       | 43 ++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h             |  7 ++++-
 kernel/user_namespace.c               |  1 +
 11 files changed, 209 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/filesystems/fuse-io.txt
