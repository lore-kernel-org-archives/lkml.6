Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C30C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38142083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A38142083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbeJBULq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60936 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbeJBULp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:45 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 49033A67;
        Tue,  2 Oct 2018 13:28:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiaofei Tan <tanxiaofei@huawei.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 107/228] scsi: hisi_sas: Fix the conflict between dev gone and host reset
Date:   Tue,  2 Oct 2018 06:23:24 -0700
Message-Id: <20181002132506.646709915@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiaofei Tan <tanxiaofei@huawei.com>

[ Upstream commit d2fc401e47529d9ffd2673a5395d56002e31ad98 ]

There is a possible conflict when a device is removed and host reset occurs
concurrently.

The reason is that then the device is notified as gone, we try to clear the
ITCT, which is notified via an interrupt. The dev gone function pends on
this event with a completion, which is completed when the ITCT interrupt
occurs.

But host reset will disable all interrupts, the wait_for_completion() may
wait indefinitely.

This patch adds an semaphore to synchronise this two processes. The
semaphore is taken by the host reset as the basis of synchronising.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h      |    1 +
 drivers/scsi/hisi_sas/hisi_sas_main.c |    6 ++++++
 2 files changed, 7 insertions(+)

--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -277,6 +277,7 @@ struct hisi_hba {
 
 	int n_phy;
 	spinlock_t lock;
+	struct semaphore sem;
 
 	struct timer_list timer;
 	struct workqueue_struct *wq;
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -914,7 +914,9 @@ static void hisi_sas_dev_gone(struct dom
 
 		hisi_sas_dereg_device(hisi_hba, device);
 
+		down(&hisi_hba->sem);
 		hisi_hba->hw->clear_itct(hisi_hba, sas_dev);
+		up(&hisi_hba->sem);
 		device->lldd_dev = NULL;
 	}
 
@@ -1364,6 +1366,7 @@ static int hisi_sas_controller_reset(str
 	if (test_and_set_bit(HISI_SAS_RESET_BIT, &hisi_hba->flags))
 		return -1;
 
+	down(&hisi_hba->sem);
 	dev_info(dev, "controller resetting...\n");
 	old_state = hisi_hba->hw->get_phys_state(hisi_hba);
 
@@ -1378,6 +1381,7 @@ static int hisi_sas_controller_reset(str
 	if (rc) {
 		dev_warn(dev, "controller reset failed (%d)\n", rc);
 		clear_bit(HISI_SAS_REJECT_CMD_BIT, &hisi_hba->flags);
+		up(&hisi_hba->sem);
 		scsi_unblock_requests(shost);
 		goto out;
 	}
@@ -1388,6 +1392,7 @@ static int hisi_sas_controller_reset(str
 	hisi_hba->hw->phys_init(hisi_hba);
 	msleep(1000);
 	hisi_sas_refresh_port_id(hisi_hba);
+	up(&hisi_hba->sem);
 
 	if (hisi_hba->reject_stp_links_msk)
 		hisi_sas_terminate_stp_reject(hisi_hba);
@@ -2016,6 +2021,7 @@ int hisi_sas_alloc(struct hisi_hba *hisi
 	struct device *dev = hisi_hba->dev;
 	int i, s, max_command_entries = hisi_hba->hw->max_command_entries;
 
+	sema_init(&hisi_hba->sem, 1);
 	spin_lock_init(&hisi_hba->lock);
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		hisi_sas_phy_init(hisi_hba, i);


