Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CA4C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BF92145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 09:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ldmNKdc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BF92145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKPTlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 14:41:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36177 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeKPTlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 14:41:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id y6-v6so3327967plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 01:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKH8Hl64xPry9TSPR7Kx7uMh8CbXMJi4RqdKTbzaB9A=;
        b=ldmNKdc4yRORustAFhg41+J8f0Vy5jC0cUsP1vwyZEde9KV1L9jsfAHNAEahK59SN3
         ayuGSfhVznv04hPYEiZtpPIvKsnHnXR6hUBj8o2fHLs19Zscmw5Fr3f9t6ZZRp6JCC2s
         oRFvkz4o8YzuX+BNQgwK9oh4romPUTDHfkWxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qKH8Hl64xPry9TSPR7Kx7uMh8CbXMJi4RqdKTbzaB9A=;
        b=igVQQogGazuKLe7HyT7oZ7ECjBxG5GH9hIQm4dLyUeBRwFFZ8BRZvFoLTjdi7XV93B
         +3zkhT+XSvBpcy0pYmmhjDOajCS5UOcPXXIhRnjxUeodA/b8Wbt2nsA6Cq1LnZf+BTRG
         gTW4aBUrLDhXD+Akl2asQDnGmUWpHNRmD7leTpAoX1puVxZOfS1+x6QgCkD33Ey2ncI4
         XI5YZCbuMOg+rfKEX+tko0X0sQxN/X0UtrXeyIEg0NkFHod02qum1+i+ltdJlxYzb8us
         s4mH9lAKzMMN0NBxGzhleRx6Lv2PDrApfcwm+L+6aS+Nq+KVyMiV5s2zYVUvgchrm1fA
         4FsQ==
X-Gm-Message-State: AGRZ1gIPOSA6AQWlRnG+U1gSeTaquWGrdo8U4GURxCUCkZdld7gIdnRw
        bjHS+CO9HEvQQUlW265sfhqcl/0Zd7c=
X-Google-Smtp-Source: AJdET5cbUPzrQdxNTt8AqORXOP5Up8lPIKp6rpFTWk0b83IWHEQ3Jfcnhe/4ldNatrWM3oV9RKuO5g==
X-Received: by 2002:a17:902:654a:: with SMTP id d10-v6mr9612238pln.302.1542360584421;
        Fri, 16 Nov 2018 01:29:44 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id h7-v6sm50820180pfd.35.2018.11.16.01.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 01:29:43 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH] ASoC: rt5663: Fix error handling of regulator_set_load
Date:   Fri, 16 Nov 2018 17:28:56 +0800
Message-Id: <20181116092856.47815-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default implementation of regulator_set_load returns
REGULATOR_MODE_NORMAL, which is positive.

rt5663_i2c_probe should only do error handling when return value of
regulator_set_load is negative.
In this case, rt5663_i2c_probe should return error.

Also, consolidate err_irq into err_enable.

Fix the missing goto for temporary regmap and rt5663->regmap.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 This patch is the fixup of the patch
 e81a2a6d12e85 ASoC: rt5663: Add regulator support
 sound/soc/codecs/rt5663.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index bb2c1ee4a836f..473a54d1ae2c5 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3522,10 +3522,11 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 	for (i = 0; i < ARRAY_SIZE(rt5663->supplies); i++) {
 		ret = regulator_set_load(rt5663->supplies[i].consumer,
 					 RT5663_SUPPLY_CURRENT_UA);
-		if (ret) {
+		if (ret < 0) {
 			dev_err(&i2c->dev,
-				"Failed to set regulator %s, ret: %d\n",
+				"Failed to set regulator load on %s, ret: %d\n",
 				rt5663->supplies[i].supply, ret);
+			return ret;
 		}
 	}
 
@@ -3543,7 +3544,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(regmap);
 		dev_err(&i2c->dev, "Failed to allocate temp register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	ret = regmap_read(regmap, RT5663_VENDOR_ID_2, &val);
@@ -3576,7 +3577,7 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 		ret = PTR_ERR(rt5663->regmap);
 		dev_err(&i2c->dev, "Failed to allocate register map: %d\n",
 			ret);
-		return ret;
+		goto err_enable;
 	}
 
 	/* reset and calibrate */
@@ -3686,17 +3687,19 @@ static int rt5663_i2c_probe(struct i2c_client *i2c,
 			rt5663_dai, ARRAY_SIZE(rt5663_dai));
 
 	if (ret)
-		goto err_irq;
+		goto err_enable;
 
 	return 0;
 
-err_irq:
+
+	/*
+	 * Error after enabling regulators should goto err_enable
+	 * to disable regulators.
+	 */
+err_enable:
 	if (i2c->irq)
 		free_irq(i2c->irq, rt5663);
 
-err_enable:
-	dev_err(&i2c->dev,
-		"%s: Disable regulator after probe error\n", __func__);
 	regulator_bulk_disable(ARRAY_SIZE(rt5663->supplies), rt5663->supplies);
 	return ret;
 }
-- 
2.19.1.1215.g8438c0b245-goog

