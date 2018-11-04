Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6FEECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5BE20870
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 14:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUqnOojM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B5BE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbeKDXXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:23:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730010AbeKDXHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B56612087A;
        Sun,  4 Nov 2018 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339522;
        bh=Mkh2uMZKE1n27xcmsngA5/qGmdgMglErXrdueCFnSmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUqnOojMkXave7T27uw96YHM0TrlQWIheMUqEITEW8ew+BXoSuarwn0Clvx6FkIG9
         6ftuMIVk+dAD0p77qr1EwktgcxU+fG2/2+JGpRzZCfNlzMGxCvbDcWn1qldwtCr1yN
         wM9hlOcqWsO8jC9jB+tIlviY5omnoIJi1EQRIThY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 15/57] Input: wm97xx-ts - fix exit path
Date:   Sun,  4 Nov 2018 08:51:02 -0500
Message-Id: <20181104135144.88324-15-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit a3f7c3fcf60868c1e90671df5d0cf9be5900a09b ]

Loading then unloading wm97xx-ts.ko when CONFIG_AC97_BUS=m
causes a WARNING: from drivers/base/driver.c:

Unexpected driver unregister!
WARNING: CPU: 0 PID: 1709 at ../drivers/base/driver.c:193 driver_unregister+0x30/0x40

Fix this by only calling driver_unregister() with the same
condition that driver_register() is called.

Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/wm97xx-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index 2566b4d8b342..73856c2a8ac0 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
 
 static void __exit wm97xx_exit(void)
 {
-	driver_unregister(&wm97xx_driver);
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		driver_unregister(&wm97xx_driver);
 	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 
-- 
2.17.1

