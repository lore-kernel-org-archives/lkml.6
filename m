Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA1FC37122
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8C92089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U32GaGTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAUXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:32:02 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56313 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAUXb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:31:59 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so12332141wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1HJyAt+qP5edrfnptK21T5j6QfkO3OmLidMh2M63/mc=;
        b=U32GaGTHLvp3n3NO7lW7yF5E/zXYuLwg72UkHyRixcRoto3R+l8yHU33mfuE/gdwqD
         3LehgWEtA0XvKiryr4PPmSOn458dXmIcIF7T3W08ZUJ7dJZuXARTMM8CjpEUfbJsaFes
         EcGE83+4XQLXpKwE11LRZAI7hMpMdzcN0c7/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1HJyAt+qP5edrfnptK21T5j6QfkO3OmLidMh2M63/mc=;
        b=dpJR7Iosjr0oq+WuG9UdmkSpD01mcPfsJ/RXAk6Xqi/Kh8EW+NZpAhPQEUPSaL9nNR
         qGRWLLXRl470xjwBdj4fvuutVH6qXjC5lPPp7Vj5jWeOHdRV83tI/QEGdaxUm83x1Ks0
         W4RKnX3/9YdY46/29AgxahCRi1D6JZqIQS3DNM50bOlcpEAYPmVc7psvnUyt5hJjsk3s
         kMfjQVLv97ebl8bdWZHGEhX32tn2v5nXVJtHUU9QbrLh+lGEphsLKZ/uTfIMbL+96B+v
         Q9RLic0ZfjvcWmdq5S/Fm1a94MXlQjGr9p/brRRTbbHG7UHutrPeDT01BK8dziLtnBzW
         O0hg==
X-Gm-Message-State: AJcUukfeBvU8gX3x35vYyrwMHGmm9HiTJ8J+ox2KRlqdLLYQpcVaoA6p
        mHF0p0H5A/2bUkjD5xLTIm6cu4O7MqE=
X-Google-Smtp-Source: ALg8bN4YCahlBqR7YA8pSUiqUJYKFUPWg/ScGkdI8nOSVevyj2aHAPsPGB7wDX1EbQkUlctO1RllhQ==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr1235680wmg.51.1548113517072;
        Mon, 21 Jan 2019 15:31:57 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id g67sm106405967wmd.38.2019.01.21.15.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 15:31:56 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, mathieu.poirier@linaro.org,
        Mike Leach <mike.leach@linaro.org>
Subject: [RESEND PATCH v3 2/2] coresight: etmv4: Update ID register table to add UCI support
Date:   Mon, 21 Jan 2019 23:31:51 +0000
Message-Id: <20190121233151.13363-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190121233151.13363-1-mike.leach@linaro.org>
References: <20190121233151.13363-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
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

