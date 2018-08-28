Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18C6C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45D9208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45D9208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbeH1Fod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:33 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38045 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbeH1Fod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:33 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so22063oix.5;
        Mon, 27 Aug 2018 18:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jTa+u2rLU64NAA1Mli/IvknEIrrX9W/VQjvhlHArq/Y=;
        b=hfQX6sOtF1+T/7B9wfzZxV6VIxs7m5P5ewe80NS9FJvhJiaLI8g5KPI5GZ4+Q+i4KI
         KwOKkqxHo9bb9xCzDrhRxJZO/cVbWLOwa+du1lhgHzoyeymyUF3NDWSr0X2LQoNjGxlf
         zmSPFrPRvF/ob8YlXYPG3APsolECU8swgPwN7e6JJsK28yW18BFCt4Bia1jYROsEVYBb
         0rz4GGfu68y/9yRkoRdIT8zAByT6egaySIYuOqXrWYlJP9ZxvAfZRjRJrNUwLw5aBBmj
         vilKPFf8A9GMUvcOabLYiNsuZwRqWZrY0S+15HdcQ13+KAqafYdxJ7rUYOg1RIZv+uwJ
         WfrA==
X-Gm-Message-State: APzg51Cxng1kFKgfJQYXjeeIpz/kitqgyyWA2EzO0rUw7pGoPY1+VVfj
        8oReXtU4/hmpgEByqIje/dfGWcg=
X-Google-Smtp-Source: ANB0VdYPFSIzd4zwIp046usWhNz3sNef89OWt6XDAcStLlwT2a2cDnbwARAy8WksvdWEvLnpOKB9tg==
X-Received: by 2002:aca:3003:: with SMTP id w3-v6mr360462oiw.231.1535421316868;
        Mon, 27 Aug 2018 18:55:16 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:16 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: pm8941: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:49 -0500
Message-Id: <20180828015252.28511-48-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/video/backlight/pm8941-wled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pm8941-wled.c b/drivers/video/backlight/pm8941-wled.c
index 0b6d21955d91..da6aab20fdcb 100644
--- a/drivers/video/backlight/pm8941-wled.c
+++ b/drivers/video/backlight/pm8941-wled.c
@@ -330,7 +330,7 @@ static int pm8941_wled_configure(struct pm8941_wled *wled, struct device *dev)
 
 	rc = of_property_read_string(dev->of_node, "label", &wled->name);
 	if (rc)
-		wled->name = dev->of_node->name;
+		wled->name = devm_kasprintf(dev, GFP_KERNEL, "%pOFn", dev->of_node);
 
 	*cfg = pm8941_wled_config_defaults;
 	for (i = 0; i < ARRAY_SIZE(u32_opts); ++i) {
-- 
2.17.1

