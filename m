Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92090C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DEE25D43
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 12:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56DEE25D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752686AbeGBMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 08:47:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58305 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752236AbeGBMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 08:47:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fZyEW-000647-PO; Mon, 02 Jul 2018 12:47:08 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] pinctrl: actions: fix unsigned less than zero comparison
Date:   Mon,  2 Jul 2018 13:47:08 +0100
Message-Id: <20180702124708.7295-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check to see if platform_get_irq failed is performed on the
unsigned value of pctrl->irq[i] and the check is never true because
an unsigned cannot be less than zero.  Fix this by assinging the
signed int ret to the return of platform_get_irq and checking ret
instead.

Detected by CoverityScan, CID#1470247 ("Unsigned comparison against 0")

Fixes: 6c5d0736e9c0 ("pinctrl: actions: Add interrupt support for OWL S900 SoC")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: move pctrl->irq[i] = ret assignment below the check on ret, thanks
to Manivannan Sadhasivam for suggesting this change.

---
 drivers/pinctrl/actions/pinctrl-owl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-owl.c b/drivers/pinctrl/actions/pinctrl-owl.c
index 4fa9cc377b3b..24dc57fcac51 100644
--- a/drivers/pinctrl/actions/pinctrl-owl.c
+++ b/drivers/pinctrl/actions/pinctrl-owl.c
@@ -1026,11 +1026,10 @@ int owl_pinctrl_probe(struct platform_device *pdev,
 	}
 
 	for (i = 0; i < pctrl->num_irq ; i++) {
-		pctrl->irq[i] = platform_get_irq(pdev, i);
-		if (pctrl->irq[i] < 0) {
-			ret = pctrl->irq[i];
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
 			goto err_exit;
-		}
+		pctrl->irq[i] = ret;
 	}
 
 	ret = owl_gpio_init(pctrl);
-- 
2.17.1

