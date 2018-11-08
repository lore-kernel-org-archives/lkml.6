Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAED6C43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F7220857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkAQoCSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F7220857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbeKIIRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbeKIHeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:01 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F5EF2089A;
        Thu,  8 Nov 2018 21:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714193;
        bh=wfWM3X4a4cbs600ZtWALGJaXie3pjlc7r37Lg8AyCa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PkAQoCSq5Kb5jrRE/V1iCMR1bgfGy4V9qfPK5Fm95SIlmO6L8xjxJoatLqzzdpAsF
         gNB6veqRDoIofpJyKugBAJ+G4XYWxZtmuNwzOdDnMjbqE1dt5EQoWC2ck9qmRrMeXH
         ieKPHuBL46gkFVvfiivXXW76nimo2OnIikezD5c8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ken Xue <Ken.Xue@amd.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Xiangliang Yu <Xiangliang.Yu@amd.com>,
        "James E.J. Bottomley" <JBottomley@odin.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Terry <Michael.terry@canonical.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 114/144] Revert "SCSI: Fix NULL pointer dereference in runtime PM"
Date:   Thu,  8 Nov 2018 13:51:25 -0800
Message-Id: <20181108215106.202460357@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1c69d3b6eb73e466ecbb8edaf1bc7fd585b288da ]

This reverts commit 49718f0fb8c9 ("SCSI: Fix NULL pointer dereference in
runtime PM")

The old commit may lead to a issue that blk_{pre|post}_runtime_suspend and
blk_{pre|post}_runtime_resume may not be called in pairs.

Take sr device as example, when sr device goes to runtime suspend,
blk_{pre|post}_runtime_suspend will be called since sr device defined
pm->runtime_suspend. But blk_{pre|post}_runtime_resume will not be called
since sr device doesn't have pm->runtime_resume. so, sr device can not
resume correctly anymore.

More discussion can be found from below link.
http://marc.info/?l=linux-scsi&m=144163730531875&w=2

Signed-off-by: Ken Xue <Ken.Xue@amd.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Cc: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: James E.J. Bottomley <JBottomley@odin.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Michael Terry <Michael.terry@canonical.com>
Cc: stable@vger.kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi_pm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index a2dcf6a54ec6..75320dad9677 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -221,13 +221,13 @@ static int sdev_runtime_suspend(struct device *dev)
 	struct scsi_device *sdev = to_scsi_device(dev);
 	int err = 0;
 
-	if (pm && pm->runtime_suspend) {
-		err = blk_pre_runtime_suspend(sdev->request_queue);
-		if (err)
-			return err;
+	err = blk_pre_runtime_suspend(sdev->request_queue);
+	if (err)
+		return err;
+	if (pm && pm->runtime_suspend)
 		err = pm->runtime_suspend(dev);
-		blk_post_runtime_suspend(sdev->request_queue, err);
-	}
+	blk_post_runtime_suspend(sdev->request_queue, err);
+
 	return err;
 }
 
@@ -250,11 +250,11 @@ static int sdev_runtime_resume(struct device *dev)
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int err = 0;
 
-	if (pm && pm->runtime_resume) {
-		blk_pre_runtime_resume(sdev->request_queue);
+	blk_pre_runtime_resume(sdev->request_queue);
+	if (pm && pm->runtime_resume)
 		err = pm->runtime_resume(dev);
-		blk_post_runtime_resume(sdev->request_queue, err);
-	}
+	blk_post_runtime_resume(sdev->request_queue, err);
+
 	return err;
 }
 
-- 
2.17.1



