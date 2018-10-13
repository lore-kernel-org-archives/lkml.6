Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C299C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A1E02054F
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 17:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GSDSxSfw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A1E02054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeJNAoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 20:44:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46598 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbeJNAoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 20:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mv0toIaNlwA0+Z3ryAFpIuL9LEcHiD181vJNGTXalvU=; b=GSDSxSfwr/FVK/e/rhBeEGOixi
        E2t2FhL76c+schVkRvFPPK91kD5Kku0wP0euKBqcYxAVwUrIBQ32Xcr8ChUPe0zqs1ufsHM/ipaMH
        tE2H1LWiM/+n+kHUF5/obqhJ35SWIfM3m0BYUfxzdGOv3iSSdQi1inYxDTzJOxc/RIGKRSvzOmsAW
        t2ceKzKGDWEKb6mI7e8Qua6giOErAyx+Ntl1Ov+RmkNQmZ7htCNqYq97CFAEPnW0tIsHB2cJv6E/X
        bn69TBk+xoL+3pGyp6PZ1iP53PPaAi6ESiXsbI4fTt9g3tvdNUrMD7Zi64Y0ki2TN2Mh8iM+FjP3z
        WYcDmTXQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBNMp-0007nT-TY; Sat, 13 Oct 2018 17:06:20 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] input: touchscreen: fix wm97xx-ts exit path
Message-ID: <c522fb84-20cd-39e6-bd2d-79ed8709fd5d@infradead.org>
Date:   Sat, 13 Oct 2018 10:06:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Loading then unloading wm97xx-ts.ko when CONFIG_AC97_BUS=m
causes a WARNING: from drivers/base/driver.c:

Unexpected driver unregister!
WARNING: CPU: 0 PID: 1709 at ../drivers/base/driver.c:193 driver_unregister+0x30/0x40

Fix this by only calling driver_unregister() with the same
condition that driver_register() is called.

Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com
Cc: linux-input@vger.kernel.org
---
 drivers/input/touchscreen/wm97xx-core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lnx-419-rc7.orig/drivers/input/touchscreen/wm97xx-core.c
+++ lnx-419-rc7/drivers/input/touchscreen/wm97xx-core.c
@@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
 
 static void __exit wm97xx_exit(void)
 {
-	driver_unregister(&wm97xx_driver);
+	if (IS_BUILTIN(CONFIG_AC97_BUS))
+		driver_unregister(&wm97xx_driver);
 	platform_driver_unregister(&wm97xx_mfd_driver);
 }
 


