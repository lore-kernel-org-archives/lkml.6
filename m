Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1DDECDE43
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A65D205F4
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 01:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A65D205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeJTJTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 05:19:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45364 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbeJTJTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 05:19:12 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B25A311533;
        Sat, 20 Oct 2018 01:10:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-250.rdu2.redhat.com [10.10.120.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC1B0100195E;
        Sat, 20 Oct 2018 01:10:38 +0000 (UTC)
Subject: [PATCH 00/24] AFS development
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 20 Oct 2018 02:10:37 +0100
Message-ID: <153999783767.866.7957078562330181644.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Sat, 20 Oct 2018 01:10:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of development patches for AFS if you could pull it for the
upcoming merge window.  Its main features are:

 (1) Provide wrapper functions for accessing iov iterators, renumber the
     iterator types to be more amenable to switching on and provide a new read
     discard iterator type (ITER_DISCARD).

 (2) Use iov iterators more directly in AFS unmarshalling routines.

 (3) Support for retrieving DNS information where the VL server address list
     is partitioned by server.

 (4) Implement VL server rotation and improve both this and FS server
     rotation.

 (5) Add support for the YFS variant of the AFS server.

 (6) When first attempting to use a server or a list of servers, plumb all the
     addresses simultaneously to try and determine the best route.

The patches are tagged here:

	git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
	afs-next-20181020

and can also be found on the following branch:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

David
---
David Howells (24):
      iov_iter: Separate type from direction and use accessor functions
      iov_iter: Renumber the ITER_* constants in uio.h
      iov_iter: Add I/O discard iterator
      afs: Better tracing of protocol errors
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Improve FS server rotation error handling
      afs: Implement VL server rotation
      afs: Fix TTL on VL server and address lists
      afs: Handle EIO from delivery function
      afs: Add a couple of tracepoints to log I/O errors
      afs: Don't invoke the server to read data beyond EOF
      afs: Increase to 64-bit volume ID and 96-bit vnode ID for YFS
      afs: Commit the status on a new file/dir/symlink
      afs: Remove callback details from afs_callback_break struct
      afs: Implement the YFS cache manager service
      afs: Fix FS.FetchStatus delivery from updating wrong vnode
      afs: Calc callback expiry in op reply delivery
      afs: Get the target vnode in afs_rmdir() and get a callback on it
      afs: Expand data structure fields to support YFS
      afs: Implement YFS support in the fs client
      afs: Allow dumping of server cursor on operation failure
      afs: Eliminate the address pointer from the address list cursor
      afs: Fix callback handling
      afs: Probe multiple fileservers simultaneously


 block/bio.c                              |    2 
 drivers/block/drbd/drbd_main.c           |    2 
 drivers/block/drbd/drbd_receiver.c       |    2 
 drivers/block/loop.c                     |    9 
 drivers/block/nbd.c                      |   12 
 drivers/fsi/fsi-sbefifo.c                |    4 
 drivers/isdn/mISDN/l1oip_core.c          |    3 
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |    6 
 drivers/nvme/target/io-cmd-file.c        |    2 
 drivers/target/iscsi/iscsi_target_util.c |    6 
 drivers/target/target_core_file.c        |    6 
 drivers/usb/usbip/usbip_common.c         |    2 
 drivers/xen/pvcalls-back.c               |    8 
 fs/9p/vfs_addr.c                         |    4 
 fs/9p/vfs_dir.c                          |    2 
 fs/9p/xattr.c                            |    4 
 fs/afs/Kconfig                           |   12 
 fs/afs/Makefile                          |    7 
 fs/afs/addr_list.c                       |  209 ++-
 fs/afs/afs.h                             |   50 -
 fs/afs/cache.c                           |    2 
 fs/afs/callback.c                        |   17 
 fs/afs/cell.c                            |   65 +
 fs/afs/cmservice.c                       |  287 +++-
 fs/afs/dir.c                             |   75 +
 fs/afs/dynroot.c                         |    4 
 fs/afs/file.c                            |    8 
 fs/afs/flock.c                           |   22 
 fs/afs/fs_probe.c                        |  270 ++++
 fs/afs/fsclient.c                        |  583 ++++----
 fs/afs/inode.c                           |   37 -
 fs/afs/internal.h                        |  322 ++++
 fs/afs/mntpt.c                           |    5 
 fs/afs/proc.c                            |  110 +-
 fs/afs/protocol_yfs.h                    |  163 ++
 fs/afs/rotate.c                          |  302 +++-
 fs/afs/rxrpc.c                           |  115 +-
 fs/afs/security.c                        |   13 
 fs/afs/server.c                          |  145 --
 fs/afs/server_list.c                     |    6 
 fs/afs/super.c                           |    5 
 fs/afs/vl_list.c                         |  340 +++++
 fs/afs/vl_probe.c                        |  273 ++++
 fs/afs/vl_rotate.c                       |  355 +++++
 fs/afs/vlclient.c                        |  195 +--
 fs/afs/volume.c                          |   56 -
 fs/afs/write.c                           |   30 
 fs/afs/xattr.c                           |    2 
 fs/afs/yfsclient.c                       | 2184 ++++++++++++++++++++++++++++++
 fs/block_dev.c                           |    2 
 fs/ceph/file.c                           |    7 
 fs/cifs/connect.c                        |    4 
 fs/cifs/file.c                           |    4 
 fs/cifs/misc.c                           |    4 
 fs/cifs/smb2ops.c                        |    4 
 fs/cifs/smbdirect.c                      |   17 
 fs/cifs/transport.c                      |    8 
 fs/direct-io.c                           |    2 
 fs/dlm/lowcomms.c                        |    2 
 fs/fuse/file.c                           |    2 
 fs/iomap.c                               |    2 
 fs/nfsd/vfs.c                            |    4 
 fs/ocfs2/cluster/tcp.c                   |    2 
 fs/orangefs/inode.c                      |    2 
 fs/splice.c                              |    7 
 include/linux/uio.h                      |   74 +
 include/trace/events/afs.h               |  213 +++
 lib/iov_iter.c                           |  301 +++-
 mm/filemap.c                             |    2 
 mm/page_io.c                             |    2 
 net/9p/client.c                          |    2 
 net/9p/trans_virtio.c                    |    2 
 net/bluetooth/6lowpan.c                  |    2 
 net/bluetooth/a2mp.c                     |    2 
 net/bluetooth/smp.c                      |    2 
 net/ceph/messenger.c                     |    6 
 net/netfilter/ipvs/ip_vs_sync.c          |    2 
 net/smc/smc_clc.c                        |    4 
 net/socket.c                             |    6 
 net/sunrpc/svcsock.c                     |    2 
 net/tipc/topsrv.c                        |    2 
 net/tls/tls_device.c                     |    4 
 net/tls/tls_sw.c                         |    4 
 83 files changed, 5761 insertions(+), 1287 deletions(-)
 create mode 100644 fs/afs/fs_probe.c
 create mode 100644 fs/afs/protocol_yfs.h
 create mode 100644 fs/afs/vl_list.c
 create mode 100644 fs/afs/vl_probe.c
 create mode 100644 fs/afs/vl_rotate.c
 create mode 100644 fs/afs/yfsclient.c

