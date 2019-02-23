Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0461C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AEF2085A
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 11:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="RF1syzuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbfBWLsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 06:48:06 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:52030 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbfBWLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 06:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dfnI8AG/7RIuy5XqMAGsaQ0IY1OdRaijN2fALgWLVrU=; b=RF1syzujEm6nb856B6hByhKLPl
        rzTWwjk9hN2kj5lg2skaTXUzKr129JIzemmfc2ICJn8qMDBAXVFMKZ8V+MBAlNYXuCkFYb2H46Dpk
        Ckgkw4req9MEGJKgRjSpFn7Ay5HRDAr4XLu6C6ZgnfTMVbDZoR/YvGsZlXpKxsT8pQCM=;
Received: from p200300ccfbc075001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbc0:7500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gxVmh-0003rx-IA; Sat, 23 Feb 2019 12:47:59 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gxVmh-0004Fq-Bx; Sat, 23 Feb 2019 12:47:59 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     tony@atomide.com, lee.jones@linaro.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: twl-core: disable irq while suspended
Date:   Sat, 23 Feb 2019 12:47:54 +0100
Message-Id: <20190223114754.16286-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit
6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device for suspend")
on gta04 we have handle_twl4030_pih() called in situations where pm_runtime_get()
in i2c-omap.c returns -EACCES.
[   86.474365] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
[   86.485473] printk: Suspending console(s) (use no_console_suspend to debug)
[   86.555572] Disabling non-boot CPUs ...
[   86.555664] Successfully put all powerdomains to target state
[   86.563720] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563751] twl4030: I2C error -13 reading PIH ISR
[   86.563812] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563812] twl4030: I2C error -13 reading PIH ISR
[   86.563873] twl: Read failed (mod 1, reg 0x01 count 1)
[   86.563903] twl4030: I2C error -13 reading PIH ISR

This happens when we wakeup via something behing twl4030
(powerbutton or rtc alarm).
This goes on for minutes until the system is finally resumed.
Disable the irq on suspend and enable it on resume to avoid
having i2c access problems when the irq registers are checked.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/twl-core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index 299016bc46d9..104477b512a2 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -1245,6 +1245,28 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	return status;
 }
 
+static int __maybe_unused twl_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq)
+		disable_irq(client->irq);
+
+	return 0;
+}
+
+static int __maybe_unused twl_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (client->irq)
+		enable_irq(client->irq);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(twl_dev_pm_ops, twl_suspend, twl_resume);
+
 static const struct i2c_device_id twl_ids[] = {
 	{ "twl4030", TWL4030_VAUX2 },	/* "Triton 2" */
 	{ "twl5030", 0 },		/* T2 updated */
@@ -1262,6 +1284,7 @@ static const struct i2c_device_id twl_ids[] = {
 /* One Client Driver , 4 Clients */
 static struct i2c_driver twl_driver = {
 	.driver.name	= DRIVER_NAME,
+	.driver.pm	= &twl_dev_pm_ops,
 	.id_table	= twl_ids,
 	.probe		= twl_probe,
 	.remove		= twl_remove,
-- 
2.11.0

