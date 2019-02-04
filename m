Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0115AC282CC
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8A32082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277741;
	bh=IzY7pChYmD4CcMa8Y9y6QCzkskOyVuBC02mvzeUiW7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EPM3ntam/zLWbN2PPi/UhfbwOf1pCFyyx+rrZpJSKwvM/F2a+TAJz44cxqAs6annB
	 woQD/8F6AQcUPWZ6cvsVl8MkyDdrSwIDImgeKRF9ifjm3AzJY4i+fcOB7dzKR6K9RV
	 OA1fGVY025aO5dDAiuRJPfPzBkbgDCfMn1YRxmQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbfBDKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732791AbfBDKxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:53:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD37B2184E;
        Mon,  4 Feb 2019 10:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277613;
        bh=IzY7pChYmD4CcMa8Y9y6QCzkskOyVuBC02mvzeUiW7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KERRPh6ly6P+grAvXBJdX4/aiAiw2wifm8UB3XwQJFdOFEjcWgRzoc2iCy67pGs6c
         +1p1LPT5fCSUEfj230+elMdB+FG++/efaCrKfIcVc/F6CbR2EQx3AazymWk9iP52L6
         a4oTAH2eYkLY1EvraAa1NOU9JaTyLIJht65v+9wk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neo Hou <neo.hou@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 4.20 52/80] gpio: sprd: Fix the incorrect data register
Date:   Mon,  4 Feb 2019 11:37:12 +0100
Message-Id: <20190204103627.473114993@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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

From: Neo Hou <neo.hou@unisoc.com>

commit 09d158d52d2bceda736797a61b6c13d7fc83707b upstream.

Since differnt type EICs have its own data register to read, thus fix the
incorrect data register.

Fixes: 25518e024e3a ("gpio: Add Spreadtrum EIC driver support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Neo Hou <neo.hou@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-eic-sprd.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/gpio/gpio-eic-sprd.c
+++ b/drivers/gpio/gpio-eic-sprd.c
@@ -180,7 +180,18 @@ static void sprd_eic_free(struct gpio_ch
 
 static int sprd_eic_get(struct gpio_chip *chip, unsigned int offset)
 {
-	return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
+	struct sprd_eic *sprd_eic = gpiochip_get_data(chip);
+
+	switch (sprd_eic->type) {
+	case SPRD_EIC_DEBOUNCE:
+		return sprd_eic_read(chip, offset, SPRD_EIC_DBNC_DATA);
+	case SPRD_EIC_ASYNC:
+		return sprd_eic_read(chip, offset, SPRD_EIC_ASYNC_DATA);
+	case SPRD_EIC_SYNC:
+		return sprd_eic_read(chip, offset, SPRD_EIC_SYNC_DATA);
+	default:
+		return -ENOTSUPP;
+	}
 }
 
 static int sprd_eic_direction_input(struct gpio_chip *chip, unsigned int offset)


