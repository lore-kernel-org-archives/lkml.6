Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5583CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BB42064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7S+YB7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BB42064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbeJIB70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:47686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728570AbeJIB70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:59:26 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82B02064A;
        Mon,  8 Oct 2018 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024380;
        bh=98QuUgFbB2jMqVe5Sl2qoOYGtZXPgQOWeaRvZnGWw14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7S+YB7u1JOwjZd2QFSSHD0ihSV+sfVPU07TA9SXVUBz4y9vbitJYszRWeBa79SSH
         GPsTDNn39gR17q3jgVG0GAYW1MNjXtIq0sxvpaFqfhcT4UdprYBPeu3zS03gCD1eV3
         vj2lZn04LciXlFxQM+E9Vj91vqm4wawLgxbGIbAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 022/168] gpio: adp5588: Fix sleep-in-atomic-context bug
Date:   Mon,  8 Oct 2018 20:30:02 +0200
Message-Id: <20181008175620.888716198@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Hennerich <michael.hennerich@analog.com>

[ Upstream commit 6537886cdc9a637711fd6da980dbb87c2c87c9aa ]

This fixes:
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_write()
[BUG] gpio: gpio-adp5588: A possible sleep-in-atomic-context bug
                          in adp5588_gpio_direction_input()

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-adp5588.c |   24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

--- a/drivers/gpio/gpio-adp5588.c
+++ b/drivers/gpio/gpio-adp5588.c
@@ -41,6 +41,8 @@ struct adp5588_gpio {
 	uint8_t int_en[3];
 	uint8_t irq_mask[3];
 	uint8_t irq_stat[3];
+	uint8_t int_input_en[3];
+	uint8_t int_lvl_cached[3];
 };
 
 static int adp5588_gpio_read(struct i2c_client *client, u8 reg)
@@ -173,12 +175,28 @@ static void adp5588_irq_bus_sync_unlock(
 	struct adp5588_gpio *dev = irq_data_get_irq_chip_data(d);
 	int i;
 
-	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++)
+	for (i = 0; i <= ADP5588_BANK(ADP5588_MAXGPIO); i++) {
+		if (dev->int_input_en[i]) {
+			mutex_lock(&dev->lock);
+			dev->dir[i] &= ~dev->int_input_en[i];
+			dev->int_input_en[i] = 0;
+			adp5588_gpio_write(dev->client, GPIO_DIR1 + i,
+					   dev->dir[i]);
+			mutex_unlock(&dev->lock);
+		}
+
+		if (dev->int_lvl_cached[i] != dev->int_lvl[i]) {
+			dev->int_lvl_cached[i] = dev->int_lvl[i];
+			adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + i,
+					   dev->int_lvl[i]);
+		}
+
 		if (dev->int_en[i] ^ dev->irq_mask[i]) {
 			dev->int_en[i] = dev->irq_mask[i];
 			adp5588_gpio_write(dev->client, GPIO_INT_EN1 + i,
 					   dev->int_en[i]);
 		}
+	}
 
 	mutex_unlock(&dev->irq_lock);
 }
@@ -221,9 +239,7 @@ static int adp5588_irq_set_type(struct i
 	else
 		return -EINVAL;
 
-	adp5588_gpio_direction_input(&dev->gpio_chip, gpio);
-	adp5588_gpio_write(dev->client, GPIO_INT_LVL1 + bank,
-			   dev->int_lvl[bank]);
+	dev->int_input_en[bank] |= bit;
 
 	return 0;
 }


