Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451ABECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97F820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97F820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbeGWQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:27:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387831AbeGWQ12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 83443401EF0B;
        Mon, 23 Jul 2018 15:25:43 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-116.rdu2.redhat.com [10.10.120.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 849112156897;
        Mon, 23 Jul 2018 15:25:42 +0000 (UTC)
Subject: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        linux-kernel@vger.kernel.org, raven@themaw.net,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Date:   Mon, 23 Jul 2018 16:25:42 +0100
Message-ID: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 23 Jul 2018 15:25:43 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 23 Jul 2018 15:25:43 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of patches to add a general variable-length notification queue
concept and to add sources of events for:

 (1) Mount topology and reconfiguration change events.

 (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).

 (3) Key/keyring changes events

One of the reasons for this is so that we can remove the issue of processes
having to repeatedly and regularly scan /proc/mounts, which has proven to be a
system performance problem.


Design decisions:

 (1) A misc chardev is used to create and open a ring buffer:

	fd = open("/dev/watch_queue", O_RDWR);

     which is then configured and mmap'd into userspace:

	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
		   MAP_SHARED, fd, 0);

     The fd cannot be read or written (though there is a facility to use write
     to inject records for debugging) and userspace just pulls data directly
     out of the buffer.

 (2) The ring index pointers are stored inside the ring and are thus
     accessible to userspace.  Userspace should only update the tail pointer
     and never the head pointer or risk breaking the buffer.  The kernel
     checks that the pointers appear valid before trying to use them.  A
     'skip' record is maintained around the pointers.

 (3) poll() can be used to wait for data to appear in the buffer.

 (4) Records in the buffer are binary, typed and have a length so that they
     can be of varying size.

     This means that multiple heterogeneous sources can share a common
     buffer.  Tags may be specified when a watchpoint is created to help
     distinguish the sources.

 (5) The queue is reusable as there are 16 million types available, of which
     I've used 4, so there is scope for others to be used.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Each time the buffer is opened, a new buffer is created - this means that
     there's no interference between watchers.

 (8) When recording a notification, the kernel will not sleep, but will rather
     mark a queue as overrun if there's insufficient space, thereby avoiding
     userspace causing the kernel to hang.

 (9) The 'watchpoint' should be specific where possible, meaning that you
     specify the object that you want to watch.

(10) The buffer is created and then watchpoints are attached to it, using one
     of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);

     where in all three cases, fd indicates the queue and the number after is
     a tag between 0 and 255.

(11) The watch must be removed if either the watch buffer is destroyed or the
     watched object is destroyed.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling namespaces
     tricky.  Further, dmesg might not exist or might be inaccessible inside a
     container.

 (3) Letting users see events they shouldn't be able to see.


Further things that need to be done:

 (1) fsinfo() syscall needs to find superblocks by ID as well as by path so
     that it can query a superblock for information without the need to try
     and work out how to reach it - if the calling process even can.

 (2) A mount_info() syscall is needed that can enumerate all the children of a
     mount.  This is necessary because mountpoints can hide each other by
     stacking, so paths are not unique keys.  This will require the ability to
     look up a mount by ID.  This avoids the need to parse /proc/mounts.

 (3) A keyctl call is needed to allow a watch on a keyring to be extended to
     "children" of that keyring, such that the watch is removed from the child
     if it is unlinked from the keyring.

 (4) A global superblock event queue maybe?

 (5) Propagating watches to child superblock over automounts?


The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=notifications

David
---
David Howells (5):
      General notification queue with user mmap()'able ring buffer
      KEYS: Add a notification facility
      vfs: Add a mount-notification facility
      vfs: Add superblock notifications
      Add sample notification program


 Documentation/security/keys/core.rst   |   59 ++
 Documentation/watch_queue.rst          |  305 ++++++++++++
 arch/x86/entry/syscalls/syscall_32.tbl |    2 
 arch/x86/entry/syscalls/syscall_64.tbl |    2 
 drivers/misc/Kconfig                   |    9 
 drivers/misc/Makefile                  |    1 
 drivers/misc/watch_queue.c             |  835 ++++++++++++++++++++++++++++++++
 fs/Kconfig                             |   21 +
 fs/Makefile                            |    1 
 fs/fs_context.c                        |    1 
 fs/mount.h                             |   26 +
 fs/mount_notify.c                      |  178 +++++++
 fs/namespace.c                         |   18 +
 fs/super.c                             |  116 ++++
 include/linux/dcache.h                 |    1 
 include/linux/fs.h                     |   77 +++
 include/linux/key.h                    |    4 
 include/linux/syscalls.h               |    4 
 include/linux/watch_queue.h            |   87 +++
 include/uapi/linux/keyctl.h            |    1 
 include/uapi/linux/watch_queue.h       |  156 ++++++
 kernel/sys_ni.c                        |    6 
 mm/interval_tree.c                     |    2 
 mm/memory.c                            |    1 
 samples/Kconfig                        |    6 
 samples/Makefile                       |    2 
 samples/watch_queue/Makefile           |    9 
 samples/watch_queue/watch_test.c       |  232 +++++++++
 security/keys/Kconfig                  |   10 
 security/keys/compat.c                 |    3 
 security/keys/gc.c                     |    5 
 security/keys/internal.h               |   29 +
 security/keys/key.c                    |   37 +
 security/keys/keyctl.c                 |   90 +++
 security/keys/keyring.c                |   17 -
 security/keys/request_key.c            |    4 
 36 files changed, 2332 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/watch_queue.rst
 create mode 100644 drivers/misc/watch_queue.c
 create mode 100644 fs/mount_notify.c
 create mode 100644 include/linux/watch_queue.h
 create mode 100644 include/uapi/linux/watch_queue.h
 create mode 100644 samples/watch_queue/Makefile
 create mode 100644 samples/watch_queue/watch_test.c

