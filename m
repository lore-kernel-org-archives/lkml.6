Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510D4206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsLrUmbH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510D4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeLEKJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:09:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:43188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727887AbeLEJjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:09 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FBA72084C;
        Wed,  5 Dec 2018 09:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002748;
        bh=ANhutPv9HPqsAFwDWfw8rzjKk2mvAhlDJNjZ8HPs+n4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GsLrUmbHcKbmHPQTIPmGvqf8tmoOVWVNxuzy5fj9r4dWnQx+aX6JlHL93LPbbw6Db
         ac0igEQK10omkmUQ7z4wEJ5pUBepElv9rCLyGjFiDFuu3ZtEIUJwY+mTKj4wjB2dWL
         yQRZLRVAOds60bK2q0KahF/CIsGelMcwBwwzKrgA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 056/123] RDMA/bnxt_re: Avoid accessing the device structure after it is freed
Date:   Wed,  5 Dec 2018 04:34:48 -0500
Message-Id: <20181205093555.5386-56-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit a6c66d6a08b88cc10aca9d3f65cfae31e7652a99 ]

When bnxt_re_ib_reg returns failure, the device structure gets
freed. Driver tries to access the device pointer
after it is freed.

[ 4871.034744] Failed to register with netedev: 0xffffffa1
[ 4871.034765] infiniband (null): Failed to register with IB: 0xffffffea
[ 4871.046430] ==================================================================
[ 4871.046437] BUG: KASAN: use-after-free in bnxt_re_task+0x63/0x180 [bnxt_re]
[ 4871.046439] Write of size 4 at addr ffff880fa8406f48 by task kworker/u48:2/17813

[ 4871.046443] CPU: 20 PID: 17813 Comm: kworker/u48:2 Kdump: loaded Tainted: G B OE  4.20.0-rc1+ #42
[ 4871.046444] Hardware name: Dell Inc. PowerEdge R730/0599V5, BIOS 1.0.4 08/28/2014
[ 4871.046447] Workqueue: bnxt_re bnxt_re_task [bnxt_re]
[ 4871.046449] Call Trace:
[ 4871.046454]  dump_stack+0x91/0xeb
[ 4871.046458]  print_address_description+0x6a/0x2a0
[ 4871.046461]  kasan_report+0x176/0x2d0
[ 4871.046463]  ? bnxt_re_task+0x63/0x180 [bnxt_re]
[ 4871.046466]  bnxt_re_task+0x63/0x180 [bnxt_re]
[ 4871.046470]  process_one_work+0x216/0x5b0
[ 4871.046471]  ? process_one_work+0x189/0x5b0
[ 4871.046475]  worker_thread+0x4e/0x3d0
[ 4871.046479]  kthread+0x10e/0x140
[ 4871.046480]  ? process_one_work+0x5b0/0x5b0
[ 4871.046482]  ? kthread_stop+0x220/0x220
[ 4871.046486]  ret_from_fork+0x3a/0x50

[ 4871.046492] The buggy address belongs to the page:
[ 4871.046494] page:ffffea003ea10180 count:0 mapcount:0 mapping:0000000000000000 index:0x0
[ 4871.046495] flags: 0x57ffffc0000000()
[ 4871.046498] raw: 0057ffffc0000000 0000000000000000 ffffea003ea10188 0000000000000000
[ 4871.046500] raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[ 4871.046501] page dumped because: kasan: bad access detected

Avoid accessing the device structure once it is freed.

Fixes: 497158aa5f52 ("RDMA/bnxt_re: Fix the ib_reg failure cleanup")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index bb3f16273938..22bd9784fa2e 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1462,6 +1462,7 @@ static void bnxt_re_task(struct work_struct *work)
 				"Failed to register with IB: %#x", rc);
 			bnxt_re_remove_one(rdev);
 			bnxt_re_dev_unreg(rdev);
+			goto exit;
 		}
 		break;
 	case NETDEV_UP:
@@ -1485,6 +1486,7 @@ static void bnxt_re_task(struct work_struct *work)
 	}
 	smp_mb__before_atomic();
 	atomic_dec(&rdev->sched_count);
+exit:
 	kfree(re_work);
 }
 
-- 
2.17.1

