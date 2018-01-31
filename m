Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752337AbeAaGVz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:21:55 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:45758 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751187AbeAaGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:21:54 -0500
Date: Wed, 31 Jan 2018 06:21:52 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] assorted vfs stuff
Message-ID: <20180131062152.GH29051@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	All kinds of misc stuff, without any unifying topic,
from various people.  Neil's d_anon patch, several bugfixes,
introduction of kvmalloc analogue of kmemdup_user(), extending
bitfield.h to deal with fixed-endians, assorted cleanups all
over the place...

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to ce4c253573ad184603e0fa77876ba155b0cde46d:

  alpha: osf_sys.c: use timespec64 where appropriate (2018-01-25 19:34:31 -0500)

----------------------------------------------------------------
Al Viro (14):
      fs/file.c: trim includes
      Add primitives for manipulating bitfields both in host- and fixed-endian.
      r128: don't open-code memdup_user()
      usx2y: don't bother with access_ok() in ->dsp_load()
      snd_hwdep_dsp_load(): don't bother with access_ok()
      usx2y: don't bother with memdup_user() for 16-byte structure
      vme_user: don't use __copy_..._user()
      uvc_v4l2: clean copyin/copyout up
      nfs4file: get rid of pointless include of btrfs.h
      memdup_user(): switch to GFP_USER
      new primitive: vmemdup_user()
      replace_user_tlv(): switch to vmemdup_user()
      snd_ctl_elem_init_enum_names(): switch to vmemdup_user()
      sctp: use vmemdup_user() rather than badly open-coding memdup_user()

Alexey Dobriyan (2):
      dcache: subtract d_hash_shift from 32 in advance
      dcache: delete unused d_hash_mask

Arnd Bergmann (2):
      alpha: osf_sys.c: fix put_tv32 regression
      alpha: osf_sys.c: use timespec64 where appropriate

Christophe Leroy (1):
      Fix misannotated out-of-line _copy_to_user()

Eric Biggers (5):
      eventfd: convert to use anon_inode_getfd()
      eventfd: fold eventfd_ctx_read() into eventfd_read()
      eventfd: fold eventfd_ctx_get() into eventfd_ctx_fileget()
      fs: fold __inode_permission() into inode_permission()
      fs/buffer.c: fold init_buffer() into init_page_buffers()

Jake Daryll Obina (1):
      jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

Jürg Billeter (1):
      fs: add RWF_APPEND

NeilBrown (1):
      VFS: don't keep disconnected dentries on d_anon

Yang Shi (1):
      vfs: remove unused hardirq.h

 Documentation/filesystems/nfs/Exporting            |  27 +++--
 arch/alpha/kernel/osf_sys.c                        |  72 ++++++------
 drivers/gpu/drm/r128/r128_state.c                  |  23 +---
 drivers/media/usb/uvc/uvc_v4l2.c                   |  55 ++++-----
 .../staging/lustre/lustre/llite/llite_internal.h   |  10 +-
 drivers/staging/vme/devices/vme_user.c             |   8 +-
 fs/buffer.c                                        |  10 +-
 fs/dcache.c                                        |  32 +++---
 fs/eventfd.c                                       | 127 +++++----------------
 fs/file.c                                          |   5 -
 fs/file_table.c                                    |   1 -
 fs/jffs2/fs.c                                      |   1 -
 fs/namei.c                                         |  71 +++++-------
 fs/nfs/nfs4file.c                                  |   1 -
 fs/super.c                                         |   2 +-
 include/linux/bitfield.h                           |  46 ++++++++
 include/linux/buffer_head.h                        |   1 -
 include/linux/eventfd.h                            |  14 +--
 include/linux/fs.h                                 |   5 +-
 include/linux/string.h                             |   1 +
 include/uapi/linux/fs.h                            |   6 +-
 lib/usercopy.c                                     |   2 +-
 mm/util.c                                          |  36 ++++--
 net/sctp/socket.c                                  |  59 ++--------
 sound/core/control.c                               |  15 +--
 sound/core/hwdep.c                                 |   2 -
 sound/usb/usx2y/us122l.c                           |  43 +++----
 sound/usb/usx2y/usX2Yhwdep.c                       |  28 +++--
 28 files changed, 298 insertions(+), 405 deletions(-)
