Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8363C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764612084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130127;
	bh=XwiXxzjudlHS5F+DLu8atoHno9WAFL34dhzHOELjoa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KVXIRoBVk61bsKEmEVRNg0KFB7eq3Qsw56uMVD/8mOfDXgthtdmYnogDBqUtShQ68
	 089jNHvmjXOT7kxSpW0duGUwcNR096nN72uZzqamTOW4P5G4hkuUS9krZ6HtvfOim4
	 zCq7olhOv0SiPwlmA6aDfLMkpZzKaujcBjrMo16A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfBYV2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:28:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbfBYV2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:28:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10E9021734;
        Mon, 25 Feb 2019 21:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130123;
        bh=XwiXxzjudlHS5F+DLu8atoHno9WAFL34dhzHOELjoa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JuV+AqjwZMiJXijbhe7GD2+JLzFuDVx9EHShX/bC7LUbzSpNev95umxCWVU/gE8ou
         SuyF83ZkvbKZcT70/61v4vT5Dhf4Gcj1tARuxx3T5wz30epKbByntRKMhEIc/HROvl
         plYGjZOSjdPDMS82omdi5E1hT9zK2pB6v3RjtSwM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.20 007/183] gpio: pxa: avoid attempting to set pin direction via pinctrl on MMP2
Date:   Mon, 25 Feb 2019 22:09:40 +0100
Message-Id: <20190225195055.881388942@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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


