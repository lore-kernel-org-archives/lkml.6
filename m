Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3726165-1519676628-2-6130347548569411929
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519676627; b=Lycgn5O3a9k5w2Iq4KXoKs/+CgQbLCQ8q+nq5/1zZDBFt7S
    fY0dPcl5g2iUYZuOc0F3z8rixDEPg0gvVfVa9+nvBYDhv+eNfrAkJJ7F+PIF94nl
    LpFbzcg+uEszf/OvhoMv1CvnsbUO7LH2hlsFKmb90NhhBy8w7CNxGufJJ/b/6/l9
    J/d6uorsYTXaorPqcVSu/c7lpp9AvmxENh7Qh2odq3QdL5Zuvgtidx1Py3AKifrK
    BYXbGwTeheSNS5OK4oxl4ABqIQ1Q00Nq/+1lhbnnUNywrn+J0L/LV7OenbEpRsBM
    cWifWsRQfmFpWsbUGEkMoRMi0ntjNSFskgG4/SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519676627; bh=aeLHPEAGsdDSrI5SzJOEATyOYn
    bhnwJG2Dhr5t8StZM=; b=WB+HvlIVxCJrT3MHJQTE7QCObUQGZzU3Js9DoLfyqR
    dynwSrAwMvxKjEi6pz89PvJQmtsUsGg0q5CtyUIANBOsVkF5Wd0LO5PrsttWvJ/O
    R31/rtzW76f4xHzBcAg7aYjuaVHL6cA0oyJwb3JJNWGLOd/apzKkaoOY1qRlIsTZ
    bqEQ2BOX8DKG1jRlS1uxMuIn6olfuiktDMnAQ29qaTBYm1reQ+vI9IATxnddwhMr
    5XpOgWLCJnhoOnIGJlNlGen6Svf8igYwZyJkUkhxxZSdAER31Wyqhodzop32RmY2
    2PEwYqrs92cTycLZK3OAAqjou+BoFATwjOeD4hORYppQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752440AbeBZUXn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 15:23:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34882 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752720AbeBZUXl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Feb 2018 15:23:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        Noa Osherovich <noaos@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 18/54] RDMA/uverbs: Fix bad unlock balance in ib_uverbs_close_xrcd
Date: Mon, 26 Feb 2018 21:21:55 +0100
Message-Id: <20180226202145.283400276@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -606,10 +606,8 @@ ssize_t ib_uverbs_close_xrcd(struct ib_u
 
 	uobj  = uobj_get_write(uobj_get_type(xrcd), cmd.xrcd_handle,
 			       file->ucontext);
-	if (IS_ERR(uobj)) {
-		mutex_unlock(&file->device->xrcd_tree_mutex);
+	if (IS_ERR(uobj))
 		return PTR_ERR(uobj);
-	}
 
 	ret = uobj_remove_commit(uobj);
 	return ret ?: in_len;
