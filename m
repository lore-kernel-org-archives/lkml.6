Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeA3Vd3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:33:29 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:36398 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbeA3Vd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:33:28 -0500
Date: Tue, 30 Jan 2018 21:33:26 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [git pull] reducing kernel_recvmsg() use
Message-ID: <20180130213326.GD29051@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	kernel_recvmsg() is a set_fs()-using wrapper for
sock_recvmsg().  In all but one case that is not needed -
use of ITER_KVEC for ->msg_iter takes care of the data
and does not care about set_fs().  The only exception is
svc_udp_recvfrom() where we want cmsg to be store into
kernel object; everything else can just use sock_recvmsg()
and be done with that.

	A followup converting svc_udp_recvfrom() away
from set_fs() (and killing kernel_recvmsg() off) is *NOT*
in that one - I'd like to hear what netdev folks think
of the approach proposed in that followup.

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sock_recvmsg

for you to fetch changes up to bc4802736d8b17eddde52e00838c348770f67c19:

  tipc: switch to sock_recvmsg() (2017-12-02 20:38:10 -0500)

----------------------------------------------------------------
Al Viro (10):
      svc_recvfrom(): switch to sock_recvmsg()
      dlm: switch to sock_recvmsg()
      ncpfs: switch to sock_recvmsg()
      cfs2: switch to sock_recvmsg()
      lustre lnet_sock_read(): switch to sock_recvmsg()
      drbd: switch to sock_recvmsg()
      mISDN: switch to sock_recvmsg()
      ipvs: switch to sock_recvmsg()
      smc: switch to sock_recvmsg()
      tipc: switch to sock_recvmsg()

 drivers/block/drbd/drbd_main.c                |  8 +-------
 drivers/block/drbd/drbd_receiver.c            |  3 ++-
 drivers/isdn/mISDN/l1oip_core.c               | 22 +++++++++-------------
 drivers/staging/lustre/lnet/lnet/lib-socket.c | 24 +++++++++++-------------
 fs/dlm/lowcomms.c                             |  4 ++--
 fs/ncpfs/sock.c                               |  3 ++-
 fs/ocfs2/cluster/tcp.c                        |  3 ++-
 net/netfilter/ipvs/ip_vs_sync.c               |  9 +++------
 net/smc/smc_clc.c                             | 18 ++++++++++--------
 net/sunrpc/svcsock.c                          |  4 ++--
 net/tipc/server.c                             |  4 ++--
 11 files changed, 46 insertions(+), 56 deletions(-)
