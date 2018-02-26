Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsocMiY/h1a0NDq6dfniAvjnFzn+zEKwVabSDH3uMx9yEcT/2VTNSexMkaYdbtJP0J+LBTi
ARC-Seal: i=1; a=rsa-sha256; t=1519676798; cv=none;
        d=google.com; s=arc-20160816;
        b=z19zoBS3s2ok/o862CWmeY6CFDRH08m1RgHsd/HBTs+YyE37M0y2Obf4qfUmV39Cwo
         P7zHzt9Ymdxxs3E3Yx3uq66vjRC3Rnn6/4EqepoOxvPHPGI7JFE36LZ94Gsj0SzLVtVF
         sXwKj62aPsNDxJsjrQ/HpPS5uDbDn6o15NBMFZoe01IvKhdZ1id3y6hoF7+NwgjS+1gp
         7jY0/WGLZLZgksr0u3VkT1327QyfK2azSDgYfGlRfzGgzsWrRmbYBCzM7INkOrpaKugr
         yP7S++TxzbCXVpysKqdwr8Edz/YGbMlzCiXRInWarDo8/sjdg/dv98Kgef8MjCv47VgS
         43ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WNUJVqCZ4RhFb8aVN2TumGfjg7lS9E66mFs4tmrWe1A=;
        b=uYc0PIVcZDMnTfp8BGPTcI3JQCQOwGjLNYgoXuyMrQ1LRMFyxOfgp90hmkTKSFKQL0
         ur22d8/RdH+DvPpMHgCEvfoyJTmWPibCntKiDNHP/scYhiRuTFebTRLeLQY1NS0jI3Ex
         b75P6Z/B8X5N4xJuEHavfK/KoZu1Me3mTabPgHdNdXKDUTI8kY7qg0QdNhjIeJDQdN3S
         R+Pu4eirPvVcqwCZ/f42118XFSCA6TSfMGZXFNFBINVkAduyRaW7WtBC9VQaJWQC3yRc
         ei09Jb9HN25QA4og0Nm8aXJZpiUsb7oPYZcsBXIQXNbHTePCMDIJD56/leatVddCIGtN
         w01A==
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
Subject: [PATCH 4.15 19/64] RDMA/uverbs: Fix bad unlock balance in ib_uverbs_close_xrcd
Date: Mon, 26 Feb 2018 21:21:56 +0100
Message-Id: <20180226202154.269947760@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202153.453363333@linuxfoundation.org>
References: <20180226202153.453363333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496434954619637?=
X-GMAIL-MSGID: =?utf-8?q?1593496618976359318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit 5c2e1c4f926856717f3fd31932e926dc3fe77ebd upstream.

There is no matching lock for this mutex. Git history suggests this is
just a missed remnant from an earlier version of the function before
this locking was moved into uverbs_free_xrcd.

Originally this lock was protecting the xrcd_table_delete()

=====================================
WARNING: bad unlock balance detected!
4.15.0+ #87 Not tainted
-------------------------------------
syzkaller223405/269 is trying to release lock (&uverbs_dev->xrcd_tree_mutex) at:
[<00000000b8703372>] ib_uverbs_close_xrcd+0x195/0x1f0
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syzkaller223405/269:
 #0:  (&uverbs_dev->disassociate_srcu){....}, at: [<000000005af3b960>] ib_uverbs_write+0x265/0xef0

stack backtrace:
CPU: 0 PID: 269 Comm: syzkaller223405 Not tainted 4.15.0+ #87
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
Call Trace:
 dump_stack+0xde/0x164
 ? dma_virt_map_sg+0x22c/0x22c
 ? ib_uverbs_write+0x265/0xef0
 ? console_unlock+0x502/0xbd0
 ? ib_uverbs_close_xrcd+0x195/0x1f0
 print_unlock_imbalance_bug+0x131/0x160
 lock_release+0x59d/0x1100
 ? ib_uverbs_close_xrcd+0x195/0x1f0
 ? lock_acquire+0x440/0x440
 ? lock_acquire+0x440/0x440
 __mutex_unlock_slowpath+0x88/0x670
 ? wait_for_completion+0x4c0/0x4c0
 ? rdma_lookup_get_uobject+0x145/0x2f0
 ib_uverbs_close_xrcd+0x195/0x1f0
 ? ib_uverbs_open_xrcd+0xdd0/0xdd0
 ib_uverbs_write+0x7f9/0xef0
 ? cyc2ns_read_end+0x10/0x10
 ? ib_uverbs_open_xrcd+0xdd0/0xdd0
 ? uverbs_devnode+0x110/0x110
 ? cyc2ns_read_end+0x10/0x10
 ? cyc2ns_read_end+0x10/0x10
 ? sched_clock_cpu+0x18/0x200
 __vfs_write+0x10d/0x700
 ? uverbs_devnode+0x110/0x110
 ? kernel_read+0x170/0x170
 ? __fget+0x358/0x5d0
 ? security_file_permission+0x93/0x260
 vfs_write+0x1b0/0x550
 SyS_write+0xc7/0x1a0
 ? SyS_read+0x1a0/0x1a0
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 entry_SYSCALL_64_fastpath+0x1e/0x8b
RIP: 0033:0x4335c9

Cc: syzkaller <syzkaller@googlegroups.com>
Cc: <stable@vger.kernel.org> # 4.11
Fixes: fd3c7904db6e ("IB/core: Change idr objects to use the new schema")
Reported-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_cmd.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/infiniband/core/uverbs_cmd.c
+++ b/drivers/infiniband/core/uverbs_cmd.c
@@ -601,10 +601,8 @@ ssize_t ib_uverbs_close_xrcd(struct ib_u
 
 	uobj  = uobj_get_write(uobj_get_type(xrcd), cmd.xrcd_handle,
 			       file->ucontext);
-	if (IS_ERR(uobj)) {
-		mutex_unlock(&file->device->xrcd_tree_mutex);
+	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
-	}
 
 	ret = uobj_remove_commit(uobj);
 	return ret ?: in_len;
