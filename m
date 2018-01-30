Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbeA3Tmt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:42:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33622 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeA3Tmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:42:47 -0500
Date: Tue, 30 Jan 2018 19:42:45 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs_mkobj() and mqueue-related stuff
Message-ID: <20180130194245.GC29051@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	mqueue and bpf go through rather painful and similar contortions to
create objects in their dentry trees.  Provide a primitive for doing that
without abusing ->mknod(), switch bpf and mqueue to it.
	Another mqueue-related thing that has ended up in that branch is
on-demand creation of internal mount (based upon the work of Giuseppe Scrivano).

The following changes since commit ae64f9bd1d3621b5e60d7363bc20afb46aede215:

  Linux 4.15-rc2 (2017-12-03 11:01:47 -0500)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mqueue

for you to fetch changes up to 36735a6a2b5e042db1af956ce4bcc13f3ff99e21:

  mqueue: switch to on-demand creation of internal mount (2018-01-05 11:54:37 -0500)

----------------------------------------------------------------
Al Viro (9):
      new primitive: vfs_mkobj()
      bpf_obj_do_pin(): switch to vfs_mkobj(), quit abusing ->mknod()
      mqueue: switch to vfs_mkobj(), quit abusing ->d_fsdata
      move dentry_open() calls up into do_mq_open()
      mqueue: fold mq_attr_ok() into mqueue_get_inode()
      do_mq_open(): move all work prior to dentry_open() into a helper
      mqueue: clean prepare_open() up
      tidy do_mq_open() up a bit
      mqueue: switch to on-demand creation of internal mount

 fs/namei.c         |  21 +++++
 include/linux/fs.h |   4 +
 ipc/mqueue.c       | 241 ++++++++++++++++++++++++-----------------------------
 kernel/bpf/inode.c |  50 +++++------
 4 files changed, 158 insertions(+), 158 deletions(-)
