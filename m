Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EEEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6FF20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298867;
	bh=maUVLeTypjDfzMOiAlPZXzggqyDrPnXRNeDmGNIvMRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I9bKcucEnQkukpu8UFs/PLySYbn08rV8Cr971e3OmyG+kCoD0dyAow3o8oEKhgxkb
	 UHpuVC88OuG2gplJVxTE2SWkJzHLs8i61bpxGtT90M7bb0HAFC6/w4eh1uIT54o81W
	 A8TvSyCNwjgHC6KqwM0hay7UX+e7n/jVJIkQ5PsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbeLTJYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:24:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731750AbeLTJYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:24:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9BFF20656;
        Thu, 20 Dec 2018 09:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297845;
        bh=maUVLeTypjDfzMOiAlPZXzggqyDrPnXRNeDmGNIvMRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lxhw3m8EzMCVcnVd2d5UG0h0yREK7o/SIOV0usXJRs9+FM1fD9rYBUHO5CJ4ckx4V
         R+hIhsiQBYkHVV4zJccSVbObHz08HlOvQbW/JEz1SwTl5TfTxF8kKKLa9TCz4xec9i
         DyAizw5NvK5X+6loCygST/vCrkIZmTCVNnRYw4ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Calum Mackay <calum.mackay@oracle.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 38/61] nfs: dont dirty kernel pages read by direct-io
Date:   Thu, 20 Dec 2018 10:18:38 +0100
Message-Id: <20181220085845.294490487@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085843.743900603@linuxfoundation.org>
References: <20181220085843.743900603@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ad3cba223ac02dc769c3bbe88efe277bbb457566 ]

When we use direct_IO with an NFS backing store, we can trigger a
WARNING in __set_page_dirty(), as below, since we're dirtying the page
unnecessarily in nfs_direct_read_completion().

To fix, replicate the logic in commit 53cbf3b157a0 ("fs: direct-io:
don't dirtying pages for ITER_BVEC/ITER_KVEC direct read").

Other filesystems that implement direct_IO handle this; most use
blockdev_direct_IO(). ceph and cifs have similar logic.

mount 127.0.0.1:/export /nfs
dd if=/dev/zero of=/nfs/image bs=1M count=200
losetup --direct-io=on -f /nfs/image
mkfs.btrfs /dev/loop0
mount -t btrfs /dev/loop0 /mnt/

kernel: WARNING: CPU: 0 PID: 8067 at fs/buffer.c:580 __set_page_dirty+0xaf/0xd0
kernel: Modules linked in: loop(E) nfsv3(E) rpcsec_gss_krb5(E) nfsv4(E) dns_resolver(E) nfs(E) fscache(E) nfsd(E) auth_rpcgss(E) nfs_acl(E) lockd(E) grace(E) fuse(E) tun(E) ip6t_rpfilter(E) ipt_REJECT(E) nf_
kernel:  snd_seq(E) snd_seq_device(E) snd_pcm(E) video(E) snd_timer(E) snd(E) soundcore(E) ip_tables(E) xfs(E) libcrc32c(E) sd_mod(E) sr_mod(E) cdrom(E) ata_generic(E) pata_acpi(E) crc32c_intel(E) ahci(E) li
kernel: CPU: 0 PID: 8067 Comm: kworker/0:2 Tainted: G            E     4.20.0-rc1.master.20181111.ol7.x86_64 #1
kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
kernel: Workqueue: nfsiod rpc_async_release [sunrpc]
kernel: RIP: 0010:__set_page_dirty+0xaf/0xd0
kernel: Code: c3 48 8b 02 f6 c4 04 74 d4 48 89 df e8 ba 05 f7 ff 48 89 c6 eb cb 48 8b 43 08 a8 01 75 1f 48 89 d8 48 8b 00 a8 04 74 02 eb 87 <0f> 0b eb 83 48 83 e8 01 eb 9f 48 83 ea 01 0f 1f 00 eb 8b 48 83 e8
kernel: RSP: 0000:ffffc1c8825b7d78 EFLAGS: 00013046
kernel: RAX: 000fffffc0020089 RBX: fffff2b603308b80 RCX: 0000000000000001
kernel: RDX: 0000000000000001 RSI: ffff9d11478115c8 RDI: ffff9d11478115d0
kernel: RBP: ffffc1c8825b7da0 R08: 0000646f6973666e R09: 8080808080808080
kernel: R10: 0000000000000001 R11: 0000000000000000 R12: ffff9d11478115d0
kernel: R13: ffff9d11478115c8 R14: 0000000000003246 R15: 0000000000000001
kernel: FS:  0000000000000000(0000) GS:ffff9d115ba00000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007f408686f640 CR3: 0000000104d8e004 CR4: 00000000000606f0
kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
kernel: DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
kernel: Call Trace:
kernel:  __set_page_dirty_buffers+0xb6/0x110
kernel:  set_page_dirty+0x52/0xb0
kernel:  nfs_direct_read_completion+0xc4/0x120 [nfs]
kernel:  nfs_pgio_release+0x10/0x20 [nfs]
kernel:  rpc_free_task+0x30/0x70 [sunrpc]
kernel:  rpc_async_release+0x12/0x20 [sunrpc]
kernel:  process_one_work+0x174/0x390
kernel:  worker_thread+0x4f/0x3e0
kernel:  kthread+0x102/0x140
kernel:  ? drain_workqueue+0x130/0x130
kernel:  ? kthread_stop+0x110/0x110
kernel:  ret_from_fork+0x35/0x40
kernel: ---[ end trace 01341980905412c9 ]---

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>

[forward-ported to v4.20]
Signed-off-by: Calum Mackay <calum.mackay@oracle.com>
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/direct.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 1ab91124a93e..53f0012ace42 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -98,8 +98,11 @@ struct nfs_direct_req {
 	struct pnfs_ds_commit_info ds_cinfo;	/* Storage for cinfo */
 	struct work_struct	work;
 	int			flags;
+	/* for write */
 #define NFS_ODIRECT_DO_COMMIT		(1)	/* an unstable reply was received */
 #define NFS_ODIRECT_RESCHED_WRITES	(2)	/* write verification failed */
+	/* for read */
+#define NFS_ODIRECT_SHOULD_DIRTY	(3)	/* dirty user-space page after read */
 	struct nfs_writeverf	verf;		/* unstable write verifier */
 };
 
@@ -422,7 +425,8 @@ static void nfs_direct_read_completion(struct nfs_pgio_header *hdr)
 		struct nfs_page *req = nfs_list_entry(hdr->pages.next);
 		struct page *page = req->wb_page;
 
-		if (!PageCompound(page) && bytes < hdr->good_bytes)
+		if (!PageCompound(page) && bytes < hdr->good_bytes &&
+		    (dreq->flags == NFS_ODIRECT_SHOULD_DIRTY))
 			set_page_dirty(page);
 		bytes += req->wb_bytes;
 		nfs_list_remove_request(req);
@@ -597,6 +601,9 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter)
 	if (!is_sync_kiocb(iocb))
 		dreq->iocb = iocb;
 
+	if (iter_is_iovec(iter))
+		dreq->flags = NFS_ODIRECT_SHOULD_DIRTY;
+
 	nfs_start_io_direct(inode);
 
 	NFS_I(inode)->read_io += count;
-- 
2.19.1



