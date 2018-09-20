Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6021C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B6E21534
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bp1k9hS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B6E21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbeIUAOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 20:14:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33757 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeIUAOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 20:14:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id r1-v6so2237505wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 11:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la48aY5uXjq4A2lLegD6L3mL5JzWDz5xO/EKbSrcn5A=;
        b=Bp1k9hS+WXoheSAwak88WteD29XgAHfc1pRhzfPGE6JrKv5W8F16YFxZqW9UxzQwTs
         f6H1rdsXwIwbG3vnb+6uZLuUGqqN/jyTH7XFr/jk+IrPeatV8Qrj4hl+xtt7DubDRV/7
         4/Cz9IXSXAmD+vl8rPxZA3tdDmaSip4ATS/9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=la48aY5uXjq4A2lLegD6L3mL5JzWDz5xO/EKbSrcn5A=;
        b=fq4BkWHA7xJb8lEghy/sSSMcKntqkHDOsx/5JPd9AJqqhJC0j03hHh75FexGChLPjy
         HjaWIC9oTi/p0UMMc6I/ZMDP07Auj1ZCnpe6eYgWq2uhaWupE/t+xFeXxubJIL8EHZZy
         JG3dgSLy6W4uPX8pTB3eTv180DIlMzUp+nRFjoN5Bn1zwQSi6VAaS+mhVixGe6R7W9Rd
         nnmfyX2uPJW20a8/RqXxPMWrSmNURba82PXb8p36C98Q7h5H6hWR3eSwffDQm+aZga/F
         E+1VobFDGLQn6GnhyyGP1aT9KDnNADibhFZjOhLhFMpNjoH3KQ+1AS+wmW1MzWBQvvkg
         KPlQ==
X-Gm-Message-State: APzg51ALi5JiSX6JHSOeDb9pi0zwbpY5LjhpGDipqUdBPAEx0u4fXiDv
        Bs/IVlILCG/26fmPkgNQ4BP7UA==
X-Google-Smtp-Source: ANB0VdbnnsXr6AQbEmNiZW7v41R8AP6CiKRWFwk8qKpp5VMHepRe6U+8ki/0/aCpHiCSV84Bg5rqpg==
X-Received: by 2002:a1c:b6d6:: with SMTP id g205-v6mr3896822wmf.17.1537468153322;
        Thu, 20 Sep 2018 11:29:13 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id 200-v6sm4783384wmv.6.2018.09.20.11.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 11:29:12 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org,
        mturquette@baylibre.com, khilman@baylibre.com,
        vincent.guittot@linaro.org, skannan@codeaurora.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        seansw@qti.qualcomm.com, daidavid1@codeaurora.org,
        evgreen@chromium.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, abailon@baylibre.com,
        maxime.ripard@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org, georgi.djakov@linaro.org
Subject: [RFC] i2c: qup: Use the interconnect API
Date:   Thu, 20 Sep 2018 11:29:03 -0700
Message-Id: <20180920182903.19991-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interconnect API provides an interface for consumer drivers to express
their bandwidth needs in the SoC. This data is aggregated and the on-chip
interconnect hardware is configured to the appropriate power/performance
profile.

Use the interconnect API to get() the path between the endpoints used for
data transfers by the I2C QUP and report the needed bandwidth based on the
i2c mode.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

This patch depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444

TODO: Use a macro for converting and rounding to icc units instead of
converting between kilobits, kilobytes etc. in the consumer drivers.

 drivers/i2c/busses/i2c-qup.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
index c86c3ae1318f..436747a74dc6 100644
--- a/drivers/i2c/busses/i2c-qup.c
+++ b/drivers/i2c/busses/i2c-qup.c
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -280,6 +281,11 @@ struct qup_i2c_dev {
 	void (*read_rx_fifo)(struct qup_i2c_dev *qup);
 	/* function to write tags in tx fifo for i2c read transfer */
 	void (*write_rx_tags)(struct qup_i2c_dev *qup);
+
+	/* frequency mode standard */
+	u32			clk_freq;
+	/* interconnect path to scale according to bandwidth needs */
+	struct icc_path		*path;
 };
 
 static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
@@ -1657,6 +1663,16 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
 	clk_disable_unprepare(qup->pclk);
 }
 
+static void qup_i2c_enable_icc(struct qup_i2c_dev *qup)
+{
+	icc_set(qup->path, 0, qup->clk_freq / 8000);
+}
+
+static void qup_i2c_disable_icc(struct qup_i2c_dev *qup)
+{
+	icc_set(qup->path, 0, 0);
+}
+
 static const struct acpi_device_id qup_i2c_acpi_match[] = {
 	{ "QCOM8010"},
 	{ },
@@ -1784,6 +1800,10 @@ static int qup_i2c_probe(struct platform_device *pdev)
 		}
 		ACPI_COMPANION_SET(&qup->adap.dev, ACPI_COMPANION(qup->dev));
 	} else {
+		qup->path = of_icc_get(qup->dev, "i2c-mem");
+		if (IS_ERR(qup->path))
+			return PTR_ERR(qup->path);
+
 		qup->clk = devm_clk_get(qup->dev, "core");
 		if (IS_ERR(qup->clk)) {
 			dev_err(qup->dev, "Could not get core clock\n");
@@ -1795,6 +1815,8 @@ static int qup_i2c_probe(struct platform_device *pdev)
 			dev_err(qup->dev, "Could not get iface clock\n");
 			return PTR_ERR(qup->pclk);
 		}
+		qup->clk_freq = clk_freq;
+		qup_i2c_enable_icc(qup);
 		qup_i2c_enable_clocks(qup);
 		src_clk_freq = clk_get_rate(qup->clk);
 	}
@@ -1927,6 +1949,7 @@ static int qup_i2c_remove(struct platform_device *pdev)
 
 	disable_irq(qup->irq);
 	qup_i2c_disable_clocks(qup);
+	icc_put(qup->path);
 	i2c_del_adapter(&qup->adap);
 	pm_runtime_disable(qup->dev);
 	pm_runtime_set_suspended(qup->dev);
@@ -1939,6 +1962,7 @@ static int qup_i2c_pm_suspend_runtime(struct device *device)
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: suspending...\n");
+	qup_i2c_disable_icc(qup);
 	qup_i2c_disable_clocks(qup);
 	return 0;
 }
@@ -1948,6 +1972,7 @@ static int qup_i2c_pm_resume_runtime(struct device *device)
 	struct qup_i2c_dev *qup = dev_get_drvdata(device);
 
 	dev_dbg(device, "pm_runtime: resuming...\n");
+	qup_i2c_enable_icc(qup);
 	qup_i2c_enable_clocks(qup);
 	return 0;
 }
