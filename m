Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD14C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbeLDLjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:39:24 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45924 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:39:23 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so11667792lfa.12;
        Tue, 04 Dec 2018 03:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNeaSJewQo7AXSXmTlRQsr8ytveIkz3c28c/Of06XVA=;
        b=B1qmM2cSoLmCk1A5YAQ5F4Vm9YkKxz3we2bnsOoSva0HDTXbv7I0T3vwx7/p+YW5ro
         jS2gzchDgvf6haotS8n87BL/varFs0/coa/ihEJIMpRExTbnWvDnfl0vQLsowxx0KZ/h
         uAeUyMQgCdOmWZyDblAAqQVq0dpGLuvjztsIFcDq8tqCN9M0bxxDribrYpWAMsii23k5
         BkxgXn7tT+oFHMgZM5gCt+FdINTi47YZkyfWUF/lKb9kWzNdgT69/1qADquwqLKCSpqU
         s6jVFVfuSQhfqAawq9z7rWIUccwKZetqzD7GPoA+qGlE/l5aVphpQV28c7090Y+Ow/66
         YnhQ==
X-Gm-Message-State: AA+aEWaQkuAOoqSAyHGGZVitUM0XdVjdhJQxQ2CVW2azbNpi50/nz+Jb
        kKyM/dbubfro0ybXDg+rw4M=
X-Google-Smtp-Source: AFSGD/WGPbXiwSzE4jKPtOlbYWM67fnnrX8eiQEaP9mRC9t2UdhES4t4nq388kSaR7O2DigQrVo5hg==
X-Received: by 2002:a19:22c2:: with SMTP id i185mr8365647lfi.2.1543923559787;
        Tue, 04 Dec 2018 03:39:19 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id d15-v6sm3078114lja.38.2018.12.04.03.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:39:19 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:39:06 +0200
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
Subject: [PATCH v6 09/10] clk: apcs-msm8916: simplify probe cleanup by using
 devm
Message-ID: <1c73fcc1dcb63aa0e5c65492692658a9e74f3c2d.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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

use devm variant for of_provider registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/qcom/apcs-msm8916.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/apcs-msm8916.c b/drivers/clk/qcom/apcs-msm8916.c
index b1cc8dbcd327..caa9b0d53d68 100644
--- a/drivers/clk/qcom/apcs-msm8916.c
+++ b/drivers/clk/qcom/apcs-msm8916.c
@@ -96,8 +96,8 @@ static int qcom_apcs_msm8916_clk_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	ret = of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &a53cc->clkr.hw);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					  &a53cc->clkr.hw);
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
