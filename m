Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="bRSacvfA"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E823A60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeFFTef (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:34:35 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbeFFTed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:34:33 -0400
X-Google-Smtp-Source: ADUXVKJ3c73875z8wOXwDqW8y3Tn/VI+/cOU0PFsfmwD0vxOrr8Rg2oN8nnkPGuP/ExJ7TLNrYtvKg==
Date: Wed, 6 Jun 2018 21:34:29 +0200
From: Miklos Szeredi <miklos@szeredi.hu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        hch@infradead.org
Subject: [GIT PULL] overlayfs fixes for 4.18
Message-ID: <20180606193429.GF23785@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-4.18

This contains a fix for the vfs_mkdir() issue discovered by Al, as well as
other fixes and cleanups.

It's the first overlayfs pull request for 4.18, the only VFS bit here is a
new inode hash insertion helper.  That helper can be used internally by the
other two (iget5_locked() and insert_inode_locked4()) so it's a cleanup as
well.  Alas, no ack from Al (no nak either, mind).

I'll follow up with a more controversal pull request that has the meat of
the overlayfs developement.  The VFS bits got some acks from Christoph
recently, and one nak that I've purged from the set.

All of this has been posted and reviewed and generally gone through the
normal development cycle, it's just hard to get the attention of top level
vfs maintainers...

Thanks,
Miklos

---
Al Viro (1):
      ovl: make ovl_create_real() cope with vfs_mkdir() safely

Amir Goldstein (6):
      ovl: update documentation for unionmount-testsuite
      ovl: remove WARN_ON() real inode attributes mismatch
      ovl: strip debug argument from ovl_do_ helpers
      ovl: struct cattr cleanups
      ovl: create helper ovl_create_temp()
      ovl: use inode_insert5() to hash a newly created inode

Miklos Szeredi (5):
      ovl: Kconfig documentation fixes
      ovl: return dentry from ovl_create_real()
      ovl: return EIO on internal error
      ovl: clean up copy-up error paths
      vfs: factor out inode_insert5()

Vivek Goyal (1):
      ovl: Pass argument to ovl_get_inode() in a structure

---
 Documentation/filesystems/overlayfs.txt |   7 +-
 fs/inode.c                              | 164 ++++++++++++-------------
 fs/overlayfs/Kconfig                    |   6 +-
 fs/overlayfs/copy_up.c                  |  83 ++++---------
 fs/overlayfs/dir.c                      | 208 +++++++++++++++++++++-----------
 fs/overlayfs/export.c                   |   8 +-
 fs/overlayfs/inode.c                    |  28 +++--
 fs/overlayfs/namei.c                    |  10 +-
 fs/overlayfs/overlayfs.h                |  65 +++++-----
 fs/overlayfs/super.c                    |   9 +-
 include/linux/fs.h                      |   4 +
 11 files changed, 319 insertions(+), 273 deletions(-)
