Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B105C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0EB2087F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeLDLhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:37:13 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34985 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeLDLhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:37:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so11705603lfc.2;
        Tue, 04 Dec 2018 03:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IPaANYg+BKvew3Ns6tmkF9qat1yGp0JhQQkX999AOmA=;
        b=pBMnYmwxRiv4Vf19MH3ryEOWLpdRoLpNigecyhwemoRDPR61T3t8x7CHhm6iDLnHWb
         H9bit1uLyI52SlXk+ICEBVLbWUkNnZju3N9qCqENkxzfKDjA20oK4muLYdBJZOgHrK3r
         0TdS85z2m9Y6JxIPHMwtryM5K+ByLVFJcDh5u9CYP5uKeRObreO5T5fsi3b6loUdy7xY
         3jUag0SgvwXOffwzfHIVOqpGjxxxgjHUuQMYO8kCTMTwcM20UrJTyrZdldGK9nvrr4Sl
         HcGKmd1xIbOVu2W5R4F4C4YhHAYdCi8sM5pcPOtLFJ6PRLVpXtrhBI2AZzcqdCY/tgFt
         pn/w==
X-Gm-Message-State: AA+aEWYkU1I1Hye5W/Oj527gHhG2MLktcfrxG9el9GU2ZKyzZmzleW7V
        +dNuSFCa+v2KQ/x4OFfaqYA=
X-Google-Smtp-Source: AFSGD/Vp5vXzXS4X9QTXmNF5hhCzfpnIqUNuj24oPKEvSrTWjEa04sxBZOR8RlzvO3cj6YwgW26BQQ==
X-Received: by 2002:a19:db4a:: with SMTP id s71mr11966423lfg.36.1543923428923;
        Tue, 04 Dec 2018 03:37:08 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a20-v6sm3086214ljf.28.2018.12.04.03.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 03:37:08 -0800 (PST)
Date:   Tue, 4 Dec 2018 13:37:01 +0200
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
Subject: [PATCH v6 05/10] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <f5222457908099bdcbbbca2f3138c34abf7f019c.1543922403.git.matti.vaittinen@fi.rohmeurope.com>
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

Use devm based clkdev lookup registration to avoid leaking lookup
structures.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/x86/clk-st.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-st.c
index 3a0996f2d556..25d4b97aff9b 100644
--- a/drivers/clk/x86/clk-st.c
+++ b/drivers/clk/x86/clk-st.c
@@ -52,7 +52,8 @@ static int st_clk_probe(struct platform_device *pdev)
 		0, st_data->base + MISCCLKCNTL1, OSCCLKENB,
 		CLK_GATE_SET_TO_DISABLE, NULL);
 
-	clk_hw_register_clkdev(hws[ST_CLK_GATE], "oscout1", NULL);
+	devm_clk_hw_register_clkdev(&pdev->dev, hws[ST_CLK_GATE], "oscout1",
+				    NULL);
 
 	return 0;
 }
-- 
2.14.3
