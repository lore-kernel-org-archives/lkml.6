Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA1FC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD1320882
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UOvi4H/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD1320882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeILCvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:51:24 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51295 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728281AbeILCvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:51:23 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so334100itf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 14:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tc0VYjzvtrRhZoxEZG72ESoXO/EpMMtSV0pE/TDCzIM=;
        b=UOvi4H/7QiAkS7olTEsrymcYzbNylgXc0bqLDh/8tKTcI3g+T+HNs7yMUbnJKRxh1h
         43OeqtxoQt+nxKMoMv7vkswTJim03nmHf4kpRYiLDB2fQxS2O09ywBsOJEexqaDEMJfx
         Hc1SiyqstJOXDyKggOkcDfVMxGezoNd3ETIQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tc0VYjzvtrRhZoxEZG72ESoXO/EpMMtSV0pE/TDCzIM=;
        b=lYYcdrw7ovTf7/z/TYQW5Bx7b+BBMVM3wrBE+vcvBZAJ9ORhUccnSlUeQc4QkOHpdx
         yJ42F08a1BH9NhqS2tAvAE/tj3LbCljLbWT4puQaNZFASbVWKm2OBKxCf+F/yIVmOveb
         SWbbefmwweodHKyXMbGVajwdJjPnG7W/CUlxsJWT1rBkAeoQQfqW2FHxWGrvGuLosV3T
         kdZluTirCLY1wE2yFONfvJKPG2qiOxvN/P6TwcKMAib2qseFoDa2K7qKNL+qDH41hay/
         eqZnVW0PglGdiMXDblJTBwlkHUdtrUTQ9hFdH/a25yoBgrgdPZsQg+/7mLV/9yoGCXqy
         kQ8A==
X-Gm-Message-State: APzg51B8ZuixXztEdrDTi7HbgFl3XPXRxKAZNaPgs04qxYidq2SPCRVo
        1eYeePRLI7F0Y3EaoZ6zupndaA==
X-Google-Smtp-Source: ANB0VdZ0dvc7Sa9Sw5qZqnIeEf0ow+LF8IwaJ/GYrt2w8/7WGHLEiH4k/3U18hBV06UqQrNzK7hQ0Q==
X-Received: by 2002:a02:88ad:: with SMTP id n42-v6mr23854655jaj.38.1536702606424;
        Tue, 11 Sep 2018 14:50:06 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id c3-v6sm1102172itd.8.2018.09.11.14.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Sep 2018 14:50:05 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        gregkh@linuxfoundation.org, kim.phillips@arm.com,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] coresight: Define macro to replace dev_dbg() boiler plate code
Date:   Tue, 11 Sep 2018 15:49:54 -0600
Message-Id: <1536702595-9999-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using a macro is much better than repeating the same code everywhere
in the drivers.  That way it is easy to keep debug output messages
confined to the sysFS mode of operation.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index acfe67646a05..8a7a197cba69 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -7,6 +7,7 @@
 #define _CORESIGHT_PRIV_H
 
 #include <linux/bitops.h>
+#include <linux/device.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
 #include <linux/pm_runtime.h>
@@ -74,6 +75,12 @@ enum cs_mode {
 	CS_MODE_PERF,
 };
 
+#define coresight_dev_dbg(dev, mode, format, ...)	\
+do {							\
+	if (mode == CS_MODE_SYSFS)			\
+		dev_dbg(dev, format, ##__VA_ARGS__);	\
+} while (0)
+
 /**
  * struct cs_buffer - keep track of a recording session' specifics
  * @cur:	index of the current buffer
-- 
2.7.4

