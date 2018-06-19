Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF27BC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EEFE208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="b83M8Ic0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EEFE208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbeFSXpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:45:34 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40505 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbeFSXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:45:30 -0400
Received: by mail-pl0-f68.google.com with SMTP id t12-v6so682083plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PM+MBg+PKev5Z1ZTi5puF0pkUcxiOjDvmt3X5LHlR9w=;
        b=b83M8Ic041H2zo+yF5A5lgQnMfsfhaHZRI+hBJcEkBnQ9rwL8q1awdJ9tUz9t9uO/9
         AQAxoH8u6TUJKL9z0OtAP0xv4VZ82H1ErEdt4tUL42Bcfuws0YDcnKJjQfVR4rZdJzZM
         yC5o38nNu20JEjnnKPZSarhABPBnvJtF8yi1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PM+MBg+PKev5Z1ZTi5puF0pkUcxiOjDvmt3X5LHlR9w=;
        b=l05riMHu9TV4VQb1m5BL/qPc3EptAsbp8vuugytkcsEwH0oo+ohoVMaeSp9RrPbx3T
         63GZd8Cl9qHAsuc//5HWg9+MAj/WpdY+Wh09waR+hCaf3MES/qIpVf6d0ZBelImXk8NF
         Bw1wdEcQUSnUnHM5Epu6DckrX/bI40rYU8ktJEJRreC3etgQihkwP65HXV1WI2iVs2Xf
         2QnU6kfbFuWzX8gj0uhkJ940AaQilMi1YAX4jgLNwop3gFPKrP0g9ZZxyMziLpgHdxnM
         r24z1bXcFQpJzLe4qTk25yHdGAVERFvvopKe6Jq8MYBP/L2K9CrfAgy/iFH9zwlHEuK9
         N4mA==
X-Gm-Message-State: APt69E3SyoI2GmHUyVuF6iUSMxmls3UquykVoHOhGtbCnCb0hKksMI35
        wammbMunFtQtwGeho9eBJVctWA==
X-Google-Smtp-Source: ADUXVKKfA51c6UKzO6TOfETeWg3VmCkAsoyywakvsyXvr7zsLo+4UNfm/+y3fk6VrQHz+xZKbzmZkg==
X-Received: by 2002:a17:902:d716:: with SMTP id w22-v6mr20936100ply.98.1529451930048;
        Tue, 19 Jun 2018 16:45:30 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id n85-v6sm987973pfa.146.2018.06.19.16.45.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 16:45:28 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     swboyd@chromium.org, Evan Green <evgreen@chromium.org>
Subject: [PATCH] pinctrl: msm: Pass along set_wake failures
Date:   Tue, 19 Jun 2018 16:43:49 -0700
Message-Id: <20180619234349.166190-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSM pinctrl driver quietly swallows errors that occur
when trying to call .irq_set_wake. It should instead pass
those failures up the chain so the caller can react to them.
Swallowing the error for instance causes gpio_keys to think that
it was able to successfully set a wake IRQ, when in fact it may
not have been, causing the following warning on resume:

[   53.777819] Unbalanced IRQ 9 wake disable
[   53.781979] WARNING: CPU: 0 PID: 1362 at kernel/irq/manage.c:623
irq_set_irq_wake+0xac/0x12c
[   53.794758] Modules linked in: spi_gpio spi_bitbang qcom_q6v5_pil
qcom_common cfg80211 ip6table_filter smsc95xx usbnet mii
[   54.016419] [<ffffff80081054b0>] irq_set_irq_wake+0xac/0x12c
[   54.022252] [<ffffff80083c86a4>] msm_gpio_irq_set_wake+0x48/0x68
[   54.028447] [<ffffff8008104d8c>] set_irq_wake_real+0x50/0x5c
[   54.034275] [<ffffff80081054d0>] irq_set_irq_wake+0xcc/0x12c
[   54.040104] [<ffffff800860fd00>] gpio_keys_resume+0x74/0xd8
[   54.045846] [<ffffff800852018c>] platform_pm_resume+0x54/0x60
[   54.051771] [<ffffff800852ceb4>] dpm_run_callback+0x104/0x210
[   54.057694] [<ffffff800852d7cc>] device_resume+0x178/0x1b0
[   54.063355] [<ffffff800852e938>] dpm_resume+0x1c4/0x38c
[   54.068745] [<ffffff800852efac>] dpm_resume_end+0x20/0x34
[   54.074315] [<ffffff80080fe700>] suspend_devices_and_enter+0x518/0x964
[   54.081044] [<ffffff80080ff1dc>] pm_suspend+0x690/0x6e0
[   54.086433] [<ffffff80080fd0f8>] state_store+0xd4/0xf8
[   54.091733] [<ffffff80088a3af0>] kobj_attr_store+0x18/0x28
[   54.097396] [<ffffff80082980a4>] sysfs_kf_write+0x5c/0x68
[   54.102961] [<ffffff8008297050>] kernfs_fop_write+0x174/0x1b8
[   54.108887] [<ffffff800821a9c0>] __vfs_write+0x58/0x160
[   54.114276] [<ffffff800821acd4>] vfs_write+0xcc/0x184
[   54.119487] [<ffffff800821af4c>] SyS_write+0x64/0xb4

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 0e22f52b2a19..d48a74ddbc1f 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -779,14 +779,15 @@ static int msm_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
 	unsigned long flags;
+	int rc;
 
 	raw_spin_lock_irqsave(&pctrl->lock, flags);
 
-	irq_set_irq_wake(pctrl->irq, on);
+	rc = irq_set_irq_wake(pctrl->irq, on);
 
 	raw_spin_unlock_irqrestore(&pctrl->lock, flags);
 
-	return 0;
+	return rc;
 }
 
 static void msm_gpio_irq_handler(struct irq_desc *desc)
-- 
2.13.5

