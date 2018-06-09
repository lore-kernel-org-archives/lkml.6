Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id nxWINxuSG1uqEAAAmS7hNA
	; Sat, 09 Jun 2018 08:39:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 145086089E; Sat,  9 Jun 2018 08:39:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9FEB8605A5;
	Sat,  9 Jun 2018 08:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FEB8605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeFIIjU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 04:39:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39810 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753037AbeFIIjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 04:39:18 -0400
Received: by mail-wm0-f66.google.com with SMTP id p11-v6so7639918wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jun 2018 01:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kEUGDhitEY6xsJm89tkety9CIbLqt8CSTdsGqx2l9tw=;
        b=OTnhv5kSZsCTd8J194BLcEWlHx6N6JnYpHh4e8nuYVgQ0VtFzAs/Tzs7y7ukwX2Ook
         xwgHUThGBfLj30cPcRsoimvh3AX7hPlfGzkrhXrWHWgWjShHvB//9hh6kWI3z8I/1Wq+
         dOrBibgbhATRwl/C4b7GP81wrAuNTE83cAyABsZfTZKw5GAlby/yClIi2Euo8s5uku2f
         pqjgFivpryYk3OLfH64RMnzd8b1/nYuRDf6UE5TzfF9abzv6O89BON6nrEvU056RhUuV
         sV5ovqI26IA/34o4ZE6m0LwgRq/wCaczxYueIJyE56mtkt8HLPc7mOoPGuWFP+3z36Xj
         ZAqw==
X-Gm-Message-State: APt69E1bNiGA8+DNqeGiX6XBv94rZqnuSQzBtN5nFceLww8FBMHO0yUq
        35drNZzJqR7bpN3+ohQiHmIi9o995no=
X-Google-Smtp-Source: ADUXVKIomte1BrR+M1Ox0nmDGukWmx6ha57mYZo8YxKiN02HtbKwdpW5asetVVk1xlsfGC1bVSd90w==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr2007193wmc.5.1528533557061;
        Sat, 09 Jun 2018 01:39:17 -0700 (PDT)
Received: from minerva.home ([90.77.100.34])
        by smtp.gmail.com with ESMTPSA id k36-v6sm48863460wrc.20.2018.06.09.01.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Jun 2018 01:39:16 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: omap3isp: zero-initialize the isp cam_xclk{a,b} initial data
Date: Sat,  9 Jun 2018 10:39:12 +0200
Message-Id: <20180609083912.27807-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct clk_init_data defined in isp_xclk_init() is a variable in the
stack but it's not explicitly zero-initialized. Because of that, in some
cases the data structure contains values that confuses the clk framework.

For example if the flags member has the CLK_IS_CRITICAL bit set, the clk
framework will wrongly prepare the clock on registration. This leads to
the isp_xclk_prepare() callback to be called which in turn calls to the
omap3isp_get() function that increments the isp device reference counter.

Since this omap3isp_get() call is unexpected, this leads to an unbalanced
omap3isp_get() call that prevents the requested IRQ to be later enabled,
due the refcount not being 0 when the correct omap3isp_get() call happens.

Fixes: 9b28ee3c9122 ("[media] omap3isp: Use the common clock framework")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

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
