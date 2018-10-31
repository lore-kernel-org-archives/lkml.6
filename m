Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CB4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B985820664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 23:45:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgCLCszi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B985820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeKAIpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 04:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728646AbeKAIHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 04:07:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A7320821;
        Wed, 31 Oct 2018 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541027234;
        bh=jK+cIQ9JcQfW8qhNHAgE4ViSNpm5IcSgQ6TOo1AWZc0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AgCLCsziZGXU7Y6svPFWj+V1v9gwWbzQYdQWCHc9fZSxqJ2en3M8jA2ypRtH13ZHK
         8rpK4IDHb484L685S7qhGoZVebQ2k3uruMsrxnWoK4PiHt3bhhGzt4WWJHxL3eudi/
         8eYrHTXWymeK6N/itLvEI199aqnKsa2fvvVc8oSw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 102/146] usb: host: ohci-at91: fix request of irq for optional gpio
Date:   Wed, 31 Oct 2018 19:04:57 -0400
Message-Id: <20181031230541.28822-102-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181031230541.28822-1-sashal@kernel.org>
References: <20181031230541.28822-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>

[ Upstream commit 325b9313ec3be56c8e2fe03f977fee19cec75820 ]

atmel,oc-gpio is optional. Request its irq only when atmel,oc is set
in device tree.

devm_gpiod_get_index_optional returns NULL if -ENOENT. Check its
return value for NULL before error, because it is more probable that
atmel,oc is not set.

This fixes the following errors on boards where atmel,oc is not set in
device tree:
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
[    0.960000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ
[    0.970000] at91_ohci 500000.ohci: failed to request gpio "overcurrent" IRQ

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-at91.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/ohci-at91.c b/drivers/usb/host/ohci-at91.c
index e98673954020..ec6739ef3129 100644
--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -551,6 +551,8 @@ static int ohci_hcd_at91_drv_probe(struct platform_device *pdev)
 		pdata->overcurrent_pin[i] =
 			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
 						      i, GPIOD_IN);
+		if (!pdata->overcurrent_pin[i])
+			continue;
 		if (IS_ERR(pdata->overcurrent_pin[i])) {
 			err = PTR_ERR(pdata->overcurrent_pin[i]);
 			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);
-- 
2.17.1

