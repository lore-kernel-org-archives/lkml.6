Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4690AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162D1206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218521;
	bh=1rN15FouHaMrs01INtpJo7WA8dHYMKC74+KAchNdVWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xuIlg2ZkCJ1K9d8Bjw+GizmdjqKAclmAZSsQQEjZ+k3rWUxN+lQjqK32Vs4D0JOAW
	 W9uFOXrA/gqGISP+XnxYKEpX63HI1hRUuCkhyPzsO2R3xR4hGCvyxMjBWpm+UcVNla
	 quVb1n+J2AwNt3rCJ9RNHSyIoFzz94i9DQ9/VJxo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390964AbfAKOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:55:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390476AbfAKOgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:36:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B31B82063F;
        Fri, 11 Jan 2019 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217411;
        bh=1rN15FouHaMrs01INtpJo7WA8dHYMKC74+KAchNdVWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DJqJX7hrJb2eWBrqXYonReCNVxV0G8F6hvd3xVLELizOmkXn1myarMhdwJ2otEGyh
         llfT7LjOADuiyCZBux44YhvawLtabp3FgiYMSUqdWKDS+4EbNzAypSKicQAFS7xGKS
         jANcDsXPRuwgK0hZOjQ5mKeGSVnquWDctrNGlxAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/148] scsi: bnx2fc: Fix NULL dereference in error handling
Date:   Fri, 11 Jan 2019 15:13:21 +0100
Message-Id: <20190111131115.241884716@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131114.337122649@linuxfoundation.org>
References: <20190111131114.337122649@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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



