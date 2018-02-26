Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227e8PCEEPtc52dgNdybb/0sEiNWZF+RXGAHtcfK7buBNtZzEr7sN9Vq9SqWNV4e/TdqSBdY
ARC-Seal: i=1; a=rsa-sha256; t=1519676804; cv=none;
        d=google.com; s=arc-20160816;
        b=rRy1gnJRFRndRSZCLd6bqYT/5ScNMzt2Ojv+Ra+tDOejC75+UOD1Rbre5m2UbX9IR3
         D2KOW7+cl+75nKW3nnIxmcOCghXugueiJxGsAAek2JweuMzDBHXGziN8wSFtoVhi4fbx
         zFPk/A05EW7eSlv7aTNDdZS6ayYeULcoH2kITNAvfYd9S7rnH3UraovDu8PZQnYhTp0k
         iYDhGeshE51BXaZQLrlo3IqBYRnT7zySL0Bb9/B7PWIDo5cvyzoclQyzyWHhrG/pi5Yb
         17qnxf4Fi7cUptlZ84iX06tgiEgvNXASAyD+EpZ4CaL0x02ZA4mIKV5EwZImeWAqyKRy
         qRqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=g3ENGFsLeGlRaTu0Av36gO8FhLkSy80wewk5mWZLSZU=;
        b=dqRfKdZtt8lBMfEEAMIB4xUGqk/PW9xbWI2KE/9mlcD0etm0ZDneZPg3dExPnMAt4g
         UbuZ+HM5slqLv8MTz2pdgEWVtVbR10+TPTjfVLvXcocW988YE6T9fdUcBT4MI0HeyMiN
         ciaqB9J4i/lAvOB7Es4OrTVg9HWxsjM416X9fEFoRVHOJ55ILZFgb4lBkah6ib3JxWGx
         ljlFA3efpoKlYNSyPyEVjlKDbmWEdjRkqL4thZy9P2WQLsUfQhfGqtsjBC+qEfPMueFJ
         WT/Pb88B140QU+1JQenhYyAIn/srpQII9OpPQzzPgkwC/uTXhEc7ltsftq2GbpZVGPc/
         pD3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Noa Osherovich <noaos@mellanox.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.15 20/64] RDMA/uverbs: Fix circular locking dependency
Date: Mon, 26 Feb 2018 21:21:57 +0100
Message-Id: <20180226202154.309904731@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496437790868994?=
X-GMAIL-MSGID: =?utf-8?q?1593496624963714648?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 1ff5325c3ca1843228a86549318bbd3b414b9207 upstream.

Avoid circular locking dependency by calling
to uobj_alloc_commit() outside of xrcd_tree_mutex lock.

======================================================
WARNING: possible circular locking dependency detected
4.15.0+ #87 Not tainted
------------------------------------------------------
syzkaller401056/269 is trying to acquire lock:
 (&uverbs_dev->xrcd_tree_mutex){+.+.}, at: [<000000006c12d2cd>] uverbs_free_xrcd+0xd2/0x360

but task is already holding lock:
 (&ucontext->uobjects_lock){+.+.}, at: [<00000000da010f09>] uverbs_cleanup_ucontext+0x168/0x730

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&ucontext->uobjects_lock){+.+.}:
       __mutex_lock+0x111/0x1720
       rdma_alloc_commit_uobject+0x22c/0x600
       ib_uverbs_open_xrcd+0x61a/0xdd0
       ib_uverbs_write+0x7f9/0xef0
       __vfs_write+0x10d/0x700
       vfs_write+0x1b0/0x550
       SyS_write+0xc7/0x1a0
       entry_SYSCALL_64_fastpath+0x1e/0x8b

-> #0 (&uverbs_dev->xrcd_tree_mutex){+.+.}:
       lock_acquire+0x19d/0x440
       __mutex_lock+0x111/0x1720
       uverbs_free_xrcd+0xd2/0x360
       remove_commit_idr_uobject+0x6d/0x110
       uverbs_cleanup_ucontext+0x2f0/0x730
       ib_uverbs_cleanup_ucontext.constprop.3+0x52/0x120
       ib_uverbs_close+0xf2/0x570
       __fput+0x2cd/0x8d0
       task_work_run+0xec/0x1d0
       do_exit+0x6a1/0x1520
       do_group_exit+0xe8/0x380
       SyS_exit_group+0x1e/0x20
       entry_SYSCALL_64_fastpath+0x1e/0x8b

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ucontext->uobjects_lock);
                               lock(&uverbs_dev->xrcd_tree_mutex);
                               lock(&ucontext->uobjects_lock);
  lock(&uverbs_dev->xrcd_tree_mutex);

 *** DEADLOCK ***

3 locks held by syzkaller401056/269:
 #0:  (&file->cleanup_mutex){+.+.}, at: [<00000000c9f0c252>] ib_uverbs_close+0xac/0x570
 #1:  (&ucontext->cleanup_rwsem){++++}, at: [<00000000b6994d49>] uverbs_cleanup_ucontext+0xf6/0x730
 #2:  (&ucontext->uobjects_lock){+.+.}, at: [<00000000da010f09>] uverbs_cleanup_ucontext+0x168/0x730

stack backtrace:
CPU: 0 PID: 269 Comm: syzkaller401056 Not tainted 4.15.0+ #87
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xde/0x164
 ? dma_virt_map_sg+0x22c/0x22c
 ? uverbs_cleanup_ucontext+0x168/0x730
 ? console_unlock+0x502/0xbd0
 print_circular_bug.isra.24+0x35e/0x396
 ? print_circular_bug_header+0x12e/0x12e
 ? find_usage_backwards+0x30/0x30
 ? entry_SYSCALL_64_fastpath+0x1e/0x8b
 validate_chain.isra.28+0x25d1/0x40c0
 ? check_usage+0xb70/0xb70
 ? graph_lock+0x160/0x160
 ? find_usage_backwards+0x30/0x30
 ? cyc2ns_read_end+0x10/0x10
 ? print_irqtrace_events+0x280/0x280
 ? __lock_acquire+0x93d/0x1630
 __lock_acquire+0x93d/0x1630
 lock_acquire+0x19d/0x440
 ? uverbs_free_xrcd+0xd2/0x360
 __mutex_lock+0x111/0x1720
 ? uverbs_free_xrcd+0xd2/0x360
 ? uverbs_free_xrcd+0xd2/0x360
 ? __mutex_lock+0x828/0x1720
 ? mutex_lock_io_nested+0x1550/0x1550
 ? uverbs_cleanup_ucontext+0x168/0x730
 ? __lock_acquire+0x9a9/0x1630
 ? mutex_lock_io_nested+0x1550/0x1550
 ? uverbs_cleanup_ucontext+0xf6/0x730
 ? lock_contended+0x11a0/0x11a0
 ? uverbs_free_xrcd+0xd2/0x360
 uverbs_free_xrcd+0xd2/0x360
 remove_commit_idr_uobject+0x6d/0x110
 uverbs_cleanup_ucontext+0x2f0/0x730
 ? sched_clock_cpu+0x18/0x200
 ? uverbs_close_fd+0x1c0/0x1c0
 ib_uverbs_cleanup_ucontext.constprop.3+0x52/0x120
 ib_uverbs_close+0xf2/0x570
 ? ib_uverbs_remove_one+0xb50/0xb50
 ? ib_uverbs_remove_one+0xb50/0xb50
 __fput+0x2cd/0x8d0
 task_work_run+0xec/0x1d0
 do_exit+0x6a1/0x1520
 ? fsnotify_first_mark+0x220/0x220
 ? exit_notify+0x9f0/0x9f0
 ? entry_SYSCALL_64_fastpath+0x5/0x8b
 ? entry_SYSCALL_64_fastpath+0x5/0x8b
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 ? time_hardirqs_on+0x27/0x670
 ? time_hardirqs_off+0x27/0x490
 ? syscall_return_slowpath+0x6c/0x460
 ? entry_SYSCALL_64_fastpath+0x5/0x8b
 do_group_exit+0xe8/0x380
 SyS_exit_group+0x1e/0x20
 entry_SYSCALL_64_fastpath+0x1e/0x8b
RIP: 0033:0x431ce9

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 4.11
Fixes: fd3c7904db6e ("IB/core: Change idr objects to use the new schema")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_cmd.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -560,9 +560,10 @@ ssize_t ib_uverbs_open_xrcd(struct ib_uv
 	if (f.file)
 		fdput(f);
 
+	mutex_unlock(&file->device->xrcd_tree_mutex);
+
 	uobj_alloc_commit(&obj->uobject);
 
-	mutex_unlock(&file->device->xrcd_tree_mutex);
 	return in_len;
 
 err_copy:
