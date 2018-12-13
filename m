Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80764C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4564B20849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675752;
	bh=I8h22XrbPhn7qbqSPPN4racHgtXt3720dVCM9AdkbRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QNweRyas5+MdcMePYOUb/RtiU4+koCd9CkDiTdm7BledRMIspdldarIAE1c4rP0ad
	 HNQB+qPTYZnJ7YVfLR26W7Kwe4yp4E3ZgnQadMOXudokoEzTMG49jFDsyjOBr2FPdd
	 NTXbemqtQyV2IKwKV0tREHlw2CJTbCQCWGgCs4OU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4564B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeLMEfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbeLMEdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:33:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C343620879;
        Thu, 13 Dec 2018 04:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675626;
        bh=I8h22XrbPhn7qbqSPPN4racHgtXt3720dVCM9AdkbRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kYoYvWCH0KRPbAxXCo08785FbI05dVmfRvklj8MtNIaRrfn2k4Ui1YxuSp+4fb13C
         x9YP28tm/kszV7PkQPGzspiTsc6oKh0VNzs+Lsk3LH0Zzma7+dJ/7fQIZAJWRnKnNg
         CrWL+I6HB/dfsMXbeMyAtvMOAWRxwxAlrUhH0qog=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Cathy Avery <cavery@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 02/16] scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq during unload
Date:   Wed, 12 Dec 2018 23:33:29 -0500
Message-Id: <20181213043343.76896-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043343.76896-1-sashal@kernel.org>
References: <20181213043343.76896-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cathy Avery <cavery@redhat.com>

[ Upstream commit 02f425f811cefcc4d325d7a72272651e622dc97e ]

Currently pvscsi_remove calls free_irq more than once as
pvscsi_release_resources and __pvscsi_shutdown both call
pvscsi_shutdown_intr. This results in a 'Trying to free already-free IRQ'
warning and stack trace. To solve the problem pvscsi_shutdown_intr has been
moved out of pvscsi_release_resources.

Signed-off-by: Cathy Avery <cavery@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/vmw_pvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index d5dd70049f81..25119780edae 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -1225,8 +1225,6 @@ static void pvscsi_shutdown_intr(struct pvscsi_adapter *adapter)
 
 static void pvscsi_release_resources(struct pvscsi_adapter *adapter)
 {
-	pvscsi_shutdown_intr(adapter);
-
 	if (adapter->workqueue)
 		destroy_workqueue(adapter->workqueue);
 
@@ -1555,6 +1553,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_reset_adapter:
 	ll_adapter_reset(adapter);
 out_release_resources:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	scsi_host_put(host);
 out_disable_device:
@@ -1563,6 +1562,7 @@ static int pvscsi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return error;
 
 out_release_resources_and_disable:
+	pvscsi_shutdown_intr(adapter);
 	pvscsi_release_resources(adapter);
 	goto out_disable_device;
 }
-- 
2.19.1

