Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036D9C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C14217FA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277591;
	bh=Dqfw0hwWoR1tI20B/bTMf8L4UOwa5mz8UKBZvdHnRq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUek8pPCynfM+/Rj9zZTV/h70m18HDQbFB7PlGnNSL7ztgg9tRIdNDfA0oTt4hQ5o
	 DXh2egimfgcx1eSZlRh1+JpILtN+7OkZ2Wk9T9wfOq1m54ljot2572Vx3OonAJvzYN
	 7cP32vJoIDrMKDC9YdcO8CvGyzk2EvFB0AOPx1yE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732737AbfBDKxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732717AbfBDKxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA487217D6;
        Mon,  4 Feb 2019 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277585;
        bh=Dqfw0hwWoR1tI20B/bTMf8L4UOwa5mz8UKBZvdHnRq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wZYuvgW1GtGJ7DnLjnnj8DADC8XnkmuB+g18t1/9rVbAxzt9eqBCU5ZNGjSZq98g5
         SJ8fNUThGmTtC8msMMR5sqhDa8E4bHAd3E+HOOE8121E4OqjBpHUSkYcimz4EDShG8
         bLQlO6lEUx3o5HPM5rNPyvxBYyWkPOnCytHfNGpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.20 61/80] IB/uverbs: Fix OOPs in uverbs_user_mmap_disassociate
Date:   Mon,  4 Feb 2019 11:37:21 +0100
Message-Id: <20190204103628.657864089@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yishai Hadas <yishaih@mellanox.com>

commit 7b21b69ab203136fdc153c7707fa6c409e523c2e upstream.

The vma->vm_mm can become impossible to get before rdma_umap_close() is
called, in this case we must not try to get an mm that is already
undergoing process exit. In this case there is no need to wait for
anything as the VMA will be destroyed by another thread soon and is
already effectively 'unreachable' by userspace.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 PGD 800000012bc50067 P4D 800000012bc50067 PUD 129db5067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 1 PID: 2050 Comm: bash Tainted: G        W  OE 4.20.0-rc6+ #3
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 RIP: 0010:__rb_erase_color+0xb9/0x280
 Code: 84 17 01 00 00 48 3b 68 10 0f 84 15 01 00 00 48 89
               58 08 48 89 de 48 89 ef 4c 89 e3 e8 90 84 22 00 e9 60 ff ff ff 48 8b 5d
               10 <f6> 03 01 0f 84 9c 00 00 00 48 8b 43 10 48 85 c0 74 09 f6 00 01 0f
 RSP: 0018:ffffbecfc090bab8 EFLAGS: 00010246
 RAX: ffff97616346cf30 RBX: 0000000000000000 RCX: 0000000000000101
 RDX: 0000000000000000 RSI: ffff97623b6ca828 RDI: ffff97621ef10828
 RBP: ffff97621ef10828 R08: ffff97621ef10828 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff97623b6ca838
 R13: ffffffffbb3fef50 R14: ffff97623b6ca828 R15: 0000000000000000
 FS:  00007f7a5c31d740(0000) GS:ffff97623bb00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000000 CR3: 000000011255a000 CR4: 00000000000006e0
 Call Trace:
  unlink_file_vma+0x3b/0x50
  free_pgtables+0xa1/0x110
  exit_mmap+0xca/0x1a0
  ? mlx5_ib_dealloc_pd+0x28/0x30 [mlx5_ib]
  mmput+0x54/0x140
  uverbs_user_mmap_disassociate+0xcc/0x160 [ib_uverbs]
  uverbs_destroy_ufile_hw+0xf7/0x120 [ib_uverbs]
  ib_uverbs_remove_one+0xea/0x240 [ib_uverbs]
  ib_unregister_device+0xfb/0x200 [ib_core]
  mlx5_ib_remove+0x51/0xe0 [mlx5_ib]
  mlx5_remove_device+0xc1/0xd0 [mlx5_core]
  mlx5_unregister_device+0x3d/0xb0 [mlx5_core]
  remove_one+0x2a/0x90 [mlx5_core]
  pci_device_remove+0x3b/0xc0
  device_release_driver_internal+0x16d/0x240
  unbind_store+0xb2/0x100
  kernfs_fop_write+0x102/0x180
  __vfs_write+0x36/0x1a0
  ? __alloc_fd+0xa9/0x170
  ? set_close_on_exec+0x49/0x70
  vfs_write+0xad/0x1a0
  ksys_write+0x52/0xc0
  do_syscall_64+0x5b/0x180
  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Cc: <stable@vger.kernel.org> # 4.19
Fixes: 5f9794dc94f5 ("RDMA/ucontext: Add a core API for mmaping driver IO memory")
Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/uverbs_main.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -1000,11 +1000,19 @@ void uverbs_user_mmap_disassociate(struc
 
 		/* Get an arbitrary mm pointer that hasn't been cleaned yet */
 		mutex_lock(&ufile->umap_lock);
-		if (!list_empty(&ufile->umaps)) {
-			mm = list_first_entry(&ufile->umaps,
-					      struct rdma_umap_priv, list)
-				     ->vma->vm_mm;
-			mmget(mm);
+		while (!list_empty(&ufile->umaps)) {
+			int ret;
+
+			priv = list_first_entry(&ufile->umaps,
+						struct rdma_umap_priv, list);
+			mm = priv->vma->vm_mm;
+			ret = mmget_not_zero(mm);
+			if (!ret) {
+				list_del_init(&priv->list);
+				mm = NULL;
+				continue;
+			}
+			break;
 		}
 		mutex_unlock(&ufile->umap_lock);
 		if (!mm)


