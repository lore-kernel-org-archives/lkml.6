Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F613C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1565A205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/+8Be2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1565A205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732317AbeK3B25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731250AbeK3B24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CABC20868;
        Thu, 29 Nov 2018 14:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501404;
        bh=XMlalHojp8qYj0XYsKnDaBe6d47+TVrOxZehxfzWC/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/+8Be2j2hPSY5allspTFuxS10mWhHCHHo3afcBMzs2ZofyFA85wbi7mih2NQj/0a
         IrMlEf5U8pjJy0OCiBm55yQB9KcFeuSZfqTGF4yx4FPCmGDvAswIjNd6o/uCdtvEm7
         81GopU4pM2O+EEMQLe/9itDfMzjKse2Uh/+fr/K4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sahitya Tummala <stummala@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 77/92] scsi: ufs: fix race between clock gating and devfreq scaling work
Date:   Thu, 29 Nov 2018 15:12:46 +0100
Message-Id: <20181129140112.725483204@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140106.520639693@linuxfoundation.org>
References: <20181129140106.520639693@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Subhash Jadavani <subhashj@codeaurora.org>

commit 30fc33f1ef475480dc5bea4fe1bda84b003b992c upstream.

UFS devfreq clock scaling work may require clocks to be ON if it need to
execute some UFS commands hence it may request for clock hold before
issuing the command. But if UFS clock gating work is already running in
parallel, ungate work would end up waiting for the clock gating work to
finish and as clock gating work would also wait for the clock scaling
work to finish, we would enter in deadlock state. Here is the call trace
during this deadlock state:

Workqueue: devfreq_wq devfreq_monitor
	__switch_to
	__schedule
	schedule
	schedule_timeout
	wait_for_common
	wait_for_completion
	flush_work
	ufshcd_hold
	ufshcd_send_uic_cmd
	ufshcd_dme_get_attr
	ufs_qcom_set_dme_vs_core_clk_ctrl_clear_div
	ufs_qcom_clk_scale_notify
	ufshcd_scale_clks
	ufshcd_devfreq_target
	update_devfreq
	devfreq_monitor
	process_one_work
	worker_thread
	kthread
	ret_from_fork

Workqueue: events ufshcd_gate_work
	__switch_to
	__schedule
	schedule
	schedule_preempt_disabled
	__mutex_lock_slowpath
	mutex_lock
	devfreq_monitor_suspend
	devfreq_simple_ondemand_handler
	devfreq_suspend_device
	ufshcd_gate_work
	process_one_work
	worker_thread
	kthread
	ret_from_fork

Workqueue: events ufshcd_ungate_work
	__switch_to
	__schedule
	schedule
	schedule_timeout
	wait_for_common
	wait_for_completion
	flush_work
	__cancel_work_timer
	cancel_delayed_work_sync
	ufshcd_ungate_work
	process_one_work
	worker_thread
	kthread
	ret_from_fork

This change fixes this deadlock by doing this in devfreq work (devfreq_wq):
Try cancelling clock gating work. If we are able to cancel gating work
or it wasn't scheduled, hold the clock reference count until scaling is
in progress. If gate work is already running in parallel, let's skip
the frequecy scaling at this time and it will be retried once next scaling
window expires.

Reviewed-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6633,15 +6633,47 @@ static int ufshcd_devfreq_target(struct
 {
 	int err = 0;
 	struct ufs_hba *hba = dev_get_drvdata(dev);
+	bool release_clk_hold = false;
+	unsigned long irq_flags;
 
 	if (!ufshcd_is_clkscaling_enabled(hba))
 		return -EINVAL;
 
+	spin_lock_irqsave(hba->host->host_lock, irq_flags);
+	if (ufshcd_eh_in_progress(hba)) {
+		spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+		return 0;
+	}
+
+	if (ufshcd_is_clkgating_allowed(hba) &&
+	    (hba->clk_gating.state != CLKS_ON)) {
+		if (cancel_delayed_work(&hba->clk_gating.gate_work)) {
+			/* hold the vote until the scaling work is completed */
+			hba->clk_gating.active_reqs++;
+			release_clk_hold = true;
+			hba->clk_gating.state = CLKS_ON;
+		} else {
+			/*
+			 * Clock gating work seems to be running in parallel
+			 * hence skip scaling work to avoid deadlock between
+			 * current scaling work and gating work.
+			 */
+			spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+			return 0;
+		}
+	}
+	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+
 	if (*freq == UINT_MAX)
 		err = ufshcd_scale_clks(hba, true);
 	else if (*freq == 0)
 		err = ufshcd_scale_clks(hba, false);
 
+	spin_lock_irqsave(hba->host->host_lock, irq_flags);
+	if (release_clk_hold)
+		__ufshcd_release(hba);
+	spin_unlock_irqrestore(hba->host->host_lock, irq_flags);
+
 	return err;
 }
 


