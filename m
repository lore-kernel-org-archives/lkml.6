Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D7CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F0820673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F0820673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeGTImg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 04:42:36 -0400
Received: from mout.perfora.net ([74.208.4.196]:35405 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726779AbeGTImg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 04:42:36 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MHqf5-1fjRzm0Iyz-003bLl; Fri, 20 Jul 2018 09:55:19 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
Subject: [PATCH] drm/tegra: hdmi: probe deferral error reporting
Date:   Fri, 20 Jul 2018 09:55:15 +0200
Message-Id: <20180720075515.26852-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:r27lmI381bKg7o+RqA1N49fXeCoMjRPUnDhnf0dYQiJUJpxmJsQ
 YQ50TI0RrS/OW4v+Ygz5UEZmXBnEdg7r6ZVy1n5vJcKYWvU4nQ5EVhkFVE2fO4zB7LvE32i
 7XqTboWdQ4BnPuv7AILoPoHvt9BJLTRYRGTxUzGtya5ZtSjk9Oc0KpOS/04Augi6EMeodGt
 E9lhCZbY2wNFWeCIm8ukA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:J4ShmahDJ6A=:BNdqUDLuIcyJNz0NxhnLZq
 fKj3MC+hiczuTGua96d83M65E56+q4JXUZt1zfF2rcmbKW38nHMcqtYKhQk2/QvwuizeUu1Ek
 g7JWXj/LYhksoRJFwCJWtXB18tMwSuL4q+g6CyI3d1Xh4nLhFxzoJuCNzTqCQSryMal2AuAVV
 c8XYt3evl9C6hH6VfBcNX4RsJw59ALoQspahpp4eOUnFlN91+FYsrpi3in5WFyssaMHDW6OdK
 11Rj3514QdtYoZ/MQGnIO0ifroQWm5JUfDsgCGqC9SXZ7shOCGosiJJYdgTyeo9xrfzUW9+r3
 OLKjwMP3ApCBtcvlYYVWo1cSWTPeMKPTuzV/oxZ+TDomSj7PEVZuI5Lxzqa5iFL1pUlRaUAkU
 3naE/I6l7JvPihJ6eosTpJWm8cf1t7/jprZtZcyHft5SYjNBbQIBoV8BhF+bnyQj18BXpvSVH
 QlS8vBHTtCFgltPUdbs1oVW6lPlhx8YBfT/LjdQogsSK3WIBxYPq8vGiOsBNGTseQu1a8CilR
 0QK089qewvRhlFDLAhbeRXAmHgyhmou2JDYhQVjRAULugtUzSp7PPbZu7q6aWF5Q4N3+0UId6
 Qb2dg0gi76oTtN/Y74VmE0Fx56ixErIY4dKgd/IbnA4JsnVGV625uLkxyaZEV1owILaFx9PU0
 00SjxHTAht8FwkkiKn+2DR5QUGvVq4t3tElngMlzq4Rd0d3yiGP3NCTy3R7Zy6EyndUY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Actually report the error code from devm_regulator_get() which may as
well just be a probe deferral.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 drivers/gpu/drm/tegra/hdmi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 0082468f703c..94c182dbb6d0 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1693,14 +1693,16 @@ static int tegra_hdmi_probe(struct platform_device *pdev)
 
 	hdmi->hdmi = devm_regulator_get(&pdev->dev, "hdmi");
 	if (IS_ERR(hdmi->hdmi)) {
-		dev_err(&pdev->dev, "failed to get HDMI regulator\n");
-		return PTR_ERR(hdmi->hdmi);
+		err = PTR_ERR(hdmi->hdmi);
+		dev_err(&pdev->dev, "failed to get HDMI regulator: %d\n", err);
+		return err;
 	}
 
 	hdmi->pll = devm_regulator_get(&pdev->dev, "pll");
 	if (IS_ERR(hdmi->pll)) {
-		dev_err(&pdev->dev, "failed to get PLL regulator\n");
-		return PTR_ERR(hdmi->pll);
+		err = PTR_ERR(hdmi->pll);
+		dev_err(&pdev->dev, "failed to get PLL regulator: %d\n", err);
+		return err;
 	}
 
 	hdmi->vdd = devm_regulator_get(&pdev->dev, "vdd");
-- 
2.14.4

