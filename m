Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C3BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBF720874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216698;
	bh=nA1vyRUxulD6OO+GhsiOQZgx6pMhiowWilBltptJF1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mqge4OdJ/9bEB9RPmcqRVgdUYrui0wTBTHzMhLjF3xdEVr5vIdVcnxdv0CFyi7f3Y
	 WiMd72j8puShV6rrFaNsnm2BF3PAsr5atHCe1ftQ3w6gfH/z8+nP9hKl0WqmYdnLwR
	 to/ewcRKN7bkadslgq886I0Hrm73TwHt7ER1e7SA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388241AbfAKOY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:24:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732115AbfAKOSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33882177B;
        Fri, 11 Jan 2019 14:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216330;
        bh=nA1vyRUxulD6OO+GhsiOQZgx6pMhiowWilBltptJF1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHFBuXwFi4+g8Rgo442ikUOq1MrhZwXhF4dIvPfRos31HL8rKQkCuErlSSKG37b0f
         1pQpa8NVnLif4Fr2vnCfs1S6P2mDoKyx2ek0hur1vy39N7Li1MY+xq9TovQX4kkNiW
         ykzLeoIrix3cGkGSwEOGqcuwx8oMKkIJeNSS1jJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 61/88] scsi: bnx2fc: Fix NULL dereference in error handling
Date:   Fri, 11 Jan 2019 15:08:30 +0100
Message-Id: <20190111131056.282264954@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index d0b227ffbd5f..573aeec7a02b 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -2279,7 +2279,7 @@ static int _bnx2fc_create(struct net_device *netdev,
 	if (!interface) {
 		printk(KERN_ERR PFX "bnx2fc_interface_create failed\n");
 		rc = -ENOMEM;
-		goto ifput_err;
+		goto netdev_err;
 	}
 
 	if (netdev->priv_flags & IFF_802_1Q_VLAN) {
-- 
2.19.1



