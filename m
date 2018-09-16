Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA06C4161C
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04EE8214C4
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ee7g1aiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EE8214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIQFKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:40 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50869 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbeIQFKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:40 -0400
Received: by mail-it0-f68.google.com with SMTP id j81-v6so8967053ite.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PIKaH/Ayz19S8iNTPDQor8FxL6MltyIuIX2u6+vfhek=;
        b=ee7g1aiNVMrlWJbii8louGa7accboQgy+AOfEg9XLtOZpHOJBDpBDYMeFIJoikkMs6
         s8EyyClPK2N6P8A4yOToExebsnio4GPoC7GlrgJpUUShXH+KgqouuDSHHGs9VzOTYHIn
         NbtlhdZOVETN+bKhQ6HZ3gGkdpNIyHjFH85qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PIKaH/Ayz19S8iNTPDQor8FxL6MltyIuIX2u6+vfhek=;
        b=JLx5sG/YOilmMa0D/o+UvYGayBg6TiyfUhUyvzP6AmwGH3rjyM5iY2bQjbakRP4v4V
         IWALNh/oknKrNcO8RX0vmMGt9ZGlJ/+Lj38WbAi/daGkZh3gZpoQWk7r1KDvSTRb6q1m
         fibFri89W6RIFAZb7c+4JDtW7KJpUk8cV27+wTqHaZxWAntJuJ/qYCDpeN+RfUXRMfPu
         6yPYK07XhZrNJO63Sv9UklkZ3mb3AnwPIcGBslJiOiytR2Zm5x3Pw4UADIX99fn82KSv
         KEcXzFR0z3FA3sPQLrWPUQ4V4fkl64DbsnhfHITO7x/7dwnqgT5RnjXma6dXeHvc8JjZ
         meOQ==
X-Gm-Message-State: APzg51AYSqqFywJnoxEO9yDhM0fnXF18BOpxeEMEIcqVnrZS1jQm4fit
        grJ/dhcAYNKUszgd0jqRlpRaaA==
X-Google-Smtp-Source: ANB0VdY7W8TNXy3QBSFCzO+Q+M/Frdz77xjS4yobxID+qnXWZiliFhGwlWnA2oBQ/UH0Ig5gbjSV8g==
X-Received: by 2002:a24:24c2:: with SMTP id f185-v6mr10666065ita.18.1537141559357;
        Sun, 16 Sep 2018 16:45:59 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:45:58 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/7] slimbus: core: update device status in probe
Date:   Sun, 16 Sep 2018 16:45:41 -0700
Message-Id: <20180916234546.29661-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

device status update can be racy with probe in some cases, so make sure
it take lock during the probe. Also after probe the device is expected
to be ready for communications, so make sure that a logical address
can be assigned to it after probe. If it fails to do so then probe
defer such instances.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 31f2910..262591f 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -40,8 +40,23 @@ static int slim_device_probe(struct device *dev)
 {
 	struct slim_device	*sbdev = to_slim_device(dev);
 	struct slim_driver	*sbdrv = to_slim_driver(dev->driver);
+	int ret;
+
+	ret = sbdrv->probe(sbdev);
+	if (ret)
+		return ret;
 
-	return sbdrv->probe(sbdev);
+	/* try getting the logical address after probe */
+	ret = slim_get_logical_addr(sbdev);
+	if (!ret) {
+		if (sbdrv->device_status)
+			sbdrv->device_status(sbdev, sbdev->status);
+	} else {
+		dev_err(&sbdev->dev, "Failed to get logical address\n");
+		ret = -EPROBE_DEFER;
+	}
+
+	return ret;
 }
 
 static int slim_device_remove(struct device *dev)
-- 
2.9.3

