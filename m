Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44585C46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E624C219E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 13:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E624C219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeHFPZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 11:25:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46442 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729714AbeHFPZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 11:25:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB27140201A0;
        Mon,  6 Aug 2018 13:16:39 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-78.rdu2.redhat.com [10.10.120.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05486178BC;
        Mon,  6 Aug 2018 13:16:38 +0000 (UTC)
Subject: [PATCH 00/10] iov_iter: Add new iters and use with AFS
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        matthew@wil.cx
Date:   Mon, 06 Aug 2018 14:16:38 +0100
Message-ID: <153356139813.1195.8360582774280288285.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 13:16:40 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 06 Aug 2018 13:16:40 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dhowells@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Al,

Here's a set of patches that adds two new iov_iter types and then makes AFS
use them to do I/O.  The iov_iter changes are:

 (1) Separate the type from the direction in the iov_iter struct and
     provide accessor functions to wrap type checking.

 (2) Renumber the type constants to be contiguous small unsigned integers,
     starting from 0 and then use switch-statements rather than if-else
     chains using bit-testing.

     Note that the compiler can optimise this better by using CMP rather
     than AND/TEST, say, as comparing integers requires fewer CMP
     instructions or can use jump tables.

 (3) Change count and iov_offset from size_t to loff_t.  This allows
     iov_offset to be then used as a byte offset with ITER_MAPPING and
     allows 4GiB and larger reads and writes to be proposed.

     This makes no difference on a 64-bit system, but does make a 32-bit
     compilation a bit larger.  Possibly only iov_offset really needs to be
     made loff_t and size >= 4GiB should just be disallowed on 32-bit.

 (4) Add an ITER_MAPPING iterator type.  This provides an iterator that
     directly accesses an address_space, and assumes that the target pages
     are in some way locked (eg. PG_lock or PG_writeback).

 (5) Add an ITER_DISCARD iterator type.  This provides an iterator that
     simply discards anything written to it.  It cannot be used as a data
     source.

The afs changes are:

 (1) Use a single ITER_MAPPING iterator to cover all the data read by a
     single FetchData RPC op.  This involves switching the operation to an
     ITER_KVEC iterator to read the status record that's transmitted after
     the data.

 (2) Use an ITER_DISCARD iterator to discard any extra data the server may
     have included that we don't want.

 (3) Use a single ITER_MAPPING iterator to cover all the data written by a
     single StoreData RPC op.

 (4) Add synchronous O_DIRECT read support.

The patches can be found here also:

	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h=afs-next

David
---
David Howells (10):
      iov_iter: Separate type from direction and use accessor functions
      iov_iter: Renumber the ITER_* constants in uio.h
      iov_iter: Make count and iov_offset loff_t not size_t
      iov_iter: Add mapping and discard iterator types
      afs: Better tracing of protocol errors
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Use ITER_MAPPING for writing
      afs: Add O_DIRECT read support
      afs: Add a couple of tracepoints to log I/O errors
      afs: Don't invoke the server to read data beyond EOF


 block/bio.c                              |    2 
 drivers/block/drbd/drbd_main.c           |    2 
 drivers/block/drbd/drbd_receiver.c       |    2 
 drivers/block/loop.c                     |    9 
 drivers/block/nbd.c                      |   12 -
 drivers/isdn/mISDN/l1oip_core.c          |    3 
 drivers/misc/vmw_vmci/vmci_queue_pair.c  |    6 
 drivers/nvme/target/io-cmd-file.c        |    2 
 drivers/target/iscsi/iscsi_target_util.c |    6 
 drivers/target/target_core_file.c        |    6 
 drivers/usb/usbip/usbip_common.c         |    2 
 drivers/xen/pvcalls-back.c               |    8 
 fs/9p/vfs_addr.c                         |    4 
 fs/9p/vfs_dir.c                          |    2 
 fs/9p/vfs_file.c                         |    2 
 fs/9p/xattr.c                            |    4 
 fs/afs/cmservice.c                       |   56 +--
 fs/afs/dir.c                             |  210 ++++++++---
 fs/afs/file.c                            |  263 ++++++++++----
 fs/afs/fsclient.c                        |  409 ++++++++-------------
 fs/afs/inode.c                           |    2 
 fs/afs/internal.h                        |   81 +++-
 fs/afs/mntpt.c                           |    2 
 fs/afs/rxrpc.c                           |  156 ++------
 fs/afs/server.c                          |    4 
 fs/afs/vlclient.c                        |  134 +++----
 fs/afs/volume.c                          |    2 
 fs/afs/write.c                           |  112 ++++--
 fs/block_dev.c                           |    2 
 fs/btrfs/file.c                          |    7 
 fs/ceph/file.c                           |    7 
 fs/cifs/connect.c                        |    4 
 fs/cifs/file.c                           |    4 
 fs/cifs/misc.c                           |    4 
 fs/cifs/smb2ops.c                        |    4 
 fs/cifs/smbdirect.c                      |   17 +
 fs/cifs/transport.c                      |    8 
 fs/direct-io.c                           |    2 
 fs/dlm/lowcomms.c                        |    2 
 fs/fuse/file.c                           |    2 
 fs/iomap.c                               |    2 
 fs/nfs/direct.c                          |    2 
 fs/nfs/file.c                            |    4 
 fs/nfsd/vfs.c                            |    4 
 fs/ocfs2/cluster/tcp.c                   |    2 
 fs/orangefs/inode.c                      |    2 
 fs/splice.c                              |    7 
 include/linux/fscache.h                  |   31 ++
 include/linux/uio.h                      |   71 ++--
 include/trace/events/afs.h               |  202 ++++++++---
 lib/iov_iter.c                           |  572 ++++++++++++++++++++++++------
 mm/filemap.c                             |    2 
 mm/page_io.c                             |    2 
 net/9p/client.c                          |    4 
 net/9p/trans_virtio.c                    |    2 
 net/bluetooth/6lowpan.c                  |    2 
 net/bluetooth/a2mp.c                     |    2 
 net/bluetooth/smp.c                      |    2 
 net/ceph/messenger.c                     |    6 
 net/netfilter/ipvs/ip_vs_sync.c          |    2 
 net/rxrpc/recvmsg.c                      |    4 
 net/smc/smc_clc.c                        |    4 
 net/socket.c                             |    6 
 net/sunrpc/svcsock.c                     |    2 
 net/tipc/topsrv.c                        |    2 
 net/tls/tls_device.c                     |    4 
 net/tls/tls_sw.c                         |    4 
 67 files changed, 1555 insertions(+), 960 deletions(-)

