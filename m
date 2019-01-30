Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17016C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04F120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A4ICsNpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfA3XlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:41:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37101 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727166AbfA3XlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:41:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so1336545wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:41:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N0+MiYkl2FyUrNQhM06/7391PqinzSAuv8ZoqqjUEE4=;
        b=A4ICsNpMFi+QJWC1G7cGMifLk7QGKMRGBKWrFYbboVsNH/8mdeQwKL1b0XE/rNcup7
         2T/DIqLlU0K0Zzd98Q7j+cTCFsCSlGookt7jBeM9iSepujof5qpJlckNf7cprfPxfi2S
         9ytIC2pIsbtAFcrytL90m0Qo+vFW3Jz7h0KVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N0+MiYkl2FyUrNQhM06/7391PqinzSAuv8ZoqqjUEE4=;
        b=Wvs1uZZOpuGNpuxh2iI7RtFcjtHnP8gOGL5EpTRElkuonl4Gt4aTlgO5UTC28GtOuR
         BQA4Pl7tObmCbu3cvGukfkIBppWPrVKkmq69Wv8YTz+f4HXRa8JIuhhYK0CBo6tDJNV1
         QFWwKfERm2GdEHpzdH0tBRtc1i4fjzJUrPfoh1cSnOQDUUCikuTd2jYFYNI8Q00ZKkO1
         BX98vuBobP2YZpZ7NkWqFjYJxZoPrllDpQqYhSpNq0OdMFWkZoGAd53mvxQEEhrT2oul
         9vSf35xC+OWt3rsz2f4iX8VdL2J97A0DjmyFAHnTl6MDZsszfCVV30zmQcblM30Y9X3g
         ujdg==
X-Gm-Message-State: AJcUukeNqI0QSAg2xZFUR2TVhMwrd93Op3QJ0lDZXKJfWCarS0HV0m78
        NZK3MBqR68ypXkSnk/g3aBHlUg==
X-Google-Smtp-Source: ALg8bN7+R3FvVFV+Gg8YnqDPIMvID5fvaGHBJxBJp8GNh1mkKpMabsZfkZ9IUjywIsWSd5vEfueGRA==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr30735806wrq.5.1548891660014;
        Wed, 30 Jan 2019 15:41:00 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 15:40:59 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, saiprakash.ranjan@codeaurora.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com, arm@kernel.org
Subject: [PATCH v4 3/3] coresight: etmv4: Update ID register table to add UCI support
Date:   Wed, 30 Jan 2019 23:40:51 +0000
Message-Id: <20190130234051.2294-4-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
References: <20190130234051.2294-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds macro to enable UCI entries to be added to AMBA ID tables.

Updates the ID register tables to contain a UCI entry for the A35 ETM
device to allow correct matching of driver in the amba bus code.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++++++++--------
 drivers/hwtracing/coresight/coresight-priv.h  |  8 +++++++
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 53e2fb6e86f6..dd9b9b5ebb84 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1067,18 +1067,21 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-#define ETM4x_AMBA_ID(pid)			\
-	{					\
-		.id	= pid,			\
-		.mask	= 0x000fffff,		\
+static struct amba_cs_uci_id uci_id_etm4[] = {
+	{
+		/*  ETMv4 UCI data */
+		.devarch	= 0x47704a13,
+		.devarch_mask	= 0xfff0ffff,
+		.devtype	= 0x00000013,
 	}
+};
 
 static const struct amba_id etm4_ids[] = {
-	ETM4x_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
-	ETM4x_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
-	ETM4x_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
-	ETM4x_AMBA_ID(0x000bb959),		/* Cortex-A73 */
-	ETM4x_AMBA_ID(0x000bb9da),		/* Cortex-A35 */
+	CS_AMBA_ID(0x000bb95d),		/* Cortex-A53 */
+	CS_AMBA_ID(0x000bb95e),		/* Cortex-A57 */
+	CS_AMBA_ID(0x000bb95a),		/* Cortex-A72 */
+	CS_AMBA_ID(0x000bb959),		/* Cortex-A73 */
+	CS_AMBA_UCI_ID(0x000bb9da, uci_id_etm4),	/* Cortex-A35 */
 	{},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 02a1f5204f9d..fd69ad24432a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -183,6 +183,14 @@ static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 			}				\
 	}
 
+/* coresight AMBA ID, full UCI structure: id table entry. */
+#define CS_AMBA_UCI_ID(pid, uci_ptr)	\
+	{				\
+		.id	= pid,		\
+		.mask	= 0x000fffff,	\
+		.data	= uci_ptr	\
+	}
+
 /* extract the data value from a UCI structure given amba_id pointer. */
 static inline void *coresight_get_uci_data(const struct amba_id *id)
 {
-- 
2.19.1

