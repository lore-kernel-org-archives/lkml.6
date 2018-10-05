Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33A0C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B5B5213A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 17:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kFOt/cRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5B5213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbeJFA1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 20:27:46 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41179 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbeJFA1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 20:27:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id 23-v6so5015056pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZzCUUChjDLJ7vvvfNzAE6rhRTVbnaQkR1LxIqNsXUt4=;
        b=kFOt/cRw0mrInk1f48gYMFjEoOjUBSwn6dXBBHRWJ19pHwLauD+kJydieY8mTi6xmK
         5Z4ERnTn3J7PsscBuxU1GR7AnDxOPVrNcOiZAm3Pp8D2MlXfPRRxPE7g7OA544h18x1I
         10J2B8QaibY75e6R3a2YKjvRNoCx7Kspp5AeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZzCUUChjDLJ7vvvfNzAE6rhRTVbnaQkR1LxIqNsXUt4=;
        b=eKv8iNyOUGEyBi0GSQxAjFU+iqBq53Syj+pF0LnvzAUngX88BQSlTsgb6NIrzbt4co
         cl+beC2j5bNyI/+Olp5xsAxEDHBzQwkv1VIteSqjO9NePl+PEb+BaDgyas8914O8B9YJ
         NaXWcROpjQ4kcjq9N0YmaLuuLkIa096MOHeTmGL+km8Ijf97P4Dn9QU925WimcFuy6kk
         g1ZYvidOsjfUqGmxYZqIshEyI/7TzL+PxyIMhzfeo6BoctyLTUcSG5TWowhV2qCCvRff
         7XTS67y7smf1+tKbLCkFU+nGoISOMgZwct8PUujeNQd3GNifgpozVmd3VpFIoKfeGBn+
         qvkw==
X-Gm-Message-State: ABuFfogVU88G6hxB+hwCBHLVFnyHrhI6WMZ9Y3w36MwczljMUoclTj04
        i95glspzBB7+HGO+MfzPXyZC0A==
X-Google-Smtp-Source: ACcGV63o1+VrHh++znxYKAXw960ZGhfrzMO1oHI7KAluMX/1BzI2ypEKN7jjhWY1MTSeCcwu1YPJYg==
X-Received: by 2002:a63:84c1:: with SMTP id k184-v6mr1396539pgd.196.1538760483964;
        Fri, 05 Oct 2018 10:28:03 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:15c:202:201:e418:c825:76cf:5f64])
        by smtp.gmail.com with ESMTPSA id x17-v6sm11413525pfn.59.2018.10.05.10.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Oct 2018 10:28:03 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Vinayak Holikatti <vinholikatti@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        sayalil@codeaurora.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH] scsi: ufs: Schedule clk gating work on correct queue
Date:   Fri,  5 Oct 2018 10:27:32 -0700
Message-Id: <20181005172732.203793-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With commit 10e5e37581fc ("scsi: ufs: Add clock ungating to a separate
workqueue"), clock gating work was moved to a
separate work queue with WQ_MEM_RECLAIM set, since clock
gating could occur from a memory reclaim context. Unfortunately,
clk_gating.gate_work was left queued via schedule_delayed_work,
which is a system workqueue that does not have WQ_MEM_RECLAIM set.
Because ufshcd_ungate_work attempts to cancel gate_work, the
following warning appears:

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
2.16.4

