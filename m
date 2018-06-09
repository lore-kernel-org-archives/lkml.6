Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gy3GFp/GG1vILgAAmS7hNA
	; Sat, 09 Jun 2018 12:22:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A0E5607BB; Sat,  9 Jun 2018 12:22:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D71D2600D0;
	Sat,  9 Jun 2018 12:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D71D2600D0
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeFIMWx (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 08:22:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38649 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753176AbeFIMWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 08:22:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so8294294wmf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 05:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8xsHvDyuu/3njWj5sUVONzEGDJDFAYdlf0VZaXeHr+U=;
        b=UIZHVKdNrrYBKB0lyt3CoCAUzqEnIWSn537ARg1T2Ipuwe41Mt+0zPoRcW+QDdXpWz
         wyleaFu5tKUG6S4liDi0nHHTrUrN3iLB+zMJH9ak+L4V05luS7P+hI+6trJswaqDcA4v
         F3p/ZYKvd59mcjLMomRTE3dr10e9VnsHDjTdRf78Htir1vwtD5/IK2n8CgcDPc71mEiK
         WQYs6tfN1ak4YcNLpINr4SG8Qj7oRZI2Zh8M3GpPxzIapQMZs1HHvjEAcYXBWmr7aA2K
         sQFyCeEseTAKuIwgim/mqJAQwIq8RkdUcim2rsOcHRnGO84wyksTwQS5VtUgwMIpydO4
         /yVw==
X-Gm-Message-State: APt69E3/aJuzoqJ6qILvzShx6u7pE4FFdH8378CZKKW0om2yEe3NaI4g
        MJmDgK/rLwETI8ph1qb7wGhs9vqDO60=
X-Google-Smtp-Source: ADUXVKLU9PElsCCN8A1in8F5tYf7iV9Pkhz+A+DoraxAvEXQWjAzAfVYEC7ABWUPvvWQXyxhI/GNwQ==
X-Received: by 2002:a1c:6803:: with SMTP id d3-v6mr4187683wmc.70.1528546970459;
        Sat, 09 Jun 2018 05:22:50 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id w15-v6sm38653373wro.52.2018.06.09.05.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 05:22:49 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: [PATCH v2] media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data
Date: Sat,  9 Jun 2018 14:22:45 +0200
Message-Id: <20180609122245.29636-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct clk_init_data init variable is declared in the isp_xclk_init()
function so is an automatic variable allocated in the stack. But it's not
explicitly zero-initialized, so some init fields are left uninitialized.

This causes the data structure to have undefined values that may confuse
the common clock framework when the clock is registered.

For example, the uninitialized .flags field could have the CLK_IS_CRITICAL
bit set, causing the framework to wrongly prepare the clk on registration.
This leads to the isp_xclk_prepare() callback being called, which in turn
calls to the omap3isp_get() function that increments the isp dev refcount.

Since this omap3isp_get() call is unexpected, this leads to an unbalanced
omap3isp_get() call that prevents the requested IRQ to be later enabled,
due the refcount not being 0 when the correct omap3isp_get() call happens.

Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

Changes in v2:
- Correct some typos in the commit message.

 drivers/media/platform/omap3isp/isp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/omap3isp/isp.c b/drivers/media/platform/omap3isp/isp.c
index f22cf351e3e..ae0ef8b241a 100644
--- a/drivers/media/platform/omap3isp/isp.c
+++ b/drivers/media/platform/omap3isp/isp.c
@@ -300,7 +300,7 @@ static struct clk *isp_xclk_src_get(struct of_phandle_args *clkspec, void *data)
 static int isp_xclk_init(struct isp_device *isp)
 {
 	struct device_node *np = isp->dev->of_node;
-	struct clk_init_data init;
+	struct clk_init_data init = { 0 };
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(isp->xclks); ++i)
-- 
2.17.1
