Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434EFC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A4520892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791150;
	bh=lv0kpigiM9+opEiVo/+8KB1l/0HhFGUtI3ScZZTDnSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IOLvya2K0PVyCAUcsPaBeLz/dp0k9C2rGKDBYSg5XnZnY31l724sQzMzXX/qPaSYd
	 RTx/R8Da+WHVWo8lqtE0zJlOiPXXOiwMLwBeWWShHQBSZqiP8XdAQPd7jICIakcOb0
	 hrRl0q4q+4fS86BvCl1K/jzgAeoh0HxdAKmkQCXk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09A4520892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbeLNMFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:49888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeLNMFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:05:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A1E521486;
        Fri, 14 Dec 2018 12:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789106;
        bh=lv0kpigiM9+opEiVo/+8KB1l/0HhFGUtI3ScZZTDnSw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ht8DtYB+ZXtyvto7tgrzf6FCG4uM+RZGFOyfuiHSuW9OrSHaqpEOCMsYxpSdGhrOa
         t1J0+LRjLF8HkJhTe7MOJDq/MP+AHfW1B9aravVfA/RdiYY7Mqh3S64XTQJvgZszg9
         jL2IRQFbP4MuoiLLRG5rOwGqcRZb5q4ysP3eGfzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Selvin Xavier <selvin.xavier@broadcom.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/142] RDMA/bnxt_re: Avoid accessing the device structure after it is freed
Date:   Fri, 14 Dec 2018 12:59:19 +0100
Message-Id: <20181214115750.023217934@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



