Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABAEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A8CC218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 19:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbI4QqYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730775AbfBATYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 14:24:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42120 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfBATY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 14:24:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so3689395plp.9;
        Fri, 01 Feb 2019 11:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=HtHtwIuaPR9dfRO7GhLJGbxylI8Q7R8JFRBv+FZeUNs=;
        b=rbI4QqYNeej5v0/SEyqiNaxOqiX/vXo086p0qVh6Pqt6uiqFZmTOo3pIUj5ePnYqUb
         HuxFg89/VTNsK/OMvFefzSAYnYTGUwJU6jbolG9nGFWIuRHvpeHNZ6F0k4xC0qXwMHsR
         RPywjSay0sdzJa0ewuAfmGyBY3kQjoh0aBwuTCX8FLmKhfTJAaEIy16RbJqZLQ/WV2ra
         D9APmOjg+3PSu6kDrXcNA7mmOelPPuhDrKbkM+eOKdwHt9VZKdess1DNt9ltM0O/v9d3
         VaqHUTgMreaXxEenCw7TLsOXE60vcWs2Eqe9zeI7Ql/gQJ4ZngKveiBtJTDNyxAKI/Sf
         nfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HtHtwIuaPR9dfRO7GhLJGbxylI8Q7R8JFRBv+FZeUNs=;
        b=gnOst2JG8HvqMGpcFpGrrlR3EPIOfqykaaN8F+4xPb9sc82KJcdkZmRtl7qcNxsGxr
         /X9cEhBRnlBREQ69pFJm0wLf2vIq6Lw6PBq6Od2ToNENOycMDX0Qlu1hGUNSZfxurd7v
         uiKg3M5s4CDuPC0ghmfgEljjubslQYTiCfzYWNYADyAe0x1fG3yIgOkPIBGs9BWihALd
         vWiLFxZesvbyd2tgb1fwjcCZFH4miSR6CHZop8qm25NX3bPLNdGa36mfAOMV4wxNRTpI
         IOF0UP2sgH5cO8cEpPpnjZGMLozUUXBSUf1a0YB+ETQFPECjoRYVzOUPQ/Wm/moRqjFf
         2guA==
X-Gm-Message-State: AJcUukdIr/09M9LMlnR5fdXrqXNgzD2zbZlnFBbaLB84ARydFnbEzJPT
        vrDBRyFAn0gChHQIA36pB45pQOWg
X-Google-Smtp-Source: ALg8bN7S10wByhiaEHz1eLY7MSJeYO1QZUGVq0sdWZB1tm2RoDdFoRHaVHCH5Vdbtr9aYOcNOxhoWw==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr39969333plr.207.1549049068546;
        Fri, 01 Feb 2019 11:24:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o66sm9377850pgo.75.2019.02.01.11.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 11:24:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK
        , TOUCHSCREEN)...)
Subject: [PATCH] Input: gpio-keys - Add shutdown callback
Date:   Fri,  1 Feb 2019 11:24:15 -0800
Message-Id: <20190201192417.15037-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms (e.g.: ARCH_BRCMSTB) it is possible to enter
"poweroff" while leaving some wake-up sources enabled such as key
presses in order to allow for the system to wake-up.

Wire up a .shutdown() callback which calls into the existing
gpio_keys_suspend() since the logic is essentially the same.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 492a971b95b5..6cd199e8a370 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -1015,8 +1015,18 @@ static int __maybe_unused gpio_keys_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(gpio_keys_pm_ops, gpio_keys_suspend, gpio_keys_resume);
 
+static void gpio_keys_shutdown(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = gpio_keys_suspend(&pdev->dev);
+	if (ret)
+		dev_err(&pdev->dev, "failed to shutdown\n");
+}
+
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
+	.shutdown	= gpio_keys_shutdown,
 	.driver		= {
 		.name	= "gpio-keys",
 		.pm	= &gpio_keys_pm_ops,
-- 
2.17.1

