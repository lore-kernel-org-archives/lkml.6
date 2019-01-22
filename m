Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0570C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7624820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548170294;
	bh=H4DZ82+ray06XcDeK25lwTE6YmctquLm3nar8Zg6id0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c1U0ayumzKVAZ7GWDDD4VEbf/NB4tJrvwgtkwIryn1Q6kRr5VcMyZPLFdD12ftrfR
	 Q9vN74o1yKMMNHvVP1LjQFXZUa+hSWhdMO/65bPX+gJCcJdrBRdXTBZv6eQBvMCMnc
	 68ZNuZeb5WzLRAbtx7N+nJIddBdotzpBUP8bKBiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfAVPSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:18:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729101AbfAVPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:18:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F9420879;
        Tue, 22 Jan 2019 15:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548170291;
        bh=H4DZ82+ray06XcDeK25lwTE6YmctquLm3nar8Zg6id0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q0INdCp9GJLF09d4PxAVcE/r4LKuuz1nkpVU93/OilG2lXvr+tMEi4wTQMJu+IPpa
         F1VZeblNRDuACTfzTGbr64Q1KyvlmlpIWShLW3OmmY0HUnpzw/xIhIHdTt7DG4P2p7
         3sopyg9/gM0jEd+eLnAmkAV+GsbDO4zjxW6EocWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steve Wise <swise@chelsio.com>
Subject: [PATCH 1/8] infiniband: cxgb4: no need to check return value of debugfs_create functions
Date:   Tue, 22 Jan 2019 16:17:53 +0100
Message-Id: <20190122151800.15092-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151800.15092-1-gregkh@linuxfoundation.org>
References: <20190122151800.15092-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Steve Wise <swise@chelsio.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/cxgb4/device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index c13c0ba30f63..9c10fff6dcfb 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -720,11 +720,8 @@ static const struct file_operations ep_debugfs_fops = {
 	.read    = debugfs_read,
 };
 
-static int setup_debugfs(struct c4iw_dev *devp)
+static void setup_debugfs(struct c4iw_dev *devp)
 {
-	if (!devp->debugfs_root)
-		return -1;
-
 	debugfs_create_file_size("qps", S_IWUSR, devp->debugfs_root,
 				 (void *)devp, &qp_debugfs_fops, 4096);
 
@@ -740,7 +737,6 @@ static int setup_debugfs(struct c4iw_dev *devp)
 	if (c4iw_wr_log)
 		debugfs_create_file_size("wr_log", S_IWUSR, devp->debugfs_root,
 					 (void *)devp, &wr_log_debugfs_fops, 4096);
-	return 0;
 }
 
 void c4iw_release_dev_ucontext(struct c4iw_rdev *rdev,
@@ -1553,8 +1549,6 @@ static int __init c4iw_init_module(void)
 		return err;
 
 	c4iw_debugfs_root = debugfs_create_dir(DRV_NAME, NULL);
-	if (!c4iw_debugfs_root)
-		pr_warn("could not create debugfs entry, continuing\n");
 
 	reg_workq = create_singlethread_workqueue("Register_iWARP_device");
 	if (!reg_workq) {
-- 
2.20.1

