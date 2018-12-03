Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECA3720848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECA3720848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeLCMV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:21:58 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40496 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:21:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id v5so8936033lfe.7;
        Mon, 03 Dec 2018 04:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GkHc1XDfS2zAEG1O6tNrzFVGgOycf/0Y3wU3cQalzu0=;
        b=K7KtWoEmhhwzGuk4hMiprMlrgrgkY8jufptMH+KXyKLK5NOidrNS/Ht8JpGK/PBY50
         pcpDl+WY+we+uP+CxcAHLMwuLv4ZTnoDzoQ8s4sdkpZSvaIMUZmyIzjAqhMC4c2u4IW/
         DfKdQtbmGUiLAtKpwYHd1tHa0g7Bjssq/ldTiMk63J0fdbuv9e4GzOAEEAMUn4RjIioJ
         loCJHDp7rUXiGbyYzN4Ugo8GQC/gIaz8sOi6n5mjJ5hCXcRc/Pfdr/RHrfF/ToO5n9aF
         n02STE6adhzoTfwzp5082/WFLC3fP104pZIocg8mo79mjMcu1iGGh6hWr0byP/SuamWi
         7jvw==
X-Gm-Message-State: AA+aEWYjdrcoDpLl3/3tezkpvj2uvhgPcPBTEitHDcKwkfI8evbjAFUr
        9C4ruQwwL4z7HBjorK/EmNU=
X-Google-Smtp-Source: AFSGD/UIhtvqjU6BNrGF0/rqLaJcmiDSDN4ffyuRVXpnM7XbhS2pcD1MTsCxuFekt7tWfH9jmI+vxQ==
X-Received: by 2002:a19:cfc6:: with SMTP id f189mr9694002lfg.102.1543839666538;
        Mon, 03 Dec 2018 04:21:06 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y81-v6sm2482409lje.30.2018.12.03.04.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:21:05 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:20:53 +0200
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
Subject: [PATCH v5 5/9] clk: clk-hi655x: Free of_provider at remove
Message-ID: <cd8810afccfcc953d6cad308f820830d1afd2f36.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
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
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..394d0109104d 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_parent_hw_provider(&pdev->dev,
+				of_clk_hw_simple_get, &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
