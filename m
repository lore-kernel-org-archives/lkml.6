Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B41C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D45421019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RERctOGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D45421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbeK2RCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728026AbeK2RCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:12 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0E7208E7;
        Thu, 29 Nov 2018 05:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471081;
        bh=Lf7I0Z31CigNxRKeDEf6Ap1T/K5AZP7iGPN46dsSLb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RERctOGEiEH3y20saamH2OFCynNaTYm/zaOtpWjNJxZLm9YMISn9XdCSgBLcLaZIj
         2j/SKtpWMV4JsDlvprITMd1X/rKOBRJrrglkgxl+ACkHZ/AS9lm9l6jpaWR0PUzpq+
         fSu4Fa2gcT7GmnSShVCNatuJp5EvsRPzdqnxIeTU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Shen Jing <jingx.shen@intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/68] Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers"
Date:   Thu, 29 Nov 2018 00:55:14 -0500
Message-Id: <20181129055559.159228-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shen Jing <jingx.shen@intel.com>

[ Upstream commit a9c859033f6ec772f8e3228c343bb1321584ae0e ]

This reverts commit b4194da3f9087dd38d91b40f9bec42d59ce589a8
since it causes list corruption followed by kernel panic:

Workqueue: adb ffs_aio_cancel_worker
RIP: 0010:__list_add_valid+0x4d/0x70
Call Trace:
insert_work+0x47/0xb0
__queue_work+0xf6/0x400
queue_work_on+0x65/0x70
dwc3_gadget_giveback+0x44/0x50 [dwc3]
dwc3_gadget_ep_dequeue+0x83/0x2d0 [dwc3]
? finish_wait+0x80/0x80
usb_ep_dequeue+0x1e/0x90
process_one_work+0x18c/0x3b0
worker_thread+0x3c/0x390
? process_one_work+0x3b0/0x3b0
kthread+0x11e/0x140
? kthread_create_worker_on_cpu+0x70/0x70
ret_from_fork+0x3a/0x50

This issue is seen with warm reboot stability testing.

Signed-off-by: Shen Jing <jingx.shen@intel.com>
Signed-off-by: Saranya Gopal <saranya.gopal@intel.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_fs.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 3ada83d81bda..31e8bf3578c8 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -215,7 +215,6 @@ struct ffs_io_data {
 
 	struct mm_struct *mm;
 	struct work_struct work;
-	struct work_struct cancellation_work;
 
 	struct usb_ep *ep;
 	struct usb_request *req;
@@ -1073,31 +1072,22 @@ ffs_epfile_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static void ffs_aio_cancel_worker(struct work_struct *work)
-{
-	struct ffs_io_data *io_data = container_of(work, struct ffs_io_data,
-						   cancellation_work);
-
-	ENTER();
-
-	usb_ep_dequeue(io_data->ep, io_data->req);
-}
-
 static int ffs_aio_cancel(struct kiocb *kiocb)
 {
 	struct ffs_io_data *io_data = kiocb->private;
-	struct ffs_data *ffs = io_data->ffs;
+	struct ffs_epfile *epfile = kiocb->ki_filp->private_data;
 	int value;
 
 	ENTER();
 
-	if (likely(io_data && io_data->ep && io_data->req)) {
-		INIT_WORK(&io_data->cancellation_work, ffs_aio_cancel_worker);
-		queue_work(ffs->io_completion_wq, &io_data->cancellation_work);
-		value = -EINPROGRESS;
-	} else {
+	spin_lock_irq(&epfile->ffs->eps_lock);
+
+	if (likely(io_data && io_data->ep && io_data->req))
+		value = usb_ep_dequeue(io_data->ep, io_data->req);
+	else
 		value = -EINVAL;
-	}
+
+	spin_unlock_irq(&epfile->ffs->eps_lock);
 
 	return value;
 }
-- 
2.17.1

