Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1BBC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ABC20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 18:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvlFanP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ABC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbeKGECp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729642AbeKGECp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:02:45 -0500
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE1E2086A;
        Tue,  6 Nov 2018 18:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541529371;
        bh=DKKrHcZEDvckhztoXQTQEnrDWU/3m1rqWN3NL85hfTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YvlFanP6vaGAN6nhlrLV9C/on7L+sJ+of5UEB5QRLkPhIQ5XB27/g28ynEAXbbHG3
         BXNZ8QfDfRJelJVaoXrD6pVTwgjA3lxCPmmW9K4y0v64jh0f/ugqteJR67h1I4AwjJ
         3ksKm5x5YOg38CQjU+kyINxXkuhjg7ldCK1MbTUI=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 1/4] of/device: Add a way to probe drivers by match data
Date:   Tue,  6 Nov 2018 10:36:06 -0800
Message-Id: <20181106183609.207702-2-sboyd@kernel.org>
X-Mailer: git-send-email 2.19.1.930.g4563a0d9d0-goog
In-Reply-To: <20181106183609.207702-1-sboyd@kernel.org>
References: <20181106183609.207702-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a handful of clk drivers that have a collection of slightly
variant device support keyed off of the compatible string. In each of
these drivers, we demux the variant and then call the "real" probe
function based on whatever is stored in the match data for that
compatible string. Let's generalize this function so that it can be
re-used as the platform_driver probe function directly.

Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/device.c       | 31 +++++++++++++++++++++++++++++++
 include/linux/of_device.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0f27fad9fe94..8381f33ed2d8 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -195,6 +195,37 @@ const void *of_device_get_match_data(const struct device *dev)
 }
 EXPORT_SYMBOL(of_device_get_match_data);
 
+/**
+ * platform_driver_probe_by_of_match_data - Probe a platform device using match data
+ * @pdev: platform device to probe
+ *
+ * For use by device drivers that multiplex their probe function through DT
+ * match data. Drivers can use this function to call their platform
+ * device probe directly without having to implement a wrapper function.
+ *
+ * static const struct of_device_id probe_funcs[] = {
+ *      { .compatible = "compat,foo", .data = foo_probe },
+ *      {}
+ * };
+ *
+ * struct platform_driver foo_driver = {
+ *      .probe = platform_driver_probe_by_of_match_data,
+ *      .driver = {
+ *            of_match_table = probe_funcs,
+ *      },
+ * };
+ *
+ */
+int platform_driver_probe_by_of_match_data(struct platform_device *pdev)
+{
+	int (*probe_func)(struct platform_device *pdev);
+
+	probe_func = of_device_get_match_data(&pdev->dev);
+
+	return probe_func(pdev);
+}
+EXPORT_SYMBOL_GPL(platform_driver_probe_by_of_match_data);
+
 static ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
 {
 	const char *compat;
diff --git a/include/linux/of_device.h b/include/linux/of_device.h
index 8d31e39dd564..4de84691d1c6 100644
--- a/include/linux/of_device.h
+++ b/include/linux/of_device.h
@@ -33,6 +33,7 @@ extern int of_device_add(struct platform_device *pdev);
 extern int of_device_register(struct platform_device *ofdev);
 extern void of_device_unregister(struct platform_device *ofdev);
 
+extern int platform_driver_probe_by_of_match_data(struct platform_device *pdev);
 extern const void *of_device_get_match_data(const struct device *dev);
 
 extern ssize_t of_device_modalias(struct device *dev, char *str, ssize_t len);
-- 
Sent by a computer through tubes

