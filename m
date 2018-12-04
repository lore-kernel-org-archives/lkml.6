Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0180C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DD320660
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DD320660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeLDLiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:38:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46402 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:38:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id v15-v6so14551622ljh.13;
        Tue, 04 Dec 2018 03:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s0eoIBAlLdqa/lK+b31yZx/TLpcNisuF7h28Wa3I9ec=;
        b=MKDSkbvW8KHe+xmTHPgG098Pwj741OzNCQw0m7Lax9z0W5m2H4aL8jFW7YMwaEOPkf
         urqjlh0FJfZS0ZcupqsLkt/97c6rGU0s2PJfTEsjQMVz60cY33GAhazbeB3hIDNN9zHW
         rzTG3r5UcRzhkcheDXg26vTfDL66jQHUdw+PRyhXMeTRQn8wwyci13VOfV5FeU7Qivcq
         3PrC7dkXBqF7OwwS2ehmUtA+pujzAdC/mgeoDTYcuhreJTFxqvi7UHpfg45TzBgkgYxn
         bpyqCq+CYOeqF5Z+6w5+RCmE6f1Kvu+mcPugl8z1ztyes7TeYofqIsbYhwywjj76PXlf
         vvqg==
X-Gm-Message-State: AA+aEWYnEY+oQ/MRMdjKhn5xR1wLordxhf4WQTY7PL+DZbAkaAyLuHXk
        eJ6G5QWt5eyqljSTx+Eh2mw=
X-Google-Smtp-Source: AFSGD/Uvsg6v6MNTQzmy8FcIl7zel0Oo0WeO1tgPHUa42MfR8TPjKSMum2kB50pJjhclNHQStDf3VA==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr13737293ljh.174.1543923495868;
        Tue, 04 Dec 2018 03:38:15 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q21-v6sm3068085ljc.5.2018.12.04.03.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:38:15 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:38:03 +0200
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
Subject: [PATCH v6 07/10] clk: rk808: use managed version of of_provider
 registration
Message-ID: <d515dafab5f22e24f3c6dd9606993e3e1255045a.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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

Simplify clean-up for rk808 by using managed version of of_provider
registration.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/clk-rk808.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/clk-rk808.c b/drivers/clk/clk-rk808.c
index 6461f2820a5b..8d90bdf5b946 100644
--- a/drivers/clk/clk-rk808.c
+++ b/drivers/clk/clk-rk808.c
@@ -138,23 +138,12 @@ static int rk808_clkout_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(node, of_clk_rk808_get, rk808_clkout);
-}
-
-static int rk808_clkout_remove(struct platform_device *pdev)
-{
-	struct rk808 *rk808 = dev_get_drvdata(pdev->dev.parent);
-	struct i2c_client *client = rk808->i2c;
-	struct device_node *node = client->dev.of_node;
-
-	of_clk_del_provider(node);
-
-	return 0;
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rk808_get,
+					   rk808_clkout);
 }
 
 static struct platform_driver rk808_clkout_driver = {
 	.probe = rk808_clkout_probe,
-	.remove = rk808_clkout_remove,
 	.driver		= {
 		.name	= "rk808-clkout",
 	},
-- 
2.14.3
