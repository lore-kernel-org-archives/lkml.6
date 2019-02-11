Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E619C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC132075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895139;
	bh=UHNVThx+s35yaFFF7BSEOko+hXdqgdqlitKWTLJ5Gvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=R4MC2nN1NxHVzWuueHQi0dynpQsbTYR0N/MwmyAgJSlT1CAwgjUij7WsYzY9UaKTR
	 4kLhucN+5ClTSTm0FER/MxhCmyxcunwB+Ck5+jg/zr4X2iPRp6reOPNRhTQTwV83cu
	 OKpW7GAFIsUpv0nEslGtYzxuNyRdMQQ2yG0K8w3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbfBKOZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbfBKOZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:25:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF8E720838;
        Mon, 11 Feb 2019 14:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895133;
        bh=UHNVThx+s35yaFFF7BSEOko+hXdqgdqlitKWTLJ5Gvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rNkt+rJ7Jzz4+DekJMKosPQHo4tRgfP1c1ZVbt6i+/hRA3GW5dndMP/RMZdHdW5Vq
         sag+7ydI134Nzmx7ViIrSYxXo+flP1IxS0Zk63TwXKFGXbWB+D/DkY6+G8hgQjEi8C
         iopZvBoJihI4Avhqaxw1VuPZlw6nqwXKXT58JaFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Radu Pirea <radu.pirea@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 103/352] spi: fix spi-at91-usart.c build errors when PINCTRL is not set
Date:   Mon, 11 Feb 2019 15:15:30 +0100
Message-Id: <20190211141852.347398732@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c2b142cc3939e932d4fa2210c2a5155df5736590 ]

Fix build errors when CONFIG_PINCTRL is not enabled.
The header file <linux/pinctrl/consumer.h> handles both CONFIG_PINCTRL
enabled and disabled cases.

  CC [M]  drivers/spi/spi-at91-usart.o
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_suspend':
../drivers/spi/spi-at91-usart.c:409:2: error: implicit declaration of function 'pinctrl_pm_select_sleep_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_sleep_state(dev);
../drivers/spi/spi-at91-usart.c: In function 'at91_usart_spi_runtime_resume':
../drivers/spi/spi-at91-usart.c:419:2: error: implicit declaration of function 'pinctrl_pm_select_default_state' [-Werror=implicit-function-declaration]
  pinctrl_pm_select_default_state(dev);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Radu Pirea <radu.pirea@microchip.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-at91-usart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-at91-usart.c b/drivers/spi/spi-at91-usart.c
index a924657642fa..08bcbd1f9aa2 100644
--- a/drivers/spi/spi-at91-usart.c
+++ b/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
 #include <linux/spi/spi.h>
-- 
2.19.1



