Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC41C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F271921886
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ4pFb9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F271921886
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbeHMRyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbeHMRyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:54:49 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC3721829;
        Mon, 13 Aug 2018 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534173129;
        bh=mpAdIh5bskQnJl2meP9mQXucy5zzMEohH6gEC/pODUw=;
        h=From:To:Subject:Date:From;
        b=AQ4pFb9WRE/Y95Hn+d/t2NVqBa4pPC+Y1SHSvkwC8fKIMcHVv3/lk7Y2LIsgnVAQm
         R79ok7qwCmEYUHUaKy/nHqARFHUfTH58nPEM+7cfLpd5JQx9U9fSR3JhZHolV/MwSt
         ih9SSdB9ou6o0dqJiZ/aatnu2Un8NnODtcQ+35jY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip/s3c24xx: Remove unneeded comparison of unsigned long to 0
Date:   Mon, 13 Aug 2018 17:11:44 +0200
Message-Id: <20180813151144.12407-1-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

irq_data->hwirq is unsigned long.  This fixes GCC warning:

    drivers/irqchip/irq-s3c24xx.c: In function 's3c_irqext0_type':
    drivers/irqchip/irq-s3c24xx.c:253:19: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
      if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
                       ^~

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/irqchip/irq-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index f6fd57ebe6e6..c19766fe8a1a 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -250,7 +250,7 @@ static int s3c_irqext0_type(struct irq_data *data, unsigned int type)
 	void __iomem *gpcon_reg;
 	unsigned long gpcon_offset, extint_offset;
 
-	if ((data->hwirq >= 0) && (data->hwirq <= 3)) {
+	if (data->hwirq <= 3) {
 		gpcon_reg = S3C2410_GPFCON;
 		extint_reg = S3C24XX_EXTINT0;
 		gpcon_offset = (data->hwirq) * 2;
-- 
2.14.1

