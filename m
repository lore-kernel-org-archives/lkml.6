Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335C9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF4A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 22:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NxYZWVWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFF4A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeK3JlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 04:41:24 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54860 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbeK3JlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 04:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b1gb1QV0UYxHTrACqeesl9+RONeBvl8ZpMoVSxtkSrg=; b=NxYZWVWgeAlSZYt4KxC3DsZzTO
        skBSH/n0pKSQYQ35EYNWAXmk4+7pYiJY60rrIy3i3+jpEIBOOHvKY38D6KdQ4MmuItCq+j59aGAL2
        2LriIeXHLwsLsJbV/uwGvobhhO6I63uBpUe/esRDH5h6YDgsfXKHtBURzPU36k6SLVr2lH5BdyE1o
        LIYAyNPHBnKIHYHl+089q15Ob77rxEB6Iu3TgGUZO/BgCO585g7tbVgYRKnXeXGEjaOz4zFec5pkz
        Xw+opG7UUhlAgWRIYjTKO3ZNYBnO9UA7RUXpVi58/5QBoFCSkdRehCjI9wlmr+aK41ztoKQHqETUI
        Txt59YYg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gSUsy-00069n-Ff; Thu, 29 Nov 2018 22:34:16 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Radu Pirea <radu.pirea@microchip.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PTCH -next] spi: fix spi-at91-usart.c build errors when PINCTRL is
 not set
Message-ID: <744804c8-49c4-d0b6-d58c-2d573765f28b@infradead.org>
Date:   Thu, 29 Nov 2018 14:34:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

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
---
 drivers/spi/spi-at91-usart.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181129.orig/drivers/spi/spi-at91-usart.c
+++ linux-next-20181129/drivers/spi/spi-at91-usart.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of_gpio.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 


