Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E915C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0F621841
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129649;
	bh=RxclemRzyefgukYl3bw7N8sFfdOONFic05WOg8/Y49k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZGowqD60tc9rXCDFFrczJe2PtCQYB1YcIumEGSI4BOfWfh85ZV92pfHuiXG0F4at1
	 Plbw9K6PxOXvAAzTlwEzkporLAMQOha+XCe+KU7pfStemBwxmGwm5Ze4aSWLhEsifl
	 Gj9kKps48+ZVpOF0UbvMk7luwv1WtdM/GYNmfNyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730494AbfBYVUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730481AbfBYVUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:20:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27792184A;
        Mon, 25 Feb 2019 21:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129642;
        bh=RxclemRzyefgukYl3bw7N8sFfdOONFic05WOg8/Y49k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLIKlPOM08l1n+7pabg/wnGkmc0WdnYoGj87EPerUgUgsT8wihiaRgYsU0CirKrrj
         u68P0uEQXOZNAOHsexUW0NIGb6nfUJq55X8TvEl6Q0LsYlaXFCTnVizUZN3GxiFMFc
         jVfYr2CyC9BsJEJOgnhQU9NM3HeqCGEf+IpBn5TA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.19 005/152] gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2
Date:   Mon, 25 Feb 2019 22:09:57 +0100
Message-Id: <20190225195044.016186687@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lubomir Rintel <lkundrak@v3.sk>

commit af14b2c98adb85e9517390bb88309338b9075350 upstream.

Similarly to PXA3xx, pinctrl-single can't set pin direction on MMP2 either.
See also: commit 9dabfdd84bdfa ("gpio: pxa: disable pinctrl calls for
PXA3xx")

Cc: stable@vger.kernel.org
Fixes: a770d946371e ("gpio: pxa: add pin control gpio direction and request")
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-pxa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpio-pxa.c
+++ b/drivers/gpio/gpio-pxa.c
@@ -245,6 +245,7 @@ static bool pxa_gpio_has_pinctrl(void)
 {
 	switch (gpio_type) {
 	case PXA3XX_GPIO:
+	case MMP2_GPIO:
 		return false;
 
 	default:


