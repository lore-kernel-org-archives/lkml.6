Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D881C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087620850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gG+UfqWj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6087620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbeLFACl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:02:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46559 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeLFACg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:02:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so21469445wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 16:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lGHDul39zNeZWBwTbhWQ3Y086neguPWhN09izxgMWVw=;
        b=gG+UfqWju0f6a7nHRvauIN0ynw03rVtRJqbOTVvnkM2gZ8D6YJPN+U6K/nxVNwO/9s
         z3x6Gt2G2eUrSgEY6QG+98vGpgR6lP8XQX3EogJbssU+6MTZVT5Uo4wbwe3B1uUFu/FP
         VUSxhx01yjEKVdMZoiWvxGtjjmkbfb64rR4NY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lGHDul39zNeZWBwTbhWQ3Y086neguPWhN09izxgMWVw=;
        b=iIqrsr74kh3u4a2aSbf9Xs1kItAJM2Hfr/aEuo8CBe8gz0rCO5458BQTCEumW0tUyZ
         SbUkIpJitpFN1JKS/penaGTJsWxUniE9fM0XyT62rQiqdbNPFnPA+Q4Iz9pIDe1sNlWz
         9OzP24rh/8SXnUfaEkO2OyQIwO/y/xUs9IJgMi5C72mLxdWSrArMGh4oKyBjtofbgeWm
         g5AgyXc46jP77k6ew/dxcrA8DnNTc5siLbIFfoe8ftZRyd5fs11OfYZNr38JSYrLoV+m
         9lTzr/JMl9wAzrfnglNzw7QSOE6qQ0YSl7/rq9aNpDWwzd9REleVnm2uPzyEV0cpvwAQ
         m8FQ==
X-Gm-Message-State: AA+aEWYUDF6u00kIxCZQuhBovZd8ynCWKzp0keErZoA9kZoI2xfw8YpC
        Qye4yLtbmrY75Z5ZF3zaP2Dv6A==
X-Google-Smtp-Source: AFSGD/VGN2fxC9LsfM7b/Y7ytGz0oiicWZfnWnkkMqCHiekPAcCJz/y4ynBuI50dn4fm5DQ2UoNKBQ==
X-Received: by 2002:adf:dfd1:: with SMTP id q17mr24530716wrn.27.1544054555123;
        Wed, 05 Dec 2018 16:02:35 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id i9sm23241184wrs.34.2018.12.05.16.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 16:02:34 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux@armlinux.org.uk,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com
Subject: [PATCH v3 2/2] coresight: etmv4: Update ID register table to add  UCI support
Date:   Thu,  6 Dec 2018 00:02:26 +0000
Message-Id: <20181206000226.2507-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181206000226.2507-1-mike.leach@linaro.org>
References: <20181206000226.2507-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..2fb8054e43ab 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1073,12 +1073,28 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		.mask	= 0x000fffff,		\
 	}
 
+static struct amba_cs_uci_id uci_id_etm4[] = {
+	{
+		/*  ETMv4 UCI data */
+		.devarch	= 0x47704a13,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000013,
+	}
+};
+
+#define ETM4x_AMBA_UCI_ID(pid)			\
+	{					\
+		.id	= pid,			\
+		.mask	= 0x000fffff,		\
+		.data	= uci_id_etm4,		\
+	}
+
 static const struct amba_id etm4_ids[] = {
 	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
 	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
 	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
 	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	ETM4x_AMBA_UCI_ID(0x000bb9da),		/* Cortex-A35 */
 	{},
 };
 
-- 
2.19.1

