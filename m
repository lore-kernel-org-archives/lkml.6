Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034052AbeE1KZq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033745AbeE1KZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:25:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 215/268] usb: gadget: ffs: Execute copy_to_user() with USER_DS set
Date: Mon, 28 May 2018 12:03:09 +0200
Message-Id: <20180528100226.608230371@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lars-Peter Clausen <lars@metafoo.de>

[ Upstream commit 4058ebf33cb0be88ca516f968eda24ab7b6b93e4 ]

When using a AIO read() operation on the function FS gadget driver a URB is
submitted asynchronously and on URB completion the received data is copied
to the userspace buffer associated with the read operation.

This is done from a kernel worker thread invoking copy_to_user() (through
copy_to_iter()). And while the user space process memory is made available
to the kernel thread using use_mm(), some architecture require in addition
to this that the operation runs with USER_DS set. Otherwise the userspace
memory access will fail.

For example on ARM64 with Privileged Access Never (PAN) and User Access
Override (UAO) enabled the following crash occurs.

	Internal error: Accessing user space memory with fs=KERNEL_DS: 9600004f [#1] SMP
	Modules linked in:
	CPU: 2 PID: 1636 Comm: kworker/2:1 Not tainted 4.9.0-04081-g8ab2dfb-dirty #487
	Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
	Workqueue: events ffs_user_copy_worker
	task: ffffffc87afc8080 task.stack: ffffffc87a00c000
	PC is at __arch_copy_to_user+0x190/0x220
	LR is at copy_to_iter+0x78/0x3c8
	[...]
	[<ffffff800847b790>] __arch_copy_to_user+0x190/0x220
	[<ffffff80086f25d8>] ffs_user_copy_worker+0x70/0x130
	[<ffffff80080b8c64>] process_one_work+0x1dc/0x460
	[<ffffff80080b8f38>] worker_thread+0x50/0x4b0
	[<ffffff80080bf5a0>] kthread+0xd8/0xf0
	[<ffffff8008083680>] ret_from_fork+0x10/0x50

Address this by placing a set_fs(USER_DS) before of the copy operation
and revert it again once the copy operation has finished.

This patch is analogous to commit d7ffde35e31a ("vhost: use USER_DS in
vhost_worker thread") which addresses the same underlying issue.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_fs.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -649,11 +649,15 @@ static void ffs_user_copy_worker(struct
 	bool kiocb_has_eventfd = io_data->kiocb->ki_flags & IOCB_EVENTFD;
 
 	if (io_data->read && ret > 0) {
+		mm_segment_t oldfs = get_fs();
+
+		set_fs(USER_DS);
 		use_mm(io_data->mm);
 		ret = copy_to_iter(io_data->buf, ret, &io_data->data);
 		if (ret != io_data->req->actual && iov_iter_count(&io_data->data))
 			ret = -EFAULT;
 		unuse_mm(io_data->mm);
+		set_fs(oldfs);
 	}
 
 	io_data->kiocb->ki_complete(io_data->kiocb, ret, ret);
