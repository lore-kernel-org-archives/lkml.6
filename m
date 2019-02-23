Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517B2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206D820855
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955910;
	bh=MBjNH2A/IJNsjwzTYAe2vXhzOxXlBEuZ7yWLGYGzZ3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ItQ33TBwAhXJKxtOWMUMzOUOBBMGpcRFvkBIh9xn1qcJEWpqDoIgKQjDZp3rfuCui
	 3yL+yoA3CYFSeQSQQwEgtUMJg9SM7rUKfQnHBAT1bSQ0k90f2VTM8I1pFRkN5S4hKi
	 PxvQaFsYx6L0eJ1rw6h/G627rpX1nUeutPh5BcGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfBWVFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbfBWVFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8837120675;
        Sat, 23 Feb 2019 21:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955899;
        bh=MBjNH2A/IJNsjwzTYAe2vXhzOxXlBEuZ7yWLGYGzZ3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l/Lhd3SNXR1cho1pqufacEy6DWWhbTtb5GDq/st2xbRYnhgXg6YY/Ags4bgewMqH8
         kfk+XNBJrdBdQlYRSIFX6XNdFRVCtxa2a2XdZHOjM90XoTcwg6+mBa8s1qr4/L0g4p
         GDFguZOGF7pzUhOhSUMp9SNvIV+aSn1lEKBnSosI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 22/72] RDMA/umem: Add missing initialization of owning_mm
Date:   Sat, 23 Feb 2019 16:03:32 -0500
Message-Id: <20190223210422.199966-22-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

[ Upstream commit a2093dd35f8cfb28dd7c878ccbd020c1bb20d0d7 ]

When allocating a umem leaf for implicit ODP MR during page fault the
field owning_mm was not set.

Initialize and take a reference on this field to avoid kernel panic when
trying to access this field.

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
 PGD 800000022dfed067 P4D 800000022dfed067 PUD 22dfcf067 PMD 0
 Oops: 0000 [#1] SMP PTI
 CPU: 0 PID: 634 Comm: kworker/u33:0 Not tainted 4.20.0-rc6+ #89
 Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
 Workqueue: mlx5_ib_page_fault mlx5_ib_eqe_pf_action [mlx5_ib]
 RIP: 0010:ib_umem_odp_map_dma_pages+0xf3/0x710 [ib_core]
 Code: 45 c0 48 21 f3 48 89 75 b0 31 f6 4a 8d 04 33 48 89 45 a8 49 8b 44 24 60 48 8b 78 10 e8 66 16 a8 c5 49 8b 54 24 08 48 89 45 98 <8b> 42 58 85 c0 0f 84 8e 05 00 00 8d 48 01 48 8d 72 58 f0 0f b1 4a
 RSP: 0000:ffffb610813a7c20 EFLAGS: 00010202
 RAX: ffff95ace6e8ac80 RBX: 0000000000000000 RCX: 000000000000000c
 RDX: 0000000000000000 RSI: 0000000000000850 RDI: ffff95aceaadae80
 RBP: ffffb610813a7ce0 R08: 0000000000000000 R09: 0000000000080c77
 R10: ffff95acfffdbd00 R11: 0000000000000000 R12: ffff95aceaa20a00
 R13: 0000000000001000 R14: 0000000000001000 R15: 000000000000000c
 FS:  0000000000000000(0000) GS:ffff95acf7800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000058 CR3: 000000022c834001 CR4: 00000000001606f0
 Call Trace:
  pagefault_single_data_segment+0x1df/0xc60 [mlx5_ib]
  mlx5_ib_eqe_pf_action+0x7bc/0xa70 [mlx5_ib]
  ? __switch_to+0xe1/0x470
  process_one_work+0x174/0x390
  worker_thread+0x4f/0x3e0
  kthread+0x102/0x140
  ? drain_workqueue+0x130/0x130
  ? kthread_stop+0x110/0x110
  ret_from_fork+0x1f/0x30

Fixes: f27a0d50a4bc ("RDMA/umem: Use umem->owning_mm inside ODP")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/umem_odp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 676c1fd1119d8..7ef385db52c35 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -356,6 +356,8 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_ucontext_per_mm *per_mm,
 	umem->writable   = 1;
 	umem->is_odp = 1;
 	odp_data->per_mm = per_mm;
+	umem->owning_mm  = per_mm->mm;
+	mmgrab(umem->owning_mm);
 
 	mutex_init(&odp_data->umem_mutex);
 	init_completion(&odp_data->notifier_completion);
@@ -388,6 +390,7 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_ucontext_per_mm *per_mm,
 out_page_list:
 	vfree(odp_data->page_list);
 out_odp_data:
+	mmdrop(umem->owning_mm);
 	kfree(odp_data);
 	return ERR_PTR(ret);
 }
-- 
2.19.1

