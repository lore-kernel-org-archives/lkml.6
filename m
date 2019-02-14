Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2820C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D03621902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 01:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="pG14xrSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389922AbfBNBg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 20:36:59 -0500
Received: from onstation.org ([52.200.56.107]:37246 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389149AbfBNBg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 20:36:56 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id B14CF1F3;
        Thu, 14 Feb 2019 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1550108215;
        bh=0g9/fEdwyhLjguANKSGMD3dHhaqWJUvUAbCu9zdQ6dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pG14xrSUyknxiZtvn4z8YkAVtcCElWMkhs/cV9WOgwqPnc3a9Nz0bPjhg7FsJ+eFt
         yj4UTqCPqcq0TJV8D/n8KtNgbKI4YxmnQ7fXHCCEtkpvboTkyczXXsBirKipNqe83F
         N2PT7WXQnfvZ0lQvdA3qyMNqBh8vhiVRGnZxAGJE=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org
Cc:     sboyd@kernel.org, lee.jones@linaro.org, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH -next 3/3] qcom: ssbi-gpio: correct boundary conditions in pm8xxx_domain_translate
Date:   Wed, 13 Feb 2019 20:36:41 -0500
Message-Id: <20190214013641.9740-3-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190214013641.9740-1-masneyb@onstation.org>
References: <20190214013641.9740-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSBI GPIOs are numbered 1..ngpio, so the boundary check in
pm8xxx_domain_translate() is off by one. This patch corrects that check.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
Originally found by Bjorn Andersson in spmi-gpio.

Linus: For your ib-qcom-ssbi branch.

 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
index 84a232450000..10575d6e2ba5 100644
--- a/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c
@@ -710,7 +710,8 @@ static int pm8xxx_domain_translate(struct irq_domain *domain,
 	struct pm8xxx_gpio *pctrl = container_of(domain->host_data,
 						 struct pm8xxx_gpio, chip);
 
-	if (fwspec->param_count != 2 || fwspec->param[0] >= pctrl->chip.ngpio)
+	if (fwspec->param_count != 2 || fwspec->param[0] < 1 ||
+	    fwspec->param[0] > pctrl->chip.ngpio)
 		return -EINVAL;
 
 	*hwirq = fwspec->param[0] - PM8XXX_GPIO_PHYSICAL_OFFSET;
-- 
2.17.2

