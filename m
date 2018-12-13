Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBDAC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4435020849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544676439;
	bh=WVZddildhXeQP6kV5VGP+x4nGfe8+6TzHWp1uFE2zVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=klaqjszt4Z5a2g4R09/kn8wHEVJVIlZX5yI8bm4NLzOGVeVP1sJI9xV5R+uto+pK6
	 wWijR+ESTrnj1OA6BUpBMQ7Kdfu6U+OZQyDMaSYA6Y1zpSX7fOkg4rNrfcLRXth+Cn
	 c2DsgJx3mN8WXZmmgpDOu9yo7AQJoQ01Eso4G3z0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4435020849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeLMErM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728184AbeLMEaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:30:19 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3C020989;
        Thu, 13 Dec 2018 04:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675419;
        bh=WVZddildhXeQP6kV5VGP+x4nGfe8+6TzHWp1uFE2zVo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tH8k8OFdo9PftFj2dj7K5SxYkmRt5truABCDA4rtC9js9+TqQMimNfwYIUuEVNGci
         6IZ3taMJT8mmH5S0fYVFGBG42ilP5eaKit7jWr3D13yopiEoKwOxnigJLNBf5mO5vj
         PSSTu8EwnVtZCsIQ2kHiMkxW28zAfUkneGqF7/iM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 54/73] ethernet: fman: fix wrong of_node_put() in probe function
Date:   Wed, 12 Dec 2018 23:28:19 -0500
Message-Id: <20181213042838.75160-54-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
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
index c415ac67cb7b..e80fedb27cee 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2786,7 +2786,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	if (!muram_node) {
 		dev_err(&of_dev->dev, "%s: could not find MURAM node\n",
 			__func__);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	err = of_address_to_resource(muram_node, 0,
@@ -2795,11 +2795,10 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 		of_node_put(muram_node);
 		dev_err(&of_dev->dev, "%s: of_address_to_resource() = %d\n",
 			__func__, err);
-		goto fman_node_put;
+		goto fman_free;
 	}
 
 	of_node_put(muram_node);
-	of_node_put(fm_node);
 
 	err = devm_request_irq(&of_dev->dev, irq, fman_irq, IRQF_SHARED,
 			       "fman", fman);
-- 
2.19.1

