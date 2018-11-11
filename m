Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEA2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1752F20866
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 00:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oYvziUZ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1752F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732231AbeKLJ4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:34152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730995AbeKLIRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:17:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 642D7215EA;
        Sun, 11 Nov 2018 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975265;
        bh=+3/qLX+Ss2De3DtbR0bXT6jcS+jBws7MwoA5xftZ0jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYvziUZ27aGxYNdRaDJvsgFg/XW3Ryyre8FkY4aVs7Fi87IoLHowMziDXydipfcvS
         2tRsQjUIpzQmU7VL2RpnQYMSDrz0MOqG5K9MZ2b8UygErcskFFBwDWzc1DAJA9gNQG
         +SbUBwxfQzlBU2dsaP22IYGKuI5/bR5Y7uiz0Ri4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 138/361] scsi: ufs: Schedule clk gating work on correct queue
Date:   Sun, 11 Nov 2018 14:18:05 -0800
Message-Id: <20181111221639.842633609@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ufs/ufshcd.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -1691,8 +1691,9 @@ static void __ufshcd_release(struct ufs_
 
 	hba->clk_gating.state = REQ_CLKS_OFF;
 	trace_ufshcd_clk_gating(dev_name(hba->dev), hba->clk_gating.state);
-	schedule_delayed_work(&hba->clk_gating.gate_work,
-			msecs_to_jiffies(hba->clk_gating.delay_ms));
+	queue_delayed_work(hba->clk_gating.clk_gating_workq,
+			   &hba->clk_gating.gate_work,
+			   msecs_to_jiffies(hba->clk_gating.delay_ms));
 }
 
 void ufshcd_release(struct ufs_hba *hba)


