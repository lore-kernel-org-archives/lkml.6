Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719BD217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="MWw/D0X/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfAYQX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 11:23:56 -0500
Received: from onstation.org ([52.200.56.107]:54998 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbfAYQXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 11:23:11 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id D69E24EC;
        Fri, 25 Jan 2019 16:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1548433390;
        bh=hNBtwRhsdcddTqreIDbHHoG94S3Bpux+k6JhuPiZQFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MWw/D0X/nDbPwrLHeBhxcvnLDS9mpgTOnotgu0PZtg99isWKe+YriyYnM/XQhXe96
         1BiDLXfgOLIxvnIEosR1BQuOkrFnPS9cioCeJon/JUuLPB4UoeU1qAqULFlkUtPfy/
         do+FEGZEI3vFbpD+gTdpBhY+HFK1yc+f0lyMWzdk=
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
Subject: [PATCH 4/9] mfd: pm8xxx: disassociate old virq if hwirq mapping already exists
Date:   Fri, 25 Jan 2019 11:22:57 -0500
Message-Id: <20190125162302.14036-5-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190125162302.14036-1-masneyb@onstation.org>
References: <20190125162302.14036-1-masneyb@onstation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check to see if the hwirq is already associated with another virq on
this IRQ domain. If so, then disassociate it before associating the
hwirq with the new virq.

This is a temporary hack that is needed in order to not break git
bisect for existing boards. The next patch in this series converts
ssbi-gpio to be a hierarchical IRQ chip, then there are several patches
to update all of the device tree files, and finally this patch will be
reverted within the same patch series.

IRQs for ssbi-gpio are all initially setup without an IRQ hierarchy
this driver is probed due to the interrupts property in device tree.
Once ssbi-gpio is converted to be a hierarchical IRQ chip in the next
patch, existing users of gpio[d]_to_irq() will call pmic_gpio_to_irq(),
and that will use the new IRQ chip code in ssbi-gpio that sets up the
IRQ in an IRQ hierarchy. The hwirq is now associated with two Linux
virqs and interrupts will not work as expected. This patch corrects
that issue.

This change was not tested on any actual hardware, however the same
change was made to spmi-pmic-arb.c and tested on a LG Nexus 5
(hammerhead) phone.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/mfd/qcom-pm8xxx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mfd/qcom-pm8xxx.c b/drivers/mfd/qcom-pm8xxx.c
index a976890c4019..97b931465601 100644
--- a/drivers/mfd/qcom-pm8xxx.c
+++ b/drivers/mfd/qcom-pm8xxx.c
@@ -387,6 +387,11 @@ static void pm8xxx_irq_domain_map(struct pm_irq_chip *chip,
 				  irq_hw_number_t hwirq, unsigned int type)
 {
 	irq_flow_handler_t handler;
+	unsigned int old_virq;
+
+	old_virq = irq_find_mapping(domain, hwirq);
+	if (old_virq)
+		irq_domain_disassociate(domain, old_virq);
 
 	if (type & IRQ_TYPE_EDGE_BOTH)
 		handler = handle_edge_irq;
-- 
2.17.2

