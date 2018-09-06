Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D25C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D4F206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 11:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D4F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIFQdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 12:33:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47340 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbeIFQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 12:33:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fxsvf-0005wh-0E; Thu, 06 Sep 2018 11:58:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: ep93xx: fix incorrect array element size check
Date:   Thu,  6 Sep 2018 12:58:30 +0100
Message-Id: <20180906115830.19386-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the while loop checks for the end of the array using
the size of egp->gc rather that the number of elements in the array,
so fix this. Also, perform the array size check first as stylistically
it is always good to bounds check on an array first before referencing
the array (in this case, we're just computing the address of an
element in an array so this is a moot point).

Fixes: fd935fc421e7 ("gpio: ep93xx: Do not pingpong irq numbers")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpio/gpio-ep93xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-ep93xx.c b/drivers/gpio/gpio-ep93xx.c
index 68a416fc3141..dd22ea19c3ed 100644
--- a/drivers/gpio/gpio-ep93xx.c
+++ b/drivers/gpio/gpio-ep93xx.c
@@ -76,7 +76,7 @@ static int ep93xx_gpio_port(struct gpio_chip *gc)
 	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
 	int port = 0;
 
-	while (gc != &epg->gc[port] && port < sizeof(epg->gc))
+	while (port < ARRAY_SIZE(epg->gc) && gc != &epg->gc[port])
 		port++;
 
 	/* This should not happen but is there as a last safeguard */
-- 
2.17.1

