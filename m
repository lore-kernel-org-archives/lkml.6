Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AC8C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2212086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKDz/gLv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2212086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeKTCzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:55:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:52792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbeKTCzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:55:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7AF20831;
        Mon, 19 Nov 2018 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645067;
        bh=QmxU0s2VKK6V1RKv2UEHT4lGvoziR3wd86G7R9TDGRg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CKDz/gLv6xVEKdOh3YgHYPVwlbh6M2ZmCkYlmjqHwIAhiRLd4TJR/pUQG8nOVpZCK
         oJueFioSK5N5qFpry5vSvxDtsBq/mEqBqKlAfVpwfyqHHjmtQ3/yzsa/G4dTC5svW9
         z8ryMF9jiuqNn22ZBzQtTBBjDfTuFHIq9BE61CkQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 006/205] Input: wm97xx-ts - fix exit path
Date:   Mon, 19 Nov 2018 17:25:13 +0100
Message-Id: <20181119162618.128620923@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/wm97xx-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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
 


