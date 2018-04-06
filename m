Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49uoss5+jaxAkg2QNNZEuFzqHHcXrgv827Ci6rAuZ2YUBEi9O5NnQa9EgR9A56jI8nEw2fg
ARC-Seal: i=1; a=rsa-sha256; t=1523021886; cv=none;
        d=google.com; s=arc-20160816;
        b=Z05ji2UZAMpjETiXE4McG1ug7dBM0Cxa0NnjhCPlv6uNcl7XyGGhVST8eW61FBuQQV
         bYs2qS/AkSnXJaD57NvjjsPi6lM7xe2MeCRzwvvufJ1uHl1TfWiXb/G/8qTu7In53TY8
         8Ebwq9GES0R6QKIFOAXsE8bfOG0YrLEhap17RnhKm95KWyXh5VquqFPpE4emcyCVBAo+
         3dqMq42O/h8W93/bWlrKgdWso6CrPMac0X9BkPGgB5mlUOBTO0OdZkgYK27BAPuPEpYS
         oIFm7DziB0v4IZmarH7CjKjjcmUD4u8VnOsObvI1DZsKV3xxh1QQybcO0YotrIeVK4kV
         EUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+JhdQYC/im6h1l1Jt44L0vmyOBPzf+zwdK+dYLT7sAs=;
        b=g+d1K73lwkwTdAV/znLd9fHBmEHY99DVsPZ2ZkS75a5KRpCqMtNEko6LI/MFf8jbjw
         m6k/3qCHcqfDtwKUCYQaCggpRkW8fkZWHN+7okpWTWZUjh0KlBFQWBLrFfU72mnBU9q2
         cpsFd3aNBbuh7eM05XkDizB9H821fme11Ot7wXnsasAuuqCI/UIj5xPpTWNApCG5t9qr
         /uCeRQOk2O4pq4sC/UdSYY269Uof/OpCZDjGoBJC0qSUnKbr9v2FI1/DRKkeZEWSatZ+
         /vrFyx4CgsCCQzlCKR2ab8EM/hDzFkNrna4fASWt77JDRa67dLB/8cTtUAKBlntRfDxm
         qY8A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 22/67] RDMA/rdma_cm: Fix use after free race with process_one_req
Date: Fri,  6 Apr 2018 15:23:52 +0200
Message-Id: <20180406084344.328165263@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084341.225558262@linuxfoundation.org>
References: <20180406084341.225558262@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597004197547888637?=
X-GMAIL-MSGID: =?utf-8?q?1597004197547888637?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

commit 9137108cc3d64ade13e753108ec611a0daed16a0 upstream.

process_one_req() can race with rdma_addr_cancel():

           CPU0                                 CPU1
           ====                                 ====
 process_one_work()
  debug_work_deactivate(work);
  process_one_req()
                                        rdma_addr_cancel()
	                                  mutex_lock(&lock);
 			    	           set_timeout(&req->work,..);
                                              __queue_work()
				   	       debug_work_activate(work);
	                                  mutex_unlock(&lock);

   mutex_lock(&lock);
[..]
	list_del(&req->list);
   mutex_unlock(&lock);
[..]

   // ODEBUG explodes since the work is still queued.
   kfree(req);

Causing ODEBUG to detect the use after free:

ODEBUG: free active (active state 0) object type: work_struct hint: process_one_req+0x0/0x6c0 include/net/dst.h:165
WARNING: CPU: 0 PID: 79 at lib/debugobjects.c:291 debug_print_object+0x166/0x220 lib/debugobjects.c:288
kvm: emulating exchange as write
Kernel panic - not syncing: panic_on_warn set ...

CPU: 0 PID: 79 Comm: kworker/u4:3 Not tainted 4.16.0-rc6+ #361
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: ib_addr process_one_req
Call Trace:
 __dump_stack lib/dump_stack.c:17 [inline]
 dump_stack+0x194/0x24d lib/dump_stack.c:53
 panic+0x1e4/0x41c kernel/panic.c:183
 __warn+0x1dc/0x200 kernel/panic.c:547
 report_bug+0x1f4/0x2b0 lib/bug.c:186
 fixup_bug.part.11+0x37/0x80 arch/x86/kernel/traps.c:178
 fixup_bug arch/x86/kernel/traps.c:247 [inline]
 do_error_trap+0x2d7/0x3e0 arch/x86/kernel/traps.c:296
 do_invalid_op+0x1b/0x20 arch/x86/kernel/traps.c:315
 invalid_op+0x1b/0x40 arch/x86/entry/entry_64.S:986
RIP: 0010:debug_print_object+0x166/0x220 lib/debugobjects.c:288
RSP: 0000:ffff8801d966f210 EFLAGS: 00010086
RAX: dffffc0000000008 RBX: 0000000000000003 RCX: ffffffff815acd6e
RDX: 0000000000000000 RSI: 1ffff1003b2cddf2 RDI: 0000000000000000
RBP: ffff8801d966f250 R08: 0000000000000000 R09: 1ffff1003b2cddc8
R10: ffffed003b2cde71 R11: ffffffff86f39a98 R12: 0000000000000001
R13: ffffffff86f15540 R14: ffffffff86408700 R15: ffffffff8147c0a0
 __debug_check_no_obj_freed lib/debugobjects.c:745 [inline]
 debug_check_no_obj_freed+0x662/0xf1f lib/debugobjects.c:774
 kfree+0xc7/0x260 mm/slab.c:3799
 process_one_req+0x2e7/0x6c0 drivers/infiniband/core/addr.c:592
 process_one_work+0xc47/0x1bb0 kernel/workqueue.c:2113
 worker_thread+0x223/0x1990 kernel/workqueue.c:2247
 kthread+0x33c/0x400 kernel/kthread.c:238
 ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:406

Fixes: 5fff41e1f89d ("IB/core: Fix race condition in resolving IP to MAC")
Reported-by: <syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/addr.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -597,6 +597,15 @@ static void process_one_req(struct work_
 	list_del(&req->list);
 	mutex_unlock(&lock);
 
+	/*
+	 * Although the work will normally have been canceled by the
+	 * workqueue, it can still be requeued as long as it is on the
+	 * req_list, so it could have been requeued before we grabbed &lock.
+	 * We need to cancel it after it is removed from req_list to really be
+	 * sure it is safe to free.
+	 */
+	cancel_delayed_work(&req->work);
+
 	req->callback(req->status, (struct sockaddr *)&req->src_addr,
 		req->addr, req->context);
 	put_client(req->client);
