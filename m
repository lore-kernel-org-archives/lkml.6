Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 8A696C5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F87208AF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F87208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934174AbeFKRU5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:20:57 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33793 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752632AbeFKRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:20:55 -0400
Received: from localhost.localdomain ([77.136.205.128])
        by mwinf5d63 with ME
        id xVLs1x00e2mkQqM03VLtG2; Mon, 11 Jun 2018 19:20:54 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Jun 2018 19:20:54 +0200
X-ME-IP: 77.136.205.128
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     atull@kernel.org, mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] fpga: altera-cvp: Fix an error handling path in 'altera_cvp_probe()'
Date:   Mon, 11 Jun 2018 19:20:49 +0200
Message-Id: <20180611172049.26630-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-Antivirus: Avast (VPS 180611-4, 11/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'fpga_mgr_create()' fails, we should release some resources, as done
in the other error handling path of the function.

Fixes: 7085e2a94f7d ("fpga: manager: change api, don't use drvdata")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/fpga/altera-cvp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
index dd4edd8f22ce..7fa793672a7a 100644
--- a/drivers/fpga/altera-cvp.c
+++ b/drivers/fpga/altera-cvp.c
@@ -455,8 +455,10 @@ static int altera_cvp_probe(struct pci_dev *pdev,
 
 	mgr = fpga_mgr_create(&pdev->dev, conf->mgr_name,
 			      &altera_cvp_ops, conf);
-	if (!mgr)
-		return -ENOMEM;
+	if (!mgr) {
+		ret = -ENOMEM;
+		goto err_unmap;
+	}
 
 	pci_set_drvdata(pdev, mgr);
 
-- 
2.17.0

