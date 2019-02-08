Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848F9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC9021907
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 02:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="T9jMTJeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBHCRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 21:17:00 -0500
Received: from onstation.org ([52.200.56.107]:35062 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727207AbfBHCQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 21:16:56 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3DD631B7B;
        Fri,  8 Feb 2019 02:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549592215;
        bh=uO7jyNkXiwGRV0jhAFXHyDrtObJ5KkZxxjlo7Enh65I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T9jMTJePsHPZQ40Y83SpE7al0p/NcTs0q3M3jXBADLICHwppvzBT/l1PeH5V10ZYq
         Yobi7UmlxIMl4iAioII+/Vg6PZbek9m3RT+mUqy8IiFJZntOCj1hb5WXNRYMrZwU6E
         2NXlY4nOkUTfHBTufhB24oHOgBhtNuryScbzqXfk=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, lee.jones@linaro.org
Cc:     tglx@linutronix.de, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 11/11] mfd: pm8xxx: revert "disassociate old virq if hwirq mapping already exists"
Date:   Thu,  7 Feb 2019 21:16:31 -0500
Message-Id: <20190208021631.30252-12-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190208021631.30252-1-masneyb@onstation.org>
References: <20190208021631.30252-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that ssbi-gpio is a proper hierarchical IRQ chip, and all in-tree
users of device tree have been updated, we can now drop the hack that
was introduced to disassociate the old Linux virq if a hwirq mapping
already exists. That patch was introduced to not break git bisect for
any existing boards.

This change was tested on an APQ8060 DragonBoard.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Tested-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes since v1:
- None

 drivers/mfd/qcom-pm8xxx.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index 2f99a98ccee5..8eb2528793f9 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -380,12 +380,6 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
 				  struct irq_domain *domain, unsigned int irq,
 				  irq_hw_number_t hwirq, unsigned int type)
 {
-	unsigned int old_virq;
-
-	old_virq = irq_find_mapping(domain, hwirq);
-	if (old_virq)
-		irq_domain_disassociate(domain, old_virq);
-
 	irq_domain_set_info(domain, irq, hwirq, chip->pm_irq_data->irq_chip,
 			    chip, handle_level_irq, NULL, NULL);
 	irq_set_noprobe(irq);
-- 
2.17.2

