Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B7EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCDC32089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ggpwLzTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDC32089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbeJHXow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:44:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37495 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbeJHXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:44:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so8067957pgq.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7ySiBOV6v4YVbOgXXN8Qe8bELIY9QXgwcfs0zDgPag=;
        b=ggpwLzTsf7tf8vXPmSIRSmdp1L7WtOA4hALlTi6klcSKIt1e+4cjf0fnJrmLrDsBeg
         hfOg24kDOijhXK/xD98CX0vnM5LH0RRJQpTIMzgL4FjhGpiSr1a/B62TfqQzG4VRrFGh
         DyyMNlNJre+hMvqfQJq6axvc9QgNdDmWRtjGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7ySiBOV6v4YVbOgXXN8Qe8bELIY9QXgwcfs0zDgPag=;
        b=fi/o4ZBigzzuX+zXt6As04WFJ5NNWw8IP3LJPkb9Z9maNVFFQ2fUnQq07vwH2XnjDY
         eFGMHtTWc3uPuK1kGn/j17QGud7YzqOGw0fAHxfBAtDdmvt0gk/5BqAtF59EfdO9u9F7
         PgXq8ok162nM+4EfALoIni4AxL2iuHKobg2uLsU287OvyoBERtuv0f0R2Wzws/lwp9K3
         h5teYcrfecy9x/XMF1wiA99/CtO3fKZsa9kth0oSr95rKFPeJpQIvJk6yCqAv/cN8C0k
         ysCpjzyKYOgFsUvYBectYcYcvLAhCnBNjXGwvteHkYjFyjhdgXdF2EXfEAzA8fNETQsp
         PxVw==
X-Gm-Message-State: ABuFfogxA0rHjSI6sVmbDjIjqniG6/clHD4x31CzM5AyaWqaHwHlZrwl
        p/ilmP8Cj34WV4fhgUsVQbAhKQ==
X-Google-Smtp-Source: ACcGV60wiZqY2GAAHuB8dVRXxVX21ZCdNKD4+f3L0+ECkVEDjM75VSrrNlXjDNbf5DbnaWLZH2ZYmg==
X-Received: by 2002:a62:1095:: with SMTP id 21-v6mr25511922pfq.227.1539016339748;
        Mon, 08 Oct 2018 09:32:19 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 3-v6sm29832077pga.12.2018.10.08.09.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:32:19 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 2/4] gpio: Drop parent irq assignment during cascade setup
Date:   Mon,  8 Oct 2018 09:32:14 -0700
Message-Id: <20181008163216.97436-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181008163216.97436-1-swboyd@chromium.org>
References: <20181008163216.97436-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to set the irq parent for interrupts that we're setting up to be
cascaded from another interrupt controller, but we may or may not have
already mapped the gpiochip irqs into the kernel's virtual irq number
space at this point. If we have mapped irqs before calling here, then
we've gone through gpiochip_irq_map() and called irq_set_parent()
already. If we haven't mapped irqs, then the gpiochip is dynamically
mapping irqs and we can rely on gpiochip_irq_map() or the gpio driver's
irqdomain ops to setup the irq parent properly.

Either way, setting the parent here when cascading the gpiochip doesn't
make much sense because it should be done at irq mapping time. In the
dynamic mapping case, this code is mapping virq 0 to some parent virq in
a loop. While that's benign, let's drop this code to simplify.

Cc: Evan Green <evgreen@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index d9d823e3761b..8fccfcf559ee 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1663,8 +1663,6 @@ static void gpiochip_set_cascaded_irqchip(struct gpio_chip *gpiochip,
 					  unsigned int parent_irq,
 					  irq_flow_handler_t parent_handler)
 {
-	unsigned int offset;
-
 	if (!gpiochip->irq.domain) {
 		chip_err(gpiochip, "called %s before setting up irqchip\n",
 			 __func__);
@@ -1688,14 +1686,6 @@ static void gpiochip_set_cascaded_irqchip(struct gpio_chip *gpiochip,
 		gpiochip->irq.parents = &gpiochip->irq.parent_irq;
 		gpiochip->irq.num_parents = 1;
 	}
-
-	/* Set the parent IRQ for all affected IRQs */
-	for (offset = 0; offset < gpiochip->ngpio; offset++) {
-		if (!gpiochip_irqchip_irq_valid(gpiochip, offset))
-			continue;
-		irq_set_parent(irq_find_mapping(gpiochip->irq.domain, offset),
-			       parent_irq);
-	}
 }
 
 /**
-- 
Sent by a computer through tubes

