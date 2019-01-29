Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2032FC282CD
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E090221738
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 01:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="if5BJhOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfA2B4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 20:56:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfA2Bzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 20:55:54 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so8899342pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 17:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gji32VkUeCkRxiH9mP+AVAmiusPVWMB1ViiGWccVEm0=;
        b=if5BJhOTMgRmISQRpJ3xFZzCEC7YMFAijTQxrWOvLcZZrCsLcrCrPg9bfsp4xRvltz
         9W+LfLECCh7NouIuswObxi/mSMWhQL28P7kH4/mNpOhBk8h8xXmVuoH8uAK6GZx9gfwe
         TgzMp2yBxkHWDaE/XbtsWUcyp8IANp1eGSYYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gji32VkUeCkRxiH9mP+AVAmiusPVWMB1ViiGWccVEm0=;
        b=HzNhO9X5FZqNeNFDMl8kcFQ56+IMYAZgeYaxHlhB8nvhZpEmA14W0P1HzAf7bARrx5
         RT9isiYmyG1aceLexTU4C6e/uZvQVw5phSp4rZgjnoQjkn8ZGfWOok3sPxoq/mU6IQM/
         49DfgaS1Z0WvA+x7HRhoz4lPYUyTVyhkMoxiJy+pvPV/V2rs+LWEOwj/CXe9rbxZ2o4X
         P8JhGpf/ZgeKbi23VDvMES+0SpcK8HHexoqaiOcYETVzNreRHWSIpjLjp+TGrI1+F3/R
         JBdSPyGR6I5wBAfu0YN8+tvB4A5hj2NLUeZSemz2jLF706wMdvoDO+CmKLxN/f9PXmWv
         apvQ==
X-Gm-Message-State: AJcUukd4LIIj0hSs0+4OMJzNytmje0dDAw2Iw7Sz13nn/WFKAiA6bSxX
        cqeJZLibJDvTkeYZKhkVZKZp4wKXyIIirA==
X-Google-Smtp-Source: ALg8bN5ERw1GU45DC++AuwfXEApEUb3qSQtkp1lhzdWUfT8L6lhNrZdWZg5sQ0IRaOTQy4KysX+Ejw==
X-Received: by 2002:a65:484c:: with SMTP id i12mr21807451pgs.309.1548726953832;
        Mon, 28 Jan 2019 17:55:53 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g15sm142911530pfj.131.2019.01.28.17.55.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 17:55:53 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [RFC/PATCH 4/5] spi: spi-geni-qcom: Use OPP API to set clk/perf state
Date:   Mon, 28 Jan 2019 17:55:46 -0800
Message-Id: <20190129015547.213276-5-swboyd@chromium.org>
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

geni spi needs to express a perforamnce state requirement on CX
depending on the frequency of the clock rates. Use OPP table from
DT to register with OPP framework and use dev_pm_opp_set_rate() to
set the clk/perf state.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/spi/spi-geni-qcom.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index fdb7cb88fb56..3ffb6b25b58d 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -116,9 +116,9 @@ static int get_spi_clk_cfg(unsigned int speed_hz,
 
 	dev_dbg(mas->dev, "req %u=>%u sclk %lu, idx %d, div %d\n", speed_hz,
 				actual_hz, sclk_freq, *clk_idx, *clk_div);
-	ret = clk_set_rate(se->clk, sclk_freq);
+	ret = dev_pm_opp_set_rate(mas->dev, sclk_freq);
 	if (ret)
-		dev_err(mas->dev, "clk_set_rate failed %d\n", ret);
+		dev_err(mas->dev, "dev_pm_opp_set_rate failed %d\n", ret);
 	return ret;
 }
 
@@ -564,6 +564,12 @@ static int spi_geni_probe(struct platform_device *pdev)
 	if (!spi)
 		return -ENOMEM;
 
+	ret = dev_pm_opp_of_add_table(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to init OPP table: %d\n", ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, spi);
 	mas = spi_master_get_devdata(spi);
 	mas->irq = irq;
@@ -629,6 +635,8 @@ static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
 	struct spi_master *spi = dev_get_drvdata(dev);
 	struct spi_geni_master *mas = spi_master_get_devdata(spi);
 
+	/* Drop the performance state vote */
+	dev_pm_opp_set_rate(dev, 0);
 	return geni_se_resources_off(&mas->se);
 }
 
-- 
Sent by a computer through tubes

