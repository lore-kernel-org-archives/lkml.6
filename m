Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B2EC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C6E20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C6E20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbeLCMXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:23:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33397 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:23:24 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so8976584lfc.0;
        Mon, 03 Dec 2018 04:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eg2ufM9FdHFhTVDmxheR3tr+ip3I7Xl4uZ2RuWzUJVA=;
        b=Gza5f3gPJPvNjLBfXib/EIiJgI0T9BYsHJSCGH7V3yUjf5nnbqEhm6nWAAvBeb0q2t
         NMDgEG3QhopRhtub5P83+lpC7DCUODOR3B1KCFNUMt8M9NSMLF6b6qizCgBstfa6zprr
         t9M4+zLvMp6HoHOpnOa7P4G0Wgy3L+It0/+w1SIjQzMWD4NECHRi5KRtJAUqu0MbYb9y
         7TIq/j/jcPH+UnBV9NSnSrUNYKspICz8c2bgY4H3hVAlEwMHA6hHFis6Tm1NJtxApNKA
         zy/jt1iEl496QKayLN7Q+K9eklpMuox3JsFepUQ47yNgJapmM9JyXuOmK9rXIjzM92aE
         B3Iw==
X-Gm-Message-State: AA+aEWZXIF0DRaQ8U2WHzQQ/tDCEd2jETSKevArVjFhGLvtJxu2gzk1j
        bA9p8REJQAkstsDWZvVv6Ac=
X-Google-Smtp-Source: AFSGD/UW/Y17SkEXDYI/3asKglm+pxUJcs8KkBfsyv6BBri5+OgsNM/kNXDc4ufMa+saFjvBX1uM7A==
X-Received: by 2002:a19:2395:: with SMTP id j143mr8716004lfj.107.1543839752957;
        Mon, 03 Dec 2018 04:22:32 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id p91sm2362753lfg.4.2018.12.03.04.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:22:32 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:22:17 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, linux@armlinux.org.uk,
        andy.gross@linaro.org, david.brown@linaro.org, pavel@ucw.cz,
        andrew.smirnov@gmail.com, lee.jones@linaro.org,
        pombredanne@nexb.com, sjhuang@iluvatar.ai, akshu.agrawal@amd.com,
        djkurtz@chromium.org, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 7/9] clk: clk-twl6040: Free of_provider at remove
Message-ID: <a7f245be2d788bb303fcc51e3d372f647b850c65.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
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
index 25dfe050ae9f..e9da09453eb2 100644
--- a/drivers/clk/clk-twl6040.c
+++ b/drivers/clk/clk-twl6040.c
@@ -108,9 +108,8 @@ static int twl6040_pdmclk_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, clkdata);
 
-	return of_clk_add_hw_provider(pdev->dev.parent->of_node,
-				      of_clk_hw_simple_get,
-				      &clkdata->pdmclk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+			of_clk_hw_simple_get, &clkdata->pdmclk_hw);
 }
 
 static struct platform_driver twl6040_pdmclk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
