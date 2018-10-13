Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9DC28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 03:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D8620895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 03:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hDYFUS3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60D8620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbeJMLWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 07:22:07 -0400
Received: from merlin.infradead.org ([205.233.59.134]:41612 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeJMLWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 07:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OwmD7Dhl+q9Q7V04nrI8OorHeVyfKXYfVBm1tzpk2U8=; b=hDYFUS3Nhd4sqx/6t+cO4kCoJ3
        INQcJANli8c9jXiZlP+nsj15hudQ61RhXVgDqP0p7zgKLDcbDZtb9EraUUgAv6q8itldj7cKtXxwh
        onL+sJqXWc59z/un7k/uGPq3UjKpG4NegONu0maMVZX6qrzl+G+ZYPRs6f4bK6Y0txjvH4sU8gHOl
        i7gIphVQI6U0Tz9pUrh6N6VH/RsbVgxHQWyEGWwtlbC48ywQzU7x1NXQs6XVP3dza4Fc0SOWh3p7M
        fe1kI12GyMkdBVceFBSHt0t/1gtmUIR68nsC32ioQxzbubn4rET3U4LKnRJr3HLQOtG0ciDpj4Laf
        4EqP1L/Q==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gBAsr-0004Y8-8N; Sat, 13 Oct 2018 03:46:33 +0000
To:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] gpio: fix SNPS_CREG kconfig dependency warning
Message-ID: <8bfd2cd6-702a-878c-ac41-b61698835f1a@infradead.org>
Date:   Fri, 12 Oct 2018 20:46:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kconfig warning for GPIO_SNPS_CREG:

WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=n] && HAS_IOMEM [=y]
  Selected by [y]:
  - GPIO_SNPS_CREG [=y] && GPIOLIB [=y] && HAS_IOMEM [=y] && (ARC || COMPILE_TEST [=y])

Drivers in drivers/gpio/Kconfig depend on OF_GPIO, not select it.
This prevents attempting to build when OF is not enabled.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Found in mmotm but comes from/applies to linux-next.

 drivers/gpio/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20181012.orig/drivers/gpio/Kconfig
+++ linux-next-20181012/drivers/gpio/Kconfig
@@ -439,7 +439,7 @@ config GPIO_SIOX
 config GPIO_SNPS_CREG
 	bool "Synopsys GPIO via CREG (Control REGisters) driver"
 	depends on ARC || COMPILE_TEST
-	select OF_GPIO
+	depends on OF_GPIO
 	help
 	  This driver supports GPIOs via CREG on various Synopsys SoCs.
 	  This is a single-register MMIO GPIO driver for complex cases


