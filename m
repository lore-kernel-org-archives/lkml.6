Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE442C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8325C2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="E7sdHMFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8325C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=purestorage.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeK3LGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:06:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45281 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbeK3LGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:06:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so1825522plm.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3CLCdRjmLflD9WdfGLK97mOP7gBgdCpzvH/stmojGE0=;
        b=E7sdHMFrpe8j0VqAryjYSinXCf5E5e8QqY6qJR760vc6Pl/lcH5KVpq9KjxhDgu584
         pQPzFdMlzOAe3iRy8bMvJj/L1qIhfo1w8FhCWxalwgQ9Cn2W7VhGHvXNMW4aQiiN8pCV
         XdhtB+GPHXeMgJvcVNb4a4JGiNsQtYO6dCE18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3CLCdRjmLflD9WdfGLK97mOP7gBgdCpzvH/stmojGE0=;
        b=AHZ917bUzGGhWuczciMBCi4W0G7/R/q6e5UFDWqLcWbhxu4ej+Vu8iPHFGMgf/6J5V
         EnSZi0njhvKRhLf8ke/azY4Q2wVlgdlXWBeFlbgVkjhBHq/meXHheuNQqFBSrFb+GkVC
         XSOzmCTMYi1P0LFmUs6xl5OD0Cxyc87UFaP78h/mhzRX7pWCCadMOfW8/hBohSo6Km8H
         vf07H9a/s0GP3Wh+CLSOLK/BXjXLzMXQUeKBJY0AprIL8bYxOs9ZbmRd2ZTyNMxgbbDQ
         fnKBwgQF2jTAd+wm1FIj8UHy0kE1daGP3QAdLYp4RkkuBOcxq/m/nfOUEZ89tespzJvC
         NQtg==
X-Gm-Message-State: AA+aEWbB0vJCjqMX5godTyJ9mHkd3pp8L0K/Z0SQbuqzQoP0L5t819pZ
        jtZNd/BY/8yD7q2gXY42ydg0EQ==
X-Google-Smtp-Source: AFSGD/UH0p/jrK+n4DnY6uj7OCiL1mnr0EOlIrJT2W1KDXZqvSBx31/IinDxScGEwrZW8FqfvFzEiA==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr3447625pll.60.1543535956806;
        Thu, 29 Nov 2018 15:59:16 -0800 (PST)
Received: from dev-jalee.dev.purestorage.com ([192.30.188.252])
        by smtp.googlemail.com with ESMTPSA id 84sm4559684pfk.134.2018.11.29.15.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 29 Nov 2018 15:59:15 -0800 (PST)
From:   Jaesoo Lee <jalee@purestorage.com>
To:     keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        psajeepa@purestorage.com, roland@purestorage.com,
        ashishk@purestorage.com, jalee@purestorage.com
Subject: [PATCH] nvme-rdma: complete requests from ->timeout
Date:   Thu, 29 Nov 2018 15:59:14 -0800
Message-Id: <1543535954-28073-1-git-send-email-jalee@purestorage.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After f6e7d48 (block: remove BLK_EH_HANDLED), the low-level device driver
is responsible to complete the timed out request and a series of changes
were submitted for various LLDDs to make completions from ->timeout
subsequently. However, adding the completion code in NVMe driver was
skipped with the assumption made in below NVMe LLDD's change.

Commit message of db8c48e (nvme: return BLK_EH_DONE from ->timeout):
 NVMe always completes the request before returning from ->timeout, either
 by polling for it, or by disabling the controller.   Return BLK_EH_DONE so
 that the block layer doesn't even try to complete it again.

This does not hold at least for NVMe RDMA host driver. An example scenario
is when the RDMA connection is gone while the controller is being deleted.
In this case, the nvmf_reg_write32() for sending shutdown admin command by
the delete_work could be hung forever if the command is not completed by
the timeout handler.

Stack trace of hang looks like:
 kworker/u66:2   D    0 21098      2 0x80000080
 Workqueue: nvme-delete-wq nvme_delete_ctrl_work
 Call Trace:
 __schedule+0x2ab/0x880
 schedule+0x36/0x80
 schedule_timeout+0x161/0x300
 ? __next_timer_interrupt+0xe0/0xe0
 io_schedule_timeout+0x1e/0x50
 wait_for_completion_io_timeout+0x130/0x1a0
 ? wake_up_q+0x80/0x80
 blk_execute_rq+0x6e/0xa0
 __nvme_submit_sync_cmd+0x6e/0xe0
 nvmf_reg_write32+0x6c/0xc0 [nvme_fabrics]
 nvme_shutdown_ctrl+0x56/0x110
 nvme_rdma_shutdown_ctrl+0xf8/0x100 [nvme_rdma]
 nvme_rdma_delete_ctrl+0x1a/0x20 [nvme_rdma]
 nvme_delete_ctrl_work+0x66/0x90
 process_one_work+0x179/0x390
 worker_thread+0x1da/0x3e0
 kthread+0x105/0x140
 ? max_active_store+0x80/0x80
 ? kthread_bind+0x20/0x20
 ret_from_fork+0x35/0x40

Signed-off-by: Jaesoo Lee <jalee@purestorage.com>
---
 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181caf..25319b7 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1688,6 +1688,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	/* fail with DNR on cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
 
+	blk_mq_complete_request(rq);
 	return BLK_EH_DONE;
 }
 
-- 
1.9.1

