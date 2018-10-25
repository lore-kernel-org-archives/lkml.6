Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029FFECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFCC2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oDjnSX37"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFCC2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbeJYWvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729867AbeJYWvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:51:01 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 258CE20848;
        Thu, 25 Oct 2018 14:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477084;
        bh=n2jyVM/+ZAVpLW0cDURq9Dx9th9EYe377BFxCDewxP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oDjnSX372TxtUwky+hb/Kfvn+Gqr6JbbciVArDhdwybwUsAPFIDp6fKIJ9hStpC0w
         Dex6qRCAE6OCddVLhloKxU6xEePj/aivnO0Gtobk7WorWPrvpc73Pp5y1Qgdeiib3U
         eDlP9GYGIM1eKZ/J2Pc3+fG7To8oJiiWZtHdna3A=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Samant <ashish.samant@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 35/65] fuse: Dont call set_page_dirty_lock() for ITER_BVEC pages for async_dio
Date:   Thu, 25 Oct 2018 10:16:35 -0400
Message-Id: <20181025141705.213937-35-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Samant <ashish.samant@oracle.com>

[ Upstream commit 61c12b49e1c9c77d7a1bcc161de540d0fd21cf0c ]

Commit 8fba54aebbdf ("fuse: direct-io: don't dirty ITER_BVEC pages") fixes
the ITER_BVEC page deadlock for direct io in fuse by checking in
fuse_direct_io(), whether the page is a bvec page or not, before locking
it.  However, this check is missed when the "async_dio" mount option is
enabled.  In this case, set_page_dirty_lock() is called from the req->end
callback in request_end(), when the fuse thread is returning from userspace
to respond to the read request.  This will cause the same deadlock because
the bvec condition is not checked in this path.

Here is the stack of the deadlocked thread, while returning from userspace:

[13706.656686] INFO: task glusterfs:3006 blocked for more than 120 seconds.
[13706.657808] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
this message.
[13706.658788] glusterfs       D ffffffff816c80f0     0  3006      1
0x00000080
[13706.658797]  ffff8800d6713a58 0000000000000086 ffff8800d9ad7000
ffff8800d9ad5400
[13706.658799]  ffff88011ffd5cc0 ffff8800d6710008 ffff88011fd176c0
7fffffffffffffff
[13706.658801]  0000000000000002 ffffffff816c80f0 ffff8800d6713a78
ffffffff816c790e
[13706.658803] Call Trace:
[13706.658809]  [<ffffffff816c80f0>] ? bit_wait_io_timeout+0x80/0x80
[13706.658811]  [<ffffffff816c790e>] schedule+0x3e/0x90
[13706.658813]  [<ffffffff816ca7e5>] schedule_timeout+0x1b5/0x210
[13706.658816]  [<ffffffff81073ffb>] ? gup_pud_range+0x1db/0x1f0
[13706.658817]  [<ffffffff810668fe>] ? kvm_clock_read+0x1e/0x20
[13706.658819]  [<ffffffff81066909>] ? kvm_clock_get_cycles+0x9/0x10
[13706.658822]  [<ffffffff810f5792>] ? ktime_get+0x52/0xc0
[13706.658824]  [<ffffffff816c6f04>] io_schedule_timeout+0xa4/0x110
[13706.658826]  [<ffffffff816c8126>] bit_wait_io+0x36/0x50
[13706.658828]  [<ffffffff816c7d06>] __wait_on_bit_lock+0x76/0xb0
[13706.658831]  [<ffffffffa0545636>] ? lock_request+0x46/0x70 [fuse]
[13706.658834]  [<ffffffff8118800a>] __lock_page+0xaa/0xb0
[13706.658836]  [<ffffffff810c8500>] ? wake_atomic_t_function+0x40/0x40
[13706.658838]  [<ffffffff81194d08>] set_page_dirty_lock+0x58/0x60
[13706.658841]  [<ffffffffa054d968>] fuse_release_user_pages+0x58/0x70 [fuse]
[13706.658844]  [<ffffffffa0551430>] ? fuse_aio_complete+0x190/0x190 [fuse]
[13706.658847]  [<ffffffffa0551459>] fuse_aio_complete_req+0x29/0x90 [fuse]
[13706.658849]  [<ffffffffa05471e9>] request_end+0xd9/0x190 [fuse]
[13706.658852]  [<ffffffffa0549126>] fuse_dev_do_write+0x336/0x490 [fuse]
[13706.658854]  [<ffffffffa054963e>] fuse_dev_write+0x6e/0xa0 [fuse]
[13706.658857]  [<ffffffff812a9ef3>] ? security_file_permission+0x23/0x90
[13706.658859]  [<ffffffff81205300>] do_iter_readv_writev+0x60/0x90
[13706.658862]  [<ffffffffa05495d0>] ? fuse_dev_splice_write+0x350/0x350
[fuse]
[13706.658863]  [<ffffffff812062a1>] do_readv_writev+0x171/0x1f0
[13706.658866]  [<ffffffff810b3d00>] ? try_to_wake_up+0x210/0x210
[13706.658868]  [<ffffffff81206361>] vfs_writev+0x41/0x50
[13706.658870]  [<ffffffff81206496>] SyS_writev+0x56/0xf0
[13706.658872]  [<ffffffff810257a1>] ? syscall_trace_leave+0xf1/0x160
[13706.658874]  [<ffffffff816cbb2e>] system_call_fastpath+0x12/0x71

Fix this by making should_dirty a fuse_io_priv parameter that can be
checked in fuse_aio_complete_req().

Reported-by: Tiger Yang <tiger.yang@oracle.com>
Signed-off-by: Ashish Samant <ashish.samant@oracle.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/file.c   | 6 +++---
 fs/fuse/fuse_i.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8577f3ba6dc6..7014318f6d18 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -625,7 +625,7 @@ static void fuse_aio_complete_req(struct fuse_conn *fc, struct fuse_req *req)
 	struct fuse_io_priv *io = req->io;
 	ssize_t pos = -1;
 
-	fuse_release_user_pages(req, !io->write);
+	fuse_release_user_pages(req, io->should_dirty);
 
 	if (io->write) {
 		if (req->misc.write.in.size != req->misc.write.out.size)
@@ -1333,7 +1333,6 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 		       loff_t *ppos, int flags)
 {
 	int write = flags & FUSE_DIO_WRITE;
-	bool should_dirty = !write && iter_is_iovec(iter);
 	int cuse = flags & FUSE_DIO_CUSE;
 	struct file *file = io->file;
 	struct inode *inode = file->f_mapping->host;
@@ -1362,6 +1361,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			mutex_unlock(&inode->i_mutex);
 	}
 
+	io->should_dirty = !write && iter_is_iovec(iter);
 	while (count) {
 		size_t nres;
 		fl_owner_t owner = current->files;
@@ -1378,7 +1378,7 @@ ssize_t fuse_direct_io(struct fuse_io_priv *io, struct iov_iter *iter,
 			nres = fuse_send_read(req, io, pos, nbytes, owner);
 
 		if (!io->async)
-			fuse_release_user_pages(req, should_dirty);
+			fuse_release_user_pages(req, io->should_dirty);
 		if (req->out.h.error) {
 			if (!res)
 				res = req->out.h.error;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7aafe9acc6c0..c6eb35a95fcc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -252,6 +252,7 @@ struct fuse_io_priv {
 	size_t size;
 	__u64 offset;
 	bool write;
+	bool should_dirty;
 	int err;
 	struct kiocb *iocb;
 	struct file *file;
-- 
2.17.1

