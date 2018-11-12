Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5668CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140EF224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 17:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bzIKgABZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 140EF224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbeKMDAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:00:48 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:32780 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbeKMDAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:00:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2GarvUEGY7mWObqwIKlbaZUW71w3jxSRkUXbJYZr73k=; b=bzIKgABZ2Y0esPcrxXz/QFqNy
        BrBkWpnFQmxfQmsNCxJ1BkVlQLhuLFbNuBwjmqX6abfVb2vZhs09z8KISJypU+uXzJw3AIWY0tuKf
        0/uNYLF48+qpSdzH285lZiKTg9bGdfbHgpN0xBbMCsv6m9foul+a0Kk6OZtS3ssB690QQp+ir13tO
        YrLCLBNXdCW0c2WaR4tZb26Kd550AwmdM8gS4S80iXnkkfbWC3BqyXOvfkkqh6rBZyXyT25NflVkT
        24gFiDTtUUnbgjxfTitxeBe79inv5HbbTOFooRn45OkfcsE9RIPVZxS/2Vm2G9FZeCVWiJhGiTk9r
        5Gi+k0rMg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gMFfc-0003OI-Ij; Mon, 12 Nov 2018 17:06:40 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] power/supply: fix sc27xx_fuel_gauge build errors
Message-ID: <3736c0f9-9f2c-bc74-22c2-677c42a2a630@infradead.org>
Date:   Mon, 12 Nov 2018 09:06:32 -0800
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

Fix build errors when FUEL_GUAGE_SC27XX is enabled but IIO is either
not enabled or IIO=m and FUEL_GUAGE_SC27XX=y.

ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_get_temp':
sc27xx_fuel_gauge.c:(.text+0x1d2): undefined reference to `iio_read_channel_processed'
ld: drivers/power/supply/sc27xx_fuel_gauge.o: in function `sc27xx_fgu_probe':
sc27xx_fuel_gauge.c:(.text+0x97f): undefined reference to `devm_iio_channel_get'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/supply/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20181112.orig/drivers/power/supply/Kconfig
+++ linux-next-20181112/drivers/power/supply/Kconfig
@@ -655,6 +655,7 @@ config CHARGER_SC2731
 config FUEL_GAUGE_SC27XX
 	tristate "Spreadtrum SC27XX fuel gauge driver"
 	depends on MFD_SC27XX_PMIC || COMPILE_TEST
+	depends on IIO
 	help
 	 Say Y here to enable support for fuel gauge with SC27XX
 	 PMIC chips.


