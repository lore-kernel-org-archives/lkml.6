Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C59BC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B86921841
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Sq1F7m05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfBJMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:44:50 -0500
Received: from smtpbg303.qq.com ([184.105.206.26]:38888 "EHLO smtpbg303.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfBJMou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:44:50 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2019 07:44:50 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1549802689;
        bh=idim2k4h+9UVrSGg7cDvZm/hfI7lWpe2uWZNyaQAA5s=;
        h=From:To:Cc:Subject:Date:Message-Id;
        b=Sq1F7m05cpOqtYtug/TsKz5nwD0IVb8ep874JH1gLN8phKVpDQZIheZLlXShvHn9b
         E+9GohfrC9Luse/6Vi17uCPXsOnKm6CXMZth89SORnwtevl1PnzT+k88NXZHAdKbbb
         au8sbe/5KJskSFq3U1zkNSAZrAnG5+4/41gx9xfY=
X-QQ-mid: esmtp7t1549802234t55qk7kyi
Received: from localhost.localdomain (unknown [115.195.140.97])
        by esmtp4.qq.com (ESMTP) with 
        id ; Sun, 10 Feb 2019 20:37:13 +0800 (CST)
X-QQ-SSF: B1000000000000F0FG100500000000V
X-QQ-FEAT: oP8qruwI8aW8VEhULnkEvjKWnl7oz/oiYMFkvDTzW+sVgzz0xmOOJlHWkwECe
        b4tMIapdti8SON3rZ5IiAf7cJRIBHrlVZkWKFiAp6VCeETJB2X4i9GuuNqM2vr6OXBBWqDW
        HkpqxoPQbh3DZBGSIeQT6ADgvhBilsA61XuepS89T8JCJtqZDXm2tAAnYstOVdSV88I6m9G
        phoEqF4glF4K9UhHPdA5e9TRPHP9NJ0A3Gqr08iw9rpkxQ83BRVFyrbShMmMo06FIqXd3wd
        VOhKeRYkvlqo4gaeUHaKkw3V2ZtnrN5IcCNnQdkR+RSkUx
X-QQ-GoodBg: 0
From:   Yisheng Xie <ysxie@foxmail.com>
To:     jacek.anaszewski@gmail.com, pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yisheng Xie <ysxie@foxmail.com>
Subject: [PATCH] leds: pwm: fix max_brightness works abnormal when active_low
Date:   Sun, 10 Feb 2019 20:37:09 +0800
Message-Id: <1549802229-31170-1-git-send-email-ysxie@foxmail.com>
X-Mailer: git-send-email 1.9.1
X-QQ-SENDSIZE: 520
X-QQ-FName: C5B2C576954147948E36D68AA99833AE
X-QQ-LocalIP: 10.198.131.167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When leds-pwm is active_low, smaller number of  duty kept in led_dat
means less brighness, so we should disable pwm when led_dat->duty is
equal to period instead of zero, which means max_brightness.

Signed-off-by: Yisheng Xie <ysxie@foxmail.com>
---
 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index df80c89..07fb772 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -41,7 +41,7 @@ static void __led_pwm_set(struct led_pwm_data *led_dat)
 
 	pwm_config(led_dat->pwm, new_duty, led_dat->period);
 
-	if (new_duty == 0)
+	if (led_dat->active_low ? new_duty == led_dat->period : new_duty == 0)
 		pwm_disable(led_dat->pwm);
 	else
 		pwm_enable(led_dat->pwm);
-- 
1.9.1


