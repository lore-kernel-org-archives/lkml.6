Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7CBC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933622085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550955950;
	bh=EB+mXnwYQD9DYnEdtuarFGfs38F1YwFB0/tKUYtA1rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bog3k1j0XWUFOjVI2Vg4P4Gds0PmBE9rVij8ym/sJK1PiYLlkDk/4auz5mCNGLvHt
	 oWcLoNlnOdsXhqT18xFwEU4fxk0m1omJGEkEQfEto66+Wk4ePDG4B514+KDWIgjXwe
	 OcKFoyAcRtbNoFiZ8o+yoMDq3SutZR+31bHoKMPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfBWVFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 16:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728496AbfBWVFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 16:05:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38473206B6;
        Sat, 23 Feb 2019 21:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550955942;
        bh=EB+mXnwYQD9DYnEdtuarFGfs38F1YwFB0/tKUYtA1rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=njBM8fkMxK7eBAlo6hdlQtP6rKNmQ3xdPiuYZxQnFJTvVOv6UgYnIBnmd5dsa61wq
         xFnwIHrHsJsICLLqbINzEX/3ec7OOFOPinLz8O9OTRcDLbqy8Gjr2q+FGmUUEFX7P9
         DLhXEqtHRgwfncW62q/g7cgA6KoIePU2irul43Mw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 50/72] scsi: bnx2fc: Fix error handling in probe()
Date:   Sat, 23 Feb 2019 16:04:00 -0500
Message-Id: <20190223210422.199966-50-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190223210422.199966-1-sashal@kernel.org>
References: <20190223210422.199966-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b2d3492fc591b1fb46b81d79ca1fc44cac6ae0ae ]

There are two issues here.  First if cmgr->hba is not set early enough then
it leads to a NULL dereference.  Second if we don't completely initialize
cmgr->io_bdt_pool[] then we end up dereferencing uninitialized pointers.

Fixes: 853e2bd2103a ("[SCSI] bnx2fc: Broadcom FCoE offload driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_io.c b/drivers/scsi/bnx2fc/bnx2fc_io.c
index 350257c13a5ba..bc9f2a2365f4d 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_io.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_io.c
@@ -240,6 +240,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 		return NULL;
 	}
 
+	cmgr->hba = hba;
 	cmgr->free_list = kcalloc(arr_sz, sizeof(*cmgr->free_list),
 				  GFP_KERNEL);
 	if (!cmgr->free_list) {
@@ -256,7 +257,6 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 		goto mem_err;
 	}
 
-	cmgr->hba = hba;
 	cmgr->cmds = (struct bnx2fc_cmd **)(cmgr + 1);
 
 	for (i = 0; i < arr_sz; i++)  {
@@ -295,7 +295,7 @@ struct bnx2fc_cmd_mgr *bnx2fc_cmd_mgr_alloc(struct bnx2fc_hba *hba)
 
 	/* Allocate pool of io_bdts - one for each bnx2fc_cmd */
 	mem_size = num_ios * sizeof(struct io_bdt *);
-	cmgr->io_bdt_pool = kmalloc(mem_size, GFP_KERNEL);
+	cmgr->io_bdt_pool = kzalloc(mem_size, GFP_KERNEL);
 	if (!cmgr->io_bdt_pool) {
 		printk(KERN_ERR PFX "failed to alloc io_bdt_pool\n");
 		goto mem_err;
-- 
2.19.1

