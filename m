Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E0220849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675939;
	bh=Vd0tjo630AzNMUrIZreeWamLgZtNlvEGc6slbBKucR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n8pMvzNouWsYGazrSzOKLHiMuvKKOMhLEfkjD6ajkU/4fUxCX+nEhOHwdXSF301r8
	 TromaQGvRF46JMl4Sfy+pqKdYDMdaVx/6va3kVt6auM2kjcSP4fxNMqGGyaaugkQwl
	 TzFj14abG8dSP3gNfDG5Gjapx28msJnG8KrR/VBE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E0220849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbeLMEi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:38:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727773AbeLMEcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B33720882;
        Thu, 13 Dec 2018 04:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675566;
        bh=Vd0tjo630AzNMUrIZreeWamLgZtNlvEGc6slbBKucR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aU9t3qGR0BYkVcBKrkY0Dad1HuN6C7sDAc9boCSiY7hwM3aUuh9uHoeYn9U7fL3VY
         Q/hbW2bb4TdV9nFaKLqvJsoKk6FeOmCAhM7akIxjoSsq0xH7I507BsO06USKDB16WR
         3gNzuQ3zaMpPrZQtIYQT5A0a70A74l6ug6IHs/oo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 27/34] ethernet: fman: fix wrong of_node_put() in probe function
Date:   Wed, 12 Dec 2018 23:31:53 -0500
Message-Id: <20181213043200.76295-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[ Upstream commit ecb239d96d369c23c33d41708646df646de669f4 ]

After getting a reference to the platform device's of_node the probe
function ends up calling of_find_matching_node() using the node as an
argument. The function takes care of decreasing the refcount on it. We
are then incorrectly decreasing the refcount on that node again.

This patch removes the unwarranted call to of_node_put().

Fixes: 414fd46e7762 ("fsl/fman: Add FMan support")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index dafd9e1baba2..380c4a2f6516 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2817,7 +2817,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (!muram_node) {
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2826,11 +2826,10 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	of_node_put(muram_node);
-	of_node_put(fm_node);
 
 	err = devm_request_irq(&of_dev->dev, irq, fman_irq, 0, "fman", fman);
 	if (err < 0) {
-- 
2.19.1

