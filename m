Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E5C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D18205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 00:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="gcF/qtTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbfAQAdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 19:33:17 -0500
Received: from onstation.org ([52.200.56.107]:54424 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfAQAdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 19:33:13 -0500
Received: from localhost.localdomain (mobile-166-171-186-103.mycingular.net [166.171.186.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3AC2D47;
        Thu, 17 Jan 2019 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547685192;
        bh=zbzwMVlg2WPqRhyJ01NsUFaxlBjs3rw7ss6sddvnK9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcF/qtTgJFe0I2yhrSarADowpbwsShuLW+Ue9xTapZVDsHQENDoxbhMAMTjT+b/oA
         SJ245OB3oDDVHlGIpDBtwwr1DEPyN3akCp6p1OAfQCuQaqIBsqJT8SvapG0TZ5bn7B
         9Q9tz6ssk13sWtXbUiV9pADZ3a0ncq+ftZs5kk8c=
From:   Brian Masney <masneyb@onstation.org>
To:     linus.walleij@linaro.org, sboyd@kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 06/14] spmi: pmic-arb: disassociate old virq if hwirq mapping already exists
Date:   Wed, 16 Jan 2019 19:32:26 -0500
Message-Id: <20190117003234.22127-7-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190117003234.22127-1-masneyb@onstation.org>
References: <20190117003234.22127-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check to see if the hwirq is already associated with another virq on
this IRQ domain. If so, then disassociate it before associating the
hwirq with the new virq.

This is a temporary hack that is needed in order to not break git
bisect for existing boards. The next patch in this series converts
spmi-gpio to be a hierarchical IRQ chip, then there are several patches
to update all of the device tree files, and finally this patch will be
reverted within the same patch series.

IRQs for spmi-gpio are all initially setup without an IRQ hierarchy
on pmic-arb when mfd/qcom-spmi-pmic.c is probed (via the
devm_of_platform_populate call) due to the interrupts property in
device tree. Once spmi-gpio is converted to be a hierarchical IRQ chip
in the next patch, existing users of gpio[d]_to_irq() will call
pmic_gpio_to_irq(), and that will use the new IRQ chip code in
spmi-gpio that sets up the IRQ in an IRQ hierarchy. The hwirq is now
associated with two Linux virqs and interrupts will not work as
expected. This patch corrects that issue.

Driver was tested using gpio-keys and iadc/vadc on the LG Nexus 5
(hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
Changes since v4:
- None

Patch introduced in v4.

 drivers/spmi/spmi-pmic-arb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 356bc3f66e22..b7cfee831417 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -744,8 +744,14 @@ static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
 				   struct irq_domain *domain, unsigned int virq,
 				   irq_hw_number_t hwirq)
 {
+	unsigned int old_virq;
+
 	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu\n", virq, hwirq);
 
+	old_virq = irq_find_mapping(domain, hwirq);
+	if (old_virq)
+		irq_domain_disassociate(domain, old_virq);
+
 	irq_domain_set_info(domain, virq, hwirq, &pmic_arb_irqchip, pmic_arb,
 			    handle_level_irq, NULL, NULL);
 }
-- 
2.17.2

