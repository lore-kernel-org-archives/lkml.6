Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98875ECDE46
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6775520685
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6775520685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeJaR3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:29:11 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46493 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbeJaR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:29:10 -0400
Received: by mail-lf1-f68.google.com with SMTP id o2-v6so10946043lfl.13;
        Wed, 31 Oct 2018 01:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yodtWAaw5BTk3hbCqBw9o101omzQN2QDRD/joFnNkiA=;
        b=PnwC1+Vprt04NqLY566cB1I+5yM5fWpxwdR6JZmUCeuvOT53KkVFxjtIAm3LnQPy/t
         OnPCB8DvpF81VJNymp5fcILYl0+poXL+braXd40HBpupOIuG9hfZgIc1LGfud4ln4kCD
         F1XT+EUpEwQddRnxDU2ZQHcJUX1bcfVO2Ar1m9IxalYJSVSyAQGQsRWzP9TZl0kt/ES4
         +u4YH8oasnvoIiQW+00DiIWARev9CtnQU1ESdeUokECMI91uqJp/wO+mF61sW93bufqR
         SErsW2LnFQQmlvoOZNYIdvQHFdLyB8yesjYcRF1/BbrRmH+fJgOf1GTIUhan5E/q2d6k
         +dpA==
X-Gm-Message-State: AGRZ1gJDT3qJQ+yhDyE1ry9QD9g54cceOXmMyzU7M9qF5l3zmhs/lW1L
        ZYYaZW9Nbtl6eWTfG451ANM=
X-Google-Smtp-Source: AJdET5d+965pcpjHNMils5+JMBG9Pp5AZoQQ91OgfhYTK3gWlr+tcNeXjqkB7PPrVZmkJtWKUL/cgw==
X-Received: by 2002:a19:f115:: with SMTP id p21mr1220273lfh.20.1540974721284;
        Wed, 31 Oct 2018 01:32:01 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id f134-v6sm1822585lfg.68.2018.10.31.01.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 01:32:00 -0700 (PDT)
Date:   Wed, 31 Oct 2018 10:31:48 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Huang Shijie <sjhuang@iluvatar.ai>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Kurtz <djkurtz@chromium.org>, mazziesaccount@gmail.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH 3/8] clk: clk-s3c2410-dclk: clean up clkdev lookup leak
Message-ID: <f1d3f6d26c2731050b4be90c32397c62e4dc31a8.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540970653.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm variant of clkdev lookup registration in order to avoid
clkdev lookup leak at device remove.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/samsung/clk-s3c2410-dclk.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-s3c2410-dclk.c b/drivers/clk/samsung/clk-s3c2410-dclk.c
index 0d92f3e5e3d9..07798debfec4 100644
--- a/drivers/clk/samsung/clk-s3c2410-dclk.c
+++ b/drivers/clk/samsung/clk-s3c2410-dclk.c
@@ -309,16 +309,17 @@ static int s3c24xx_dclk_probe(struct platform_device *pdev)
 			goto err_clk_register;
 		}
 
-	ret = clk_hw_register_clkdev(clk_table[MUX_DCLK0], "dclk0", NULL);
+	ret = devm_clk_hw_register_clkdev(&pdev->dev, clk_table[MUX_DCLK0],
+					  "dclk0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_DCLK1], "dclk1",
-					     NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_DCLK1], "dclk1", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT0],
-					     "clkout0", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT0], "clkout0", NULL);
 	if (!ret)
-		ret = clk_hw_register_clkdev(clk_table[MUX_CLKOUT1],
-					     "clkout1", NULL);
+		ret = devm_clk_hw_register_clkdev(&pdev->dev,
+				clk_table[MUX_CLKOUT1], "clkout1", NULL);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register aliases, %d\n", ret);
 		goto err_clk_register;
-- 
2.14.3


