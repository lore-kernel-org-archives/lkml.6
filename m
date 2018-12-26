Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A106218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864844;
	bh=fP/fDD7nwyxppWA5KHMWf+vLqAm+sDnyMOlqNj0tOYc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QWHZTvstDL5I63uu8i/43NF4caCYAXX/QMOigf4999YB94EWXIPA3Dm5UmqH6cCDY
	 tWP4i9fjQHBjqcVhstcNCLhEREb3lso4mIZNbGyCz2q7kEB/K1b9spOPvq4nshdpJn
	 qbV5cV96Mv2K/kYH+ziGPwJLz8DZopvBBIRmhzHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbeLZWyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbeLZWyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:54:00 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71008218EA;
        Wed, 26 Dec 2018 22:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864840;
        bh=fP/fDD7nwyxppWA5KHMWf+vLqAm+sDnyMOlqNj0tOYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8mpWoDPlaz8KoINOcyUEO3+/eGsD6d5J5wpSczNn57XdcmwkV7JZ4wyfg7shqHh0
         RtdIvXnxACeIusaNXFCcF3cyjZy6YZxGIJewd9JVE4AUO3+SIyaaFmQsBPfS/EPLwM
         8kj+rC4DHneOSZbqaIAONsVhe3n7o/9MjKe/lzM8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 09/35] scsi: bnx2fc: Fix NULL dereference in error handling
Date:   Wed, 26 Dec 2018 17:41:16 -0500
Message-Id: <20181226224142.150866-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226224142.150866-1-sashal@kernel.org>
References: <20181226224142.150866-1-sashal@kernel.org>
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
index bee7d37367ca..68cc332bd6cb 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2331,7 +2331,7 @@ static int _bnx2fc_create(struct net_device *netdev,
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
 		rc = -ENOMEM;
-		goto ifput_err;
+		goto netdev_err;
 	}
 
 	if (netdev->priv_flags & IFF_802_1Q_VLAN) {
-- 
2.19.1

