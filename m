Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07489C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8DF2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f4re+ohg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE8DF2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbeJHXoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:44:54 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44830 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbeJHXox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:44:53 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so8464161pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TzKRxyCHqF26dJMlvbN+uiJtZzu1cpTCP8N1Afaqyeg=;
        b=f4re+ohgd8+bHH1zc1NzxEnZ/VIL946udSZFI13xHwdmXfEktAkaxM7XRDukmD6au1
         xV1akM4i8SOVIgCLSFEIL+Q+nmmawUgQ2O8vAwz1zou7LniaemaBtqa39YaLnjRpf2ao
         T6D37JjWV40tz+UNbflvqzM/Y6TrRVmvWKUnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TzKRxyCHqF26dJMlvbN+uiJtZzu1cpTCP8N1Afaqyeg=;
        b=qFaedKaHoiZ/iVXQyIORYePXu48OwDJPguo7msK1QOk7D8r81R9n8h/3Ghavqs8qNx
         HL8X79VCqecGR/jTEYP9oVF2zV89yb50b7rt/FSWSWAktyp3GrGyuE5/NSRT1mySLYoW
         yO70iCxWAXbSCchfNbItPbbSnQIAf1MB2A5Ox+X3nwY+TBunYAYYfmNAurqWjHMuccTL
         EyETMo+M0jRcAY/5Ji/dLP+ljx3UieR6FIZYHXpMN5CXmcS4vX+e9a6IzKtTQsiICYhK
         ge6kp4BLn+el8164+c7LXq5rCBfAog9LJoYa+jWvSUvNqoVOJM6f5lk5wANmLpTcyX0q
         Q89w==
X-Gm-Message-State: ABuFfoiRuvaUHTC46dUgamezIAhbEoYy0GT3VQgg43KFaPeuRPXNu3FU
        DG9UAcWsXBvE0XJiFv9u98v+zw==
X-Google-Smtp-Source: ACcGV60JFCcBPzGRXo7vWlzrn7YlQ9Zo5EfwMG7KMCyFILUpD4xbhvGU21xGRez+6mGuriO3iiGBGw==
X-Received: by 2002:a62:62c3:: with SMTP id w186-v6mr14937144pfb.5.1539016341266;
        Mon, 08 Oct 2018 09:32:21 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 3-v6sm29832077pga.12.2018.10.08.09.32.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:32:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 4/4] gpio: Clarify kerneldoc on gpiochip_set_chained_irqchip()
Date:   Mon,  8 Oct 2018 09:32:16 -0700
Message-Id: <20181008163216.97436-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181008163216.97436-1-swboyd@chromium.org>
References: <20181008163216.97436-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This doesn't support nested anymore, so drivers shouldn't call it with
the handler set to NULL.

Cc: Evan Green <evgreen@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 37c6fc73b179..1729d0f698e7 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1693,8 +1693,7 @@ static void gpiochip_set_cascaded_irqchip(struct gpio_chip *gpiochip,
  * @parent_irq: the irq number corresponding to the parent IRQ for this
  * chained irqchip
  * @parent_handler: the parent interrupt handler for the accumulated IRQ
- * coming out of the gpiochip. If the interrupt is nested rather than
- * cascaded, pass NULL in this handler argument
+ * coming out of the gpiochip.
  */
 void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
 				  struct irq_chip *irqchip,
-- 
Sent by a computer through tubes

