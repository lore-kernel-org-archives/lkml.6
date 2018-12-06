Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA14C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129FD20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544089560;
	bh=7B1FR073yK47T8KiTaCBKYDsfWZzAka7q2QdGvqKf94=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BA4/0AeJ7263d63ZEyu7nsnyY1T1jCDK8COTRSupnLpn6BZskT6nBWexHP8iBoEbB
	 Dox9SZ84mpw2ueN44RsxN14q6W1j6Y7ALhhe8mTXBbKdWUcspKuh8PZfCTQEMXYNuU
	 7KCQ41WOC+ZmJCN/HdrcMNknV8Uv5qmnWmMLNwnU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129FD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeLFJp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:45:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:54430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729393AbeLFJpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:45:55 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3BDB20645;
        Thu,  6 Dec 2018 09:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544089555;
        bh=7B1FR073yK47T8KiTaCBKYDsfWZzAka7q2QdGvqKf94=;
        h=From:To:Cc:Subject:Date:From;
        b=WIzFsMzRClonByl3I3fkIpgp9RIFVAJFSLYFSnnwAcJyGzGhBZuGWqG93Rg3jMZI1
         +TumH6G5Zl9iaaguElKJN5UN/LXVyZAGd1C9Ns5JdkgP9162iyObTSpbYXJw4sDne5
         eh1vRUWNwZbYWJdJdNtPUMQki9tbkfHbJMMuH15A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] gpiolib: Fix return value of gpio_to_desc() stub if !GPIOLIB
Date:   Thu,  6 Dec 2018 10:45:49 +0100
Message-Id: <1544089549-23629-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_GPOILIB is not set, the stub of gpio_to_desc() should return
the same type of error as regular version: NULL.  All the callers
compare the return value of gpio_to_desc() against NULL, so returned
ERR_PTR would be treated as non-error case leading to dereferencing of
error value.

Fixes: 79a9becda894 ("gpiolib: export descriptor-based GPIO interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/gpio/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index ed070512b40e..3b01fbcafc94 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -505,7 +505,7 @@ static inline int gpiod_set_consumer_name(struct gpio_desc *desc,
 
 static inline struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
-	return ERR_PTR(-EINVAL);
+	return NULL;
 }
 
 static inline int desc_to_gpio(const struct gpio_desc *desc)
-- 
2.7.4

