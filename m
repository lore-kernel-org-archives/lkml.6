Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1DEC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9416F20818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="klKYfO7D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9416F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbeKLIxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:53:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390571AbeKLIWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75F0D2241E;
        Sun, 11 Nov 2018 22:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975548;
        bh=DLYcEQTaGcx65aYAKuvWMTIWRvE6sH7pfmjfHUPE6a0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=klKYfO7DVa3MdH6m73M5lJVf4I2wjYibhSeX+OUc1v57lXjmr0bIPnlD25HC+CiQc
         Guy35SoiQVodEpZ8Vi4Q7ecLFfZ9+RolLbXjG4EsXh7kNJ2Bww+WD9QNR3Okjw5SI5
         W3nIGNv1ghnvK8SZTAzhJO0MSolVbEPm1affcxTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 084/222] usb: host: ohci-at91: fix request of irq for optional gpio
Date:   Sun, 11 Nov 2018 14:23:01 -0800
Message-Id: <20181111221655.548295205@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/ohci-at91.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/ohci-at91.c
+++ b/drivers/usb/host/ohci-at91.c
@@ -550,6 +550,8 @@ static int ohci_hcd_at91_drv_probe(struc
 		pdata->overcurrent_pin[i] =
 			devm_gpiod_get_index_optional(&pdev->dev, "atmel,oc",
 						      i, GPIOD_IN);
+		if (!pdata->overcurrent_pin[i])
+			continue;
 		if (IS_ERR(pdata->overcurrent_pin[i])) {
 			err = PTR_ERR(pdata->overcurrent_pin[i]);
 			dev_err(&pdev->dev, "unable to claim gpio \"overcurrent\": %d\n", err);


