Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F6EC282D9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 061C0218DA
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NG/qi3r9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfA3XlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:41:06 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43824 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3XlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:41:00 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so1296788wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 15:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tYoiEn3rGlYfp2djZcDtRq0G4N8SiFNVjNwRGoB1+ak=;
        b=NG/qi3r9Jong2qjYQkyYg6Gypld8RDdK4DWdP9KrS3GzGFcpWRvs0ZsM3JcGY14i2K
         0i4gZLY4L1L3bQrFomimVnGMrlYRk9X5Lq0tjJExWFTAhGrX4vyIIOW2F2b59B1cSoul
         cPVjwOZCc84dqDUpvHR5vAhrEkZY2ZpHLjnEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tYoiEn3rGlYfp2djZcDtRq0G4N8SiFNVjNwRGoB1+ak=;
        b=roLlYB5IoD2tOUd0HQntg9PGchFGcRwPRv/oWBvp5K1pJXNRUkp/8M1fpBFUF33e8a
         uanqwdxFPfqXc9Wro+CnWLe5/5kJPWMUDucpVf7qe94djdFt7Zt8/wDzwPLtjPINy1bv
         Ni3ffY79Og6rb1l8zu2aa7bpjgi4xVc6t+EWp1NUXDxUsK7IykTZvUj5aJhG4EGNB+aE
         +Lmb1MBWYtHaUCItY8FLmIYgv+GCCABtcdg1fob02sHTa5+u9+RAEZDR2rD5D8UFXZY+
         dyhkG7PGuqS8Jrb3A4WxkKY5PWwktghT9BOLC/XLA6Rsm1A059P1TVyq1/6r5z3H8QAr
         tqNw==
X-Gm-Message-State: AJcUukdYnIhFC4Fkn19nuRzorIOPRwScb8NFPmPU6RC6ibI9OYL+R5Cf
        gok2FmdxFIoxIpAJxlupUOepEQ==
X-Google-Smtp-Source: ALg8bN75ZFF1kDytY7l/gUl+safwed7S2O6sTIaGR87t2DxcGzQ0D7ilymqOcNoN4rPCPDYxeA3nfw==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr33224434wrm.218.1548891658976;
        Wed, 30 Jan 2019 15:40:58 -0800 (PST)
Received: from linaro.org ([2a00:23c5:6815:3901:cf0e:17bd:f425:fac3])
        by smtp.gmail.com with ESMTPSA id s3sm2344770wmj.23.2019.01.30.15.40.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 15:40:58 -0800 (PST)
From:   Mike Leach <mike.leach@linaro.org>
To:     mike.leach@linaro.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, saiprakash.ranjan@codeaurora.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com, arm@kernel.org
Subject: [PATCH v4 2/3] drivers: amba: Update component matching to use the CoreSight UCI values.
Date:   Wed, 30 Jan 2019 23:40:50 +0000
Message-Id: <20190130234051.2294-3-mike.leach@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190130234051.2294-1-mike.leach@linaro.org>
References: <20190130234051.2294-1-mike.leach@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches provide an update of amba_device and matching code to handle
the additional registers required for the Class 0x9 (CoreSight) UCI.

The *data pointer in the amba_id is used by the driver to provide extended
ID register values for matching.

CoreSight components where PID/CID pair is currently sufficient for
unique identification need not provide this additional information.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/amba/bus.c       | 45 +++++++++++++++++++++++++++++++++-------
 include/linux/amba/bus.h |  6 ++++++
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 41b706403ef7..b4dae624b9af 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -26,19 +26,36 @@
 
 #define to_amba_driver(d)	container_of(d, struct amba_driver, drv)
 
-static const struct amba_id *
-amba_lookup(const struct amba_id *table, struct amba_device *dev)
+/* called on periphid match and class 0x9 coresight device. */
+static int
+amba_cs_uci_id_match(const struct amba_id *table, struct amba_device *dev)
 {
 	int ret = 0;
+	struct amba_cs_uci_id *uci;
+
+	uci = table->data;
 
+	/* no table data or zero mask - return match on periphid */
+	if (!uci || (uci->devarch_mask == 0))
+		return 1;
+
+	/* test against read devtype and masked devarch value */
+	ret = (dev->uci.devtype == uci->devtype) &&
+		((dev->uci.devarch & uci->devarch_mask) == uci->devarch);
+	return ret;
+}
+
+static const struct amba_id *
+amba_lookup(const struct amba_id *table, struct amba_device *dev)
+{
 	while (table->mask) {
-		ret = (dev->periphid & table->mask) == table->id;
-		if (ret)
-			break;
+		if (((dev->periphid & table->mask) == table->id) &&
+			((dev->cid != CORESIGHT_CID) ||
+			 (amba_cs_uci_id_match(table, dev))))
+			return table;
 		table++;
 	}
-
-	return ret ? table : NULL;
+	return NULL;
 }
 
 static int amba_match(struct device *dev, struct device_driver *drv)
@@ -399,10 +416,22 @@ static int amba_device_try_add(struct amba_device *dev, struct resource *parent)
 			cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) <<
 				(i * 8);
 
+		if (cid == CORESIGHT_CID) {
+			/* set the base to the start of the last 4k block */
+			void __iomem *csbase = tmp + size - 4096;
+
+			dev->uci.devarch =
+				readl(csbase + UCI_REG_DEVARCH_OFFSET);
+			dev->uci.devtype =
+				readl(csbase + UCI_REG_DEVTYPE_OFFSET) & 0xff;
+		}
+
 		amba_put_disable_pclk(dev);
 
-		if (cid == AMBA_CID || cid == CORESIGHT_CID)
+		if (cid == AMBA_CID || cid == CORESIGHT_CID) {
 			dev->periphid = pid;
+			dev->cid = cid;
+		}
 
 		if (!dev->periphid)
 			ret = -ENODEV;
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index e3c36223e40b..f99b74a6e4ca 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -58,6 +58,10 @@ struct amba_cs_uci_id {
 	void *data;
 };
 
+/* define offsets for registers used by UCI */
+#define UCI_REG_DEVTYPE_OFFSET	0xFCC
+#define UCI_REG_DEVARCH_OFFSET	0xFBC
+
 struct clk;
 
 struct amba_device {
@@ -65,6 +69,8 @@ struct amba_device {
 	struct resource		res;
 	struct clk		*pclk;
 	unsigned int		periphid;
+	unsigned int		cid;
+	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
 	char			*driver_override;
 };
-- 
2.19.1

