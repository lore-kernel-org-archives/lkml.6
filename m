Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73F4ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AD220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wmjhJPdR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AD220664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeKAIqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:46:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbeKAIHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643292081B;
        Wed, 31 Oct 2018 23:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027227;
        bh=5I9G2dYuYHbM8b7hQ5md1BXNzHe3WaUGgQqzR0Tnmqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wmjhJPdRd1nXHdXJsWi8ez8gYye/7xpZIDx69uUScD5eej8yMh5tBi14sR/W1R7tx
         C1dRpZfeaPn/rnuSLrM+2iTVnNWg2pfR/Pyag+OlfEEMqhKtniSEWtHajqRq4WHvBb
         w6BVHJ4T4zXNuHoxbTEvEJ8QYsRoC6HPdWnC5IIc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 093/146] scsi: ufs: Schedule clk gating work on correct queue
Date:   Wed, 31 Oct 2018 19:04:48 -0400
Message-Id: <20181031230541.28822-93-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evan Green <evgreen@chromium.org>

[ Upstream commit f4bb7704699beee9edfbee875daa9089c86cf724 ]

With commit 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate
workqueue"), clock gating work was moved to a separate work queue with
WQ_MEM_RECLAIM set, since clock gating could occur from a memory reclaim
context. Unfortunately, clk_gating.gate_work was left queued via
schedule_delayed_work, which is a system workqueue that does not have
WQ_MEM_RECLAIM set.  Because ufshcd_ungate_work attempts to cancel
gate_work, the following warning appears:

[   14.174170] workqueue: WQ_MEM_RECLAIM ufs_clk_gating_0:ufshcd_ungate_work is flushing !WQ_MEM_RECLAIM events:ufshcd_gate_work
[   14.174179] WARNING: CPU: 4 PID: 173 at kernel/workqueue.c:2440 check_flush_dependency+0x110/0x118
[   14.205725] CPU: 4 PID: 173 Comm: kworker/u16:3 Not tainted 4.14.68 #1
[   14.212437] Hardware name: Google Cheza (rev1) (DT)
[   14.217459] Workqueue: ufs_clk_gating_0 ufshcd_ungate_work
[   14.223107] task: ffffffc0f6a40080 task.stack: ffffff800a490000
[   14.229195] PC is at check_flush_dependency+0x110/0x118
[   14.234569] LR is at check_flush_dependency+0x110/0x118
[   14.239944] pc : [<ffffff80080cad14>] lr : [<ffffff80080cad14>] pstate: 60c001c9
[   14.333050] Call trace:
[   14.427767] [<ffffff80080cad14>] check_flush_dependency+0x110/0x118
[   14.434219] [<ffffff80080cafec>] start_flush_work+0xac/0x1fc
[   14.440046] [<ffffff80080caeec>] flush_work+0x40/0x94
[   14.445246] [<ffffff80080cb288>] __cancel_work_timer+0x11c/0x1b8
[   14.451433] [<ffffff80080cb4b8>] cancel_delayed_work_sync+0x20/0x30
[   14.457886] [<ffffff80085b9294>] ufshcd_ungate_work+0x24/0xd0
[   14.463800] [<ffffff80080cfb04>] process_one_work+0x32c/0x690
[   14.469713] [<ffffff80080d0154>] worker_thread+0x218/0x338
[   14.475361] [<ffffff80080d527c>] kthread+0x120/0x130
[   14.480470] [<ffffff8008084814>] ret_from_fork+0x10/0x18

The simple solution is to put the gate_work on the same WQ_MEM_RECLAIM
work queue as the ungate_work.

Fixes: 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate workqueue")
Signed-off-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ufs/ufshcd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index c55f38ec391c..54074dd483a7 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1691,8 +1691,9 @@ static void __ufshcd_release(struct ufs_hba *hba)
 
 	hba->clk_gating.state = REQ_CLKS_OFF;
 	trace_ufshcd_clk_gating(dev_name(hba->dev), hba->clk_gating.state);
-	schedule_delayed_work(&hba->clk_gating.gate_work,
-			msecs_to_jiffies(hba->clk_gating.delay_ms));
+	queue_delayed_work(hba->clk_gating.clk_gating_workq,
+			   &hba->clk_gating.gate_work,
+			   msecs_to_jiffies(hba->clk_gating.delay_ms));
 }
 
 void ufshcd_release(struct ufs_hba *hba)
-- 
2.17.1

