Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86D8C282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DB02177E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GrLPu896"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfA2B4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:56:05 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42953 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfA2Bzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:54 -0500
Received: by mail-pf1-f195.google.com with SMTP id 64so8885582pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cATQLWSVRvCn1SsUsbBtXSPozOZ5/uzoCaTY1Z0hItQ=;
        b=GrLPu896AeP69/qFFjVidbQpr5XsvKSqPGrnRkFqc0oyA9QDbdjOHOPxiOrpxnDspk
         ujGr5qnUHvn0y9mrC7dvRk6mcug7rRaPPlDcQn3vJlaDQMgoHhqrMmbz84SNzPiUZOg8
         mZ+6PRL5tDD3Tg39o0KMTzuUf8UtF7d7cX0C8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cATQLWSVRvCn1SsUsbBtXSPozOZ5/uzoCaTY1Z0hItQ=;
        b=jGuRbQyV9rtX9qqVHPd+Oz+5xQJWWstefVTYmRUVz5uV1YUaSZrbNCRLpM4GQ6X6Az
         OjB//VrR3azWoDRz7IlciQyAnSTA3JYRuu60wgt1HSfLje/hXpUrcm211CG8K3qmGrKG
         JW5kDJ9tNUHORvLFhF4Mb8ZEpuH35Sl4gErufj9Rd2CCfmvKCZTWG1f0+WhDAtyg10il
         gBVWM4QIUxZDUr/rzftWCo8DNi907r5AdtXAgBsDpLMf94htyEikH15Bk2wLiQen6Clo
         UJVPEnKFOxvAOBalpGhnLu8phRnHdrUVBZYK/4td8FGsJ9hsbKA4aofq7dBfjA+GLQMG
         rTKw==
X-Gm-Message-State: AJcUukcZNLKz0tJ4I30ov8LNdfYaymxuVwDu+fjAH+l5YncVVtz8EuzN
        MLG12VkdzRyS69lcHgvxe5MzZ9tAlcT7yQ==
X-Google-Smtp-Source: ALg8bN6gGuF6SvKMeUDruFsteW+0NOW13owtLSEFBvqKNcngSC2ynmws9guSkqqGCxHQYsIW+FN+Pw==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr21686546pgv.31.1548726952920;
        Mon, 28 Jan 2019 17:55:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:52 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 3/5] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
Date:   Mon, 28 Jan 2019 17:55:45 -0800
Message-Id: <20190129015547.213276-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190129015547.213276-1-swboyd@chromium.org>
References: <20190129015547.213276-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

geni serial needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index a72d6d9fb983..dca8f6845463 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_opp.h>
 #include <linux/platform_device.h>
 #include <linux/qcom-geni-se.h>
 #include <linux/serial.h>
@@ -119,6 +120,7 @@ struct qcom_geni_serial_port {
 	bool brk;
 
 	unsigned int tx_remaining;
+	struct device *dev;
 };
 
 static const struct uart_ops qcom_geni_console_pops;
@@ -1028,7 +1030,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 
 	uport->uartclk = clk_rate;
-	clk_set_rate(port->se.clk, clk_rate);
+	dev_pm_opp_set_rate(port->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
 
@@ -1265,8 +1267,10 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
 		geni_se_resources_on(&port->se);
 	else if (new_state == UART_PM_STATE_OFF &&
-			old_state == UART_PM_STATE_ON)
+			old_state == UART_PM_STATE_ON) {
+		dev_pm_opp_set_rate(port->dev, 0);
 		geni_se_resources_off(&port->se);
+	}
 }
 
 static const struct uart_ops qcom_geni_console_pops = {
@@ -1332,6 +1336,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid line %d\n", line);
 		return PTR_ERR(port);
 	}
+	port->dev = &pdev->dev;
 
 	uport = &port->uport;
 	/* Don't allow 2 drivers to access the same port */
@@ -1353,6 +1358,12 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 		return -EINVAL;
 	uport->mapbase = res->start;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	port->tx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->rx_fifo_depth = DEF_FIFO_DEPTH_WORDS;
 	port->tx_fifo_width = DEF_FIFO_WIDTH_BITS;
-- 
Sent by a computer through tubes

