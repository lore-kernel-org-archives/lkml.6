Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D772C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80BF21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFNpId4O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C80BF21104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeK3B2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:28:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731487AbeK3B2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:28:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8BFB2145D;
        Thu, 29 Nov 2018 14:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501402;
        bh=4NMHMXWbfTSVfDlvs7JONDWPY2hDrVZ7bOVKcvj/IPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OFNpId4OvHHxN/PGfY5HwirG8CPIsSKuCMKcuvQ4tuyc88cFh3ndqKHLOhwj2k1iP
         c/+rUigo/yDCmLP1fny/pDoMeoXUknePuuq06xlwRQN9tf4/EkohAZJd74lqzrmUZX
         OPcJ6FAcx6siKKQyKvOM4K32pOGS+RVJzh2MIMic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 76/92] scsi: ufshcd: Fix race between clk scaling and ungate work
Date:   Thu, 29 Nov 2018 15:12:45 +0100
Message-Id: <20181129140112.641547400@linuxfoundation.org>
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

From: Venkat Gopalakrishnan <venkatg@codeaurora.org>

commit f2a785ac23125fa0774327d39e837e45cf28fe92 upstream.

The ungate work turns on the clock before it exits hibern8, if the link
was put in hibern8 during clock gating work.  There occurs a race
condition when clock scaling work calls ufshcd_hold() to make sure low
power states cannot be entered, but that returns by checking only
whether the clocks are on.  This causes the clock scaling work to issue
UIC commands when the link is in hibern8 causing failures. Make sure we
exit hibern8 state before returning from ufshcd_hold().

Callstacks for race condition:

 ufshcd_scale_gear
 ufshcd_devfreq_scale
 ufshcd_devfreq_target
 update_devfreq
 devfreq_monitor
 process_one_work
 worker_thread
 kthread
 ret_from_fork

 ufshcd_uic_hibern8_exit
 ufshcd_ungate_work
 process_one_work
 worker_thread
 kthread
 ret_from_fork

Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/ufs/ufshcd.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -672,6 +672,21 @@ int ufshcd_hold(struct ufs_hba *hba, boo
 start:
 	switch (hba->clk_gating.state) {
 	case CLKS_ON:
+		/*
+		 * Wait for the ungate work to complete if in progress.
+		 * Though the clocks may be in ON state, the link could
+		 * still be in hibner8 state if hibern8 is allowed
+		 * during clock gating.
+		 * Make sure we exit hibern8 state also in addition to
+		 * clocks being ON.
+		 */
+		if (ufshcd_can_hibern8_during_gating(hba) &&
+		    ufshcd_is_link_hibern8(hba)) {
+			spin_unlock_irqrestore(hba->host->host_lock, flags);
+			flush_work(&hba->clk_gating.ungate_work);
+			spin_lock_irqsave(hba->host->host_lock, flags);
+			goto start;
+		}
 		break;
 	case REQ_CLKS_OFF:
 		if (cancel_delayed_work(&hba->clk_gating.gate_work)) {


