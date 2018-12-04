Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B81FC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B6C2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14B6C2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLDLhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:37:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41519 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDLhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:37:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so11680106lfj.8;
        Tue, 04 Dec 2018 03:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIzu5TM0Q0ij7JdKvBe/DIJ+uIu2SF/SLoojaqBlAkU=;
        b=RyqV9Z03vqlN4CknqIenGR8taN64AhmVmIJ92jl8mvuM01DyfADekBG3OwxwnFpzK1
         m+lf/wJv+Ftu9GYK8JC8REzZwA8WIkwjJ9UYes0n5hMq0o5lBiWTr2K/Xk499xXJXuTB
         ixqFTtH7wX3FuQ71g+2JyiQ1+EINUwarYZ1dRb+Ai17hBGcpqvers5N4N4eIw37bR7xK
         C2QWzzQNIo3Z9PPFKS1d2t+PxoddJVrSWjvfjAJWI9FZeWiq4QJyql3koNGGUNK298C4
         eYb+0q3FbCrwqF1qMM5PMUaTpGPbDS2samqMJKF6KasySFxZJPf6tpbbzvXSoZ2yVawC
         d7ig==
X-Gm-Message-State: AA+aEWYpGhSWVDGSUkiKJf1UW9UD1WSeatKQk4y9gG/gvGsoxd6yCi0c
        ged8ubKIG5GdntdxRKaW46w=
X-Google-Smtp-Source: AFSGD/VViV3CLRN5jn1QfIg3yeByA6Pca3qlmf7TgBZw3CGSaVwAwPUi2LOC5/ENoK1+9KOlr9U1dA==
X-Received: by 2002:a19:5402:: with SMTP id i2mr11152848lfb.128.1543923462510;
        Tue, 04 Dec 2018 03:37:42 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id e94sm2935609lfi.23.2018.12.04.03.37.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:37:41 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:37:29 +0200
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
Subject: [PATCH v6 06/10] clk: clk-hi655x: Free of_provider at remove
Message-ID: <90cd96112ca1ade6bff3b58989e290ae3def59e2.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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
---
 drivers/clk/clk-hi655x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-hi655x.c b/drivers/clk/clk-hi655x.c
index 403a0188634a..a0de3315df2e 100644
--- a/drivers/clk/clk-hi655x.c
+++ b/drivers/clk/clk-hi655x.c
@@ -107,8 +107,8 @@ static int hi655x_clk_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return of_clk_add_hw_provider(parent->of_node, of_clk_hw_simple_get,
-				     &hi655x_clk->clk_hw);
+	return devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get,
+					   &hi655x_clk->clk_hw);
 }
 
 static struct platform_driver hi655x_clk_driver = {
-- 
2.14.3
