Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304D9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE7A20820
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 16:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DLOyFMMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCE7A20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438090AbeKWCqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 21:46:30 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43497 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbeKWCq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 21:46:29 -0500
Received: by mail-lj1-f195.google.com with SMTP id 83-v6so8369869ljf.10
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 08:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nuwurduJbbd/l3+2ThhClajDsChdjDwF/WBDQ2w50A=;
        b=DLOyFMMKM+xm9ePOIPlh8WA3oN+vCgl2gcIMl8YEt2YyVHzlhTRskoMbgdFvYSCY3+
         OP3Vw01t82y754wH6gMqMgrGTGIcuEZVjoszV1o2DpclsKoLchE1q5mleTKBJEcngsOi
         QcPEvRzG4fq32scnW8OKMYYnE718kYhpi+sys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nuwurduJbbd/l3+2ThhClajDsChdjDwF/WBDQ2w50A=;
        b=dOmxQoHi+JEL0FZRFTsKuXR3DA53saoOyQhJj22MtBpzbUyLiEwHNa3Iy6BPglnAbE
         vuKGYT9M2/w8q8koM/PWB2xgAty4agTrEQZ2EsCI4vt+CRMgXB7pzD4FVpxkpwUs0Zo+
         RSl3ZUkGS3FQFXlDz28oGgZ3KMqHdUZlMjj3RSBRgLIn3Bysxb9XnmL/sjHD9TwpODFY
         xFfE2h9dJuYDJP5raIeuSySfIyI7dRr70dRCpMlVbLCYCfSxC2qMB9e3CXGI6rX8w8d4
         27odf47zdGecorVggjiv0PlBOlFx9qHUWe8E8bz01VijZ853sCgqkvFqoDJSM8pSX1KW
         onQg==
X-Gm-Message-State: AGRZ1gJ24uC92zneBf71ifji1+KDJ4Q2iI5ISAfw+LnGUQxMX5jKk2dn
        0kh3lAIpEi6+tTpXkqpMgdTxEA==
X-Google-Smtp-Source: AJdET5fTvqRM23AC35HFm7GZua9e4YRUfipCDHFdB/zJe4vbunqZ2qeOe+2vEG67+0+CTQPHf+TbBA==
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr7241532ljg.64.1542902788919;
        Thu, 22 Nov 2018 08:06:28 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id r27-v6sm7561035lja.65.2018.11.22.08.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 08:06:27 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH] regulator: core: do not put managed GPIOd:s
Date:   Thu, 22 Nov 2018 17:04:21 +0100
Message-Id: <20181122160421.9658-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers have been converted to pass GPIO descriptors
rather than GPIO numbers to the regulator core. We should
not issue gpiod_put() on those descriptors, but rather
let the driver reference count it with devm_* if they so
desire.

Currently the regulator core issues gpiod_put() on all
descriptors as it assumes it was obtained with the
sequence gpio_request_one()/gpio_to_desc(), as
gpio_request_one() will be equivalent to gpiod_get().

We introduce a helper bool that deal with this situation
by making sure the core only issue gpiod_put() if the
GPIO was requested from within the core itself.

A subsequent patch set will delete legacy GPIO handling
and get rid of this ugliness, so it is a stepgap patch.

Fixes: e45e290a882e ("regulator: core: Support passing an initialized GPIO enable descriptor")
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: I will rebase my v7 series for removing legacy
GPIO on this if it solves Marek's probel, it can be applied
for fixes if need be but I don't know how big this problem is.
---
 drivers/regulator/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 03a03763457c..05bb2db6cff5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -80,6 +80,7 @@ struct regulator_map {
 struct regulator_enable_gpio {
 	struct list_head list;
 	struct gpio_desc *gpiod;
+	bool gpiod_needs_put;
 	u32 enable_count;	/* a number of enabled shared GPIO */
 	u32 request_count;	/* a number of requested shared GPIO */
 	unsigned int ena_gpio_invert:1;
@@ -2247,6 +2248,8 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 	}
 
 	pin->gpiod = gpiod;
+	if (!config->ena_gpiod)
+		pin->gpiod_needs_put = true;
 	pin->ena_gpio_invert = config->ena_gpio_invert;
 	list_add(&pin->list, &regulator_ena_gpio_list);
 
@@ -2268,7 +2271,8 @@ static void regulator_ena_gpio_free(struct regulator_dev *rdev)
 		if (pin->gpiod == rdev->ena_pin->gpiod) {
 			if (pin->request_count <= 1) {
 				pin->request_count = 0;
-				gpiod_put(pin->gpiod);
+				if (pin->gpiod_needs_put)
+					gpiod_put(pin->gpiod);
 				list_del(&pin->list);
 				kfree(pin);
 				rdev->ena_pin = NULL;
-- 
2.19.1

