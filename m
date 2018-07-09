Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12692C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EEB208A2
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOV3hhb2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1EEB208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933303AbeGIXuJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:50:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33304 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933129AbeGIXuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:50:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so1540488pgv.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=U+/ail1Y2/zS6EKnjkbyr94CF/SqkicIq6LsMUZ45Go=;
        b=fOV3hhb23H4sdM2wOdjq2UG4SphvViR7FE/Bo88VQnMTd60MSu9frp6XSmgeuvKvVz
         PbIRlNQzBfNbbdbXZsB6ZU659cAlKMpP1GxJXsuUC2IPTLC8DI25JuiruzOkRCqm+1WT
         vNFXs7BdF1HTN3SvD86YN1PAsNNLfIv+AGRW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+/ail1Y2/zS6EKnjkbyr94CF/SqkicIq6LsMUZ45Go=;
        b=fHOENJCB3JqNONkrRF7B9r8e3H6JSsPOnhyiZMdOB9CG3LfYJpv5YPA2pfbijyfB8g
         oHyJctHlaxKTz7badZJlq64nDVLg4/pk7odJhP5VINLlHi1maeaBkHezV6csLYvnazjG
         ZLjVmGM6/NKmCzTVXOS5ftU33aFxX39fYduuHUDtlKuwIK4dKnfwvlofPp96FKEWkj0T
         ZknLg88pF2Gwh3rCBYNspXlt3dlpx0Vw+w3n0J3vXypHVF/f2reqTIfOBsK68Tv75ksH
         v3RgwcfFW2v7TQUqHceYqLjHA05wSWt5TRJ8+oDBiG9v1OBo9Js3VkwxA7wQjvu3t3IE
         tNXg==
X-Gm-Message-State: APt69E38HZTcOL/SnngTLUrIMT4cLiBDMK5IxWvuKXatIx4jJ8bLsZv/
        zJb180vucCHV4Ev1tUcFC9368w==
X-Google-Smtp-Source: AAOMgpdG2tA/51MAAt5mZBgdrWLAYYxpWV0+R2q9L9BpYWtDSWLgY92VrLlOWE/wvRoCkEbzFtvRKg==
X-Received: by 2002:a62:d94a:: with SMTP id s71-v6mr23100530pfg.164.1531180202823;
        Mon, 09 Jul 2018 16:50:02 -0700 (PDT)
Received: from evgreen2.mtv.corp.google.com ([2620:0:1000:1511:116f:8bf3:133b:f7fd])
        by smtp.gmail.com with ESMTPSA id x11-v6sm26361213pge.15.2018.07.09.16.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Jul 2018 16:50:01 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     andy.gross@linaro.org, david.brown@linaro.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, dianders@chromium.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-i2c@vger.kernel.org
Cc:     Evan Green <evgreen@chromium.org>
Subject: [PATCH] i2c: i2c-qcom-geni: Fix suspend clock handling
Date:   Mon,  9 Jul 2018 16:49:37 -0700
Message-Id: <20180709234937.176154-1-evgreen@chromium.org>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_suspended can return 0 even if the last runtime power
management function called in the device was a suspend call. This
trips up the i2c-qcom-geni's suspend_noirq accounting, which was
trying to use the function to determine if it should disable clocks
or if that had already been done.

The fix is to track whether or not clocks have been enabled explicitly
in the driver with a new member. While in there, also honor the return
value of geni_se_resources_off, which can technically fail.

An example of the warning generated during suspend:
[   68.314733] WARNING: CPU: 0 PID: 1990 at drivers/clk/clk.c:595 clk_core_disable+0x28/0x200
[   68.464576] Call trace:
[   68.554410] [<ffffff80083f0ed0>] clk_core_disable+0x28/0x200
[   68.560244] [<ffffff80083f349c>] clk_disable+0x38/0x4c
[   68.565541] [<ffffff8008408910>] geni_se_resources_off+0x40/0x74
[   68.571731] [<ffffff800862aadc>] geni_i2c_runtime_suspend+0x2c/0x3c
[   68.578185] [<ffffff800862ae6c>] geni_i2c_suspend_noirq+0x38/0x68
[   68.584475] [<ffffff800852bd40>] dpm_run_callback+0x104/0x210
[   68.590404] [<ffffff800852c3d4>] __device_suspend_noirq+0x158/0x1a8
[   68.596859] [<ffffff800852dff0>] dpm_noirq_suspend_devices+0x180/0x38c
[   68.603594] [<ffffff80080fdebc>] suspend_devices_and_enter+0x49c/0x964
[   68.610321] [<ffffff80080fea14>] pm_suspend+0x690/0x6e0
[   68.615712] [<ffffff80080fc930>] state_store+0xd4/0xf8
[   68.621014] [<ffffff80088a57f0>] kobj_attr_store+0x18/0x28
[   68.626672] [<ffffff8008297a54>] sysfs_kf_write+0x5c/0x68
[   68.632240] [<ffffff8008296a00>] kernfs_fop_write+0x174/0x1b8
[   68.638177] [<ffffff800821a2c4>] __vfs_write+0x58/0x160
[   68.643567] [<ffffff800821a5d8>] vfs_write+0xcc/0x184
[   68.648780] [<ffffff800821a850>] SyS_write+0x64/0xb4

Signed-off-by: Evan Green <evgreen@chromium.org>
---
This change applies atop Karthik's patch [1], which as far as I can tell
technically hasn't landed yet, but also hasn't had feedback in awhile
either. I opted to submit this as a separate patch, but if the maintainers
prefer it's fine with me if this get folded in to another spin of the
base series.

[1] https://patchwork.kernel.org/patch/10460819/

 drivers/i2c/busses/i2c-qcom-geni.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 54bcd1a79cc5..90c4cbfa22d8 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -85,6 +85,7 @@ struct geni_i2c_dev {
 	spinlock_t lock;
 	u32 clk_freq_out;
 	const struct geni_i2c_clk_fld *clk_fld;
+	int suspended;
 };
 
 struct geni_i2c_err_log {
@@ -567,9 +568,15 @@ static int geni_i2c_probe(struct platform_device *pdev)
 	geni_se_init(&gi2c->se, gi2c->tx_wm, tx_depth);
 	geni_se_config_packing(&gi2c->se, BITS_PER_BYTE, PACKING_BYTES_PW,
 							true, true, true);
-	geni_se_resources_off(&gi2c->se);
+	ret = geni_se_resources_off(&gi2c->se);
+	if (ret) {
+		dev_err(&pdev->dev, "Error turning off resources %d\n", ret);
+		return ret;
+	}
+
 	dev_dbg(&pdev->dev, "i2c fifo/se-dma mode. fifo depth:%d\n", tx_depth);
 
+	gi2c->suspended = 1;
 	pm_runtime_set_suspended(gi2c->se.dev);
 	pm_runtime_set_autosuspend_delay(gi2c->se.dev, I2C_AUTO_SUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gi2c->se.dev);
@@ -590,10 +597,19 @@ static int geni_i2c_remove(struct platform_device *pdev)
 
 static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 {
+	int ret;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
 	disable_irq(gi2c->irq);
-	geni_se_resources_off(&gi2c->se);
+	ret = geni_se_resources_off(&gi2c->se);
+	if (ret) {
+		enable_irq(gi2c->irq);
+		return ret;
+
+	} else {
+		gi2c->suspended = 1;
+	}
+
 	return 0;
 }
 
@@ -607,12 +623,15 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 		return ret;
 
 	enable_irq(gi2c->irq);
+	gi2c->suspended = 0;
 	return 0;
 }
 
 static int __maybe_unused geni_i2c_suspend_noirq(struct device *dev)
 {
-	if (!pm_runtime_suspended(dev)) {
+	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
+
+	if (!gi2c->suspended) {
 		geni_i2c_runtime_suspend(dev);
 		pm_runtime_disable(dev);
 		pm_runtime_set_suspended(dev);
-- 
2.18.0.203.gfac676dfb9-goog

