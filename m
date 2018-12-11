Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EE4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B69720879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544648;
	bh=mrrjWM2Agqd4WHzwkPDRYdT0A8KQA4i8/AqTdcD3NcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l6kFaLBpyrTczx11ZHLYedpYw+DZU/Xxo69X5HtFrssf2N5jW5z0MkUote6GbIRtF
	 TlTD7JPMeQM4xLbZHd/OYzNXbef8l8zjBb8SGnbr9+ha3Kn13IMDO49uUpWzTZmYsi
	 sMP1+ZXPsluW0NGvg0Aptw1/sraZq8xEdwNMU2WU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B69720879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbeLKQKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728661AbeLKPvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:51:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CA8920855;
        Tue, 11 Dec 2018 15:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543478;
        bh=mrrjWM2Agqd4WHzwkPDRYdT0A8KQA4i8/AqTdcD3NcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R8bhgHGfNPS0ki5GmeapkrWFg7Y0KEUe7rw5ZeSKC26vkSJNmg/IMf1aHT9FBnqKm
         etQ6XsiIlalRU/9JbkRzobCC1p4YSqT9GLX7twhFjXXPSo4K63DO5Yykg5eWWofAaQ
         JKhkycl7IILQAD23hIXk5hepvomylBgRz5u/PM70=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shen Jing <jingx.shen@intel.com>,
        Saranya Gopal <saranya.gopal@intel.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/67] Revert "usb: gadget: ffs: Fix BUG when userland exits with submitted AIO transfers"
Date:   Tue, 11 Dec 2018 16:41:14 +0100
Message-Id: <20181211151631.091509460@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 17467545391b..52e6897fa35a 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -219,7 +219,6 @@ struct ffs_io_data {
 
 	struct mm_struct *mm;
 	struct work_struct work;
-	struct work_struct cancellation_work;
 
 	struct usb_ep *ep;
 	struct usb_request *req;
@@ -1074,31 +1073,22 @@ ffs_epfile_open(struct inode *inode, struct file *file)
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
2.19.1



