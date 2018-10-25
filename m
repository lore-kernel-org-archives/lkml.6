Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF405C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3F192086D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qeqDWhYG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3F192086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbeJYWsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729083AbeJYWsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:40 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0764220870;
        Thu, 25 Oct 2018 14:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476944;
        bh=y0g6lqdTWjtoM3K5HOOZoZ3p8dhRDToQlhmBaYskoEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qeqDWhYGQbuKuIFaE77p+bDwZptuMipTaVku+0b7Ov6pTejKV/DK7Ay+5Z8/sTqlT
         6MZXMQ8pzY+mAFdo4GDqp69p39cXckki1TGtfcxEdYkv5FRHR/Cudg47qVHSYdkyU7
         GnfW2NXemtZhQ7ATh7So9tZg6/bOvapaHaljdRPU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 54/98] staging: wilc1000: Fix problem with wrong vif index
Date:   Thu, 25 Oct 2018 10:13:39 -0400
Message-Id: <20181025141423.213774-54-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Shankar <aditya.shankar@microchip.com>

[ Upstream commit 0e490657c7214cce33fbca3d88227298c5c968ae ]

The vif->idx value is always 0 for two interfaces.

wl->vif_num = 0;

loop {
     ...

     vif->idx = wl->vif_num;
     ...
     wl->vif_num = i;
      ....
     i++;
     ...
}

At present, vif->idx is assigned the value of wl->vif_num
at the beginning of this block and device is initialized
based on this index value.
In the next iteration, wl->vif_num is still 0 as it is only updated
later but gets assigned to vif->idx in the beginning. This causes problems
later when we try to reference a particular interface and also while
configuring the firmware.

This patch moves the assignment to vif->idx from the beginning
of the block to after wl->vif_num is updated with latest value of i.

Fixes: commit 735bb39ca3be ("staging: wilc1000: simplify vif[i]->ndev accesses")
Cc: <stable@vger.kernel.org>
Signed-off-by: Aditya Shankar <aditya.shankar@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/wilc1000/linux_wlan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/linux_wlan.c b/drivers/staging/wilc1000/linux_wlan.c
index 07d6e4824a9d..2e5e3b368532 100644
--- a/drivers/staging/wilc1000/linux_wlan.c
+++ b/drivers/staging/wilc1000/linux_wlan.c
@@ -1260,11 +1260,12 @@ int wilc_netdev_init(struct wilc **wilc, struct device *dev, int io_type,
 		else
 			strcpy(ndev->name, "p2p%d");
 
-		vif->idx = wl->vif_num;
 		vif->wilc = *wilc;
 		vif->ndev = ndev;
 		wl->vif[i] = vif;
 		wl->vif_num = i;
+		vif->idx = wl->vif_num;
+
 		ndev->netdev_ops = &wilc_netdev_ops;
 
 		{
-- 
2.17.1

