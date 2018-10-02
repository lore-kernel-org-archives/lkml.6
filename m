Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DE7C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9112B2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9112B2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJBUKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:10:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeJBUKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:10:02 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A0038BF0;
        Tue,  2 Oct 2018 13:26:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niklas Cassel <niklas.cassel@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 022/228] iommu/msm: Dont call iommu_device_{,un}link from atomic context
Date:   Tue,  2 Oct 2018 06:21:59 -0700
Message-Id: <20181002132500.583331949@linuxfoundation.org>
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

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit 379521462e4add27f3514da8e4ab1fd7a54fe1c7 ]

Fixes the following splat during boot:

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:747
in_atomic(): 1, irqs_disabled(): 128, pid: 77, name: kworker/2:1
4 locks held by kworker/2:1/77:
 #0: (ptrval) ((wq_completion)"events"){+.+.}, at: process_one_work+0x1fc/0x8fc
 #1: (ptrval) (deferred_probe_work){+.+.}, at: process_one_work+0x1fc/0x8fc
 #2: (ptrval) (&dev->mutex){....}, at: __device_attach+0x40/0x178
 #3: (ptrval) (msm_iommu_lock){....}, at: msm_iommu_add_device+0x28/0xcc
irq event stamp: 348
hardirqs last  enabled at (347): [<c049dc18>] kfree+0xe0/0x3c0
hardirqs last disabled at (348): [<c0c35cac>] _raw_spin_lock_irqsave+0x2c/0x68
softirqs last  enabled at (0): [<c0322fd8>] copy_process.part.5+0x280/0x1a68
softirqs last disabled at (0): [<00000000>]   (null)
Preemption disabled at:
[<00000000>]   (null)
CPU: 2 PID: 77 Comm: kworker/2:1 Not tainted 4.17.0-rc5-wt-ath-01075-gaca0516bb4cf #239
Hardware name: Generic DT based system
Workqueue: events deferred_probe_work_func
[<c0314e00>] (unwind_backtrace) from [<c030fc70>] (show_stack+0x20/0x24)
[<c030fc70>] (show_stack) from [<c0c16ad8>] (dump_stack+0xa0/0xcc)
[<c0c16ad8>] (dump_stack) from [<c035a978>] (___might_sleep+0x1f8/0x2d4)
ath10k_sdio mmc2:0001:1: Direct firmware load for ath10k/QCA9377/hw1.0/board-2.bin failed with error -2
[<c035a978>] (___might_sleep) from [<c035aac4>] (__might_sleep+0x70/0xa8)
[<c035aac4>] (__might_sleep) from [<c0c3066c>] (__mutex_lock+0x50/0xb28)
[<c0c3066c>] (__mutex_lock) from [<c0c31170>] (mutex_lock_nested+0x2c/0x34)
ath10k_sdio mmc2:0001:1: board_file api 1 bmi_id N/A crc32 544289f7
[<c0c31170>] (mutex_lock_nested) from [<c052d798>] (kernfs_find_and_get_ns+0x30/0x5c)
[<c052d798>] (kernfs_find_and_get_ns) from [<c0531cc8>] (sysfs_add_link_to_group+0x28/0x58)
[<c0531cc8>] (sysfs_add_link_to_group) from [<c07ef75c>] (iommu_device_link+0x50/0xb4)
[<c07ef75c>] (iommu_device_link) from [<c07f2288>] (msm_iommu_add_device+0xa0/0xcc)
[<c07f2288>] (msm_iommu_add_device) from [<c07ec6d0>] (add_iommu_group+0x3c/0x64)
[<c07ec6d0>] (add_iommu_group) from [<c07f9d40>] (bus_for_each_dev+0x84/0xc4)
[<c07f9d40>] (bus_for_each_dev) from [<c07ec7c8>] (bus_set_iommu+0xd0/0x10c)
[<c07ec7c8>] (bus_set_iommu) from [<c07f1a68>] (msm_iommu_probe+0x5b8/0x66c)
[<c07f1a68>] (msm_iommu_probe) from [<c07feaa8>] (platform_drv_probe+0x60/0xbc)
[<c07feaa8>] (platform_drv_probe) from [<c07fc1fc>] (driver_probe_device+0x30c/0x4cc)
[<c07fc1fc>] (driver_probe_device) from [<c07fc59c>] (__device_attach_driver+0xac/0x14c)
[<c07fc59c>] (__device_attach_driver) from [<c07f9e14>] (bus_for_each_drv+0x68/0xc8)
[<c07f9e14>] (bus_for_each_drv) from [<c07fbd3c>] (__device_attach+0xe4/0x178)
[<c07fbd3c>] (__device_attach) from [<c07fc698>] (device_initial_probe+0x1c/0x20)
[<c07fc698>] (device_initial_probe) from [<c07faee8>] (bus_probe_device+0x98/0xa0)
[<c07faee8>] (bus_probe_device) from [<c07fb4f4>] (deferred_probe_work_func+0x74/0x198)
[<c07fb4f4>] (deferred_probe_work_func) from [<c0348eb4>] (process_one_work+0x2c4/0x8fc)
[<c0348eb4>] (process_one_work) from [<c03497b0>] (worker_thread+0x2c4/0x5cc)
[<c03497b0>] (worker_thread) from [<c0350d10>] (kthread+0x180/0x188)
[<c0350d10>] (kthread) from [<c03010b4>] (ret_from_fork+0x14/0x20)

Fixes: 42df43b36163 ("iommu/msm: Make use of iommu_device_register interface")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Reviewed-by: Vivek Gautam <vivek.gautam@codeaurora.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/msm_iommu.c |   16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -395,20 +395,15 @@ static int msm_iommu_add_device(struct d
 	struct msm_iommu_dev *iommu;
 	struct iommu_group *group;
 	unsigned long flags;
-	int ret = 0;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-
 	iommu = find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
 	if (iommu)
 		iommu_device_link(&iommu->iommu, dev);
 	else
-		ret = -ENODEV;
-
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
-	if (ret)
-		return ret;
+		return -ENODEV;
 
 	group = iommu_group_get_for_dev(dev);
 	if (IS_ERR(group))
@@ -425,13 +420,12 @@ static void msm_iommu_remove_device(stru
 	unsigned long flags;
 
 	spin_lock_irqsave(&msm_iommu_lock, flags);
-
 	iommu = find_iommu_for_dev(dev);
+	spin_unlock_irqrestore(&msm_iommu_lock, flags);
+
 	if (iommu)
 		iommu_device_unlink(&iommu->iommu, dev);
 
-	spin_unlock_irqrestore(&msm_iommu_lock, flags);
-
 	iommu_group_remove_device(dev);
 }
 


