Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA25C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD9120878
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:23:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD9120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeLCMYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:24:18 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34664 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbeLCMYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:24:18 -0500
Received: by mail-lj1-f196.google.com with SMTP id u6-v6so11172270ljd.1;
        Mon, 03 Dec 2018 04:23:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=abc15EH5GKVAESf+iqe1waxzU2AmezuL+i/+AhHeQPw=;
        b=qMLGGl7+PToHiKnetNjW9/+kXFOZgLyH25suyaNqnn0ybeB8TH8eCKWN0oya2UgQz3
         rLNRi/1oYeP4yCOCU7TYhoWHNnU1tcbUzHfbAzw7FpTHllIMtnV981rRVmPMREUYHOZo
         kFn2b4pN+1ie3eGodqSheps6xHqzt0CxeDPNJqpwvMayuOrZi73zGZigHNfSHJs1Xntk
         Brrq67B1CQFCupy6kPUXvhdmmCpOAq9HFkD1FgCPFI1XhxTAhJ4r9q4VNuN8Ho274tKE
         fl5DFw6rc7Vk1KJZrd5q74sb5fOv+KtLgTE8W2I2vjM5YPohiWPFV5MG4iOguUTa+xpw
         YKQw==
X-Gm-Message-State: AA+aEWbODZ+hPjaXbhtM9eo/2EOYboo13Mksfv4lCe7Y+BkPXwsYpARd
        lBHEIqTHQfT5KE8+2Yx9tgs=
X-Google-Smtp-Source: AFSGD/X2P+ECjuWcgLVnhgHsXAS1vsbc//5eO3P+7JAab0Xc3ar+iGOvGZMXA/rBp7IYIV8eZcsaQw==
X-Received: by 2002:a2e:6594:: with SMTP id e20-v6mr10729993ljf.123.1543839806395;
        Mon, 03 Dec 2018 04:23:26 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q4-v6sm2423194ljb.4.2018.12.03.04.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 04:23:25 -0800 (PST)
Date:   Mon, 3 Dec 2018 14:23:12 +0200
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
Subject: [PATCH v5 8/9] clk: apcs-msm8916: simplify probe cleanup by using
 devm
Message-ID: <f4813c9596694c764cf61ff7a1ddf747707a20e4.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
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

use devm variant for of_provider registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/qcom/apcs-msm8916.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index b1cc8dbcd327..f4e0c136ab1a 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -96,8 +96,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &a53cc->clkr.hw);
+	ret = devm_of_clk_add_parent_hw_provider(dev, of_clk_hw_simple_get,
+						 &a53cc->clkr.hw);
 	if (ret) {
 		dev_err(dev, "failed to add clock provider: %d\n", ret);
 		goto err;
@@ -118,7 +118,6 @@ static int qcom_apcs_msm8916_clk_remove(struct platform_device *pdev)
 	struct device *parent = pdev->dev.parent;
 
 	clk_notifier_unregister(a53cc->pclk, &a53cc->clk_nb);
-	of_clk_del_provider(parent->of_node);
 
 	return 0;
 }
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
