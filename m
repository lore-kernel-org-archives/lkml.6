Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F99C677E4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1FD02089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dvuJtZUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FD02089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeJHXoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:44:54 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39874 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeJHXow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:44:52 -0400
Received: by mail-pg1-f196.google.com with SMTP id r9-v6so8059304pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 09:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tY8fPC4eXBooeYgVdvops20KNuH1M9jYeuVvcX41Iac=;
        b=dvuJtZUp1ex/foNXzuJcf10hA+1KOk502yIcSVUEuRklbJEjFFcYXLma0kf0lR7SF3
         yGGCEtUmw283vmV/x7NTUXXeZ3jGNhE16tAx6qjkH6zK/7x+4AmaVt14qHWsKur+ctpK
         tF9wNqqNS0zTUhXVnhw4Zf4boHHU+z8IlX91Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tY8fPC4eXBooeYgVdvops20KNuH1M9jYeuVvcX41Iac=;
        b=D3TkhNxu7P6JmhVMydRi83topGbU35zK4rg+CBRgOfILY0ee3RtdZqG8CqjX6/qR2q
         XDvB6zNlfeVtzQEQAGVOSCG5mkCMQlZLqAF4CxiYpTF2fhhU2wucj/QTOuCZyQccIfO5
         z4G9JimzwPat6WLq2wTzMg0qMq/pndQ2Jv/afbjoKvBFca904mJBOoxSXkeRBTFXbkyW
         2l2XVNtty7Mhqn5sGyO6IuJgI/OnnNEnU8AsDco2Wl1Q6GpryCiieVt/odfWbu0EOHGN
         PJe8nCDNdlG0vRX8FdBPuYfKQik4t2WlNNcdiNLRP7RhhmRkoq0GAewJkp8M+865BkaJ
         6V3g==
X-Gm-Message-State: ABuFfojjoR0YpWWDSvlX2+mqbtBE4yrjkVJjRjSldcfsaH9kf0Qq2p1s
        HTJ73rixTJ81VgIDR7wBxIKx+90X4E4=
X-Google-Smtp-Source: ACcGV60Ga0p7FllAN+U+wzL0C0Uaf6rL13TFSJPkE+mmxBMFUpcsUDkwBmf0hld4ScGlQ0H0dxnSaw==
X-Received: by 2002:a62:7604:: with SMTP id r4-v6mr26150290pfc.230.1539016340463;
        Mon, 08 Oct 2018 09:32:20 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fed3:9637:a13a:6c15])
        by smtp.gmail.com with ESMTPSA id 3-v6sm29832077pga.12.2018.10.08.09.32.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 09:32:20 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH 3/4] gpio: Remove unused 'irqchip' argument to gpiochip_set_cascaded_irqchip()
Date:   Mon,  8 Oct 2018 09:32:15 -0700
Message-Id: <20181008163216.97436-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181008163216.97436-1-swboyd@chromium.org>
References: <20181008163216.97436-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This argument hasn't ever been used since it was introduced in commit
1425052097b5 ("gpio: add IRQ chip helpers in gpiolib"). Let's drop it to
reduce reading confusion.

Cc: Evan Green <evgreen@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpio/gpiolib.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 8fccfcf559ee..37c6fc73b179 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1651,7 +1651,6 @@ EXPORT_SYMBOL_GPL(gpiochip_irqchip_irq_valid);
 /**
  * gpiochip_set_cascaded_irqchip() - connects a cascaded irqchip to a gpiochip
  * @gpiochip: the gpiochip to set the irqchip chain to
- * @irqchip: the irqchip to chain to the gpiochip
  * @parent_irq: the irq number corresponding to the parent IRQ for this
  * chained irqchip
  * @parent_handler: the parent interrupt handler for the accumulated IRQ
@@ -1659,7 +1658,6 @@ EXPORT_SYMBOL_GPL(gpiochip_irqchip_irq_valid);
  * cascaded, pass NULL in this handler argument
  */
 static void gpiochip_set_cascaded_irqchip(struct gpio_chip *gpiochip,
-					  struct irq_chip *irqchip,
 					  unsigned int parent_irq,
 					  irq_flow_handler_t parent_handler)
 {
@@ -1708,8 +1706,7 @@ void gpiochip_set_chained_irqchip(struct gpio_chip *gpiochip,
 		return;
 	}
 
-	gpiochip_set_cascaded_irqchip(gpiochip, irqchip, parent_irq,
-				      parent_handler);
+	gpiochip_set_cascaded_irqchip(gpiochip, parent_irq, parent_handler);
 }
 EXPORT_SYMBOL_GPL(gpiochip_set_chained_irqchip);
 
@@ -1724,8 +1721,7 @@ void gpiochip_set_nested_irqchip(struct gpio_chip *gpiochip,
 				 struct irq_chip *irqchip,
 				 unsigned int parent_irq)
 {
-	gpiochip_set_cascaded_irqchip(gpiochip, irqchip, parent_irq,
-				      NULL);
+	gpiochip_set_cascaded_irqchip(gpiochip, parent_irq, NULL);
 }
 EXPORT_SYMBOL_GPL(gpiochip_set_nested_irqchip);
 
-- 
Sent by a computer through tubes

