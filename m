Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF579C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF20F2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF20F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbeLDLiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:38:50 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38680 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:38:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id p86so11690840lfg.5;
        Tue, 04 Dec 2018 03:38:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZdU1eWJ3OUe0zNYgDLJWqUhZGKZPNEOFUSCmMYIOKrc=;
        b=c0jI+G7hKLqa9FgSnytfLASjE8AwIPgnyYMCpGmDhcJBEhxLi1XvuRwC5Cke+HrlRk
         dqxGTq9YPQjy9ZOjmR7RKoF9/141jxB7lhgW08hGRRfo611tFuCohdjltc9ExrcaTyGv
         Yw6qh0Gdtd2j8xRESFmc5JqWmxa2uoOQCIEFZoGdEV5/+n62rnB8LHkkzRrpWPwn8jYb
         jfazT91P2N2NpB5MINqyvgvJo2qZa0L9G+Wv7XyV2cOktls3eK3bLGMmw1hH0LhMRHUw
         8U2IdesNl/kHOFxEzvP2SQPpaUa/inP0tcD0DhYKM8d71Yymk3KgJkPOk+7OPCoj0SeN
         qfOQ==
X-Gm-Message-State: AA+aEWZ7mXynpF6v+EcOGYnQvYx/YYzyDXqBSdi1r/4eI2JLhOV+XTXs
        pqEZR1vN+DhMuGbXNlusBDE=
X-Google-Smtp-Source: AFSGD/V1xPO8IerCWDRq/eowaUVH5Dlt/SrQkU+0AKRmpC8SX2ZuRWhXGwxxjPIdY1NB+9b4oHQB5Q==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr8364473lfi.2.1543923526355;
        Tue, 04 Dec 2018 03:38:46 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id r27-v6sm3146758lja.65.2018.12.04.03.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:38:45 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:38:32 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, pombredanne@nexb.com,
        sjhuang@iluvatar.ai, akshu.agrawal@amd.com, djkurtz@chromium.org,
        rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 08/10] clk: clk-twl6040: Free of_provider at remove
Message-ID: <e00097fb5b52f1d4002c8febdb3887736e84acd0.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use devm variant for of_provider registration so provider is freed
at exit.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/clk/clk-twl6040.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/clk-twl6040.c b/drivers/clk/clk-twl6040.c
index 25dfe050ae9f..ea846f77750b 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3
