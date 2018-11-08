Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A3CECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BED20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgkXCpRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BED20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbeKIHhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:55330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729563AbeKIHhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:19 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB92420892;
        Thu,  8 Nov 2018 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714390;
        bh=PwD1xsoy22ne5GdIczNyg1BvsVLkdhAB85Fe20Ndag8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgkXCpRfZUdSXM8y2VpLrK14dLM71vw7Ao6beW45Ar2OglhwxQr37IY/2+SI0ydXY
         QXJktgv+oPGEq5sRj3XbBh1j6FqapIpxsXEMs5sU6kMLoV/pCmtlwTa5f2EgZ36hoQ
         cr4JLtAFnx8W+F/UI3EH+s2UvRxcS8MKOvV39spE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tiger Yang <tiger.yang@oracle.com>,
        Ashish Samant <ashish.samant@oracle.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 053/114] fuse: Dont call set_page_dirty_lock() for ITER_BVEC pages for async_dio
Date:   Thu,  8 Nov 2018 13:51:08 -0800
Message-Id: <20181108215105.930400314@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



