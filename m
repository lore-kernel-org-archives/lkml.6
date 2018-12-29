Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A2CC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC2F3218F0
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 16:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfADQB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 11:01:57 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:31525 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfADQB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 11:01:56 -0500
Received: from localhost.localdomain ([90.126.241.217])
        by mwinf5d07 with ME
        id LG1s1z00A4i89ZE03G1sx6; Fri, 04 Jan 2019 17:01:54 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 04 Jan 2019 17:01:54 +0100
X-ME-IP: 90.126.241.217
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
        jerinj@marvell.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] octeontx2-af: Fix a resource leak in an error handling path in 'cgx_probe()'
Date:   Sat, 29 Dec 2018 17:42:22 +0100
Message-Id: <20181229164222.15791-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an error occurs after the call to 'pci_alloc_irq_vectors()', we must
call 'pci_free_irq_vectors()' in order to avoid a	resource leak.

The same sequence is already in place in the corresponding 'cgx_remove()'
function.

Fixes: 1463f382f58d ("octeontx2-af: Add support for CGX link management")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/net/ethernet/marvell/octeontx2/af/cgx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
index 742f0c1f60df..6d55e3d0b7ea 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/cgx.c
@@ -825,7 +825,7 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!cgx->cgx_cmd_workq) {
 		dev_err(dev, "alloc workqueue failed for cgx cmd");
 		err = -ENOMEM;
-		goto err_release_regions;
+		goto err_free_irq_vectors;
 	}
 
 	list_add(&cgx->cgx_list, &cgx_list);
@@ -841,6 +841,8 @@ static int cgx_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_release_lmac:
 	cgx_lmac_exit(cgx);
 	list_del(&cgx->cgx_list);
+err_free_irq_vectors:
+	pci_free_irq_vectors(pdev);
 err_release_regions:
 	pci_release_regions(pdev);
 err_disable_device:
-- 
2.19.1

