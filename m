Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6FEC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922DE20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu+MrmCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 922DE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeLEJjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:39:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbeLEJjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:39:06 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F00A20850;
        Wed,  5 Dec 2018 09:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002745;
        bh=6oP864o1K3sNwHVKvL7TnzChKDnb0yac7zREVqzL8oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bu+MrmCuvijUMtpfDqli7ScNo7pn2pWNAYknSBswWgq0racUIx+YtuMoFg2Xh82Go
         LoRdz/JFpputXml3l1yfbBwLf+oMeELryzhHwFc0Sp+bXwu9FhItsx1Ql9T7fDKPPn
         epHCIySuM58e27Mx1Wm+7CxpH7vcdd6xg6bSvVx4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 055/123] RDMA/bnxt_re: Fix system hang when registration with L2 driver fails
Date:   Wed,  5 Dec 2018 04:34:47 -0500
Message-Id: <20181205093555.5386-55-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Selvin Xavier <selvin.xavier@broadcom.com>

[ Upstream commit 3c4b1419c33c2417836a63f8126834ee36968321 ]

Driver doesn't release rtnl lock if registration with
L2 driver (bnxt_re_register_netdev) fais and this causes
hang while requesting for the next lock.

[  371.635416] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  371.635417] kworker/u48:1   D    0   634      2 0x80000000
[  371.635423] Workqueue: bnxt_re bnxt_re_task [bnxt_re]
[  371.635424] Call Trace:
[  371.635426]  ? __schedule+0x36b/0xbd0
[  371.635429]  schedule+0x39/0x90
[  371.635430]  schedule_preempt_disabled+0x11/0x20
[  371.635431]  __mutex_lock+0x45b/0x9c0
[  371.635433]  ? __mutex_lock+0x16d/0x9c0
[  371.635435]  ? bnxt_re_ib_reg+0x2b/0xb30 [bnxt_re]
[  371.635438]  ? wake_up_klogd+0x37/0x40
[  371.635442]  bnxt_re_ib_reg+0x2b/0xb30 [bnxt_re]
[  371.635447]  bnxt_re_task+0xfd/0x180 [bnxt_re]
[  371.635449]  process_one_work+0x216/0x5b0
[  371.635450]  ? process_one_work+0x189/0x5b0
[  371.635453]  worker_thread+0x4e/0x3d0
[  371.635455]  kthread+0x10e/0x140
[  371.635456]  ? process_one_work+0x5b0/0x5b0
[  371.635458]  ? kthread_stop+0x220/0x220
[  371.635460]  ret_from_fork+0x3a/0x50
[  371.635477] INFO: task NetworkManager:1228 blocked for more than 120 seconds.
[  371.635478]       Tainted: G    B      OE     4.20.0-rc1+ #42
[  371.635479] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.

Release the rtnl_lock correctly in the failure path.

Fixes: de5c95d0f518 ("RDMA/bnxt_re: Fix system crash during RDMA resource initialization")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 85cd1a3593d6..bb3f16273938 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1252,6 +1252,7 @@ static int bnxt_re_ib_reg(struct bnxt_re_dev *rdev)
 	/* Registered a new RoCE device instance to netdev */
 	rc = bnxt_re_register_netdev(rdev);
 	if (rc) {
+		rtnl_unlock();
 		pr_err("Failed to register with netedev: %#x\n", rc);
 		return -EINVAL;
 	}
-- 
2.17.1

