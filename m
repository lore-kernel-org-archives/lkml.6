Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA6C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B7E2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lrkvqA/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3B7E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJOOYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 10:24:20 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39348 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeJOOYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 10:24:19 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9F6eOdF039282;
        Mon, 15 Oct 2018 01:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1539585624;
        bh=O1MNlTL8Ajqs/IldHTKK0tj83xOG0qZBKMcMwMMqaoc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lrkvqA/rQ7pOjG3OrQO+QGd9BicZbLFCz7PjNvwCyYYUBOkbpx42dpqShqRw2cd0m
         f+fDw7s/bC3cFKbhEnuoQ5EIeNsn2uYL5fIAzJ5VfeB2RHZ3h3AMh1snIOrzJABmHK
         tcfA59GxG17VR/+NtavmINoyEEujdR/ELcfMwzRQ=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eO5h005742;
        Mon, 15 Oct 2018 01:40:24 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 15
 Oct 2018 01:40:24 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 15 Oct 2018 01:40:24 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9F6eH4O023129;
        Mon, 15 Oct 2018 01:40:22 -0500
From:   Vignesh R <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH 1/3] spi: omap2-mcspi: Switch to readl_poll_timeout()
Date:   Mon, 15 Oct 2018 12:08:27 +0530
Message-ID: <20181015063829.26978-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181015063829.26978-1-vigneshr@ti.com>
References: <20181015063829.26978-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use standard readl_poll_timeout() macro for polling on status bits.

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 508c61c669e7..985f00d8a964 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -33,6 +33,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/gcd.h>
+#include <linux/iopoll.h>
 
 #include <linux/spi/spi.h>
 #include <linux/gpio.h>
@@ -353,19 +354,9 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
-	unsigned long timeout;
-
-	timeout = jiffies + msecs_to_jiffies(1000);
-	while (!(readl_relaxed(reg) & bit)) {
-		if (time_after(jiffies, timeout)) {
-			if (!(readl_relaxed(reg) & bit))
-				return -ETIMEDOUT;
-			else
-				return 0;
-		}
-		cpu_relax();
-	}
-	return 0;
+	u32 val;
+
+	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
 }
 
 static void omap2_mcspi_rx_callback(void *data)
-- 
2.19.1

