Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6134C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A862087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfADT0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:26:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:46186 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:26:51 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1gfV7I-00077Q-L6; Fri, 04 Jan 2019 19:26:48 +0000
Date:   Fri, 4 Jan 2019 19:26:48 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git mount.part1
Message-ID: <20190104192648.GO2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	mount API prereqs.  Mostly that's LSM mount options cleanups.
One trivial conflict in security/selinux/hooks.c, resolved by taking
the variant from this branch - the method has been split, leaving
only the part that used to be conditional upon "it's not an internal
mount" and check has been moved into the caller of the remaining piece.
The last commit in this pile ("mount_fs: suppress MAC on MS_SUBMOUNT as
well as MS_KERNMOUNT") is an equivalent of the conflict-creating
mainline change.
	There are several minor fixes in there, but nothing
earth-shattering (leaks on failure exits, mostly).

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git mount.part1

for you to fetch changes up to 718c43038f287e843c2f63d946977de90014cb11:

  mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMOUNT (2018-12-21 11:51:23 -0500)

----------------------------------------------------------------
Al Viro (25):
      exofs_mount(): fix leaks on failure exits
      selinux: expand superblock_doinit() calls
      smack: make smack_parse_opts_str() clean up on failure
      LSM: lift parsing LSM options into the caller of ->sb_kern_mount()
      LSM: lift extracting and parsing LSM options into the caller of ->sb_remount()
      new helper: security_sb_eat_lsm_opts()
      LSM: split ->sb_set_mnt_opts() out of ->sb_kern_mount()
      selinux; don't open-code a loop in sb_finish_set_opts()
      btrfs: sanitize security_mnt_opts use
      nfs_remount(): don't leak, don't ignore LSM options quietly
      LSM: turn sb_eat_lsm_opts() into a method
      selinux: kill selinux_sb_get_mnt_opts()
      LSM: hide struct security_mnt_opts from any generic code
      selinux: switch to private struct selinux_mnt_opts
      smack: switch to private smack_mnt_opts
      LSM: bury struct security_mnt_opts
      selinux: new helper - selinux_add_opt()
      selinux: switch away from match_token()
      selinux: regularize Opt_... names a bit
      selinux: rewrite selinux_sb_eat_lsm_opts()
      LSM: new method: ->sb_add_mnt_opt()
      smack: take the guts of smack_parse_opts_str() into a new helper
      smack: get rid of match_token()
      smack: rewrite smack_sb_eat_lsm_opts()
      mount_fs: suppress MAC on MS_SUBMOUNT as well as MS_KERNMOUNT

David Howells (2):
      vfs: Suppress MS_* flag defs within the kernel unless explicitly enabled
      vfs: Separate changing mount flags full remount

 arch/arc/kernel/setup.c       |   1 +
 arch/arm/kernel/atags_parse.c |   1 +
 arch/sh/kernel/setup.c        |   1 +
 arch/sparc/kernel/setup_32.c  |   1 +
 arch/sparc/kernel/setup_64.c  |   1 +
 arch/x86/kernel/setup.c       |   1 +
 drivers/base/devtmpfs.c       |   1 +
 fs/btrfs/ctree.h              |   4 -
 fs/btrfs/super.c              |  82 +----
 fs/exofs/super.c              |  37 +-
 fs/namespace.c                | 156 ++++++---
 fs/nfs/internal.h             |   2 +-
 fs/nfs/super.c                |  34 +-
 fs/pnode.c                    |   1 +
 fs/super.c                    |  24 +-
 include/linux/lsm_hooks.h     |  17 +-
 include/linux/mount.h         |   2 +-
 include/linux/security.h      |  82 +----
 include/uapi/linux/fs.h       |  56 +--
 include/uapi/linux/mount.h    |  58 +++
 init/do_mounts.c              |   1 +
 init/do_mounts_initrd.c       |   1 +
 security/apparmor/lsm.c       |   1 +
 security/apparmor/mount.c     |   1 +
 security/security.c           |  39 ++-
 security/selinux/hooks.c      | 799 ++++++++++++++++--------------------------
 security/smack/smack_lsm.c    | 359 ++++++++-----------
 security/tomoyo/mount.c       |   1 +
 28 files changed, 724 insertions(+), 1040 deletions(-)
 create mode 100644 include/uapi/linux/mount.h
