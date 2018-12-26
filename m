Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964CAC43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DF218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864829;
	bh=0D0pHnv5oRmunLo6xE42EFaSuUxellEFXE9yVR/kfH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCVSX8PVwz2p/cKcub3f92prL+iadeG6cLHe4ViH4Lm+WWA+RNVlJKMS4bNmBr46e
	 SjxFT6DfkL1pwW4469OzWxVU27tfX4M1iiIMUBe6GqUDVfuLH76sWVlcPJKPmSFxEJ
	 +QibCQijlcMnvPvw1kO0lR3AS6gU6I802iWiUxII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeLZWgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:36:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeLZWgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:36:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D987218EA;
        Wed, 26 Dec 2018 22:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545863792;
        bh=0D0pHnv5oRmunLo6xE42EFaSuUxellEFXE9yVR/kfH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CqQrRj3fgjI5yb1CIu7pn+9JF9BDh81+XWqiPMzO5tQzDbzLBBfSrvBwIyqrAdGrT
         vgGtrUvBIOFlpdaSzf7n8jbNptYFvulf+0fnfIxZRMzjeZTpLHASwh14bIAZdWJR1Z
         lWbjwdVskTN8BDburccle3ocv3wSK/7AzdXE7xvE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 23/97] scsi: bnx2fc: Fix NULL dereference in error handling
Date:   Wed, 26 Dec 2018 17:34:43 -0500
Message-Id: <20181226223557.149329-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 9ae4f8420ed7be4b13c96600e3568c144d101a23 ]

If "interface" is NULL then we can't release it and trying to will only
lead to an Oops.

Fixes: aea71a024914 ("[SCSI] bnx2fc: Introduce interface structure for each vlan interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index f00045813378..3f97ec4aac4b 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2371,7 +2371,7 @@ static int _bnx2fc_create(struct net_device *netdev,
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
 		rc = -ENOMEM;
-		goto ifput_err;
+		goto netdev_err;
 	}
 
 	if (is_vlan_dev(netdev)) {
-- 
2.19.1

